Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9B2D92C0405
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 19:14:34 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <rob.herring@calxeda.com>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 14/25] powerpc/83xx: add a const qualifier
Date: Mon, 23 Jul 2012 11:13:19 +0200
Message-Id: <1343034810-3386-15-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	arch/powerpc/platforms/83xx/suspend.c: In function 'pmc_probe':
	arch/powerpc/platforms/83xx/suspend.c:336:7: error: assignment discards 'const' qualifier from pointer target type [-Werror]

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/platforms/83xx/suspend.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index 1a04671..1d769a2 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -326,7 +326,7 @@ static int pmc_probe(struct platform_device *ofdev)
 	const struct of_device_id *match;
 	struct device_node *np = ofdev->dev.of_node;
 	struct resource res;
-	struct pmc_type *type;
+	const struct pmc_type *type;
 	int ret = 0;
 
 	match = of_match_device(pmc_match, &ofdev->dev);
-- 
1.7.10.4
