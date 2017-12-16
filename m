Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzJZh67ZNzDrXT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 18:19:24 +1100 (AEDT)
Subject: [PATCH] SB600 for the Nemo board has non-zero devices on non-root bus
To: Bjorn Helgaas <helgaas@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Darren Stevens <darren@stevens-zone.net>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20171202230052.34y2ivxgpgr3osct@localhost>
 <CAOesGMhfMpt+xG1vhVHU+O5o4W5y2S5mZyn9tp+CPn9G6XrNVA@mail.gmail.com>
 <4CEE49CE-68F3-457F-B302-54BA8550F36A@xenosoft.de>
 <1d5276c3-1d29-114a-c868-6f022eee58e7@xenosoft.de>
 <99f78122-cd53-100f-4f58-be5bf7927d4e@xenosoft.de>
 <87fu8odnfk.fsf@concordia.ellerman.id.au>
 <20171206210637.GO23510@bhelgaas-glaptop.roam.corp.google.com>
 <877etxh1lf.fsf@concordia.ellerman.id.au>
 <f5fe03d3-87f8-2a2d-2d83-fbefcd489a77@xenosoft.de>
 <98c7e034-b523-a703-e637-957e2857ab32@xenosoft.de>
 <20171215202509.GZ30595@bhelgaas-glaptop.roam.corp.google.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <6326d79e-405b-2ae8-5295-97bf11219b81@xenosoft.de>
Date: Sat, 16 Dec 2017 08:18:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171215202509.GZ30595@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/mixed; boundary="------------3DB08A6DD8A4ACC3E91EA54C"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------3DB08A6DD8A4ACC3E91EA54C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04 December 2017 at 12:40PM, Darren Stevens wrote:
 > Hello Bjorn
 >
 > Firstly sorry for not being able to join in this discussion, I have been
 > moving house and only got my X1000 set up again yesterday..
 >
 > On 30/11/2017, Bjorn Helgaas wrote:
 >> I *think* something like the patch below should make this work if you
 >> use the "pci=pcie_scan_all" parameter.  We have some x86 DMI quirks
 >> that set PCI_SCAN_ALL_PCIE_DEVS automatically.  I don't know how to do
 >> something similar on powerpc, but maybe you do?
 >
 > Actually the root ports on the Nemo's PA6T processor don't respond to the
 > SB600 unless we turn on a special 'relax pci-e' bit in one of its control
 > registers. We use a small out of tree init routine to do this, and there
 > would be the ideal place to put a call to
 > pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS).
 >
 > This patch fixes the last major hurdle to getting the X1000 fully 
supported in
 > the linux kernel, so thanks very much for that.
 >
 > Regards
 > Darren
 >
 >


On 15 December 2017 at 09:25PM, Bjorn Helgaas wrote:
 > On Fri, Dec 15, 2017 at 09:04:51AM +0100, Christian Zigotzky wrote:
 >> On 09 December 2017 at 7:03PM, Christian Zigotzky wrote:
 >>> On 08 December 2017 at 12:59PM, Michael Ellerman wrote:
 >>>>
 >>>>> Darren's idea of doing it at the same time you tweak the SB600 "relax
 >>>>> pci-e" bit is ideal because then the two pieces are obviously
 >>>>> connected and it wouldn't affect any other systems at all.
 >>>>
 >>>> Yes that would be ideal. That patch is currently out-of-tree I gather,
 >>>> but I guess everyone who's using these machines must have that patch
 >>>> anyway.
 >>>>
 >>>> Darren what does that code look like? Can we get it upstream and close
 >>>> the loop on this?
 >>>>
 >>>> cheers
 >>>>
 >>>
 >>> Hi Michael,
 >>>
 >>> Please find attached the code.
 >>>
 >>> Thanks,
 >>> Christian
 >>
 >> Hi All,
 >>
 >> I haven't received any response yet. Is this the correct patch you
 >> are looking for?
 >
 > This is a powerpc patch that doesn't affect the PCI core, so I would
 > say this is Michael's bailiwick.
 >
 > I guess you're only looking for a hint about whether this is the right
 > approach, because it's obviously fully baked yet (no changelog,
 > signed-off-by, etc, not a "safe for all powerpc" run-time solution,
 > not in Linux indentation style, etc).
 >
 > It looks like the "pasemi,1682m-iob" DT property is required and
 > possibly sufficient to identify this system at run-time.
 >
 > My advice is to finish that stuff up, post it to the powerpc
 > maintainers and the linuxppc-dev@lists.ozlabs.org list, and go from
 > there.
 >

