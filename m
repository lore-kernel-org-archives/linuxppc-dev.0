Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sN8Bs71yNzDqB7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 21:12:53 +1000 (AEST)
Subject: [PATCH 4/5] powerpc-MSI-HSTA: Rename jump labels in hsta_msi_probe()
To: linuxppc-dev@lists.ozlabs.org, Adam Buchbinder
 <adam.buchbinder@gmail.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>
References: <566ABCD9.1060404@users.sourceforge.net>
 <fe8faf9e-01bb-4f3e-8258-ecb37ba15c9f@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <f6c6b735-ade9-a4f8-505b-a5eacd055de1@users.sourceforge.net>
Date: Mon, 29 Aug 2016 13:12:18 +0200
MIME-Version: 1.0
In-Reply-To: <fe8faf9e-01bb-4f3e-8258-ecb37ba15c9f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 29 Aug 2016 11:22:19 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
index 691db9a..3097ddd 100644
--- a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
@@ -154,14 +154,14 @@ static int hsta_msi_probe(struct platform_device *pdev)
 
 	ret = msi_bitmap_alloc(&ppc4xx_hsta_msi.bmp, irq_count, dev->of_node);
 	if (ret)
-		goto out;
+		goto unmap_io;
 
 	ppc4xx_hsta_msi.irq_map = kmalloc_array(irq_count,
 						sizeof(*ppc4xx_hsta_msi.irq_map),
 						GFP_KERNEL);
 	if (!ppc4xx_hsta_msi.irq_map) {
 		ret = -ENOMEM;
-		goto out1;
+		goto free_bitmap;
 	}
 
 	/* Setup a mapping from irq offsets to hardware irq numbers */
@@ -171,7 +171,7 @@ static int hsta_msi_probe(struct platform_device *pdev)
 		if (ppc4xx_hsta_msi.irq_map[irq] == NO_IRQ) {
 			dev_err(dev, "Unable to map IRQ\n");
 			ret = -EINVAL;
-			goto out2;
+			goto free_irq_map;
 		}
 	}
 
@@ -180,14 +180,11 @@ static int hsta_msi_probe(struct platform_device *pdev)
 		phb->controller_ops.teardown_msi_irqs = hsta_teardown_msi_irqs;
 	}
 	return 0;
-
-out2:
+ free_irq_map:
 	kfree(ppc4xx_hsta_msi.irq_map);
-
-out1:
+ free_bitmap:
 	msi_bitmap_free(&ppc4xx_hsta_msi.bmp);
-
-out:
+ unmap_io:
 	iounmap(ppc4xx_hsta_msi.data);
 	return ret;
 }
-- 
2.9.3
