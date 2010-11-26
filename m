Return-Path: <r58472@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74A2DB70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Nov 2010 19:37:58 +1100 (EST)
Received: from mail36-am1 (localhost.localdomain [127.0.0.1])	by
	mail36-am1-R.bigfish.com (Postfix) with ESMTP id D4D8113F04E9	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 26 Nov 2010 08:37:51 +0000 (UTC)
Received: from AM1EHSMHS006.bigfish.com (unknown [10.3.201.248])	by
	mail36-am1.bigfish.com (Postfix) with ESMTP id 7C08F14B804C	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 26 Nov 2010 08:37:51 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oAQ8dYnM023246	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 26 Nov 2010 01:39:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oAQ8tYtw029254	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Nov 2010 02:55:35 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>
Subject: [PATCH] ucc_geth: fix ucc halt problem in half duplex mode
Date: Fri, 26 Nov 2010 17:29:58 +0800
Message-ID: <1290763798-22844-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Jean-Denis Boyer <jdboyer@media5corp.com>,
	Andreas Schmitz <Andreas.Schmitz@riedel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 58933c64(ucc_geth: Fix the wrong the Rx/Tx FIFO size),
the UCC_GETH_UTFTT_INIT is set to 512 based on the recommendation
of the QE Reference Manual.  But that will sometimes cause tx halt
while working in half duplex mode.

According to errata draft QE_GENERAL-A003(High Tx Virtual FIFO
threshold size can cause UCC to halt), setting UTFTT less than
[(UTFS x (M - 8)/M) - 128] will prevent this from happening
(M is the minimum buffer size).

The patch changes UTFTT back to 256.

Signed-off-by: Li Yang <leoli@freescale.com>
Cc: Jean-Denis Boyer <jdboyer@media5corp.com>
Cc: Andreas Schmitz <Andreas.Schmitz@riedel.net>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/ucc_geth.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth.h b/drivers/net/ucc_geth.h
index 05a9558..a78b9c0 100644
--- a/drivers/net/ucc_geth.h
+++ b/drivers/net/ucc_geth.h
@@ -899,7 +899,8 @@ struct ucc_geth_hardware_statistics {
 #define UCC_GETH_UTFS_INIT                      512	/* Tx virtual FIFO size
 							 */
 #define UCC_GETH_UTFET_INIT                     256	/* 1/2 utfs */
-#define UCC_GETH_UTFTT_INIT                     512
+#define UCC_GETH_UTFTT_INIT                     256	/* 1/2 utfs
+							   due to errata */
 /* Gigabit Ethernet (1000 Mbps) */
 #define UCC_GETH_URFS_GIGA_INIT                 4096/*2048*/	/* Rx virtual
 								   FIFO size */
-- 
1.6.6-rc1.GIT
