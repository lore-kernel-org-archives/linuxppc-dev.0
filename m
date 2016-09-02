Return-Path: <julia.lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQrgH5W5QzDsd9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 06:43:21 +1000 (AEST)
Date: Fri, 2 Sep 2016 22:43:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 ksummit-discuss@lists.linuxfoundation.org,
 "Nikula, Jani" <jani.nikula@linux.intel.com>,
 Dave Airlie <airlied@linux.ie>, Grant Likely <grant.likely@linaro.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Ksummit-discuss] [CORE TOPIC] (group) maintainership models
In-Reply-To: <CA+55aFzw-KkQOhVJG+c-WEFA=6o5aXy=yU9KXQ7jwy-xy--d9Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1609022241560.3378@hadrien>
References: <CAKMK7uEuqLLf2bCyB-sAuu5WvVA1Kp7Jvc33k3um5DfdQr4eyg@mail.gmail.com>
 <20160902104619.GD9355@localhost>
 <CA+55aFwSpNrOuOzaR5hh0A1XvuTu0=xVbE_CV1RVf9GMrTPDNQ@mail.gmail.com>
 <7359509.5sppVSLXcK@wuerfel>
 <CA+55aFzw-KkQOhVJG+c-WEFA=6o5aXy=yU9KXQ7jwy-xy--d9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Fri, 2 Sep 2016, Linus Torvalds wrote:

> On Fri, Sep 2, 2016 at 1:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > When I once looked, I thought all drivers using NO_IRQ were specific
> > to powerpc or one of the less common architectures.
>
> powerpc definitely does seem to be the biggest case, with about half
> the instances of NO_IRQ being under arch/powerpc/ (and a few more in
> ppc-specific drivers).
>
> Adding the powerpc maintainers to the list - because it would really
> be nice to get rid of it, or at least make it *so* rare that we don't
> have people re-introducing it again because they thought it was the
> right thing to do.
>
> A fair amount of of it could even be done by some trivial scripting.
> Something like
>
>   git grep -wl NO_IRQ arch/powerpc/ | while read a
>   do
>       sed 's/(\([a-z_]*irq\) != NO_IRQ)/(\1)/' < $a > $a.new
>       sed 's/(\([a-z_]*irq\) == NO_IRQ)/(!\1)/' < $a.new > $a
>   done
>
> does fix at least a few of the cases. It still leaves several
> assignments and "return NO_IRQ;" statements, but a few more
> sed-scripts would take care of most of it. Then remove the #define,
> and do a full build to find any straggling cases.

Like this?

@@
expression e;
@@

e
- != NO_IRQ

@@
expression e;
@@

+!
e
- == NO_IRQ

@@
@@

- NO_IRQ
+ 0

---

Is it always correct to replace return NO_IRQ by return 0?

Completely untested patch below.

julia

diff -u -p a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -511,7 +511,7 @@ unsigned int mpc52xx_get_irq(void)
 			irq |= (MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET);
 		}
 	} else {
-		return NO_IRQ;
+		return 0;
 	}

 	return irq_linear_revmap(mpc52xx_irqhost, irq);
diff -u -p a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -368,7 +368,7 @@ static void chrp_8259_cascade(struct irq
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();

-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);

 	chip->irq_eoi(&desc->irq_data);
