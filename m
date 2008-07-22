Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id A43A6DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 17:14:14 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1438513wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 00:14:12 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/mpc5200: add PSC SICR bit definitions
To: linuxppc-dev@ozlabs.org
Date: Tue, 22 Jul 2008 01:14:10 -0600
Message-ID: <20080722071410.8690.44322.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Required by the PSC I2S audio driver.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 include/asm-powerpc/mpc52xx_psc.h |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/mpc52xx_psc.h b/include/asm-powerpc/mpc52xx_psc.h
index 5467c2c..8917ed6 100644
--- a/include/asm-powerpc/mpc52xx_psc.h
+++ b/include/asm-powerpc/mpc52xx_psc.h
@@ -60,10 +60,12 @@
 #define MPC52xx_PSC_RXTX_FIFO_ALARM	0x0002
 #define MPC52xx_PSC_RXTX_FIFO_EMPTY	0x0001
 
-/* PSC interrupt mask bits */
+/* PSC interrupt status/mask bits */
 #define MPC52xx_PSC_IMR_TXRDY		0x0100
 #define MPC52xx_PSC_IMR_RXRDY		0x0200
 #define MPC52xx_PSC_IMR_DB		0x0400
+#define MPC52xx_PSC_IMR_TXEMP		0x0800
+#define MPC52xx_PSC_IMR_ORERR		0x1000
 #define MPC52xx_PSC_IMR_IPC		0x8000
 
 /* PSC input port change bit */
@@ -92,6 +94,34 @@
 
 #define MPC52xx_PSC_RFNUM_MASK	0x01ff
 
+#define MPC52xx_PSC_SICR_DTS1			(1 << 29)
+#define MPC52xx_PSC_SICR_SHDR			(1 << 28)
+#define MPC52xx_PSC_SICR_SIM_MASK		(0xf << 24)
+#define MPC52xx_PSC_SICR_SIM_UART		(0x0 << 24)
+#define MPC52xx_PSC_SICR_SIM_UART_DCD		(0x8 << 24)
+#define MPC52xx_PSC_SICR_SIM_CODEC_8		(0x1 << 24)
+#define MPC52xx_PSC_SICR_SIM_CODEC_16		(0x2 << 24)
+#define MPC52xx_PSC_SICR_SIM_AC97		(0x3 << 24)
+#define MPC52xx_PSC_SICR_SIM_SIR		(0x8 << 24)
+#define MPC52xx_PSC_SICR_SIM_SIR_DCD		(0xc << 24)
+#define MPC52xx_PSC_SICR_SIM_MIR		(0x5 << 24)
+#define MPC52xx_PSC_SICR_SIM_FIR		(0x6 << 24)
+#define MPC52xx_PSC_SICR_SIM_CODEC_24		(0x7 << 24)
+#define MPC52xx_PSC_SICR_SIM_CODEC_32		(0xf << 24)
+#define MPC52xx_PSC_SICR_GENCLK			(1 << 23)
+#define MPC52xx_PSC_SICR_I2S			(1 << 22)
+#define MPC52xx_PSC_SICR_CLKPOL			(1 << 21)
+#define MPC52xx_PSC_SICR_SYNCPOL		(1 << 20)
+#define MPC52xx_PSC_SICR_CELLSLAVE		(1 << 19)
+#define MPC52xx_PSC_SICR_CELL2XCLK		(1 << 18)
+#define MPC52xx_PSC_SICR_ESAI			(1 << 17)
+#define MPC52xx_PSC_SICR_ENAC97			(1 << 16)
+#define MPC52xx_PSC_SICR_SPI			(1 << 15)
+#define MPC52xx_PSC_SICR_MSTR			(1 << 14)
+#define MPC52xx_PSC_SICR_CPOL			(1 << 13)
+#define MPC52xx_PSC_SICR_CPHA			(1 << 12)
+#define MPC52xx_PSC_SICR_USEEOF			(1 << 11)
+#define MPC52xx_PSC_SICR_DISABLEEOF		(1 << 10)
 
 /* Structure of the hardware registers */
 struct mpc52xx_psc {
