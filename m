Return-Path: <osstklei@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5DFD4DDEB6
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 22:54:26 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0MBsLGE187352
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 11:54:21 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0MBsLdR1671252
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 11:54:21 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0MBsLob004533
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 11:54:21 GMT
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 5/7] ehea: Improved logging of permission issues
Date: Mon, 22 Jan 2007 12:54:20 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701221254.20725.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Stefan Roscher <roscher@de.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <ossrosch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Disabled dump of hcall regs on some permission issues and
fixed appropriate misleading logmessages

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea_main.c |   16 +++++++---------
 drivers/net/ehea/ehea_phyp.c |   10 ++++++++--
 2 files changed, 15 insertions(+), 11 deletions(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-19 14:16:35.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 14:22:42.000000000 +0100
@@ -730,10 +730,7 @@ int ehea_set_portspeed(struct ehea_port 
 		}
 	} else {
 		if (hret == H_AUTHORITY) {
-			ehea_info("Hypervisor denied setting port speed. Either"
-				  " this partition is not authorized to set "
-				  "port speed or another partition has modified"
-				  " port speed first.");
+			ehea_info("Hypervisor denied setting port speed");
 			ret = -EPERM;
 		} else {
 			ret = -EIO;
@@ -1487,11 +1484,12 @@ out:
 
 static void ehea_promiscuous_error(u64 hret, int enable)
 {
-	ehea_info("Hypervisor denied %sabling promiscuous mode.%s",
-		  enable == 1 ? "en" : "dis",
-		  hret != H_AUTHORITY ? "" : " Another partition owning a "
-		  "logical port on the same physical port might have altered "
-		  "promiscuous mode first.");
+	if (hret == H_AUTHORITY)
+		ehea_info("Hypervisor denied %sabling promiscuous mode",
+			  enable == 1 ? "en" : "dis");
+	else
+		ehea_error("failed %sabling promiscuous mode",
+			   enable == 1 ? "en" : "dis");
 }
 
 static void ehea_promiscuous(struct net_device *dev, int enable)
diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_phyp.c patched_kernel/drivers/net/ehea/ehea_phyp.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_phyp.c	2007-01-12 19:54:26.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_phyp.c	2007-01-19 14:23:31.000000000 +0100
@@ -94,6 +94,7 @@ static long ehea_plpar_hcall9(unsigned l
 {
 	long ret;
 	int i, sleep_msecs;
+	u8 cb_cat;
 
 	for (i = 0; i < 5; i++) {
 		ret = plpar_hcall9(opcode, outs,
@@ -106,7 +107,13 @@ static long ehea_plpar_hcall9(unsigned l
 			continue;
 		}
 
-		if (ret < H_SUCCESS)
+		cb_cat = EHEA_BMASK_GET(H_MEHEAPORT_CAT, arg2);
+
+		if ((ret < H_SUCCESS) && !(((ret == H_AUTHORITY)
+		    && (opcode == H_MODIFY_HEA_PORT))
+		    && (((cb_cat == H_PORT_CB4) && ((arg3 == H_PORT_CB4_JUMBO)
+		    || (arg3 == H_PORT_CB4_SPEED))) || ((cb_cat == H_PORT_CB7)
+		    && (arg3 == H_PORT_CB7_DUCQPN)))))
 			ehea_error("opcode=%lx ret=%lx"
 				   " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
 				   " arg5=%lx arg6=%lx arg7=%lx arg8=%lx"
@@ -120,7 +127,6 @@ static long ehea_plpar_hcall9(unsigned l
 				   outs[0], outs[1], outs[2], outs[3],
 				   outs[4], outs[5], outs[6], outs[7],
 				   outs[8]);
-
 		return ret;
 	}
 
