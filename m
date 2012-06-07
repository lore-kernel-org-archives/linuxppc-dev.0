Return-Path: <R1AAHA@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 38283B6FAC
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2012 10:51:42 +1000 (EST)
Date: Wed, 6 Jun 2012 19:49:42 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <linux-edac@vger.kernel.org>
Subject: [PATCH] mpc85xx_edac: fix error: too few arguments to function
 'edac_mc_alloc'
Message-ID: <20120606194942.1c25679a3062ba90ef53307f@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Mauro Carvalho Chehab <mchehab@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit ca0907b "edac: Remove the legacy EDAC ABI" broke mpc85xx_edac
in the following manner:

mpc85xx_edac.c:983:35: error: too few arguments to function 'edac_mc_alloc'

this patch puts back the missing 'layers' argument.

Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/edac/mpc85xx_edac.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 4c40235..0e37462 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -980,7 +980,8 @@ static int __devinit mpc85xx_mc_err_probe(struct platform_device *op)
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = 1;
 	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(edac_mc_idx, ARRAY_SIZE(layers), sizeof(*pdata));
+	mci = edac_mc_alloc(edac_mc_idx, ARRAY_SIZE(layers), layers,
+			    sizeof(*pdata));
 	if (!mci) {
 		devres_release_group(&op->dev, mpc85xx_mc_err_probe);
 		return -ENOMEM;
-- 
1.7.10.2
