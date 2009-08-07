Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CB9F1B7BD0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 05:58:08 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 5F353DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 05:58:08 +1000 (EST)
Date: Fri, 7 Aug 2009 23:58:06 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/7] sdhci-of: Avoid writing reserved bits into host
	control register
Message-ID: <20090807195806.GB2735@oksana.dev.rtsoft.ru>
References: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben@fluff.org>, sdhci-devel@lists.ossman.eu,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Pierre Ossman <pierre@ossman.eu>, David Vrabel <david.vrabel@csr.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SDHCI core tries to write HISPD bit into the host control register,
but the eSDHC controllers don't have that bit, and that causes
all sorts of misbehaviour when using 4-bit mode capable SD cards.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci-of.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 92b5667..8440fd9 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -48,6 +48,8 @@ struct sdhci_of_host {
 #define ESDHC_CLOCK_HCKEN	0x00000002
 #define ESDHC_CLOCK_IPGEN	0x00000001
 
+#define ESDHC_HOST_CONTROL_RES	0x05
+
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	return in_be32(host->ioaddr + reg);
@@ -109,6 +111,10 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 	int base = reg & ~0x3;
 	int shift = (reg & 0x3) * 8;
 
+	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
+	if (reg == SDHCI_HOST_CONTROL)
+		val &= ~ESDHC_HOST_CONTROL_RES;
+
 	clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);
 }
 
-- 
1.6.3.3
