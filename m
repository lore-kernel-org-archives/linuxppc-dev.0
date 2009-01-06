Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B029DE599
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 10:13:08 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	avorontsov@ru.mvista.com
Subject: [PATCH] powerpc: add Ethernet UPSMR definitions to QE library
Date: Tue,  6 Jan 2009 17:12:23 -0600
Message-Id: <1231283543-26752-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the UCC_GETH_UPSMR_xxx definitions to qe.h.  The ucc_geth driver will
eventually use these instead of the UPSMR_ macros it currently defines.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/include/asm/qe.h |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index edee15d..a355e72 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -591,7 +591,7 @@ struct ucc_slow_pram {
 #define UCC_GETH_UCCE_RXF1      0x00000002
 #define UCC_GETH_UCCE_RXF0      0x00000001
 
-/* UPSMR, when used as a UART */
+/* UCC Protocol Specific Mode Register (UPSMR), when used for UART */
 #define UCC_UART_UPSMR_FLC		0x8000
 #define UCC_UART_UPSMR_SL		0x4000
 #define UCC_UART_UPSMR_CL_MASK		0x3000
@@ -619,6 +619,23 @@ struct ucc_slow_pram {
 #define UCC_UART_UPSMR_TPM_EVEN		0x0002
 #define UCC_UART_UPSMR_TPM_HIGH		0x0003
 
+/* UCC Protocol Specific Mode Register (UPSMR), when used for Ethernet */
+#define UCC_GETH_UPSMR_FTFE     0x80000000
+#define UCC_GETH_UPSMR_PTPE     0x40000000
+#define UCC_GETH_UPSMR_ECM      0x04000000
+#define UCC_GETH_UPSMR_HSE      0x02000000
+#define UCC_GETH_UPSMR_PRO      0x00400000
+#define UCC_GETH_UPSMR_CAP      0x00200000
+#define UCC_GETH_UPSMR_RSH      0x00100000
+#define UCC_GETH_UPSMR_RPM      0x00080000
+#define UCC_GETH_UPSMR_R10M     0x00040000
+#define UCC_GETH_UPSMR_RLPB     0x00020000
+#define UCC_GETH_UPSMR_TBIM     0x00010000
+#define UCC_GETH_UPSMR_RES1     0x00002000
+#define UCC_GETH_UPSMR_RMM      0x00001000
+#define UCC_GETH_UPSMR_CAM      0x00000400
+#define UCC_GETH_UPSMR_BRO      0x00000200
+
 /* UCC Transmit On Demand Register (UTODR) */
 #define UCC_SLOW_TOD	0x8000
 #define UCC_FAST_TOD	0x8000
-- 
1.5.5
