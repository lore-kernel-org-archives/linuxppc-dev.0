Return-Path: <himangi774@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6892E1A007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 03:36:02 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id kp14so6055871pab.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 10:35:58 -0700 (PDT)
Date: Mon, 19 May 2014 23:05:51 +0530
From: Himangi Saraogi <himangi774@gmail.com>
To: Olof Johansson <olof@lixom.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dt/powerpc: Introduce the use of the managed version of
 kzalloc
Message-ID: <20140519173550.GA10502@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: julia.lawall@lip6.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch moves data allocated using kzalloc to managed data allocated
using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
functions. Also, the now unnecessary labels out_free_priv and out are
done away with.

The following Coccinelle semantic patch was used for making the change:

@platform@
identifier p, probefn, removefn;
@@
struct platform_driver p = {
  .probe = probefn,
  .remove = removefn,
};

@prb@
identifier platform.probefn, pdev;
expression e, e1, e2;
@@
probefn(struct platform_device *pdev, ...) {
  <+...
- e = kzalloc(e1, e2)
+ e = devm_kzalloc(&pdev->dev, e1, e2)
  ...
?-kfree(e);
  ...+>
}

@rem depends on prb@
identifier platform.removefn;
expression e;
@@
removefn(...) {
  <...
- kfree(e);
  ...>
}

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
Not compile tested due to incompatible architecture

 arch/powerpc/platforms/pasemi/gpio_mdio.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index 15adee5..a722a4a 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -226,15 +226,14 @@ static int gpio_mdio_probe(struct platform_device *ofdev)
 	const unsigned int *prop;
 	int err;
 
-	err = -ENOMEM;
-	priv = kzalloc(sizeof(struct gpio_priv), GFP_KERNEL);
+	priv = devm_kzalloc(&ofdev->dev, sizeof(struct gpio_priv), GFP_KERNEL);
 	if (!priv)
-		goto out;
+		return -ENOMEM;
 
 	new_bus = mdiobus_alloc();
 
 	if (!new_bus)
-		goto out_free_priv;
+		return -ENOMEM;
 
 	new_bus->name = "pasemi gpio mdio bus";
 	new_bus->read = &gpio_mdio_read;
@@ -268,9 +267,6 @@ static int gpio_mdio_probe(struct platform_device *ofdev)
 
 out_free_irq:
 	kfree(new_bus);
-out_free_priv:
-	kfree(priv);
-out:
 	return err;
 }
 
@@ -283,7 +279,6 @@ static int gpio_mdio_remove(struct platform_device *dev)
 
 	dev_set_drvdata(&dev->dev, NULL);
 
-	kfree(bus->priv);
 	bus->priv = NULL;
 	mdiobus_free(bus);
 
-- 
1.9.1
