Return-Path: <B42677@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C2842C0116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 21:02:41 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/4 V2] mmc: esdhc: Correct host version of T4240-R1.0
Date: Wed, 17 Jul 2013 18:11:30 +0800
Message-ID: <1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, cjb@laptop.org, AFLEMING@freescale.com,
 Haijun Zhang <haijun.zhang@freescale.com>, cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vender version and sdhc spec version of T4240-R1.0 is incorrect.
The right value should be VVN=0x13, SVN = 0x1. The wrong version
number will break down the ADMA data transfer.
This defect only exist in T4240-R1.0. Will be fixed in T4240-R2.0.
Also share vvn and svr for public use.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
changes for V2:
	- Remove broken ADMA quirk.
	- Rebuild patch of  Add quirks to support T4240 board

 drivers/mmc/host/sdhci-of-esdhc.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index adfaadd..570bca8 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -26,7 +26,7 @@
 #define VENDOR_V_22	0x12
 #define VENDOR_V_23	0x13
 
-static u32 svr;
+static u32 svr, vvn;
 
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
@@ -43,11 +43,9 @@ static u32 esdhc_readl(struct sdhci_host *host, int reg)
 	 * For FSL eSDHC, must aligned 4-byte, so use 0xFC to read the
 	 * the verdor version number, oxFE is SDHCI_HOST_VERSION.
 	 */
-	if ((reg == SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1)) {
-		u32 tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
-		tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
-		if (tmp > VENDOR_V_22)
-			ret |= SDHCI_CAN_DO_ADMA2;
+	if ((reg == SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1) &&
+		(vvn > VENDOR_V_22)) {
+		ret |= SDHCI_CAN_DO_ADMA2;
 	}
 
 	return ret;
@@ -63,6 +61,12 @@ static u16 esdhc_readw(struct sdhci_host *host, int reg)
 		ret = in_be32(host->ioaddr + base) & 0xffff;
 	else
 		ret = (in_be32(host->ioaddr + base) >> shift) & 0xffff;
+
+	/* T4240-R1.0 had a incorrect vendor version and spec version */
+	if ((reg == SDHCI_HOST_VERSION) &&
+		((SVR_SOC_VER(svr) == SVR_T4240) && (SVR_REV(svr) == 0x10)))
+		ret = (VENDOR_V_23 << SDHCI_VENDOR_VER_SHIFT) | SDHCI_SPEC_200;
+
 	return ret;
 }
 
@@ -175,17 +179,12 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
  */
 static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
 {
-	u32 tmp;
 	bool applicable;
 	dma_addr_t dmastart;
 	dma_addr_t dmanow;
 
-	tmp = esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
-	tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
-
 	applicable = (intmask & SDHCI_INT_DATA_END) &&
-		(intmask & SDHCI_INT_BLK_GAP) &&
-		(tmp == VENDOR_V_23);
+		(intmask & SDHCI_INT_BLK_GAP) && (vvn == VENDOR_V_23);
 	if (applicable) {
 
 		esdhc_reset(host, SDHCI_RESET_DATA);
@@ -318,10 +317,9 @@ static void esdhc_of_resume(struct sdhci_host *host)
 
 static void esdhc_of_platform_init(struct sdhci_host *host)
 {
-	u32 vvn;
+	svr = mfspr(SPRN_SVR);
+	vvn = esdhc_readw(host, SDHCI_HOST_VERSION);
 
-	vvn = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
-	vvn = (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
 	if (vvn == VENDOR_V_22)
 		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
 
@@ -390,7 +388,6 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	struct device_node *np;
 	int ret;
 
-	svr = mfspr(SPRN_SVR);
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
 	if (IS_ERR(host))
 		return PTR_ERR(host);
-- 
1.8.0
