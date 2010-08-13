Return-Path: <abounine@tundra.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 80FA3B70DE
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Aug 2010 01:20:43 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 7/9] RapidIO: Add handling for PW message from a lost device
Date: Fri, 13 Aug 2010 11:18:04 -0400
Message-Id: <1281712686-31308-8-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add check if PW message source device is accessible and change PW message
handler to recover if PW message source device is not available anymore (power
down or link disconnect).
To avoid possible loss of notification, the PW message handler scans the route
back from the source device to identify end of the broken link.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Reviewed-by: Thomas Moll <thomas.moll@sysgo.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/rapidio/rio.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/rapidio/rio.h |    2 +
 2 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index f58df11..22f7847 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -495,6 +495,90 @@ int rio_set_port_lockout(struct rio_dev *rdev, u32 pnum, int lock)
 }
 
 /**
+ * rio_chk_dev_route - Validate route to the specified device.
+ * @rdev: Pointer to RIO device control structure
+ * @nrdev: Pointer to last active device on the route to rdev
+ * @npnum: nrdev port number on the route to rdev
+ *
+ * Follows a route to the specified RIO device to determine the last available
+ * device (and corresponding RIO port) on the route.
+ */
+static int
+rio_chk_dev_route(struct rio_dev *rdev, struct rio_dev **nrdev, int *npnum)
+{
+	u32 result;
+	int p_port, rc = -EIO;
+	struct rio_dev *prev = NULL;
+
+	while (rdev->prev && (rdev->prev->pef & RIO_PEF_SWITCH)) {
+		if (rio_read_config_32(rdev->prev, RIO_DEV_ID_CAR, &result)) {
+			rdev = rdev->prev;
+			continue;
+		}
+
+		prev = rdev->prev;
+		for (p_port = 0; p_port < prev->rswitch->nports; p_port++)
+			if (prev->rswitch->nextdev[p_port] == rdev)
+				break;
+
+		if (p_port < prev->rswitch->nports) {
+			pr_debug("RIO: link failed on [%s]-P%d\n",
+				 rio_name(prev), p_port);
+			*nrdev = prev;
+			*npnum = p_port;
+			rc = 0;
+		} else {
+			pr_debug("RIO: failed to trace route to %s\n",
+				 rio_name(prev));
+		}
+
+		break;
+	}
+
+	return rc;
+}
+
+/**
+ * rio_mport_chk_dev_access - Validate access to the specified device.
+ * @mport: Master port to send transactions
+ * @destid: Device destination ID in network
+ * @hopcount: Number of hops into the network
+ */
+static int
+rio_mport_chk_dev_access(struct rio_mport *mport, u16 destid, u8 hopcount)
+{
+	int i = 0;
+	u32 tmp;
+
+	while (rio_mport_read_config_32(mport, destid, hopcount,
+					RIO_DEV_ID_CAR, &tmp)) {
+		i++;
+		if (i == RIO_MAX_CHK_RETRY)
+			return -EIO;
+		mdelay(1);
+	}
+
+	return 0;
+}
+
+/**
+ * rio_chk_dev_access - Validate access to the specified device.
+ * @rdev: Pointer to RIO device control structure
+ */
+static int rio_chk_dev_access(struct rio_dev *rdev)
+{
+	u8 hopcount = 0xff;
+	u16 destid = rdev->destid;
+
+	if (rdev->rswitch) {
+		destid = rdev->rswitch->destid;
+		hopcount = rdev->rswitch->hopcount;
+	}
+
+	return rio_mport_chk_dev_access(rdev->net->hport, destid, hopcount);
+}
+
+/**
  * rio_clr_err_stopped - Clears port Error-stopped states.
  * @rdev: Pointer to RIO device control structure
  * @pnum: Switch port number to clear errors
@@ -627,8 +711,8 @@ int rio_inb_pwrite_handler(union rio_pw_msg *pw_msg)
 
 	rdev = rio_get_comptag(pw_msg->em.comptag, NULL);
 	if (rdev == NULL) {
-		/* Someting bad here (probably enumeration error) */
-		pr_err("RIO: %s No matching device for CTag 0x%08x\n",
+		/* Device removed or enumeration error */
+		pr_debug("RIO: %s No matching device for CTag 0x%08x\n",
 			__func__, pw_msg->em.comptag);
 		return -EIO;
 	}
@@ -659,6 +743,26 @@ int rio_inb_pwrite_handler(union rio_pw_msg *pw_msg)
 			return 0;
 	}
 
+	portnum = pw_msg->em.is_port & 0xFF;
+
+	/* Check if device and route to it are functional:
+	 * Sometimes devices may send PW message(s) just before being
+	 * powered down (or link being lost).
+	 */
+	if (rio_chk_dev_access(rdev)) {
+		pr_debug("RIO: device access failed - get link partner\n");
+		/* Scan route to the device and identify failed link.
+		 * This will replace device and port reported in PW message.
+		 * PW message should not be used after this point.
+		 */
+		if (rio_chk_dev_route(rdev, &rdev, &portnum)) {
+			pr_err("RIO: Route trace for %s failed\n",
+				rio_name(rdev));
+			return -EIO;
+		}
+		pw_msg = NULL;
+	}
+
 	/* For End-point devices processing stops here */
 	if (!(rdev->pef & RIO_PEF_SWITCH))
 		return 0;
@@ -676,9 +780,6 @@ int rio_inb_pwrite_handler(union rio_pw_msg *pw_msg)
 	/*
 	 * Process the port-write notification from switch
 	 */
-
-	portnum = pw_msg->em.is_port & 0xFF;
-
 	if (rdev->rswitch->em_handle)
 		rdev->rswitch->em_handle(rdev, portnum);
 
diff --git a/drivers/rapidio/rio.h b/drivers/rapidio/rio.h
index f27b7a9..bc71ba1 100644
--- a/drivers/rapidio/rio.h
+++ b/drivers/rapidio/rio.h
@@ -14,6 +14,8 @@
 #include <linux/list.h>
 #include <linux/rio.h>
 
+#define RIO_MAX_CHK_RETRY	3
+
 /* Functions internal to the RIO core code */
 
 extern u32 rio_mport_get_feature(struct rio_mport *mport, int local, u16 destid,
-- 
1.7.0.5
