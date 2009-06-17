Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D5D10B70DD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 11:55:56 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 17 Jun 2009 11:55:18 +1000
Subject: [PATCH 1/2] powerpc/of: Fix usage of dev_set_name() in
	of_device_alloc()
Message-Id: <20090617015556.C3AAADDDA1@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dev_set_name() takes a format string, so use it properly and avoid
a warning with recent gcc's

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/of_device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/of_device.c	2009-06-17 11:34:54.000000000 +1000
+++ linux-work/arch/powerpc/kernel/of_device.c	2009-06-17 11:35:04.000000000 +1000
@@ -76,7 +76,7 @@ struct of_device *of_device_alloc(struct
 	dev->dev.archdata.of_node = np;
 
 	if (bus_id)
-		dev_set_name(&dev->dev, bus_id);
+		dev_set_name(&dev->dev, "%s", bus_id);
 	else
 		of_device_make_bus_id(dev);
 
