Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 08081B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 07:38:49 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -mm 1/4] RapidIO: Add definitions of Component Tag fields
Date: Fri, 10 Dec 2010 15:38:15 -0500
Message-Id: <1292013498-31406-2-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com>
References: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add definition of the unique device identifier field in the component tag.
RIO_CTAG_UDEVID does not take all 32 bits of the component tag value to
allow future extensions to the component tag use.

Selected size of the RIO_CTAG_UDEVID field (17 bits) is sufficient to accommodate
maximum number of endpoints in large RIO network (16-bit id) plus switches.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Thomas Moll <thomas.moll@sysgo.com>
Cc: Micha Nelissen <micha@neli.hopto.org>
---
 drivers/rapidio/rio.c |    2 +-
 include/linux/rio.h   |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index c13289e..cc2a3b7 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -710,7 +710,7 @@ int rio_inb_pwrite_handler(union rio_pw_msg *pw_msg)
 	u32 err_status, em_perrdet, em_ltlerrdet;
 	int rc, portnum;
 
-	rdev = rio_get_comptag(pw_msg->em.comptag, NULL);
+	rdev = rio_get_comptag((pw_msg->em.comptag & RIO_CTAG_UDEVID), NULL);
 	if (rdev == NULL) {
 		/* Device removed or enumeration error */
 		pr_debug("RIO: %s No matching device for CTag 0x%08x\n",
diff --git a/include/linux/rio.h b/include/linux/rio.h
index 9b55885..ff681eb 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -66,6 +66,16 @@
 
 #define RIO_PW_MSG_SIZE		64
 
+/*
+ * A component tag value (stored in the component tag CSR) is used as device's
+ * unique identifier assigned during enumeration. Besides being used for
+ * identifying switches (which do not have device ID register), it also is used
+ * by error management notification and therefore has to be assigned
+ * to endpoints as well.
+ */
+#define RIO_CTAG_RESRVD	0xfffe0000 /* Reserved */
+#define RIO_CTAG_UDEVID	0x0001ffff /* Unique device identifier */
+
 extern struct bus_type rio_bus_type;
 extern struct device rio_bus;
 extern struct list_head rio_devices;	/* list of all devices */
-- 
1.7.3.1
