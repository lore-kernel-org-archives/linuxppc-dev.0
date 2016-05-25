Return-Path: <claudiu.manoil@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0086.outbound.protection.outlook.com [157.56.110.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rF4ps3jnjzDqVL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:15:48 +1000 (AEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <scottwood@freescale.com>
Subject: [PATCH][v2] powerpc/85xx: Don't report SRAM to L2 cache fallback as
 error
Date: Wed, 25 May 2016 10:58:42 +0300
Message-ID: <1464163122-32320-1-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the SRAM region parameters are missing the SRAM driver
probing exits and the L2 region is configured as L2 cache
entirely.  This is the expected default behaviour, so it
makes no sense to report it as an error.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: drop info print on Scott's request

 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index 861cebf..c27058e 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -90,12 +90,8 @@ static int mpc85xx_l2ctlr_of_probe(struct platform_device *dev)
 	}
 	l2cache_size = *prop;
 
-	if (get_cache_sram_params(&sram_params)) {
-		dev_err(&dev->dev,
-			"Entire L2 as cache, provide valid sram offset and size\n");
-		return -EINVAL;
-	}
-
+	if (get_cache_sram_params(&sram_params))
+		return 0; /* fall back to L2 cache only */
 
 	rem = l2cache_size % sram_params.sram_size;
 	ways = LOCK_WAYS_FULL * sram_params.sram_size / l2cache_size;
-- 
1.7.11.7
