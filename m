Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sN8Cp423bzDsQb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 21:13:42 +1000 (AEST)
Subject: [PATCH 5/5] powerpc-MSI-HSTA: Move three assignments in
 hsta_msi_probe()
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
Message-ID: <4fd422ec-6133-65dd-0a0c-e8613fd4820d@users.sourceforge.net>
Date: Mon, 29 Aug 2016 13:13:12 +0200
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
Date: Mon, 29 Aug 2016 11:30:48 +0200

Move the assignments for three data structure members to the end
so that they will only be performed if the desired resource allocations
succeeded by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
index 3097ddd..57014ce 100644
--- a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
@@ -143,10 +143,7 @@ static int hsta_msi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ppc4xx_hsta_msi.dev = dev;
-	ppc4xx_hsta_msi.address = mem->start;
 	ppc4xx_hsta_msi.data = ioremap(mem->start, resource_size(mem));
-	ppc4xx_hsta_msi.irq_count = irq_count;
 	if (!ppc4xx_hsta_msi.data) {
 		dev_err(dev, "Unable to map memory\n");
 		return -ENOMEM;
@@ -179,6 +176,10 @@ static int hsta_msi_probe(struct platform_device *pdev)
 		phb->controller_ops.setup_msi_irqs = hsta_setup_msi_irqs;
 		phb->controller_ops.teardown_msi_irqs = hsta_teardown_msi_irqs;
 	}
+
+	ppc4xx_hsta_msi.dev = dev;
+	ppc4xx_hsta_msi.address = mem->start;
+	ppc4xx_hsta_msi.irq_count = irq_count;
 	return 0;
  free_irq_map:
 	kfree(ppc4xx_hsta_msi.irq_map);
-- 
2.9.3
