Return-Path: <thierry.reding@gmail.com>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 431E82C00F6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 23:26:37 +1000 (EST)
Received: by mail-bk0-f50.google.com with SMTP id mz11so2890005bkb.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 06:26:04 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <rob.herring@calxeda.com>,
 Grant Likely <grant.likely@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 01/10] of/irq: Rework of_irq_count()
Date: Wed, 18 Sep 2013 15:24:43 +0200
Message-Id: <1379510692-32435-2-git-send-email-treding@nvidia.com>
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
Cc: linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The of_irq_to_resource() helper that is used to implement of_irq_count()
tries to resolve interrupts and in fact creates a mapping for resolved
interrupts. That's pretty heavy lifting for something that claims to
just return the number of interrupts requested by a given device node.

Instead, use the more lightweight of_irq_map_one(), which, despite the
name, doesn't create an actual mapping. Perhaps a better name would be
of_irq_translate_one().

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 1752988..5f44388 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -368,9 +368,10 @@ EXPORT_SYMBOL_GPL(of_irq_to_resource);
  */
 int of_irq_count(struct device_node *dev)
 {
+	struct of_irq irq;
 	int nr = 0;
 
-	while (of_irq_to_resource(dev, nr, NULL))
+	while (of_irq_map_one(dev, nr, &irq) == 0)
 		nr++;
 
 	return nr;
-- 
1.8.4