Darren,

Where is this small out of tree init routine in our patch? I haven't 
found it yet. Please post this routine here. Please find attached our 
latest Nemo patch.

Thanks,
Christian

--------------3DB08A6DD8A4ACC3E91EA54C
Content-Type: text/x-patch;
 name="nemo_4.15-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nemo_4.15-2.patch"

diff -rupN a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
--- a/arch/powerpc/platforms/pasemi/pci.c	2017-11-16 08:18:35.078874462 +0100
+++ b/arch/powerpc/platforms/pasemi/pci.c	2017-11-16 08:17:22.034367975 +0100
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 
 #include <asm/pci-bridge.h>
+#include <asm/isa-bridge.h>
 #include <asm/machdep.h>
 
 #include <asm/ppc-pci.h>
@@ -108,6 +109,69 @@ static int workaround_5945(struct pci_bu
 	return 1;
 }
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+static int sb600_bus = 5;
+static void __iomem *iob_mapbase = NULL;
+
+static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
+                             int offset, int len, u32 *val);
+
+static void sb600_set_flag(int bus)
+{
+    struct resource res;
+    struct device_node *dn;
+       struct pci_bus *busp;
+       u32 val;
+       int err;
+
+       if (sb600_bus == -1)
+       {
+               busp = pci_find_bus(0, 0);
+               pa_pxp_read_config(busp, PCI_DEVFN(17,0), PCI_SECONDARY_BUS, 1, &val);
+
+               sb600_bus = val;
+
+               printk(KERN_CRIT "NEMO SB600 on bus %d.\n",sb600_bus);
+       }
+
+       if (iob_mapbase == NULL)
+       {
+        dn = of_find_compatible_node(NULL, "isa", "pasemi,1682m-iob");
+        if (!dn)
+        {
+               printk(KERN_CRIT "NEMO SB600 missing iob node\n");
+                       return;
+               }
+
+               err = of_address_to_resource(dn, 0, &res);
+        of_node_put(dn);
+
+               if (err)
+               {
+               printk(KERN_CRIT "NEMO SB600 missing resource\n");
+                       return;
+               }
+
+               printk(KERN_CRIT "NEMO SB600 IOB base %08lx\n",res.start);
+
+               iob_mapbase = ioremap(res.start + 0x100, 0x94);
+       }
+
+       if (iob_mapbase != NULL)
+       {
+               if (bus == sb600_bus)
+               {
+                       out_le32(iob_mapbase + 4, in_le32(iob_mapbase + 4) | 0x800);
+               }
+               else
+               {
+                       out_le32(iob_mapbase + 4, in_le32(iob_mapbase + 4) & ~0x800);
+               }
+       }
+}
+#endif
+
+
 static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
 			      int offset, int len, u32 *val)
 {
@@ -126,6 +190,10 @@ static int pa_pxp_read_config(struct pci
 
 	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+       sb600_set_flag(bus->number);
+#endif
+
 	/*
 	 * Note: the caller has already checked that offset is
 	 * suitably aligned and that len is 1, 2 or 4.
@@ -210,6 +278,9 @@ static int __init pas_add_bridge(struct
 	/* Interpret the "ranges" property */
 	pci_process_bridge_OF_ranges(hose, dev, 1);
 
+	/* Scan for an isa bridge. */
+	isa_bridge_find_early(hose);
+
 	return 0;
 }
 
diff -rupN a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
--- a/arch/powerpc/platforms/pasemi/setup.c	2017-11-16 08:18:35.078874462 +0100
+++ b/arch/powerpc/platforms/pasemi/setup.c	2017-11-16 08:17:22.036368061 +0100
@@ -34,6 +34,7 @@
 #include <asm/prom.h>
 #include <asm/iommu.h>
 #include <asm/machdep.h>
+#include <asm/i8259.h>
 #include <asm/mpic.h>
 #include <asm/smp.h>
 #include <asm/time.h>
@@ -72,6 +73,17 @@ static void __noreturn pas_restart(char
 		out_le32(reset_reg, 0x6000000);
 }
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+void pas_shutdown(void)
+{
+       /* (added by DStevens 19/06/13)
+          Set the PLD bit that makes the SB600 think the power button is being pressed */
+       void __iomem *pld_map = ioremap(0xf5000000,4096);
+       while (1)
+               out_8(pld_map+7,0x01);
+}
+#endif
+
 #ifdef CONFIG_SMP
 static arch_spinlock_t timebase_lock;
 static unsigned long timebase;
@@ -183,16 +195,30 @@ static int __init pas_setup_mce_regs(voi
 }
 machine_device_initcall(pasemi, pas_setup_mce_regs);
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+static void sb600_8259_cascade(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int cascade_irq = i8259_irq();
+
+	if (cascade_irq !=NO_IRQ)
+               generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+#endif
+
 static __init void pas_init_IRQ(void)
 {
 	struct device_node *np;
-	struct device_node *root, *mpic_node;
+	struct device_node *root, *mpic_node, *i8259_node;
 	unsigned long openpic_addr;
 	const unsigned int *opprop;
 	int naddr, opplen;
 	int mpic_flags;
 	const unsigned int *nmiprop;
 	struct mpic *mpic;
+	int gpio_virq;
 
 	mpic_node = NULL;
 
@@ -244,6 +270,22 @@ static __init void pas_init_IRQ(void)
 		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 	}
 
+
+#ifdef CONFIG_PPC_PASEMI_NEMO
+       // Connect legacy i8259 controller in SB600
+	i8259_node = of_find_node_by_path("/pxp@0,e0000000");
+	printk("Init i8259\n");
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
+#endif
 	of_node_put(mpic_node);
 	of_node_put(root);
 }
@@ -398,6 +440,18 @@ static const struct of_device_id pasemi_
 	{},
 };
 
