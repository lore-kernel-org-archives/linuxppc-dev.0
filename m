Return-Path: <R63238@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14E191007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 19:24:13 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAR8NsLf000255
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 01:24:04 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nAR8Nsxo012252
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 02:23:55 -0600 (CST)
From: Dave Liu <daveliu@freescale.com>
To: davem@davemloft.net
Subject: ucc_geth: Fix the wrong the Rx/Tx FIFO size
Date: Fri, 27 Nov 2009 16:16:43 +0800
Message-Id: <1259309803-5474-1-git-send-email-daveliu@freescale.com>
Cc: netdev@vger.kernel.orgnetdev, @vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

current the Rx/Tx FIFO size settings cause problem
when four UEC ethernets work simultaneously.

eg: GETH1, UEM-J15, GETH2, UEC-J5 on 8569MDS board

 $ ifconfig eth0 10.193.20.166
 $ ifconfig eth1 10.193.20.167
 $ ifconfig eth2 10.193.20.168
 then
 $ ifconfig eth3 10.193.20.169

The fourth ethernet will cause all of interface broken,
you cann't ping successfully any more.
The patch fix this issue for MPC8569 Rev1.0 and Rev2.0

Signed-off-by: Dave Liu <daveliu@freescale.com>
---
 drivers/net/ucc_geth.h |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ucc_geth.h b/drivers/net/ucc_geth.h
index 03a6ca0..26a43ed 100644
--- a/drivers/net/ucc_geth.h
+++ b/drivers/net/ucc_geth.h
@@ -838,13 +838,13 @@ struct ucc_geth_hardware_statistics {
 							   using the maximum is
 							   easier */
 #define UCC_GETH_SEND_QUEUE_QUEUE_DESCRIPTOR_ALIGNMENT	32
-#define UCC_GETH_SCHEDULER_ALIGNMENT		4	/* This is a guess */
+#define UCC_GETH_SCHEDULER_ALIGNMENT		8	/* This is a guess */
 #define UCC_GETH_TX_STATISTICS_ALIGNMENT	4	/* This is a guess */
 #define UCC_GETH_RX_STATISTICS_ALIGNMENT	4	/* This is a guess */
 #define UCC_GETH_RX_INTERRUPT_COALESCING_ALIGNMENT	64
 #define UCC_GETH_RX_BD_QUEUES_ALIGNMENT		8	/* This is a guess */
 #define UCC_GETH_RX_PREFETCHED_BDS_ALIGNMENT	128	/* This is a guess */
-#define UCC_GETH_RX_EXTENDED_FILTERING_GLOBAL_PARAMETERS_ALIGNMENT 4	/* This
+#define UCC_GETH_RX_EXTENDED_FILTERING_GLOBAL_PARAMETERS_ALIGNMENT 8	/* This
 									   is a
 									   guess
 									 */
@@ -899,16 +899,17 @@ struct ucc_geth_hardware_statistics {
 #define UCC_GETH_UTFS_INIT                      512	/* Tx virtual FIFO size
 							 */
 #define UCC_GETH_UTFET_INIT                     256	/* 1/2 utfs */
-#define UCC_GETH_UTFTT_INIT                     128
+#define UCC_GETH_UTFTT_INIT                     512
 /* Gigabit Ethernet (1000 Mbps) */
 #define UCC_GETH_URFS_GIGA_INIT                 4096/*2048*/	/* Rx virtual
 								   FIFO size */
 #define UCC_GETH_URFET_GIGA_INIT                2048/*1024*/	/* 1/2 urfs */
 #define UCC_GETH_URFSET_GIGA_INIT               3072/*1536*/	/* 3/4 urfs */
-#define UCC_GETH_UTFS_GIGA_INIT                 8192/*2048*/	/* Tx virtual
+#define UCC_GETH_UTFS_GIGA_INIT                 4096/*2048*/	/* Tx virtual
+								   FIFO size */
+#define UCC_GETH_UTFET_GIGA_INIT                2048/*1024*/	/* 1/2 utfs */
+#define UCC_GETH_UTFTT_GIGA_INIT                4096/*0x40*/	/* Tx virtual
 								   FIFO size */
-#define UCC_GETH_UTFET_GIGA_INIT                4096/*1024*/	/* 1/2 utfs */
-#define UCC_GETH_UTFTT_GIGA_INIT                0x400/*0x40*/	/* */
 
 #define UCC_GETH_REMODER_INIT                   0	/* bits that must be
 							   set */
-- 
1.6.4
