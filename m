Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA687C48BC3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Feb 2024 15:41:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tg0qc3t2Vz3vXX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Feb 2024 02:41:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=ukl@pengutronix.de; receiver=lists.ozlabs.org)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tg0q40qj4z3cML
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2024 02:40:46 +1100 (AEDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcoi4-0003mQ-O6; Wed, 21 Feb 2024 16:40:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcoi4-0024B8-Ad; Wed, 21 Feb 2024 16:40:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcoi4-008uv8-0i;
	Wed, 21 Feb 2024 16:40:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5/6] powerpc: fsl_msi: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 16:40:19 +0100
Message-ID: <42d8e3721053dce21ea373a24cb37fb0f59eed26.1708529736.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708529736.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708529736.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=6wL4elibviE13Qv+1O6PDAfQtFc//5sf09sSXO5Ik7w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1hllxFPbP6+IIGKKvkk5Ws4Lt7VVSolYdoVHG eN7s2rqluaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdYZZQAKCRCPgPtYfRL+ TqbkB/9La74GIZJCNSzzvQ7gCfSrnyvErHtHyXEdSl5q3IbnyyPh9e2hT43VC7/wZThw40qdYlC dU3tSt+hgFMOSMXa7+2jQDOfnYkQOQGKuD8U8UDBounvDQGQN/mIVJ/QqxMT+5mhTMQhh6TB25P a1sBAx5sDsA6EorQlXHuwmoLPLDqyBuNlStFOTgFWcKX1Qp+Nr14Gzjji2PBC0WthYGay+lh+HR 9SIonp1e2UBiuX5AI8uD4S5noZel4hp8Bm57I7qS2kbFaFJnAyZQ7L4TxdV3lvhmFEAkxkrNYwR Ju//dxeuymA47NJ5kUoS4H2iMLViSHxefbG9z42YRZW0ROof
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linuxppc-dev@lists.ozlabs.org
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, kernel@pengutronix.de, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/sysdev/fsl_msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 558ec68d768e..8e6c84df4ca1 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -320,7 +320,7 @@ static irqreturn_t fsl_msi_cascade(int irq, void *data)
 	return ret;
 }
 
-static int fsl_of_msi_remove(struct platform_device *ofdev)
+static void fsl_of_msi_remove(struct platform_device *ofdev)
 {
 	struct fsl_msi *msi = platform_get_drvdata(ofdev);
 	int virq, i;
@@ -343,8 +343,6 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 	if ((msi->feature & FSL_PIC_IP_MASK) != FSL_PIC_IP_VMPIC)
 		iounmap(msi->msi_regs);
 	kfree(msi);
-
-	return 0;
 }
 
 static struct lock_class_key fsl_msi_irq_class;
@@ -603,7 +601,7 @@ static struct platform_driver fsl_of_msi_driver = {
 		.of_match_table = fsl_of_msi_ids,
 	},
 	.probe = fsl_of_msi_probe,
-	.remove = fsl_of_msi_remove,
+	.remove_new = fsl_of_msi_remove,
 };
 
 static __init int fsl_of_msi_init(void)
-- 
2.43.0