@@ -514,7 +514,7 @@ static void __init chrp_find_8259(void)
 	}
 	if (chrp_mpic != NULL) {
 		cascade_irq = irq_of_parse_and_map(pic, 0);
-		if (cascade_irq == NO_IRQ)
+		if (!cascade_irq)
 			printk(KERN_ERR "i8259: failed to map cascade irq\n");
 		else
 			irq_set_chained_handler(cascade_irq,
diff -u -p a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -552,7 +552,7 @@ void maple_pci_irq_fixup(struct pci_dev
 	    pci_bus_to_host(dev->bus) == u4_pcie) {
 		printk(KERN_DEBUG "Fixup U4 PCIe IRQ\n");
 		dev->irq = irq_create_mapping(NULL, 1);
-		if (dev->irq != NO_IRQ)
+		if (dev->irq)
 			irq_set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
 	}

@@ -562,7 +562,7 @@ void maple_pci_irq_fixup(struct pci_dev
 	if (dev->vendor == PCI_VENDOR_ID_AMD &&
 	    dev->device == PCI_DEVICE_ID_AMD_8111_IDE &&
 	    (dev->class & 5) != 5) {
-		dev->irq = NO_IRQ;
+		dev->irq = 0;
 	}

 	DBG(" <- maple_pci_irq_fixup\n");
@@ -648,7 +648,7 @@ int maple_pci_get_legacy_ide_irq(struct
 		return defirq;
 	}
 	irq = irq_of_parse_and_map(np, channel & 0x1);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		printk("Failed to map onboard IDE interrupt for channel %d\n",
 		       channel);
 		return defirq;
diff -u -p a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -181,7 +181,7 @@ unsigned int flipper_pic_get_irq(void)
 	irq_status = in_be32(io_base + FLIPPER_ICR) &
 		     in_be32(io_base + FLIPPER_IMR);
 	if (irq_status == 0)
-		return NO_IRQ;	/* no more IRQs pending */
+		return 0;	/* no more IRQs pending */

 	irq = __ffs(irq_status);
 	return irq_linear_revmap(flipper_irq_host, irq);
diff -u -p a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -114,7 +114,7 @@ static unsigned int __hlwd_pic_get_irq(s
 	irq_status = in_be32(io_base + HW_BROADWAY_ICR) &
 		     in_be32(io_base + HW_BROADWAY_IMR);
 	if (irq_status == 0)
-		return NO_IRQ;	/* no more IRQs pending */
+		return 0;	/* no more IRQs pending */

 	irq = __ffs(irq_status);
 	return irq_linear_revmap(h, irq);
@@ -131,7 +131,7 @@ static void hlwd_pic_irq_cascade(struct
 	raw_spin_unlock(&desc->lock);

 	virq = __hlwd_pic_get_irq(irq_domain);
-	if (virq != NO_IRQ)
+	if (virq)
 		generic_handle_irq(virq);
 	else
 		pr_err("spurious interrupt!\n");
diff -u -p a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -47,7 +47,7 @@ static void mvme5100_8259_cascade(struct
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();

-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);

 	chip->irq_eoi(&desc->irq_data);
@@ -84,7 +84,7 @@ static void __init mvme5100_pic_init(voi
 	}

 	cirq = irq_of_parse_and_map(cp, 0);
-	if (cirq == NO_IRQ) {
+	if (!cirq) {
 		pr_warn("mvme5100_pic_init: no cascade interrupt?\n");
 		return;
 	}
diff -u -p a/arch/powerpc/platforms/pasemi/misc.c b/arch/powerpc/platforms/pasemi/misc.c
--- a/arch/powerpc/platforms/pasemi/misc.c
+++ b/arch/powerpc/platforms/pasemi/misc.c
@@ -76,7 +76,7 @@ static int __init pasemi_register_i2c_de
 			}

 			info.irq = irq_of_parse_and_map(node, 0);
-			if (info.irq == NO_IRQ)
+			if (!info.irq)
 				info.irq = -1;

 			if (find_i2c_driver(node, &info) < 0)
diff -u -p a/arch/powerpc/platforms/pasemi/msi.c b/arch/powerpc/platforms/pasemi/msi.c
--- a/arch/powerpc/platforms/pasemi/msi.c
+++ b/arch/powerpc/platforms/pasemi/msi.c
@@ -68,7 +68,7 @@ static void pasemi_msi_teardown_msi_irqs
 	pr_debug("pasemi_msi_teardown_msi_irqs, pdev %p\n", pdev);

 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;

 		hwirq = virq_to_hw(entry->irq);
@@ -109,7 +109,7 @@ static int pasemi_msi_setup_msi_irqs(str
 		}

 		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			pr_debug("pasemi_msi: failed mapping hwirq 0x%x\n",
 				  hwirq);
 			msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq,
diff -u -p a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -59,7 +59,7 @@ struct mce_regs {

 static struct mce_regs mce_regs[MAX_MCE_REGS];
 static int num_mce_regs;
-static int nmi_virq = NO_IRQ;
+static int nmi_virq = 0;


 static void __noreturn pas_restart(char *cmd)
@@ -264,7 +264,7 @@ static int pas_machine_check_handler(str
 	srr0 = regs->nip;
 	srr1 = regs->msr;

-	if (nmi_virq != NO_IRQ && mpic_get_mcirq() == nmi_virq) {
+	if (nmi_virq && mpic_get_mcirq() == nmi_virq) {
 		printk(KERN_ERR "NMI delivered\n");
 		debugger(regs);
 		mpic_end_irq(irq_get_irq_data(nmi_virq));
diff -u -p a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -76,7 +76,7 @@ void __init mpc85xx_cpm2_pic_init(void)
 		return;
 	}
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		of_node_put(np);
 		printk(KERN_ERR "PIC init: got no IRQ for cpm cascade\n");
 		return;
diff -u -p a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -78,7 +78,7 @@ static inline unsigned int socrates_fpga
 			break;
 	}
 	if (i == 3)
-		return NO_IRQ;
+		return 0;

 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
 	cause = socrates_fpga_pic_read(FPGA_PIC_IRQMASK(i));
@@ -103,7 +103,7 @@ static void socrates_fpga_pic_cascade(st
 	 */
 	cascade_irq = socrates_fpga_pic_get_irq(irq);

-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);
 	chip->irq_eoi(&desc->irq_data);
 }
@@ -292,7 +292,7 @@ void socrates_fpga_pic_init(struct devic

 	for (i = 0; i < 3; i++) {
 		socrates_fpga_irqs[i] = irq_of_parse_and_map(pic, i);
-		if (socrates_fpga_irqs[i] == NO_IRQ) {
+		if (!socrates_fpga_irqs[i]) {
 			pr_warning("FPGA PIC: can't get irq%d.\n", i);
 			continue;
 		}
diff -u -p a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -196,7 +196,7 @@ static void mpc85xx_8259_cascade_handler
 {
 	unsigned int cascade_irq = i8259_irq();

-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		/* handle an interrupt from the 8259 */
 		generic_handle_irq(cascade_irq);

@@ -247,7 +247,7 @@ static int mpc85xx_cds_8259_attach(void)
 	}

 	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
-	if (cascade_irq == NO_IRQ) {
+	if (!cascade_irq) {
 		printk(KERN_ERR "Failed to map cascade interrupt\n");
 		return -ENXIO;
 	}
diff -u -p a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -51,7 +51,7 @@ static void mpc85xx_8259_cascade(struct
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();

-	if (cascade_irq != NO_IRQ) {
+	if (cascade_irq) {
 		generic_handle_irq(cascade_irq);
 	}
 	chip->irq_eoi(&desc->irq_data);
@@ -96,7 +96,7 @@ void __init mpc85xx_ds_pic_init(void)
 	}

 	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
-	if (cascade_irq == NO_IRQ) {
+	if (!cascade_irq) {
 		printk(KERN_ERR "Failed to map cascade interrupt\n");
 		return;
 	}
diff -u -p a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -352,7 +352,7 @@ static int pmc_probe(struct platform_dev
 		return -ENODEV;

 	pmc_irq = irq_of_parse_and_map(np, 0);
-	if (pmc_irq != NO_IRQ) {
+	if (pmc_irq) {
 		ret = request_irq(pmc_irq, pmc_irq_handler, IRQF_SHARED,
 		                  "pmc", ofdev);

@@ -400,7 +400,7 @@ out_syscr:
 out_pmc:
 	iounmap(pmc_regs);
 out:
-	if (pmc_irq != NO_IRQ)
+	if (pmc_irq)
 		free_irq(pmc_irq, ofdev);

 	return ret;
diff -u -p a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -89,7 +89,7 @@ static int __init of_fsl_spi_probe(char
 			goto err;

 		ret = of_irq_to_resource(np, 0, &res[1]);
-		if (ret == NO_IRQ)
+		if (!ret)
 			goto err;

 		pdev = platform_device_alloc("mpc83xx_spi", i);
diff -u -p a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -204,7 +204,7 @@ static void pika_setup_critical_temp(str
 	i2c_smbus_write_byte_data(client, 3,  0); /* Tlow */

 	irq = irq_of_parse_and_map(np, 0);
-	if (irq  == NO_IRQ) {
+	if (!irq) {
 		printk(KERN_ERR __FILE__ ": Unable to get ad7414 irq\n");
 		return;
 	}
diff -u -p a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -22,7 +22,7 @@ static void mpc86xx_8259_cascade(struct
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();

-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);

 	chip->irq_eoi(&desc->irq_data);
@@ -58,7 +58,7 @@ void __init mpc86xx_init_irq(void)
 	}

 	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
-	if (cascade_irq == NO_IRQ) {
+	if (!cascade_irq) {
 		printk(KERN_ERR "Failed to map cascade interrupt\n");
 		return;
 	}
diff -u -p a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -119,7 +119,7 @@ static void rtas_teardown_msi_irqs(struc
 	struct msi_desc *entry;

 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;

 		irq_set_msi_desc(entry->irq, NULL);
@@ -471,7 +471,7 @@ again:

 		virq = irq_create_mapping(NULL, hwirq);

-		if (virq == NO_IRQ) {
+		if (!virq) {
 			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);
 			return -ENOSPC;
 		}
@@ -490,7 +490,7 @@ again:
 static void rtas_msi_pci_irq_fixup(struct pci_dev *pdev)
 {
 	/* No LSI -> leave MSIs (if any) configured */
-	if (pdev->irq == NO_IRQ) {
+	if (!pdev->irq) {
 		dev_dbg(&pdev->dev, "rtas_msi: no LSI, nothing to do.\n");
 		return;
 	}
diff -u -p a/arch/powerpc/platforms/pseries/event_sources.c b/arch/powerpc/platforms/pseries/event_sources.c
--- a/arch/powerpc/platforms/pseries/event_sources.c
+++ b/arch/powerpc/platforms/pseries/event_sources.c
@@ -34,7 +34,7 @@ void request_event_sources_irqs(struct d
 		if (count > 15)
 			break;
 		virqs[count] = irq_create_of_mapping(&oirq);
-		if (virqs[count] == NO_IRQ) {
+		if (!virqs[count]) {
 			pr_err("event-sources: Unable to allocate "
 			       "interrupt number for %s\n",
 			       np->full_name);
diff -u -p a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -114,7 +114,7 @@ static void pseries_8259_cascade(struct
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();

-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);

 	chip->irq_eoi(&desc->irq_data);
@@ -141,7 +141,7 @@ static void __init pseries_setup_i8259_c
 	}

 	cascade = irq_of_parse_and_map(found, 0);
-	if (cascade == NO_IRQ) {
+	if (!cascade) {
 		printk(KERN_ERR "pic: failed to map cascade interrupt");
 		return;
 	}
diff -u -p a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -192,7 +192,7 @@ static int ps3_virq_setup(enum ps3_cpu_b

 	*virq = irq_create_mapping(NULL, outlet);

-	if (*virq == NO_IRQ) {
+	if (!*virq) {
 		FAIL("%s:%d: irq_create_mapping failed: outlet %lu\n",
 			__func__, __LINE__, outlet);
 		result = -ENOMEM;
@@ -339,7 +339,7 @@ int ps3_event_receive_port_setup(enum ps
 	if (result) {
 		FAIL("%s:%d: lv1_construct_event_receive_port failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
-		*virq = NO_IRQ;
+		*virq = 0;
 		return result;
 	}

@@ -418,7 +418,7 @@ int ps3_sb_event_receive_port_setup(stru
 			" failed: %s\n", __func__, __LINE__,
 			ps3_result(result));
 		ps3_event_receive_port_destroy(*virq);
-		*virq = NO_IRQ;
+		*virq = 0;
 		return result;
 	}

@@ -724,12 +724,12 @@ static unsigned int ps3_get_irq(void)
 	asm volatile("cntlzd %0,%1" : "=r" (plug) : "r" (x));
 	plug &= 0x3f;

-	if (unlikely(plug == NO_IRQ)) {
+	if (unlikely(!plug)) {
 		DBG("%s:%d: no plug found: thread_id %llu\n", __func__,
 			__LINE__, pd->thread_id);
 		dump_bmp(&per_cpu(ps3_private, 0));
 		dump_bmp(&per_cpu(ps3_private, 1));
-		return NO_IRQ;
+		return 0;
 	}

 #if defined(DEBUG)
diff -u -p a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -91,7 +91,7 @@ static void __init ps3_smp_probe(void)
 			result = smp_request_message_ipi(virqs[i], i);

 			if (result)
-				virqs[i] = NO_IRQ;
+				virqs[i] = 0;
 			else
 				ps3_register_ipi_irq(cpu, virqs[i]);
 		}
@@ -112,7 +112,7 @@ void ps3_smp_cleanup_cpu(int cpu)
 	for (i = 0; i < MSG_COUNT; i++) {
 		/* Can't call free_irq from interrupt context. */
 		ps3_event_receive_port_destroy(virqs[i]);
-		virqs[i] = NO_IRQ;
+		virqs[i] = 0;
 	}

 	DBG(" <- %s:%d: (%d)\n", __func__, __LINE__, cpu);
diff -u -p a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -284,7 +284,7 @@ fail_alloc_2:
 fail_alloc_1:
 	ps3_spe_irq_destroy(spu->irqs[0]);
 fail_alloc_0:
-	spu->irqs[0] = spu->irqs[1] = spu->irqs[2] = NO_IRQ;
+	spu->irqs[0] = spu->irqs[1] = spu->irqs[2] = 0;
 	return result;
 }

@@ -334,7 +334,7 @@ static int ps3_destroy_spu(struct spu *s
 	ps3_spe_irq_destroy(spu->irqs[1]);
 	ps3_spe_irq_destroy(spu->irqs[0]);

-	spu->irqs[0] = spu->irqs[1] = spu->irqs[2] = NO_IRQ;
+	spu->irqs[0] = spu->irqs[1] = spu->irqs[2] = 0;

 	spu_unmap(spu);

diff -u -p a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -251,7 +251,7 @@ static unsigned int pmac_pic_get_irq(voi
 	}
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 	if (unlikely(irq < 0))
-		return NO_IRQ;
+		return 0;
 	return irq_linear_revmap(pmac_pic_host, irq);
 }

@@ -389,7 +389,7 @@ static void __init pmac_pic_probe_oldsty
 		out_le32(&pmac_irq_hw[i]->enable, 0);

 	/* Hookup cascade irq */
-	if (slave && pmac_irq_cascade != NO_IRQ)
+	if (slave && pmac_irq_cascade)
 		setup_irq(pmac_irq_cascade, &gatwick_cascade_action);

 	printk(KERN_INFO "irq: System has %d possible interrupts\n", max_irqs);
@@ -444,7 +444,7 @@ static void __init pmac_pic_setup_mpic_n
 	pswitch = of_find_node_by_name(NULL, "programmer-switch");
 	if (pswitch) {
 		nmi_irq = irq_of_parse_and_map(pswitch, 0);
-		if (nmi_irq != NO_IRQ) {
+		if (nmi_irq) {
 			mpic_irq_set_priority(nmi_irq, 9);
 			setup_irq(nmi_irq, &xmon_action);
 		}
diff -u -p a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -401,7 +401,7 @@ static int kw_i2c_xfer(struct pmac_i2c_b
 {
 	struct pmac_i2c_host_kw *host = bus->hostdata;
 	u8 mode_reg = host->speed;
-	int use_irq = host->irq != NO_IRQ && !bus->polled;
+	int use_irq = host->irq && !bus->polled;

 	/* Setup mode & subaddress if any */
 	switch(bus->mode) {
@@ -535,7 +535,7 @@ static struct pmac_i2c_host_kw *__init k
 		break;
 	}
 	host->irq = irq_of_parse_and_map(np, 0);
-	if (host->irq == NO_IRQ)
+	if (!host->irq)
 		printk(KERN_WARNING
 		       "low_i2c: Failed to map interrupt for %s\n",
 		       np->full_name);
@@ -557,7 +557,7 @@ static struct pmac_i2c_host_kw *__init k
 	 */
 	if (request_irq(host->irq, kw_i2c_irq, IRQF_NO_SUSPEND,
 			"keywest i2c", host))
-		host->irq = NO_IRQ;
+		host->irq = 0;

 	printk(KERN_INFO "KeyWest i2c @0x%08x irq %d %s\n",
 	       *addrp, host->irq, np->full_name);
diff -u -p a/arch/powerpc/platforms/powermac/pfunc_base.c b/arch/powerpc/platforms/powermac/pfunc_base.c
--- a/arch/powerpc/platforms/powermac/pfunc_base.c
+++ b/arch/powerpc/platforms/powermac/pfunc_base.c
@@ -26,7 +26,7 @@ static irqreturn_t macio_gpio_irq(int ir
 static int macio_do_gpio_irq_enable(struct pmf_function *func)
 {
 	unsigned int irq = irq_of_parse_and_map(func->node, 0);
-	if (irq == NO_IRQ)
+	if (!irq)
 		return -EINVAL;
 	return request_irq(irq, macio_gpio_irq, 0, func->node->name, func);
 }
@@ -34,7 +34,7 @@ static int macio_do_gpio_irq_enable(stru
 static int macio_do_gpio_irq_disable(struct pmf_function *func)
 {
 	unsigned int irq = irq_of_parse_and_map(func->node, 0);
-	if (irq == NO_IRQ)
+	if (!irq)
 		return -EINVAL;
 	free_irq(irq, func);
 	return 0;
diff -u -p a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -97,7 +97,7 @@ cpld_pic_get_irq(int offset, u8 ignore,
 	status |= (ignore | mask);

 	if (status == 0xff)
-		return NO_IRQ;
+		return 0;

 	cpld_irq = ffz(status) + offset;

@@ -110,14 +110,14 @@ static void cpld_pic_cascade(struct irq_

 	irq = cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_status,
 		&cpld_regs->pci_mask);
-	if (irq != NO_IRQ) {
+	if (irq) {
 		generic_handle_irq(irq);
 		return;
 	}

 	irq = cpld_pic_get_irq(8, MISC_IGNORE, &cpld_regs->misc_status,
 		&cpld_regs->misc_mask);
-	if (irq != NO_IRQ) {
+	if (irq) {
 		generic_handle_irq(irq);
 		return;
 	}
@@ -177,7 +177,7 @@ mpc5121_ads_cpld_pic_init(void)
 		goto end;

 	cascade_irq = irq_of_parse_and_map(np, 0);
-	if (cascade_irq == NO_IRQ)
+	if (!cascade_irq)
 		goto end;

 	/*
diff -u -p a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
--- a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
+++ b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
@@ -473,7 +473,7 @@ static int mpc512x_lpbfifo_probe(struct
 	}

 	lpbfifo.irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (lpbfifo.irq == NO_IRQ) {
+	if (!lpbfifo.irq) {
 		dev_err(&pdev->dev, "mapping irq failed\n");
 		ret = -ENODEV;
 		goto err0;
diff -u -p a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -241,6 +241,6 @@ void __init mpc8xx_pics_init(void)
 	}

 	irq = cpm_pic_init();
-	if (irq != NO_IRQ)
+	if (irq)
 		irq_set_chained_handler(irq, cpm_cascade);
 }
diff -u -p a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -131,7 +131,7 @@ int __init pq2ads_pci_init_irq(void)
 	}

 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		printk(KERN_ERR "No interrupt in pci pic node.\n");
 		of_node_put(np);
 		goto out;
diff -u -p a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -402,7 +402,7 @@ static int spu_request_irqs(struct spu *
 {
 	int ret = 0;

-	if (spu->irqs[0] != NO_IRQ) {
+	if (spu->irqs[0]) {
 		snprintf(spu->irq_c0, sizeof (spu->irq_c0), "spe%02d.0",
 			 spu->number);
 		ret = request_irq(spu->irqs[0], spu_irq_class_0,
@@ -410,7 +410,7 @@ static int spu_request_irqs(struct spu *
 		if (ret)
 			goto bail0;
 	}
-	if (spu->irqs[1] != NO_IRQ) {
+	if (spu->irqs[1]) {
 		snprintf(spu->irq_c1, sizeof (spu->irq_c1), "spe%02d.1",
 			 spu->number);
 		ret = request_irq(spu->irqs[1], spu_irq_class_1,
@@ -418,7 +418,7 @@ static int spu_request_irqs(struct spu *
 		if (ret)
 			goto bail1;
 	}
-	if (spu->irqs[2] != NO_IRQ) {
+	if (spu->irqs[2]) {
 		snprintf(spu->irq_c2, sizeof (spu->irq_c2), "spe%02d.2",
 			 spu->number);
 		ret = request_irq(spu->irqs[2], spu_irq_class_2,
@@ -429,10 +429,10 @@ static int spu_request_irqs(struct spu *
 	return 0;

 bail2:
-	if (spu->irqs[1] != NO_IRQ)
+	if (spu->irqs[1])
 		free_irq(spu->irqs[1], spu);
 bail1:
-	if (spu->irqs[0] != NO_IRQ)
+	if (spu->irqs[0])
 		free_irq(spu->irqs[0], spu);
 bail0:
 	return ret;
@@ -440,11 +440,11 @@ bail0:

 static void spu_free_irqs(struct spu *spu)
 {
-	if (spu->irqs[0] != NO_IRQ)
+	if (spu->irqs[0])
 		free_irq(spu->irqs[0], spu);
-	if (spu->irqs[1] != NO_IRQ)
+	if (spu->irqs[1])
 		free_irq(spu->irqs[1], spu);
-	if (spu->irqs[2] != NO_IRQ)
+	if (spu->irqs[2])
 		free_irq(spu->irqs[2], spu);
 }

diff -u -p a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -123,7 +123,7 @@ static void iic_ioexc_cascade(struct irq
 				unsigned int cirq =
 					irq_linear_revmap(iic_host,
 							  base | cascade);
-				if (cirq != NO_IRQ)
+				if (cirq)
 					generic_handle_irq(cirq);
 			}
 		/* post-ack level interrupts */
@@ -153,10 +153,10 @@ static unsigned int iic_get_irq(void)
 	*(unsigned long *) &pending =
 		in_be64((u64 __iomem *) &iic->regs->pending_destr);
 	if (!(pending.flags & CBE_IIC_IRQ_VALID))
-		return NO_IRQ;
+		return 0;
 	virq = irq_linear_revmap(iic_host, iic_pending_to_hwnum(pending));
-	if (virq == NO_IRQ)
-		return NO_IRQ;
+	if (!virq)
+		return 0;
 	iic->eoi_stack[++iic->eoi_ptr] = pending.prio;
 	BUG_ON(iic->eoi_ptr > 15);
 	return virq;
@@ -198,7 +198,7 @@ static void iic_request_ipi(int msg)
 	int virq;

 	virq = irq_create_mapping(iic_host, iic_msg_to_irq(msg));
-	if (virq == NO_IRQ) {
+	if (!virq) {
 		printk(KERN_ERR
 		       "iic: failed to map IPI %s\n", smp_ipi_name[msg]);
 		return;
@@ -353,7 +353,7 @@ static int __init setup_iic(void)
 		cascade |= 1 << IIC_IRQ_CLASS_SHIFT;
 		cascade |= IIC_UNIT_IIC;
 		cascade = irq_create_mapping(iic_host, cascade);
-		if (cascade == NO_IRQ)
+		if (!cascade)
 			continue;
 		/*
 		 * irq_data is a generic pointer that gets passed back
diff -u -p a/arch/powerpc/platforms/cell/pmu.c b/arch/powerpc/platforms/cell/pmu.c
--- a/arch/powerpc/platforms/cell/pmu.c
+++ b/arch/powerpc/platforms/cell/pmu.c
@@ -385,7 +385,7 @@ static int __init cbe_init_pm_irq(void)
 	for_each_online_node(node) {
 		irq = irq_create_mapping(NULL, IIC_IRQ_IOEX_PMI |
 					       (node << IIC_IRQ_NODE_SHIFT));
-		if (irq == NO_IRQ) {
+		if (!irq) {
 			printk("ERROR: Unable to allocate irq for node %d\n",
 			       node);
 			return -EINVAL;
@@ -412,7 +412,7 @@ void cbe_sync_irq(int node)
 			       IIC_IRQ_IOEX_PMI
 			       | (node << IIC_IRQ_NODE_SHIFT));

-	if (irq == NO_IRQ) {
+	if (!irq) {
 		printk(KERN_WARNING "ERROR, unable to get existing irq %d " \
 		"for node %d\n", irq, node);
 		return;
diff -u -p a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -207,11 +207,11 @@ static void spider_irq_cascade(struct ir

 	cs = in_be32(pic->regs + TIR_CS) >> 24;
 	if (cs == SPIDER_IRQ_INVALID)
-		virq = NO_IRQ;
+		virq = 0;
 	else
 		virq = irq_linear_revmap(pic->host, cs);

-	if (virq != NO_IRQ)
+	if (virq)
 		generic_handle_irq(virq);

 	chip->irq_eoi(&desc->irq_data);
@@ -245,19 +245,19 @@ static unsigned int __init spider_find_c
 	/* Now do the horrible hacks */
 	tmp = of_get_property(of_node, "#interrupt-cells", NULL);
 	if (tmp == NULL)
-		return NO_IRQ;
+		return 0;
 	intsize = *tmp;
 	imap = of_get_property(of_node, "interrupt-map", &imaplen);
 	if (imap == NULL || imaplen < (intsize + 1))
-		return NO_IRQ;
+		return 0;
 	iic = of_find_node_by_phandle(imap[intsize]);
 	if (iic == NULL)
-		return NO_IRQ;
+		return 0;
 	imap += intsize + 1;
 	tmp = of_get_property(iic, "#interrupt-cells", NULL);
 	if (tmp == NULL) {
 		of_node_put(iic);
-		return NO_IRQ;
+		return 0;
 	}
 	intsize = *tmp;
 	/* Assume unit is last entry of interrupt specifier */
@@ -266,7 +266,7 @@ static unsigned int __init spider_find_c
 	tmp = of_get_property(iic, "ibm,interrupt-server-ranges", NULL);
 	if (tmp == NULL) {
 		of_node_put(iic);
-		return NO_IRQ;
+		return 0;
 	}
 	/* ugly as hell but works for now */
 	pic->node_id = (*tmp) >> 1;
@@ -281,7 +281,7 @@ static unsigned int __init spider_find_c
 				  (pic->node_id << IIC_IRQ_NODE_SHIFT) |
 				  (2 << IIC_IRQ_CLASS_SHIFT) |
 				  unit);
-	if (virq == NO_IRQ)
+	if (!virq)
 		printk(KERN_ERR "spider_pic: failed to map cascade !");
 	return virq;
 }
@@ -318,7 +318,7 @@ static void __init spider_init_one(struc

 	/* Hook up the cascade interrupt to the iic and nodeid */
 	virq = spider_find_cascade_and_node(pic);
-	if (virq == NO_IRQ)
+	if (!virq)
 		return;
 	irq_set_handler_data(virq, pic);
 	irq_set_chained_handler(virq, spider_irq_cascade);
diff -u -p a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -105,7 +105,7 @@ static int __init spu_map_interrupts_old
 	spu->irqs[2] = irq_create_mapping(NULL, IIC_IRQ_CLASS_2 | isrc);

 	/* Right now, we only fail if class 2 failed */
-	return spu->irqs[2] == NO_IRQ ? -EINVAL : 0;
+	return !spu->irqs[2] ? -EINVAL : 0;
 }

 static void __iomem * __init spu_map_prop_old(struct spu *spu,
@@ -191,7 +191,7 @@ static int __init spu_map_interrupts(str
 		pr_debug("  irq %d no 0x%x on %s\n", i, oirq.args[0],
 			 oirq.np->full_name);
 		spu->irqs[i] = irq_create_of_mapping(&oirq);
-		if (spu->irqs[i] == NO_IRQ) {
+		if (!spu->irqs[i]) {
 			pr_debug("spu_new: failed to map it !\n");
 			goto err;
 		}
@@ -202,7 +202,7 @@ err:
 	pr_debug("failed to map irq %x for spu %s\n", *oirq.args,
 		spu->name);
 	for (; i >= 0; i--) {
-		if (spu->irqs[i] != NO_IRQ)
+		if (spu->irqs[i])
 			irq_dispose_mapping(spu->irqs[i]);
 	}
 	return ret;
diff -u -p a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -411,7 +411,7 @@ static void cell_iommu_enable_hardware(s

 	virq = irq_create_mapping(NULL,
 			IIC_IRQ_IOEX_ATI | (iommu->nid << IIC_IRQ_NODE_SHIFT));
-	BUG_ON(virq == NO_IRQ);
+	BUG_ON(!virq);

 	ret = request_irq(virq, ioc_interrupt, 0, iommu->name, iommu);
 	BUG_ON(ret);
diff -u -p a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -271,7 +271,7 @@ static int axon_msi_setup_msi_irqs(struc

 	for_each_pci_msi_entry(entry, dev) {
 		virq = irq_create_direct_mapping(msic->irq_domain);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			dev_warn(&dev->dev,
 				 "axon_msi: virq allocation failed!\n");
 			return -1;
@@ -293,7 +293,7 @@ static void axon_msi_teardown_msi_irqs(s
 	dev_dbg(&dev->dev, "axon_msi: tearing down msi irqs\n");

 	for_each_pci_msi_entry(entry, dev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;

 		irq_set_msi_desc(entry->irq, NULL);
@@ -375,7 +375,7 @@ static int axon_msi_probe(struct platfor
 	}

 	virq = irq_of_parse_and_map(dn, 0);
-	if (virq == NO_IRQ) {
+	if (!virq) {
 		printk(KERN_ERR "axon_msi: irq parse and map failed for %s\n",
 		       dn->full_name);
 		goto out_free_fifo;
diff -u -p a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -222,7 +222,7 @@ int __init opal_event_init(void)
 		/* Get hardware and virtual IRQ */
 		irq = be32_to_cpup(irqs);
 		virq = irq_create_mapping(NULL, irq);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			pr_warn("Failed to map irq 0x%x\n", irq);
 			continue;
 		}
@@ -260,7 +260,7 @@ machine_arch_initcall(powernv, opal_even
 int opal_event_request(unsigned int opal_event_nr)
 {
 	if (WARN_ON_ONCE(!opal_event_irqchip.domain))
-		return NO_IRQ;
+		return 0;

 	return irq_create_mapping(opal_event_irqchip.domain, opal_event_nr);
 }
diff -u -p a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
--- a/arch/powerpc/platforms/powernv/pci-cxl.c
+++ b/arch/powerpc/platforms/powernv/pci-cxl.c
@@ -344,7 +344,7 @@ int pnv_cxl_cx4_setup_msi_irqs(struct pc
 			return (hwirq ? hwirq : -ENOMEM);

 		virq = irq_create_mapping(NULL, hwirq);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			pr_warn("%s: Failed to map cxl mode MSI to linux irq\n",
 				pci_name(pdev));
 			return -ENOMEM;
@@ -374,7 +374,7 @@ void pnv_cxl_cx4_teardown_msi_irqs(struc
 		return;

 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
diff -u -p a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -186,7 +186,7 @@ int pnv_setup_msi_irqs(struct pci_dev *p
 			return -ENOSPC;
 		}
 		virq = irq_create_mapping(NULL, phb->msi_base + hwirq);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			pr_warn("%s: Failed to map MSI to linux irq\n",
 				pci_name(pdev));
 			msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq, 1);
@@ -217,7 +217,7 @@ void pnv_teardown_msi_irqs(struct pci_de
 		return;

 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
diff -u -p a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -168,7 +168,7 @@ unsigned int ehv_pic_get_irq(void)
 		ev_int_iack(0, &irq); /* legacy mode */

 	if (irq == 0xFFFF)    /* 0xFFFF --> no irq is pending */
-		return NO_IRQ;
+		return 0;

 	/*
 	 * this will also setup revmap[] in the slow path for the first
diff -u -p a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -112,10 +112,10 @@ static unsigned int icp_hv_get_irq(void)
 	unsigned int irq;

 	if (vec == XICS_IRQ_SPURIOUS)
-		return NO_IRQ;
+		return 0;

 	irq = irq_find_mapping(xics_host, vec);
-	if (likely(irq != NO_IRQ)) {
+	if (likely(irq)) {
 		xics_push_cppr(vec);
 		return irq;
 	}
@@ -126,7 +126,7 @@ static unsigned int icp_hv_get_irq(void)
 	/* We might learn about it later, so EOI it */
 	icp_hv_set_xirr(xirr);

-	return NO_IRQ;
+	return 0;
 }

 static void icp_hv_set_cpu_priority(unsigned char cppr)
diff -u -p a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -131,7 +131,7 @@ static void xics_request_ipi(void)
 	unsigned int ipi;

 	ipi = irq_create_mapping(xics_host, XICS_IPI);
-	BUG_ON(ipi == NO_IRQ);
+	BUG_ON(!ipi);

 	/*
 	 * IPIs are marked IRQF_PERCPU. The handler was set in map.
diff -u -p a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -124,10 +124,10 @@ static unsigned int icp_native_get_irq(v
 	unsigned int irq;

 	if (vec == XICS_IRQ_SPURIOUS)
-		return NO_IRQ;
+		return 0;

 	irq = irq_find_mapping(xics_host, vec);
-	if (likely(irq != NO_IRQ)) {
+	if (likely(irq)) {
 		xics_push_cppr(vec);
 		return irq;
 	}
@@ -138,7 +138,7 @@ static unsigned int icp_native_get_irq(v
 	/* We might learn about it later, so EOI it */
 	icp_native_set_xirr(xirr);

-	return NO_IRQ;
+	return 0;
 }

 #ifdef CONFIG_SMP
diff -u -p a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -51,14 +51,14 @@ static unsigned int icp_opal_get_irq(voi

 	rc = opal_int_get_xirr(&xirr, false);
 	if (rc < 0)
-		return NO_IRQ;
+		return 0;
 	xirr = be32_to_cpu(xirr);
 	vec = xirr & 0x00ffffff;
 	if (vec == XICS_IRQ_SPURIOUS)
-		return NO_IRQ;
+		return 0;

 	irq = irq_find_mapping(xics_host, vec);
-	if (likely(irq != NO_IRQ)) {
+	if (likely(irq)) {
 		xics_push_cppr(vec);
 		return irq;
 	}
@@ -69,7 +69,7 @@ static unsigned int icp_opal_get_irq(voi
 	/* We might learn about it later, so EOI it */
 	opal_int_eoi(xirr);

-	return NO_IRQ;
+	return 0;
 }

 static void icp_opal_set_cpu_priority(unsigned char cppr)
diff -u -p a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -79,7 +79,7 @@ unsigned int mpc8xx_get_irq(void)
 	irq = in_be32(&siu_reg->sc_sivec) >> 26;

 	if (irq == PIC_VEC_SPURRIOUS)
-		irq = NO_IRQ;
+		irq = 0;

         return irq_linear_revmap(mpc8xx_pic_host, irq);

diff -u -p a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -433,7 +433,7 @@ void tsi108_irq_cascade(struct irq_desc
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = get_pci_source();

-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);

 	chip->irq_eoi(&desc->irq_data);
diff -u -p a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -131,7 +131,7 @@ static void fsl_teardown_msi_irqs(struct
 	irq_hw_number_t hwirq;

 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 		hwirq = virq_to_hw(entry->irq);
 		msi_data = irq_get_chip_data(entry->irq);
@@ -250,7 +250,7 @@ static int fsl_setup_msi_irqs(struct pci

 		virq = irq_create_mapping(msi_data->irqhost, hwirq);

-		if (virq == NO_IRQ) {
+		if (!virq) {
 			dev_err(&pdev->dev, "fail mapping hwirq %i\n", hwirq);
 			msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
 			rc = -ENOSPC;
@@ -285,7 +285,7 @@ static irqreturn_t fsl_msi_cascade(int i
 	msir_index = cascade_data->index;

 	if (msir_index >= NR_MSI_REG_MAX)
-		cascade_irq = NO_IRQ;
+		cascade_irq = 0;

 	switch (msi_data->feature & FSL_PIC_IP_MASK) {
 	case FSL_PIC_IP_MPIC:
@@ -315,7 +315,7 @@ static irqreturn_t fsl_msi_cascade(int i
 		cascade_irq = irq_linear_revmap(msi_data->irqhost,
 				msi_hwirq(msi_data, msir_index,
 					  intr_index + have_shift));
-		if (cascade_irq != NO_IRQ) {
+		if (cascade_irq) {
 			generic_handle_irq(cascade_irq);
 			ret = IRQ_HANDLED;
 		}
@@ -337,7 +337,7 @@ static int fsl_of_msi_remove(struct plat
 		if (msi->cascade_array[i]) {
 			virq = msi->cascade_array[i]->virq;

-			BUG_ON(virq == NO_IRQ);
+			BUG_ON(!virq);

 			free_irq(virq, msi->cascade_array[i]);
 			kfree(msi->cascade_array[i]);
@@ -362,7 +362,7 @@ static int fsl_msi_setup_hwirq(struct fs
 	int virt_msir, i, ret;

 	virt_msir = irq_of_parse_and_map(dev->dev.of_node, irq_index);
-	if (virt_msir == NO_IRQ) {
+	if (!virt_msir) {
 		dev_err(&dev->dev, "%s: Cannot translate IRQ index %d\n",
 			__func__, irq_index);
 		return 0;
diff -u -p a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -238,7 +238,7 @@ static int mpic_msgr_probe(struct platfo

 		if (receive_mask & (1 << i)) {
 			msgr->irq = irq_of_parse_and_map(np, irq_index);
-			if (msgr->irq == NO_IRQ) {
+			if (!msgr->irq) {
 				dev_err(&dev->dev,
 						"Missing interrupt specifier");
 				kfree(msgr);
@@ -246,7 +246,7 @@ static int mpic_msgr_probe(struct platfo
 			}
 			irq_index += 1;
 		} else {
-			msgr->irq = NO_IRQ;
+			msgr->irq = 0;
 		}

 		mpic_msgrs[reg_number] = msgr;
diff -u -p a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
--- a/arch/powerpc/sysdev/mv64x60_pic.c
+++ b/arch/powerpc/sysdev/mv64x60_pic.c
@@ -272,7 +272,7 @@ unsigned int mv64x60_get_irq(void)
 	u32 cause;
 	int level1;
 	irq_hw_number_t hwirq;
-	int virq = NO_IRQ;
+	int virq = 0;

 	cause = in_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_SELECT_CAUSE);
 	if (cause & MV64X60_SELECT_CAUSE_HIGH) {
diff -u -p a/arch/powerpc/sysdev/ge/ge_pic.c b/arch/powerpc/sysdev/ge/ge_pic.c
--- a/arch/powerpc/sysdev/ge/ge_pic.c
+++ b/arch/powerpc/sysdev/ge/ge_pic.c
@@ -102,7 +102,7 @@ static void gef_pic_cascade(struct irq_d
 	 */
 	cascade_irq = gef_pic_get_irq();

-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);

 	chip->irq_eoi(&desc->irq_data);
@@ -206,7 +206,7 @@ void __init gef_pic_init(struct device_n

 	/* Map controller */
 	gef_pic_cascade_irq = irq_of_parse_and_map(np, 0);
-	if (gef_pic_cascade_irq == NO_IRQ) {
+	if (!gef_pic_cascade_irq) {
 		printk(KERN_ERR "SBC610: failed to map cascade interrupt");
 		return;
 	}
@@ -228,7 +228,7 @@ void __init gef_pic_init(struct device_n
 unsigned int gef_pic_get_irq(void)
 {
 	u32 cause, mask, active;
-	unsigned int virq = NO_IRQ;
+	unsigned int virq = 0;
 	int hwirq;

 	cause = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_STATUS);
diff -u -p a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -110,7 +110,7 @@ static void u3msi_teardown_msi_irqs(stru
 	irq_hw_number_t hwirq;

 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;

 		hwirq = virq_to_hw(entry->irq);
@@ -155,7 +155,7 @@ static int u3msi_setup_msi_irqs(struct p
 		msg.address_hi = addr >> 32;

 		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			pr_debug("u3msi: failed mapping hwirq 0x%x\n", hwirq);
 			msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, 1);
 			return -ENOSPC;
diff -u -p a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1649,7 +1649,7 @@ void __init mpic_init(struct mpic *mpic)
 	/* Check if this MPIC is chained from a parent interrupt controller */
 	if (mpic->flags & MPIC_SECONDARY) {
 		int virq = irq_of_parse_and_map(mpic->node, 0);
-		if (virq != NO_IRQ) {
+		if (virq) {
 			printk(KERN_INFO "%s: hooking up to IRQ %d\n",
 					mpic->node->full_name, virq);
 			irq_set_handler_data(virq, mpic);
@@ -1778,13 +1778,13 @@ static unsigned int _mpic_get_one_irq(st
 	if (unlikely(src == mpic->spurious_vec)) {
 		if (mpic->flags & MPIC_SPV_EOI)
 			mpic_eoi(mpic);
-		return NO_IRQ;
+		return 0;
 	}
 	if (unlikely(mpic->protected && test_bit(src, mpic->protected))) {
 		printk_ratelimited(KERN_WARNING "%s: Got protected source %d !\n",
 				   mpic->name, (int)src);
 		mpic_eoi(mpic);
-		return NO_IRQ;
+		return 0;
 	}

 	return irq_linear_revmap(mpic->irqhost, src);
@@ -1817,17 +1817,17 @@ unsigned int mpic_get_coreint_irq(void)
 	if (unlikely(src == mpic->spurious_vec)) {
 		if (mpic->flags & MPIC_SPV_EOI)
 			mpic_eoi(mpic);
-		return NO_IRQ;
+		return 0;
 	}
 	if (unlikely(mpic->protected && test_bit(src, mpic->protected))) {
 		printk_ratelimited(KERN_WARNING "%s: Got protected source %d !\n",
 				   mpic->name, (int)src);
-		return NO_IRQ;
+		return 0;
 	}

 	return irq_linear_revmap(mpic->irqhost, src);
 #else
-	return NO_IRQ;
+	return 0;
 #endif
 }

@@ -1852,7 +1852,7 @@ void mpic_request_ipis(void)
 	for (i = 0; i < 4; i++) {
 		unsigned int vipi = irq_create_mapping(mpic->irqhost,
 						       mpic->ipi_vecs[0] + i);
-		if (vipi == NO_IRQ) {
+		if (!vipi) {
 			printk(KERN_ERR "Failed to map %s\n", smp_ipi_name[i]);
 			continue;
 		}
diff -u -p a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -102,7 +102,7 @@ static int ppc4xx_setup_msi_irqs(struct
 					__func__);
 		}
 		virq = irq_of_parse_and_map(msi_data->msi_dev, int_no);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
 			msi_bitmap_free_hwirqs(&msi_data->bitmap, int_no, 1);
 			return -ENOSPC;
@@ -129,7 +129,7 @@ void ppc4xx_teardown_msi_irqs(struct pci
 	dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");

 	for_each_pci_msi_entry(entry, dev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
@@ -201,7 +201,7 @@ static int ppc4xx_of_msi_remove(struct p

 	for (i = 0; i < msi_irqs; i++) {
 		virq = msi->msi_virqs[i];
-		if (virq != NO_IRQ)
+		if (virq)
 			irq_dispose_mapping(virq);
 	}

diff -u -p a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpic_err.c
--- a/arch/powerpc/sysdev/fsl_mpic_err.c
+++ b/arch/powerpc/sysdev/fsl_mpic_err.c
@@ -115,8 +115,8 @@ static irqreturn_t fsl_error_int_handler
 		errint = __builtin_clz(eisr);
 		cascade_irq = irq_linear_revmap(mpic->irqhost,
 				 mpic->err_int_vecs[errint]);
-		WARN_ON(cascade_irq == NO_IRQ);
-		if (cascade_irq != NO_IRQ) {
+		WARN_ON(!cascade_irq);
+		if (cascade_irq) {
 			generic_handle_irq(cascade_irq);
 		} else {
 			eimr |=  1 << (31 - errint);
@@ -134,7 +134,7 @@ void mpic_err_int_init(struct mpic *mpic
 	int ret;

 	virq = irq_create_mapping(mpic->irqhost, irqnum);
-	if (virq == NO_IRQ) {
+	if (!virq) {
 		pr_err("Error interrupt setup failed\n");
 		return;
 	}
diff -u -p a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -68,9 +68,9 @@ unsigned int i8259_irq(void)
 		if (!pci_intack)
 			outb(0x0B, 0x20);	/* ISR register */
 		if(~inb(0x20) & 0x80)
-			irq = NO_IRQ;
+			irq = 0;
 	} else if (irq == 0xff)
-		irq = NO_IRQ;
+		irq = 0;

 	if (lock)
 		raw_spin_unlock(&i8259_lock);
diff -u -p a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
--- a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
@@ -60,7 +60,7 @@ static int hsta_setup_msi_irqs(struct pc
 		}

 		hwirq = ppc4xx_hsta_msi.irq_map[irq];
-		if (hwirq == NO_IRQ) {
+		if (!hwirq) {
 			pr_err("%s: Failed mapping irq %d\n", __func__, irq);
 			return -EINVAL;
 		}
@@ -110,7 +110,7 @@ static void hsta_teardown_msi_irqs(struc
 	int irq;

 	for_each_pci_msi_entry(entry, dev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;

 		irq = hsta_find_hwirq_offset(entry->irq);
@@ -166,7 +166,7 @@ static int hsta_msi_probe(struct platfor
 	for (irq = 0; irq < irq_count; irq++) {
 		ppc4xx_hsta_msi.irq_map[irq] =
 			irq_of_parse_and_map(dev->of_node, irq);
-		if (ppc4xx_hsta_msi.irq_map[irq] == NO_IRQ) {
+		if (!ppc4xx_hsta_msi.irq_map[irq]) {
 			dev_err(dev, "Unable to map IRQ\n");
 			ret = -EINVAL;
 			goto out2;
diff -u -p a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -240,7 +240,7 @@ static int axon_ram_probe(struct platfor
 	device_add_disk(&device->dev, bank->disk);

 	bank->irq_id = irq_of_parse_and_map(device->dev.of_node, 0);
-	if (bank->irq_id == NO_IRQ) {
+	if (!bank->irq_id) {
 		dev_err(&device->dev, "Cannot access ECC interrupt ID\n");
 		rc = -EFAULT;
 		goto failed;
@@ -250,7 +250,7 @@ static int axon_ram_probe(struct platfor
 			AXON_RAM_IRQ_FLAGS, bank->disk->disk_name, device);
 	if (rc != 0) {
 		dev_err(&device->dev, "Cannot register ECC interrupt handler\n");
-		bank->irq_id = NO_IRQ;
+		bank->irq_id = 0;
 		rc = -EFAULT;
 		goto failed;
 	}
@@ -268,7 +268,7 @@ static int axon_ram_probe(struct platfor

 failed:
 	if (bank != NULL) {
-		if (bank->irq_id != NO_IRQ)
+		if (bank->irq_id)
 			free_irq(bank->irq_id, device);
 		if (bank->disk != NULL) {
 			if (bank->disk->major > 0)
diff -u -p a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
--- a/arch/powerpc/sysdev/fsl_gtm.c
+++ b/arch/powerpc/sysdev/fsl_gtm.c
@@ -406,7 +406,7 @@ static int __init fsl_gtm_init(void)
 			unsigned int irq;

 			irq = irq_of_parse_and_map(np, i);
-			if (irq == NO_IRQ) {
+			if (!irq) {
 				pr_err("%s: not enough interrupts specified\n",
 				       np->full_name);
 				goto err;
diff -u -p a/arch/powerpc/sysdev/pmi.c b/arch/powerpc/sysdev/pmi.c
--- a/arch/powerpc/sysdev/pmi.c
+++ b/arch/powerpc/sysdev/pmi.c
@@ -158,7 +158,7 @@ static int pmi_of_probe(struct platform_
 	data->dev = dev;

 	data->irq = irq_of_parse_and_map(np, 0);
-	if (data->irq == NO_IRQ) {
+	if (!data->irq) {
 		printk(KERN_ERR "pmi: invalid interrupt.\n");
 		rc = -EFAULT;
 		goto error_cleanup_iomap;
diff -u -p a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -132,7 +132,7 @@ unsigned int cpm_pic_init(void)
 {
 	struct device_node *np = NULL;
 	struct resource res;
-	unsigned int sirq = NO_IRQ, hwirq, eirq;
+	unsigned int sirq = 0, hwirq, eirq;
 	int ret;

 	pr_debug("cpm_pic_init\n");
@@ -154,7 +154,7 @@ unsigned int cpm_pic_init(void)
 		goto end;

 	sirq = irq_of_parse_and_map(np, 0);
-	if (sirq == NO_IRQ)
+	if (!sirq)
 		goto end;

 	/* Initialize the CPM interrupt controller. */
@@ -168,7 +168,7 @@ unsigned int cpm_pic_init(void)
 	cpm_pic_host = irq_domain_add_linear(np, 64, &cpm_pic_host_ops, NULL);
 	if (cpm_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
-		sirq = NO_IRQ;
+		sirq = 0;
 		goto end;
 	}

@@ -182,7 +182,7 @@ unsigned int cpm_pic_init(void)
 	}

 	eirq = irq_of_parse_and_map(np, 0);
-	if (eirq == NO_IRQ)
+	if (!eirq)
 		goto end;

 	if (setup_irq(eirq, &cpm_error_irqaction))
diff -u -p a/arch/powerpc/sysdev/ppc4xx_soc.c b/arch/powerpc/sysdev/ppc4xx_soc.c
--- a/arch/powerpc/sysdev/ppc4xx_soc.c
+++ b/arch/powerpc/sysdev/ppc4xx_soc.c
@@ -109,7 +109,7 @@ static int __init ppc4xx_l2c_probe(void)

 	/* Get and map irq number from device tree */
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		printk(KERN_ERR "irq_of_parse_and_map failed\n");
 		of_node_put(np);
 		return -ENODEV;
diff -u -p a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -864,7 +864,7 @@ unsigned int ipic_get_irq(void)
 	irq = ipic_read(primary_ipic->regs, IPIC_SIVCR) & IPIC_SIVCR_VECTOR_MASK;

 	if (irq == 0)    /* 0 --> no irq is pending */
-		return NO_IRQ;
+		return 0;

 	return irq_linear_revmap(primary_ipic->irqhost, irq);
 }
diff -u -p a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -193,10 +193,10 @@ static int __init add_legacy_soc_port(st
 	 */
 	if (tsi && !strcmp(tsi->type, "tsi-bridge"))
 		return add_legacy_port(np, -1, UPIO_TSI, addr, addr,
-				       NO_IRQ, legacy_port_flags, 0);
+				       0, legacy_port_flags, 0);
 	else
 		return add_legacy_port(np, -1, UPIO_MEM, addr, addr,
-				       NO_IRQ, legacy_port_flags, 0);
+				       0, legacy_port_flags, 0);
 }

 static int __init add_legacy_isa_port(struct device_node *np,
@@ -242,7 +242,7 @@ static int __init add_legacy_isa_port(st

 	/* Add port, irq will be dealt with later */
 	return add_legacy_port(np, index, UPIO_PORT, be32_to_cpu(reg[1]),
-			       taddr, NO_IRQ, legacy_port_flags, 0);
+			       taddr, 0, legacy_port_flags, 0);

 }

@@ -314,7 +314,7 @@ static int __init add_legacy_pci_port(st
 	/* Add port, irq will be dealt with later. We passed a translated
 	 * IO port value. It will be fixed up later along with the irq
 	 */
-	return add_legacy_port(np, index, iotype, base, addr, NO_IRQ,
+	return add_legacy_port(np, index, iotype, base, addr, 0,
 			       legacy_port_flags, np != pci_dev);
 }
 #endif
@@ -462,14 +462,14 @@ static void __init fixup_port_irq(int in
 	DBG("fixup_port_irq(%d)\n", index);

 	virq = irq_of_parse_and_map(np, 0);
-	if (virq == NO_IRQ && legacy_serial_infos[index].irq_check_parent) {
+	if (!virq && legacy_serial_infos[index].irq_check_parent) {
 		np = of_get_parent(np);
 		if (np == NULL)
 			return;
 		virq = irq_of_parse_and_map(np, 0);
 		of_node_put(np);
 	}
-	if (virq == NO_IRQ)
+	if (!virq)
 		return;

 	port->irq = virq;
@@ -543,7 +543,7 @@ static int __init serial_dev_init(void)
 		struct plat_serial8250_port *port = &legacy_serial_ports[i];
 		struct device_node *np = legacy_serial_infos[i].np;

-		if (port->irq == NO_IRQ)
+		if (!port->irq)
 			fixup_port_irq(i, np, port);
 		if (port->iotype == UPIO_PORT)
 			fixup_port_pio(i, np, port);
diff -u -p a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -178,7 +178,7 @@ struct pci_dev *of_create_pci_dev(struct
 		dev->hdr_type = PCI_HEADER_TYPE_NORMAL;
 		dev->rom_base_reg = PCI_ROM_ADDRESS;
 		/* Maybe do a default OF mapping here */
-		dev->irq = NO_IRQ;
+		dev->irq = 0;
 	}

 	of_pci_parse_addrs(node, dev);
diff -u -p a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -324,7 +324,7 @@ static int pci_read_irq_line(struct pci_
 			 line, pin);

 		virq = irq_create_mapping(NULL, line);
-		if (virq != NO_IRQ)
+		if (virq)
 			irq_set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
 	} else {
 		pr_debug(" Got one, spec %d cells (0x%08x 0x%08x...) on %s\n",
@@ -333,7 +333,7 @@ static int pci_read_irq_line(struct pci_

 		virq = irq_create_of_mapping(&oirq);
 	}
-	if(virq == NO_IRQ) {
+	if(!virq) {
 		pr_debug(" Failed to map !\n");
 		return -1;
 	}
diff -u -p a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -514,7 +514,7 @@ void __do_irq(struct pt_regs *regs)
 	may_hard_irq_enable();

 	/* And finally process it */
-	if (unlikely(irq == NO_IRQ))
+	if (unlikely(!irq))
 		__this_cpu_inc(irq_stat.spurious_irqs);
 	else
 		generic_handle_irq(irq);
diff -u -p a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -227,7 +227,7 @@ int ibmebus_request_irq(u32 ist, irq_han
 {
 	unsigned int irq = irq_create_mapping(NULL, ist);

-	if (irq == NO_IRQ)
+	if (!irq)
 		return -EINVAL;

 	return request_irq(irq, handler, irq_flags, devname, dev_id);
