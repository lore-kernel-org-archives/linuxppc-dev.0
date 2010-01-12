Return-Path: <B13201@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2CDACB7C6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 21:11:43 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0CABNWw001658 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 03:11:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o0CAHHNI024908
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 04:17:18 -0600 (CST)
From: Liu Yu <yu.liu@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] qe: Update the SNUM table for MPC8569 Rev2.0
Date: Tue, 12 Jan 2010 18:04:03 +0800
Message-Id: <1263290643-30014-1-git-send-email-yu.liu@freescale.com>
Cc: Liu Yu <yu.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dave Liu <daveliu@freescale.com>

The MPC8569 Rev2.0 has the correct SNUM table as QE
Reference Manual, we must follow it.

However the Rev1.0 silicon need the old SNUM table
as workaround due to Rev1.0 silicon SNUM erratum.

So, we support both snum table, and choose the one FDT tell us.
And u-boot will fixup FDT according to SPRN_SVR.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
Signed-off-by: Dave Liu <daveliu@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |   22 ++++++++++++++++++++--
 drivers/net/ucc_geth.c          |    4 ++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 149393c..c13aede 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006-2010 Freescale Semicondutor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
@@ -266,7 +266,19 @@ EXPORT_SYMBOL(qe_clock_source);
 static void qe_snums_init(void)
 {
 	int i;
-	static const u8 snum_init[] = {
+	static const u8 snum_init_76[] = {
+		0x04, 0x05, 0x0C, 0x0D, 0x14, 0x15, 0x1C, 0x1D,
+		0x24, 0x25, 0x2C, 0x2D, 0x34, 0x35, 0x88, 0x89,
+		0x98, 0x99, 0xA8, 0xA9, 0xB8, 0xB9, 0xC8, 0xC9,
+		0xD8, 0xD9, 0xE8, 0xE9, 0x44, 0x45, 0x4C, 0x4D,
+		0x54, 0x55, 0x5C, 0x5D, 0x64, 0x65, 0x6C, 0x6D,
+		0x74, 0x75, 0x7C, 0x7D, 0x84, 0x85, 0x8C, 0x8D,
+		0x94, 0x95, 0x9C, 0x9D, 0xA4, 0xA5, 0xAC, 0xAD,
+		0xB4, 0xB5, 0xBC, 0xBD, 0xC4, 0xC5, 0xCC, 0xCD,
+		0xD4, 0xD5, 0xDC, 0xDD, 0xE4, 0xE5, 0xEC, 0xED,
+		0xF4, 0xF5, 0xFC, 0xFD,
+	};
+	static const u8 snum_init_46[] = {
 		0x04, 0x05, 0x0C, 0x0D, 0x14, 0x15, 0x1C, 0x1D,
 		0x24, 0x25, 0x2C, 0x2D, 0x34, 0x35, 0x88, 0x89,
 		0x98, 0x99, 0xA8, 0xA9, 0xB8, 0xB9, 0xC8, 0xC9,
@@ -274,9 +286,15 @@ static void qe_snums_init(void)
 		0x28, 0x29, 0x38, 0x39, 0x48, 0x49, 0x58, 0x59,
 		0x68, 0x69, 0x78, 0x79, 0x80, 0x81,
 	};
+	static const u8 *snum_init;
 
 	qe_num_of_snum = qe_get_num_of_snums();
 
+	if (qe_num_of_snum == 76)
+		snum_init = snum_init_76;
+	else
+		snum_init = snum_init_46;
+
 	for (i = 0; i < qe_num_of_snum; i++) {
 		snums[i].num = snum_init[i];
 		snums[i].state = QE_SNUM_STATE_FREE;
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index afaf088..750d86d 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3863,11 +3863,11 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 		ug_info->uf_info.utftt = UCC_GETH_UTFTT_GIGA_INIT;
 		ug_info->numThreadsTx = UCC_GETH_NUM_OF_THREADS_4;
 
-		/* If QE's snum number is 46 which means we need to support
+		/* If QE's snum number is 46/76 which means we need to support
 		 * 4 UECs at 1000Base-T simultaneously, we need to allocate
 		 * more Threads to Rx.
 		 */
-		if (qe_get_num_of_snums() == 46)
+		if (qe_get_num_of_snums() == 76 || qe_get_num_of_snums() == 46)
 			ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_6;
 		else
 			ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_4;
-- 
1.6.4
