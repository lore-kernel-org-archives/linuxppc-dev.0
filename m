Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z8vnN2DQJzDr1l
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jan 2018 09:16:55 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Sun, 31 Dec 2017 22:04:10 +0000 (GMT)
Message-ID: <4b3d1fd01f9.613e9d05@auth.smtp.1and1.co.uk>
Subject: [PATCH NEXT 2/4] powerpc/pasemi: Add Nemo board IRQ init routine
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c3689404196289f.50"
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

----=_BOUNDARY.6c3689404196289f.50
Content-Type: text/plain

    Add a IRQ init routine for the Nemo board which also inits and attatches
    the i8259 found in the SB600.
    
    Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

---

----=_BOUNDARY.6c3689404196289f.50
Content-Type: text/plain;
	name="irq.patch"
Content-Disposition: attachment;
	filename="irq.patch";
	size=3025

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index c4a3e93..c583c17 100644
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
@@ -183,6 +184,99 @@ static int __init pas_setup_mce_regs(void)
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
+static __init void nemo_init_IRQ(void)
+{
+	struct device_node *np;
+	struct device_node *root, *mpic_node, *i8259_node;
+	unsigned long openpic_addr;
+	const unsigned int *opprop;
+	int naddr, opplen;
+	int mpic_flags;
+	const unsigned int *nmiprop;
+	struct mpic *mpic;
+	int gpio_virq;
+
+	mpic_node = NULL;
+
+	for_each_node_by_type(np, "interrupt-controller")
+		if (of_device_is_compatible(np, "open-pic")) {
+			mpic_node = np;
+			break;
+		}
+	if (!mpic_node)
+		for_each_node_by_type(np, "open-pic") {
+			mpic_node = np;
+			break;
+		}
+	if (!mpic_node) {
+		printk(KERN_ERR
+			"Failed to locate the MPIC interrupt controller\n");
+		return;
+	}
+
+	/* Find address list in /platform-open-pic */
+	root = of_find_node_by_path("/");
+	naddr = of_n_addr_cells(root);
+	opprop = of_get_property(root, "platform-open-pic", &opplen);
+	if (!opprop) {
+		printk(KERN_ERR "No platform-open-pic property.\n");
+		of_node_put(root);
+		return;
+	}
+	openpic_addr = of_read_number(opprop, naddr);
+	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
+
+	mpic_flags = MPIC_LARGE_VECTORS | MPIC_NO_BIAS | MPIC_NO_RESET;
+
+	nmiprop = of_get_property(mpic_node, "nmi-source", NULL);
+	if (nmiprop)
+		mpic_flags |= MPIC_ENABLE_MCK;
+
+	mpic = mpic_alloc(mpic_node, openpic_addr,
+			  mpic_flags, 0, 0, "PASEMI-OPIC");
+	BUG_ON(!mpic);
+
+	mpic_assign_isu(mpic, 0, mpic->paddr + 0x10000);
+	mpic_init(mpic);
+	/* The NMI/MCK source needs to be prio 15 */
+	if (nmiprop) {
+		nmi_virq = irq_create_mapping(NULL, *nmiprop);
+		mpic_irq_set_priority(nmi_virq, 15);
+		irq_set_irq_type(nmi_virq, IRQ_TYPE_EDGE_RISING);
+		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
+	}
+
+
+	/* Connect the SB600's legacy i8259 controller */
+	i8259_node = of_find_node_by_path("/pxp@0,e0000000");
+	i8259_init(i8259_node, 0);
+	of_node_put(i8259_node);
+
+	gpio_virq = irq_create_mapping(NULL, 3);
+	irq_set_irq_type(gpio_virq, IRQ_TYPE_LEVEL_HIGH);
+	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
+	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
+
+	irq_set_default_host(mpic->irqhost);
+
+	of_node_put(mpic_node);
+	of_node_put(root);
+
+}
+#endif
+
 static __init void pas_init_IRQ(void)
 {
 	struct device_node *np;

----=_BOUNDARY.6c3689404196289f.50--
