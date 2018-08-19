Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41tqdL5d30zF1S4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 07:21:56 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Sun, 19 Aug 2018 21:21:47 +0100 (BST)
Message-ID: <4c6da03c92f.ac1d78@auth.smtp.1and1.co.uk>
Subject: [PATCH NEXT v2 2/4] powerpc/pasemi: Add Nemo board IRQ initroutine
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c124c6049b4ee29.54"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6c124c6049b4ee29.54
Content-Type: text/plain

Add a IRQ init routine for the Nemo board which inits and attatches
the i8259 found in the SB600, and a cascade routine to dispatch the
interrupts.

Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

---

----=_BOUNDARY.6c124c6049b4ee29.54
Content-Type: text/plain;
	name="irq.patch"
Content-Disposition: attachment;
	filename="irq.patch";
	size=1435

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 9a6eb04..fad5280 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -34,6 +34,7 @@
 #include <asm/prom.h>
 #include <asm/iommu.h>
 #include <asm/machdep.h>
+#include <asm/i8259.h>
 #include <asm/mpic.h>
 #include <asm/smp.h>
 #include <asm/time.h>
@@ -183,6 +184,42 @@ static int __init pas_setup_mce_regs(void)
 }
 machine_device_initcall(pasemi, pas_setup_mce_regs);
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+static void sb600_8259_cascade(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int cascade_irq = i8259_irq();
+
+	if (cascade_irq)
+               generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
+static void nemo_init_IRQ(struct mpic *mpic)
+{
+	struct device_node *np;
+	int gpio_virq;
+	/* Connect the SB600's legacy i8259 controller */
+	np = of_find_node_by_path("/pxp@0,e0000000");
+	i8259_init(np, 0);
+	of_node_put(np);
+
+	gpio_virq = irq_create_mapping(NULL, 3);
+	irq_set_irq_type(gpio_virq, IRQ_TYPE_LEVEL_HIGH);
+	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
+	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
+
+	irq_set_default_host(mpic->irqhost);
+}
+
+#else
+
+static inline void nemo_init_IRQ(struct mpic *mpic)
+{
+}
+#endif
+
 static __init void pas_init_IRQ(void)
 {
 	struct device_node *np;

----=_BOUNDARY.6c124c6049b4ee29.54--
