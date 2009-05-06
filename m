Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC209DDDA5
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 20:44:41 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n46AiaBR023706
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 03:44:37 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n46AiZYT013464
	for <linuxppc-dev@ozlabs.org>; Wed, 6 May 2009 05:44:35 -0500 (CDT)
From: Dave Liu <daveliu@freescale.com>
To: drzeus-sdhci@drzeus.cx
Subject: [PATCH] mmc: Fix the wrong accessor to HOSTVER register
Date: Wed,  6 May 2009 18:40:07 +0800
Message-Id: <1241606407-18685-1-git-send-email-daveliu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx, ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Freescale eSDHC controller has the special order for
the HOST version register. that is not same as the other's
registers. The address of HOSTVER in spec is 0xFE, and
we need use the in_be16(0xFE) to access it, not in_be16(0xFC).

Signed-off-by: Dave Liu <daveliu@freescale.com>
---
 drivers/mmc/host/sdhci-of.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 3ff4ac3..e167131 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -55,7 +55,13 @@ static u32 esdhc_readl(struct sdhci_host *host, int reg)
 
 static u16 esdhc_readw(struct sdhci_host *host, int reg)
 {
-	return in_be16(host->ioaddr + (reg ^ 0x2));
+	u16 ret;
+
+	if (unlikely(reg == SDHCI_HOST_VERSION))
+		ret = in_be16(host->ioaddr + reg);
+	else
+		ret = in_be16(host->ioaddr + (reg ^ 0x2));
+	return ret;
 }
 
 static u8 esdhc_readb(struct sdhci_host *host, int reg)
-- 
1.5.4