+static struct resource rtc_resource[] = {{
+	.name = "rtc",
+	.start = 0x70,
+	.end = 0x71,
+	.flags = IORESOURCE_IO,
+}, {
+	.name = "rtc",
+	.start = 8,
+	.end = 8,
+	.flags = IORESOURCE_IRQ,
+}};
+
 static int __init pasemi_publish_devices(void)
 {
 	pasemi_pcmcia_init();
@@ -405,6 +459,10 @@ static int __init pasemi_publish_devices
 	/* Publish OF platform devices for SDC and other non-PCI devices */
 	of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+	platform_device_register_simple("rtc_cmos", -1, rtc_resource, 2);
+#endif
+
 	return 0;
 }
 machine_device_initcall(pasemi, pasemi_publish_devices);
@@ -421,9 +479,13 @@ static int __init pas_probe(void)
 
 	iommu_init_early_pasemi();
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+       pm_power_off              = pas_shutdown;         // Varisys provided a way to turn us off
+#endif
 	return 1;
 }
 
+
 define_machine(pasemi) {
 	.name			= "PA Semi PWRficient",
 	.probe			= pas_probe,
@@ -435,4 +497,7 @@ define_machine(pasemi) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= pas_progress,
 	.machine_check_exception = pas_machine_check_handler,
+#if 0 // def CONFIG_PPC_PASEMI_NEMO
+       .pci_probe_mode = sb600_pci_probe_mode,
+#endif
 };
diff -rupN a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
--- a/drivers/ata/pata_atiixp.c	2017-11-16 08:18:43.932095778 +0100
+++ b/drivers/ata/pata_atiixp.c	2017-11-16 08:17:22.036368061 +0100
@@ -278,6 +278,12 @@ static int atiixp_init_one(struct pci_de
 	};
 	const struct ata_port_info *ppi[] = { &info, &info };
 
