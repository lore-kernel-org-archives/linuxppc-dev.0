Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7qc74m5czDqn0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 00:04:55 +1100 (AEDT)
Message-Id: <b4dbdec1ba02c2829ebcbf479eca3bfeac09391b.1507284818.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1507284818.git.christophe.leroy@c-s.fr>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 10/18] crypto: talitos - use of_property_read_u32()
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri,  6 Oct 2017 15:04:51 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use of_property_read_u32() to simplify DT read

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 2a53d0f2a869..f139a0cef2e2 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3158,7 +3158,6 @@ static int talitos_probe(struct platform_device *ofdev)
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
 	struct talitos_private *priv;
-	const unsigned int *prop;
 	int i, err;
 	int stride;
 
@@ -3182,21 +3181,11 @@ static int talitos_probe(struct platform_device *ofdev)
 	}
 
 	/* get SEC version capabilities from device tree */
-	prop = of_get_property(np, "fsl,num-channels", NULL);
-	if (prop)
-		priv->num_channels = *prop;
-
-	prop = of_get_property(np, "fsl,channel-fifo-len", NULL);
-	if (prop)
-		priv->chfifo_len = *prop;
-
-	prop = of_get_property(np, "fsl,exec-units-mask", NULL);
-	if (prop)
-		priv->exec_units = *prop;
-
-	prop = of_get_property(np, "fsl,descriptor-types-mask", NULL);
-	if (prop)
-		priv->desc_types = *prop;
+	of_property_read_u32(np, "fsl,num-channels", &priv->num_channels);
+	of_property_read_u32(np, "fsl,channel-fifo-len", &priv->chfifo_len);
+	of_property_read_u32(np, "fsl,exec-units-mask", &priv->exec_units);
+	of_property_read_u32(np, "fsl,descriptor-types-mask",
+			     &priv->desc_types);
 
 	if (!is_power_of_2(priv->num_channels) || !priv->chfifo_len ||
 	    !priv->exec_units || !priv->desc_types) {
-- 
2.13.3
