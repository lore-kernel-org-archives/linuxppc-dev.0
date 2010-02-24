Return-Path: <alexb@tundra.com>
Received: from mx2.tundra.com (mail2.tundra.com [142.46.200.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.tundra.com", Issuer "mail.tundra.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0DF2FB7C98
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Feb 2010 02:21:11 +1100 (EST)
Date: Wed, 24 Feb 2010 10:20:50 -0500
From: Alexandre Bounine <alexb@tundra.com>
To: mporter@kernel.crashing.org
Subject: [PATCH 2/7] RapidIO: Add switch locking during discovery
Message-ID: <20100224152050.GB13661@kaneng01.tundra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: abounine@idt.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, thomas.moll.ext@nsn.com,
	thomas.moll@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


From: Alexandre Bounine <alexandre.bounine@idt.com>

Add switch access locking during RapidIO discovery. Access lock is
required when reading switch routing table contents due to indexed mechanism
of RT addressing.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Tested-by: Thomas Moll <thomas.moll@sysgo.com>
---

 rio-scan.c |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 79 insertions(+), 9 deletions(-)

diff -x '*.pj' -X dontdiff_2.6.32-rc5 -pNur w33r7a/drivers/rapidio/rio-scan.c w33r7b/drivers/rapidio/rio-scan.c
--- w33r7a/drivers/rapidio/rio-scan.c	2010-02-09 15:11:09.141972000 -0500
+++ w33r7b/drivers/rapidio/rio-scan.c	2010-02-10 16:13:56.382802000 -0500
@@ -750,6 +750,7 @@ rio_disc_peer(struct rio_net *net, struc
 	int num_ports;
 	struct rio_dev *rdev;
 	u16 ndestid;
+	u32 result;
 
 	/* Setup new RIO device */
 	if ((rdev = rio_setup_device(net, port, destid, hopcount, 0))) {
@@ -778,6 +779,27 @@ rio_disc_peer(struct rio_net *net, struc
 				pr_debug(
 				    "RIO: scanning device on port %d\n",
 				    port_num);
+
+				/* Attempt to acquire device lock */
+				rio_mport_write_config_32(port, destid,
+							  hopcount,
+							  RIO_HOST_DID_LOCK_CSR,
+							  port->host_deviceid);
+				rio_mport_read_config_32(port, destid, hopcount,
+					RIO_HOST_DID_LOCK_CSR, &result);
+				while (result != port->host_deviceid) {
+					/* Delay a bit */
+					mdelay(1);
+					/* Try to acquire device lock again */
+					rio_mport_write_config_32(port, destid,
+						hopcount,
+						RIO_HOST_DID_LOCK_CSR,
+						port->host_deviceid);
+					rio_mport_read_config_32(port, destid,
+						hopcount,
+						RIO_HOST_DID_LOCK_CSR, &result);
+				}
+
 				for (ndestid = 0;
 				     ndestid < RIO_ANY_DESTID(port->sys_size);
 				     ndestid++) {
@@ -789,6 +811,19 @@ rio_disc_peer(struct rio_net *net, struc
 						break;
 				}
 
+				/* Release device lock */
+				rio_mport_write_config_32(port, destid,
+							  hopcount,
+							  RIO_HOST_DID_LOCK_CSR,
+							  port->host_deviceid);
+				rio_mport_read_config_32(port, destid, hopcount,
+					RIO_HOST_DID_LOCK_CSR, &result);
+				if ((result & 0xffff) != 0xffff) {
+					pr_info("RIO: badness when releasing " \
+						"host lock on %s\n",
+						rio_name(rdev));
+				}
+
 				if (rio_disc_peer
 				    (net, port, ndestid, hopcount + 1) < 0)
 					return -1;
@@ -958,17 +993,45 @@ static void rio_build_route_tables(void)
 	struct rio_dev *rdev;
 	int i;
 	u8 sport;
+	u32 result;
 
 	list_for_each_entry(rdev, &rio_devices, global_list)
-	    if (rio_is_switch(rdev))
-		for (i = 0;
-		     i < RIO_MAX_ROUTE_ENTRIES(rdev->net->hport->sys_size);
-		     i++) {
-			if (rio_route_get_entry
-			    (rdev->net->hport, rdev->rswitch, RIO_GLOBAL_TABLE,
-			     i, &sport) < 0)
-				continue;
-			rdev->rswitch->route_table[i] = sport;
+		if (rio_is_switch(rdev)) {
+			/* Attempt to acquire device lock */
+			rio_write_config_32(rdev, RIO_HOST_DID_LOCK_CSR,
+					rdev->net->hport->host_deviceid);
+			rio_read_config_32(rdev,
+					RIO_HOST_DID_LOCK_CSR, &result);
+			while (result != rdev->net->hport->host_deviceid) {
+				/* Delay a bit */
+				mdelay(1);
+				/* Attempt to acquire device lock again */
+				rio_write_config_32(rdev, RIO_HOST_DID_LOCK_CSR,
+					rdev->net->hport->host_deviceid);
+				rio_read_config_32(rdev,
+					RIO_HOST_DID_LOCK_CSR, &result);
+			}
+
+			for (i = 0;
+			     i < RIO_MAX_ROUTE_ENTRIES(rdev->net->hport->sys_size);
+			     i++) {
+				if (rio_route_get_entry
+				    (rdev->net->hport, rdev->rswitch,
+				     RIO_GLOBAL_TABLE, i, &sport) < 0)
+					continue;
+				rdev->rswitch->route_table[i] = sport;
+			}
+
+			/* Release device lock */
+			rio_write_config_32(rdev, RIO_HOST_DID_LOCK_CSR,
+					rdev->net->hport->host_deviceid);
+			rio_read_config_32(rdev,
+					RIO_HOST_DID_LOCK_CSR, &result);
+			if ((result & 0xffff) != 0xffff) {
+				pr_info("RIO: badness when releasing " \
+					"host lock on %s\n", rio_name(rdev));
+			}
+
 		}
 }
 
@@ -1027,6 +1090,13 @@ int __devinit rio_disc_mport(struct rio_
 		del_timer_sync(&rio_enum_timer);
 
 		pr_debug("done\n");
+
+		/* Read DestID assigned by enumerator */
+		rio_local_read_config_32(mport, RIO_DID_CSR,
+					 &mport->host_deviceid);
+		mport->host_deviceid = RIO_GET_DID(mport->sys_size,
+						   mport->host_deviceid);
+
 		if (rio_disc_peer(net, mport, RIO_ANY_DESTID(mport->sys_size),
 					0) < 0) {
 			printk(KERN_INFO

---

Important Notice: This message is intended for the use of the individual to whom it is addressed and may contain information which is privileged, confidential and/or exempt from disclosure under applicable law. If the reader of this message is not the intended recipient, or is not the employee or agent responsible for delivering the message to the intended recipient, you are hereby notified that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender immediately by telephone or return e-mail and delete the original message from your systems. Thank you. 
