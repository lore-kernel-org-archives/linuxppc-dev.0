Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCNDq4zrCzDqxy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 09:45:47 +1100 (AEDT)
Received: by mail-oi0-f68.google.com with SMTP id g6so2026672oib.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 14:45:47 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: cell: use irq_of_parse_and_map helper
Date: Thu,  4 Jan 2018 16:45:41 -0600
Message-Id: <20180104224542.15333-3-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of calling both of_irq_parse_one and irq_create_of_mapping, call
of_irq_parse_and_map instead which does the same thing. This gets us closer
to making the former 2 functions static.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/platforms/cell/spu_manage.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index f636ee22b203..2e01ad5df492 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -180,35 +180,22 @@ static int __init spu_map_device_old(struct spu *spu)

 static int __init spu_map_interrupts(struct spu *spu, struct device_node *np)
 {
-	struct of_phandle_args oirq;
-	int ret;
 	int i;

 	for (i=0; i < 3; i++) {
-		ret = of_irq_parse_one(np, i, &oirq);
-		if (ret) {
-			pr_debug("spu_new: failed to get irq %d\n", i);
-			goto err;
-		}
-		ret = -EINVAL;
-		pr_debug("  irq %d no 0x%x on %pOF\n", i, oirq.args[0],
-			 oirq.np);
-		spu->irqs[i] = irq_create_of_mapping(&oirq);
-		if (!spu->irqs[i]) {
-			pr_debug("spu_new: failed to map it !\n");
+		spu->irqs[i] = irq_of_parse_and_map(np, i);
+		if (!spu->irqs[i])
 			goto err;
-		}
 	}
 	return 0;

 err:
-	pr_debug("failed to map irq %x for spu %s\n", *oirq.args,
-		spu->name);
+	pr_debug("failed to map irq %x for spu %s\n", i, spu->name);
 	for (; i >= 0; i--) {
 		if (spu->irqs[i])
 			irq_dispose_mapping(spu->irqs[i]);
 	}
-	return ret;
+	return -EINVAL;
 }

 static int spu_map_resource(struct spu *spu, int nr,
--
2.14.1
