Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B4477B7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 02:40:58 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 50D5CDDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 02:40:58 +1000 (EST)
Date: Fri, 7 Aug 2009 20:40:57 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/4] sdhci-of: Fix SD clock calculation
Message-ID: <20090807164057.GA13464@oksana.dev.rtsoft.ru>
References: <20090807163940.GA29192@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090807163940.GA29192@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben@fluff.org>, linux-kernel@vger.kernel.org,
	sdhci-devel@lists.ossman.eu, linuxppc-dev@ozlabs.org,
	Pierre Ossman <pierre@ossman.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linear divisor's values in a register start at 0 (zero means
"divide by 1"). Before this patch the code didn't account that
fact, so SD cards were running underclocked.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci-of.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 9088443..92b5667 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -136,6 +136,7 @@ static void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	pre_div >>= 1;
+	div--;
 
 	setbits32(host->ioaddr + ESDHC_SYSTEM_CONTROL, ESDHC_CLOCK_IPGEN |
 		  ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN |
-- 
1.6.3.3
