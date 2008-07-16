Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 662F9DDF0C
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 09:22:31 +1000 (EST)
Date: Wed, 16 Jul 2008 18:21:46 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 1/6] crypto: talitos - remove calls to of_node_put
Message-Id: <20080716182146.0b095f5d.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Lee Nipper <lee.nipper@freescale.com>

Remove of_node_put calls since there is no corresponding of_node_get.
This patch prevents an exception when talitos is loaded a 2nd time.
This sequence: modprobe talitos; rmmod talitos; modprobe talitos
causes this message: "WARNING: Bad of_node_put() on /soc8349@e0000000/crypto@30000".

Signed-off-by: Lee Nipper <lee.nipper@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
this patchseries contains various fixes to the talitos driver, mainly as a
result of Lee's stress testing.

 drivers/crypto/talitos.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index b11943d..01e6595 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1466,9 +1466,6 @@ static int talitos_probe(struct of_device *ofdev,
 		goto err_out;
 	}
 
-	of_node_put(np);
-	np = NULL;
-
 	priv->head_lock = kmalloc(sizeof(spinlock_t) * priv->num_channels,
 				  GFP_KERNEL);
 	priv->tail_lock = kmalloc(sizeof(spinlock_t) * priv->num_channels,
@@ -1559,8 +1556,6 @@ static int talitos_probe(struct of_device *ofdev,
 
 err_out:
 	talitos_remove(ofdev);
-	if (np)
-		of_node_put(np);
 
 	return err;
 }
-- 
1.5.6