+        /* SB600 on the Nemo board doesn't have secondary port wired */
+        #ifdef CONFIG_PPC_PASEMI_NEMO
+        if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
+            ppi[1] = &ata_dummy_port_info;
+        #endif
+
 	return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
 				      ATA_HOST_PARALLEL_SCAN);
 }
diff -rupN a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
--- a/drivers/ata/pata_of_platform.c	2017-11-16 08:18:43.906095154 +0100
+++ b/drivers/ata/pata_of_platform.c	2017-11-16 08:17:22.040368233 +0100
@@ -40,14 +40,36 @@ static int pata_of_platform_probe(struct
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(dn, 1, &ctl_res);
-	if (ret) {
-		dev_err(&ofdev->dev, "can't get CTL address from "
-			"device tree\n");
-		return -EINVAL;
+	if (of_device_is_compatible(dn, "electra-ide")) {
+		/* Altstatus is really at offset 0x3f6 from the primary window
+		 * on electra-ide. Adjust ctl_res and io_res accordingly.
+		 */
+		ctl_res = io_res;
+		ctl_res.start = ctl_res.start+0x3f6;
+		io_res.end = ctl_res.start-1;
+
+#ifdef CONFIG_PPC_PASEMI_NEMO
+	} else if (of_device_is_compatible(dn, "electra-cf")) {
+		/* Task regs are at 0x800, with alt status @ 0x80e in the primary window
+		* on electra-cf. Adjust ctl_res and io_res accordingly.
+		*/
+		ctl_res = io_res;
+		io_res.start += 0x800;
+		ctl_res.start = ctl_res.start + 0x80e;
+		io_res.end = ctl_res.start-1;
+#endif
+	} else {
+		ret = of_address_to_resource(dn, 1, &ctl_res);
+		if (ret) {
+			dev_err(&ofdev->dev, "can't get CTL address from "
+				"device tree\n");
+			return -EINVAL;
+		}
 	}
 
 	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
+	if (irq_res)
+		irq_res->flags = 0;
 
 	of_property_read_u32(dn, "reg-shift", &reg_shift);
 
@@ -60,6 +82,11 @@ static int pata_of_platform_probe(struct
 		dev_info(&ofdev->dev, "pio-mode unspecified, assuming PIO0\n");
 	}
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+       irq_res = 0;                    // force irq off (doesn't seem to work)
+#endif
+
+
 	pio_mask = 1 << pio_mode;
 	pio_mask |= (1 << pio_mode) - 1;
 
@@ -69,6 +96,10 @@ static int pata_of_platform_probe(struct
 
 static const struct of_device_id pata_of_platform_match[] = {
 	{ .compatible = "ata-generic", },
+	{ .compatible = "electra-ide", },
+#ifdef CONFIG_PPC_PASEMI_NEMO
+	{ .compatible = "electra-cf",},
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pata_of_platform_match);
diff -rupN a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
--- a/drivers/i2c/busses/i2c-pasemi.c	2017-11-16 08:18:40.088001610 +0100
+++ b/drivers/i2c/busses/i2c-pasemi.c	2017-11-16 08:17:22.041368276 +0100
@@ -365,7 +365,6 @@ static int pasemi_smb_probe(struct pci_d
 	smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
-	smbus->adapter.nr = PCI_FUNC(dev->devfn);
 
 	/* set up the sysfs linkage to our parent device */
 	smbus->adapter.dev.parent = &dev->dev;
@@ -373,7 +372,7 @@ static int pasemi_smb_probe(struct pci_d
 	reg_write(smbus, REG_CTL, (CTL_MTR | CTL_MRR |
 		  (CLK_100K_DIV & CTL_CLK_M)));
 
-	error = i2c_add_numbered_adapter(&smbus->adapter);
+	error = i2c_add_adapter(&smbus->adapter);
 	if (error)
 		goto out_release_region;
 

--------------3DB08A6DD8A4ACC3E91EA54C--
