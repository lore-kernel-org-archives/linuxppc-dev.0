Return-Path: <roel.kluin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6AE87B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 00:43:39 +1000 (EST)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id C58CEDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 00:43:37 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 5so1049748qwi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Sep 2009 07:43:35 -0700 (PDT)
Message-ID: <4AA7C095.7090009@gmail.com>
Date: Wed, 09 Sep 2009 16:49:57 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] 82xx: kmalloc failure ignored in ep8248e_mdio_probe()
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Prevent NULL dereference if kmalloc() fails. Also clean up if
of_mdiobus_register() returns an error.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found with sed: http://kernelnewbies.org/roelkluin

Please review.

diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
index 51fcae4..f9aee18 100644
--- a/arch/powerpc/platforms/82xx/ep8248e.c
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -132,12 +132,25 @@ static int __devinit ep8248e_mdio_probe(struct of_device *ofdev,
 		return -ENOMEM;
 
 	bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
+	if (bus->irq == NULL) {
+		ret = -ENOMEM;
+		goto err_free_bus;
+	}
 
 	bus->name = "ep8248e-mdio-bitbang";
 	bus->parent = &ofdev->dev;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
 
-	return of_mdiobus_register(bus, ofdev->node);
+	ret = of_mdiobus_register(bus, ofdev->node);
+	if (ret)
+		goto err_free_irq;
+
+	return 0;
+err_free_irq:
+	kfree(bus->irq);
+err_free_bus:
+	free_mdio_bitbang(bus);
+	return ret;
 }
 
 static int ep8248e_mdio_remove(struct of_device *ofdev)
