Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT4kK1Z1fzDrvF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 21:53:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Remove all usages of NO_IRQ
Date: Tue,  6 Sep 2016 21:53:24 +1000
Message-Id: <1473162804-6802-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NO_IRQ has been == 0 on powerpc for just over ten years (since commit
0ebfff1491ef ("[POWERPC] Add new interrupt mapping core and change
platforms to use it")). It's also 0 on most other arches.

Although it's fairly harmless, every now and then it causes confusion
when a driver is built on powerpc and another arch which doesn't define
NO_IRQ. There's at least 6 definitions of NO_IRQ in drivers/, at least
some of which are to work around that problem.

So we'd like to remove it. This is fairly trivial in the arch code, we
just convert:

    if (irq == NO_IRQ)	to	if (!irq)
    if (irq != NO_IRQ)	to	if (irq)
    irq = NO_IRQ;	to	irq = 0;
    return NO_IRQ;	to	return 0;

And a few other odd cases as well.

At least for now we need to continue to #define NO_IRQ, because there is
driver code that builds on powerpc and may build on arm (and possibly
other arches), where NO_IRQ is *not* == 0. Hopefully they can be fixed
in the medium term and we can drop the definition entirely.

Note we also change some occurrences in PPC sound drivers, drivers/ps3,
and drivers/macintosh.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/machdep.h               |  2 +-
 arch/powerpc/include/asm/mpic_msgr.h             |  6 +++---
 arch/powerpc/include/asm/parport.h               |  2 +-
 arch/powerpc/kernel/ibmebus.c                    |  2 +-
 arch/powerpc/kernel/irq.c                        |  2 +-
 arch/powerpc/kernel/legacy_serial.c              | 14 +++++++-------
 arch/powerpc/kernel/pci-common.c                 |  5 +++--
 arch/powerpc/kernel/pci_of_scan.c                |  2 +-
 arch/powerpc/platforms/44x/warp.c                |  2 +-
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |  8 ++++----
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c    |  2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        |  2 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c     |  2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c        |  2 +-
 arch/powerpc/platforms/83xx/suspend.c            |  4 ++--
 arch/powerpc/platforms/85xx/common.c             |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c        |  4 ++--
 arch/powerpc/platforms/85xx/mpc85xx_ds.c         |  4 ++--
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c  |  6 +++---
 arch/powerpc/platforms/86xx/pic.c                |  4 ++--
 arch/powerpc/platforms/8xx/m8xx_setup.c          |  2 +-
 arch/powerpc/platforms/cell/axon_msi.c           |  6 +++---
 arch/powerpc/platforms/cell/interrupt.c          | 12 ++++++------
 arch/powerpc/platforms/cell/iommu.c              |  2 +-
 arch/powerpc/platforms/cell/pmu.c                |  4 ++--
 arch/powerpc/platforms/cell/spider-pic.c         | 18 +++++++++---------
 arch/powerpc/platforms/cell/spu_base.c           | 16 ++++++++--------
 arch/powerpc/platforms/cell/spu_manage.c         |  9 ++++++---
 arch/powerpc/platforms/chrp/setup.c              |  4 ++--
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |  2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |  4 ++--
 arch/powerpc/platforms/embedded6xx/mvme5100.c    |  4 ++--
 arch/powerpc/platforms/maple/pci.c               |  6 +++---
 arch/powerpc/platforms/pasemi/misc.c             |  2 +-
 arch/powerpc/platforms/pasemi/msi.c              |  4 ++--
 arch/powerpc/platforms/pasemi/setup.c            |  4 ++--
 arch/powerpc/platforms/powermac/low_i2c.c        |  6 +++---
 arch/powerpc/platforms/powermac/pfunc_base.c     |  4 ++--
 arch/powerpc/platforms/powermac/pic.c            |  6 +++---
 arch/powerpc/platforms/powernv/opal-irqchip.c    |  4 ++--
 arch/powerpc/platforms/powernv/pci-cxl.c         |  4 ++--
 arch/powerpc/platforms/powernv/pci.c             |  4 ++--
 arch/powerpc/platforms/ps3/interrupt.c           | 10 +++++-----
 arch/powerpc/platforms/ps3/smp.c                 |  4 ++--
 arch/powerpc/platforms/ps3/spu.c                 |  4 ++--
 arch/powerpc/platforms/pseries/event_sources.c   |  2 +-
 arch/powerpc/platforms/pseries/msi.c             |  6 +++---
 arch/powerpc/platforms/pseries/setup.c           |  4 ++--
 arch/powerpc/sysdev/axonram.c                    |  6 +++---
 arch/powerpc/sysdev/cpm1.c                       |  8 ++++----
 arch/powerpc/sysdev/ehv_pic.c                    |  4 ++--
 arch/powerpc/sysdev/fsl_gtm.c                    |  2 +-
 arch/powerpc/sysdev/fsl_mpic_err.c               |  6 +++---
 arch/powerpc/sysdev/fsl_msi.c                    | 12 ++++++------
 arch/powerpc/sysdev/ge/ge_pic.c                  |  8 ++++----
 arch/powerpc/sysdev/i8259.c                      |  4 ++--
 arch/powerpc/sysdev/ipic.c                       |  4 ++--
 arch/powerpc/sysdev/mpc8xx_pic.c                 |  2 +-
 arch/powerpc/sysdev/mpic.c                       | 14 +++++++-------
 arch/powerpc/sysdev/mpic_msgr.c                  |  4 ++--
 arch/powerpc/sysdev/mpic_u3msi.c                 |  4 ++--
 arch/powerpc/sysdev/mv64x60_pic.c                |  2 +-
 arch/powerpc/sysdev/pmi.c                        |  2 +-
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c            |  6 +++---
 arch/powerpc/sysdev/ppc4xx_msi.c                 |  6 +++---
 arch/powerpc/sysdev/ppc4xx_soc.c                 |  2 +-
 arch/powerpc/sysdev/tsi108_pci.c                 |  2 +-
 arch/powerpc/sysdev/uic.c                        |  2 +-
 arch/powerpc/sysdev/xics/icp-hv.c                |  6 +++---
 arch/powerpc/sysdev/xics/icp-native.c            |  6 +++---
 arch/powerpc/sysdev/xics/icp-opal.c              |  8 ++++----
 arch/powerpc/sysdev/xics/xics-common.c           |  2 +-
 drivers/macintosh/macio_asic.c                   |  4 ++--
 drivers/macintosh/rack-meter.c                   |  2 +-
 drivers/macintosh/smu.c                          | 18 +++++++++---------
 drivers/macintosh/via-cuda.c                     |  2 +-
 drivers/macintosh/via-pmu.c                      |  6 +++---
 drivers/ps3/ps3-vuart.c                          |  4 ++--
 sound/aoa/core/gpio-feature.c                    |  4 ++--
 sound/ppc/tumbler.c                              |  8 ++++----
 80 files changed, 204 insertions(+), 200 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 0420b388dd83..e02cbc6a6c70 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -61,7 +61,7 @@ struct machdep_calls {
 
 	void		(*init_IRQ)(void);
 
-	/* Return an irq, or NO_IRQ to indicate there are none pending. */
+	/* Return an irq, or 0 to indicate there are none pending. */
 	unsigned int	(*get_irq)(void);
 
 	/* PCI stuff */
diff --git a/arch/powerpc/include/asm/mpic_msgr.h b/arch/powerpc/include/asm/mpic_msgr.h
index d4f471fb1031..088420d8aa59 100644
--- a/arch/powerpc/include/asm/mpic_msgr.h
+++ b/arch/powerpc/include/asm/mpic_msgr.h
@@ -122,9 +122,9 @@ static inline void mpic_msgr_set_destination(struct mpic_msgr *msgr,
  * @msgr:	the message register whose IRQ is to be returned
  *
  * Returns the IRQ number associated with the given message register.
- * NO_IRQ is returned if this message register is not capable of
- * receiving interrupts.  What message register can and cannot receive
- * interrupts is specified in the device tree for the system.
+ * 0 is returned if this message register is not capable of receiving
+ * interrupts.  What message register can and cannot receive interrupts is
+ * specified in the device tree for the system.
  */
 static inline int mpic_msgr_get_irq(struct mpic_msgr *msgr)
 {
diff --git a/arch/powerpc/include/asm/parport.h b/arch/powerpc/include/asm/parport.h
index a452968b29ea..6595ad1d18cc 100644
--- a/arch/powerpc/include/asm/parport.h
+++ b/arch/powerpc/include/asm/parport.h
@@ -28,7 +28,7 @@ static int parport_pc_find_nonpci_ports (int autoirq, int autodma)
 		io1 = prop[1]; io2 = prop[2];
 
 		virq = irq_of_parse_and_map(np, 0);
-		if (virq == NO_IRQ)
+		if (!virq)
 			continue;
 
 		if (parport_pc_probe_port(io1, io2, virq, autodma, NULL, 0)
diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index c1ca9282f4a0..6ca9a2ffaac7 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -227,7 +227,7 @@ int ibmebus_request_irq(u32 ist, irq_handler_t handler,
 {
 	unsigned int irq = irq_create_mapping(NULL, ist);
 
-	if (irq == NO_IRQ)
+	if (!irq)
 		return -EINVAL;
 
 	return request_irq(irq, handler, irq_flags, devname, dev_id);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 08887cf2b20e..f10f8901c1c7 100644
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
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 7b750c4ed5c7..bc525ea0dc09 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -193,10 +193,10 @@ static int __init add_legacy_soc_port(struct device_node *np,
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
@@ -242,7 +242,7 @@ static int __init add_legacy_isa_port(struct device_node *np,
 
 	/* Add port, irq will be dealt with later */
 	return add_legacy_port(np, index, UPIO_PORT, be32_to_cpu(reg[1]),
-			       taddr, NO_IRQ, legacy_port_flags, 0);
+			       taddr, 0, legacy_port_flags, 0);
 
 }
 
@@ -314,7 +314,7 @@ static int __init add_legacy_pci_port(struct device_node *np,
 	/* Add port, irq will be dealt with later. We passed a translated
 	 * IO port value. It will be fixed up later along with the irq
 	 */
-	return add_legacy_port(np, index, iotype, base, addr, NO_IRQ,
+	return add_legacy_port(np, index, iotype, base, addr, 0,
 			       legacy_port_flags, np != pci_dev);
 }
 #endif
@@ -462,14 +462,14 @@ static void __init fixup_port_irq(int index,
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
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index e58908066b0e..95d3769a2e26 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -360,7 +360,7 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 			 line, pin);
 
 		virq = irq_create_mapping(NULL, line);
-		if (virq != NO_IRQ)
+		if (virq)
 			irq_set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
 	} else {
 		pr_debug(" Got one, spec %d cells (0x%08x 0x%08x...) on %s\n",
@@ -369,7 +369,8 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 
 		virq = irq_create_of_mapping(&oirq);
 	}
-	if(virq == NO_IRQ) {
+
+	if (!virq) {
 		pr_debug(" Failed to map !\n");
 		return -1;
 	}
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 526ac6750e4d..ea3d98115b88 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -178,7 +178,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 		dev->hdr_type = PCI_HEADER_TYPE_NORMAL;
 		dev->rom_base_reg = PCI_ROM_ADDRESS;
 		/* Maybe do a default OF mapping here */
-		dev->irq = NO_IRQ;
+		dev->irq = 0;
 	}
 
 	of_pci_parse_addrs(node, dev);
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 5ecce543103e..a886c2c22097 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -204,7 +204,7 @@ static void pika_setup_critical_temp(struct device_node *np,
 	i2c_smbus_write_byte_data(client, 3,  0); /* Tlow */
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq  == NO_IRQ) {
+	if (!irq) {
 		printk(KERN_ERR __FILE__ ": Unable to get ad7414 irq\n");
 		return;
 	}
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index 0035d146df73..fe4d4eac7427 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -97,7 +97,7 @@ cpld_pic_get_irq(int offset, u8 ignore, u8 __iomem *statusp,
 	status |= (ignore | mask);
 
 	if (status == 0xff)
-		return NO_IRQ;
+		return 0;
 
 	cpld_irq = ffz(status) + offset;
 
@@ -110,14 +110,14 @@ static void cpld_pic_cascade(struct irq_desc *desc)
 
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
diff --git a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
index d93dd4acf40b..cec3f88f153d 100644
--- a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
+++ b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
@@ -473,7 +473,7 @@ static int mpc512x_lpbfifo_probe(struct platform_device *pdev)
 	}
 
 	lpbfifo.irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (lpbfifo.irq == NO_IRQ) {
+	if (!lpbfifo.irq) {
 		dev_err(&pdev->dev, "mapping irq failed\n");
 		ret = -ENODEV;
 		goto err0;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 4fe2074c88cb..fc98912f42cf 100644
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
diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index 60e89fc9c753..8b065bdf7412 100644
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
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 2ef03e7d248c..0d6a62fc5864 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -89,7 +89,7 @@ static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
 			goto err;
 
 		ret = of_irq_to_resource(np, 0, &res[1]);
-		if (ret == NO_IRQ)
+		if (!ret)
 			goto err;
 
 		pdev = platform_device_alloc("mpc83xx_spi", i);
diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index fcbea4b51a78..24717d060008 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -352,7 +352,7 @@ static int pmc_probe(struct platform_device *ofdev)
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
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 28720a4ded7b..954e5e8b14ef 100644
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
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 62f171c71c4c..86f20156178e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -196,7 +196,7 @@ static void mpc85xx_8259_cascade_handler(struct irq_desc *desc)
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
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 6bc07d837b1c..ed69c7ee1829 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -51,7 +51,7 @@ static void mpc85xx_8259_cascade(struct irq_desc *desc)
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
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index b02d6a5bb035..82f8490b5aa7 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -78,7 +78,7 @@ static inline unsigned int socrates_fpga_pic_get_irq(unsigned int irq)
 			break;
 	}
 	if (i == 3)
-		return NO_IRQ;
+		return 0;
 
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
 	cause = socrates_fpga_pic_read(FPGA_PIC_IRQMASK(i));
@@ -103,7 +103,7 @@ static void socrates_fpga_pic_cascade(struct irq_desc *desc)
 	 */
 	cascade_irq = socrates_fpga_pic_get_irq(irq);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);
 	chip->irq_eoi(&desc->irq_data);
 }
@@ -292,7 +292,7 @@ void socrates_fpga_pic_init(struct device_node *pic)
 
 	for (i = 0; i < 3; i++) {
 		socrates_fpga_irqs[i] = irq_of_parse_and_map(pic, i);
-		if (socrates_fpga_irqs[i] == NO_IRQ) {
+		if (!socrates_fpga_irqs[i]) {
 			pr_warning("FPGA PIC: can't get irq%d.\n", i);
 			continue;
 		}
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
index 845defa1fd19..a6c695fa4da0 100644
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -22,7 +22,7 @@ static void mpc86xx_8259_cascade(struct irq_desc *desc)
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
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index b1ab6e96cb31..f81069f79a94 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -241,6 +241,6 @@ void __init mpc8xx_pics_init(void)
 	}
 
 	irq = cpm_pic_init();
-	if (irq != NO_IRQ)
+	if (irq)
 		irq_set_chained_handler(irq, cpm_cascade);
 }
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index aed7714495c1..8b55c5f19d4c 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -271,7 +271,7 @@ static int axon_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	for_each_pci_msi_entry(entry, dev) {
 		virq = irq_create_direct_mapping(msic->irq_domain);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			dev_warn(&dev->dev,
 				 "axon_msi: virq allocation failed!\n");
 			return -1;
@@ -293,7 +293,7 @@ static void axon_msi_teardown_msi_irqs(struct pci_dev *dev)
 	dev_dbg(&dev->dev, "axon_msi: tearing down msi irqs\n");
 
 	for_each_pci_msi_entry(entry, dev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 
 		irq_set_msi_desc(entry->irq, NULL);
@@ -375,7 +375,7 @@ static int axon_msi_probe(struct platform_device *device)
 	}
 
 	virq = irq_of_parse_and_map(dn, 0);
-	if (virq == NO_IRQ) {
+	if (!virq) {
 		printk(KERN_ERR "axon_msi: irq parse and map failed for %s\n",
 		       dn->full_name);
 		goto out_free_fifo;
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 9f609fc8d331..2246505c8018 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -123,7 +123,7 @@ static void iic_ioexc_cascade(struct irq_desc *desc)
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
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index f7d1a4953ea0..34cf4fd68f75 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -411,7 +411,7 @@ static void cell_iommu_enable_hardware(struct cbe_iommu *iommu)
 
 	virq = irq_create_mapping(NULL,
 			IIC_IRQ_IOEX_ATI | (iommu->nid << IIC_IRQ_NODE_SHIFT));
-	BUG_ON(virq == NO_IRQ);
+	BUG_ON(!virq);
 
 	ret = request_irq(virq, ioc_interrupt, 0, iommu->name, iommu);
 	BUG_ON(ret);
diff --git a/arch/powerpc/platforms/cell/pmu.c b/arch/powerpc/platforms/cell/pmu.c
index 348a27b12512..e3ad0c38f017 100644
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
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index d06dcac66fcb..ff924af00e78 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -207,11 +207,11 @@ static void spider_irq_cascade(struct irq_desc *desc)
 
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
@@ -245,19 +245,19 @@ static unsigned int __init spider_find_cascade_and_node(struct spider_pic *pic)
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
@@ -266,7 +266,7 @@ static unsigned int __init spider_find_cascade_and_node(struct spider_pic *pic)
 	tmp = of_get_property(iic, "ibm,interrupt-server-ranges", NULL);
 	if (tmp == NULL) {
 		of_node_put(iic);
-		return NO_IRQ;
+		return 0;
 	}
 	/* ugly as hell but works for now */
 	pic->node_id = (*tmp) >> 1;
@@ -281,7 +281,7 @@ static unsigned int __init spider_find_cascade_and_node(struct spider_pic *pic)
 				  (pic->node_id << IIC_IRQ_NODE_SHIFT) |
 				  (2 << IIC_IRQ_CLASS_SHIFT) |
 				  unit);
-	if (virq == NO_IRQ)
+	if (!virq)
 		printk(KERN_ERR "spider_pic: failed to map cascade !");
 	return virq;
 }
@@ -318,7 +318,7 @@ static void __init spider_init_one(struct device_node *of_node, int chip,
 
 	/* Hook up the cascade interrupt to the iic and nodeid */
 	virq = spider_find_cascade_and_node(pic);
-	if (virq == NO_IRQ)
+	if (!virq)
 		return;
 	irq_set_handler_data(virq, pic);
 	irq_set_chained_handler(virq, spider_irq_cascade);
diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index bb4a8e07c229..e84d8fbc2e21 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -402,7 +402,7 @@ static int spu_request_irqs(struct spu *spu)
 {
 	int ret = 0;
 
-	if (spu->irqs[0] != NO_IRQ) {
+	if (spu->irqs[0]) {
 		snprintf(spu->irq_c0, sizeof (spu->irq_c0), "spe%02d.0",
 			 spu->number);
 		ret = request_irq(spu->irqs[0], spu_irq_class_0,
@@ -410,7 +410,7 @@ static int spu_request_irqs(struct spu *spu)
 		if (ret)
 			goto bail0;
 	}
-	if (spu->irqs[1] != NO_IRQ) {
+	if (spu->irqs[1]) {
 		snprintf(spu->irq_c1, sizeof (spu->irq_c1), "spe%02d.1",
 			 spu->number);
 		ret = request_irq(spu->irqs[1], spu_irq_class_1,
@@ -418,7 +418,7 @@ static int spu_request_irqs(struct spu *spu)
 		if (ret)
 			goto bail1;
 	}
-	if (spu->irqs[2] != NO_IRQ) {
+	if (spu->irqs[2]) {
 		snprintf(spu->irq_c2, sizeof (spu->irq_c2), "spe%02d.2",
 			 spu->number);
 		ret = request_irq(spu->irqs[2], spu_irq_class_2,
@@ -429,10 +429,10 @@ static int spu_request_irqs(struct spu *spu)
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
 
diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index 21b4bfb97200..672d310dcf14 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -105,7 +105,10 @@ static int __init spu_map_interrupts_old(struct spu *spu,
 	spu->irqs[2] = irq_create_mapping(NULL, IIC_IRQ_CLASS_2 | isrc);
 
 	/* Right now, we only fail if class 2 failed */
-	return spu->irqs[2] == NO_IRQ ? -EINVAL : 0;
+	if (!spu->irqs[2])
+		return -EINVAL;
+
+	return 0;
 }
 
 static void __iomem * __init spu_map_prop_old(struct spu *spu,
@@ -191,7 +194,7 @@ static int __init spu_map_interrupts(struct spu *spu, struct device_node *np)
 		pr_debug("  irq %d no 0x%x on %s\n", i, oirq.args[0],
 			 oirq.np->full_name);
 		spu->irqs[i] = irq_create_of_mapping(&oirq);
-		if (spu->irqs[i] == NO_IRQ) {
+		if (!spu->irqs[i]) {
 			pr_debug("spu_new: failed to map it !\n");
 			goto err;
 		}
@@ -202,7 +205,7 @@ err:
 	pr_debug("failed to map irq %x for spu %s\n", *oirq.args,
 		spu->name);
 	for (; i >= 0; i--) {
-		if (spu->irqs[i] != NO_IRQ)
+		if (spu->irqs[i])
 			irq_dispose_mapping(spu->irqs[i]);
 	}
 	return ret;
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index bfb300633dfe..0ce1b45f02a8 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -368,7 +368,7 @@ static void chrp_8259_cascade(struct irq_desc *desc)
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
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index b7866e01483d..ade83829d5e8 100644
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
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 9b7975706bfc..89c54de88b7a 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -114,7 +114,7 @@ static unsigned int __hlwd_pic_get_irq(struct irq_domain *h)
 	irq_status = in_be32(io_base + HW_BROADWAY_ICR) &
 		     in_be32(io_base + HW_BROADWAY_IMR);
 	if (irq_status == 0)
-		return NO_IRQ;	/* no more IRQs pending */
+		return 0;	/* no more IRQs pending */
 
 	irq = __ffs(irq_status);
 	return irq_linear_revmap(h, irq);
@@ -131,7 +131,7 @@ static void hlwd_pic_irq_cascade(struct irq_desc *desc)
 	raw_spin_unlock(&desc->lock);
 
 	virq = __hlwd_pic_get_irq(irq_domain);
-	if (virq != NO_IRQ)
+	if (virq)
 		generic_handle_irq(virq);
 	else
 		pr_err("spurious interrupt!\n");
diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index ed7321d6772e..8e3590941960 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -47,7 +47,7 @@ static void mvme5100_8259_cascade(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
@@ -84,7 +84,7 @@ static void __init mvme5100_pic_init(void)
 	}
 
 	cirq = irq_of_parse_and_map(cp, 0);
-	if (cirq == NO_IRQ) {
+	if (!cirq) {
 		pr_warn("mvme5100_pic_init: no cascade interrupt?\n");
 		return;
 	}
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index a2f89e6326ce..a0589aac4163 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -552,7 +552,7 @@ void maple_pci_irq_fixup(struct pci_dev *dev)
 	    pci_bus_to_host(dev->bus) == u4_pcie) {
 		printk(KERN_DEBUG "Fixup U4 PCIe IRQ\n");
 		dev->irq = irq_create_mapping(NULL, 1);
-		if (dev->irq != NO_IRQ)
+		if (dev->irq)
 			irq_set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
 	}
 
@@ -562,7 +562,7 @@ void maple_pci_irq_fixup(struct pci_dev *dev)
 	if (dev->vendor == PCI_VENDOR_ID_AMD &&
 	    dev->device == PCI_DEVICE_ID_AMD_8111_IDE &&
 	    (dev->class & 5) != 5) {
-		dev->irq = NO_IRQ;
+		dev->irq = 0;
 	}
 
 	DBG(" <- maple_pci_irq_fixup\n");
@@ -648,7 +648,7 @@ int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
 		return defirq;
 	}
 	irq = irq_of_parse_and_map(np, channel & 0x1);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		printk("Failed to map onboard IDE interrupt for channel %d\n",
 		       channel);
 		return defirq;
diff --git a/arch/powerpc/platforms/pasemi/misc.c b/arch/powerpc/platforms/pasemi/misc.c
index e0ab299763c1..8571e7bf78b6 100644
--- a/arch/powerpc/platforms/pasemi/misc.c
+++ b/arch/powerpc/platforms/pasemi/misc.c
@@ -76,7 +76,7 @@ static int __init pasemi_register_i2c_devices(void)
 			}
 
 			info.irq = irq_of_parse_and_map(node, 0);
-			if (info.irq == NO_IRQ)
+			if (!info.irq)
 				info.irq = -1;
 
 			if (find_i2c_driver(node, &info) < 0)
diff --git a/arch/powerpc/platforms/pasemi/msi.c b/arch/powerpc/platforms/pasemi/msi.c
index d9af76342d99..d9cd510c8865 100644
--- a/arch/powerpc/platforms/pasemi/msi.c
+++ b/arch/powerpc/platforms/pasemi/msi.c
@@ -68,7 +68,7 @@ static void pasemi_msi_teardown_msi_irqs(struct pci_dev *pdev)
 	pr_debug("pasemi_msi_teardown_msi_irqs, pdev %p\n", pdev);
 
 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 
 		hwirq = virq_to_hw(entry->irq);
@@ -109,7 +109,7 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		}
 
 		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			pr_debug("pasemi_msi: failed mapping hwirq 0x%x\n",
 				  hwirq);
 			msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq,
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index e86c1bd08f1f..cb5605fcaf49 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -59,7 +59,7 @@ struct mce_regs {
 
 static struct mce_regs mce_regs[MAX_MCE_REGS];
 static int num_mce_regs;
-static int nmi_virq = NO_IRQ;
+static int nmi_virq = 0;
 
 
 static void __noreturn pas_restart(char *cmd)
@@ -264,7 +264,7 @@ static int pas_machine_check_handler(struct pt_regs *regs)
 	srr0 = regs->nip;
 	srr1 = regs->msr;
 
-	if (nmi_virq != NO_IRQ && mpic_get_mcirq() == nmi_virq) {
+	if (nmi_virq && mpic_get_mcirq() == nmi_virq) {
 		printk(KERN_ERR "NMI delivered\n");
 		debugger(regs);
 		mpic_end_irq(irq_get_irq_data(nmi_virq));
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 6d6f277477aa..c8c217b7dd33 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -401,7 +401,7 @@ static int kw_i2c_xfer(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
 {
 	struct pmac_i2c_host_kw *host = bus->hostdata;
 	u8 mode_reg = host->speed;
-	int use_irq = host->irq != NO_IRQ && !bus->polled;
+	int use_irq = host->irq && !bus->polled;
 
 	/* Setup mode & subaddress if any */
 	switch(bus->mode) {
@@ -535,7 +535,7 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 		break;
 	}	
 	host->irq = irq_of_parse_and_map(np, 0);
-	if (host->irq == NO_IRQ)
+	if (!host->irq)
 		printk(KERN_WARNING
 		       "low_i2c: Failed to map interrupt for %s\n",
 		       np->full_name);
@@ -557,7 +557,7 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 	 */
 	if (request_irq(host->irq, kw_i2c_irq, IRQF_NO_SUSPEND,
 			"keywest i2c", host))
-		host->irq = NO_IRQ;
+		host->irq = 0;
 
 	printk(KERN_INFO "KeyWest i2c @0x%08x irq %d %s\n",
 	       *addrp, host->irq, np->full_name);
diff --git a/arch/powerpc/platforms/powermac/pfunc_base.c b/arch/powerpc/platforms/powermac/pfunc_base.c
index e49d07f3d542..459138ed4571 100644
--- a/arch/powerpc/platforms/powermac/pfunc_base.c
+++ b/arch/powerpc/platforms/powermac/pfunc_base.c
@@ -26,7 +26,7 @@ static irqreturn_t macio_gpio_irq(int irq, void *data)
 static int macio_do_gpio_irq_enable(struct pmf_function *func)
 {
 	unsigned int irq = irq_of_parse_and_map(func->node, 0);
-	if (irq == NO_IRQ)
+	if (!irq)
 		return -EINVAL;
 	return request_irq(irq, macio_gpio_irq, 0, func->node->name, func);
 }
@@ -34,7 +34,7 @@ static int macio_do_gpio_irq_enable(struct pmf_function *func)
 static int macio_do_gpio_irq_disable(struct pmf_function *func)
 {
 	unsigned int irq = irq_of_parse_and_map(func->node, 0);
-	if (irq == NO_IRQ)
+	if (!irq)
 		return -EINVAL;
 	free_irq(irq, func);
 	return 0;
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 981546345033..f5f9ad7c3398 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -251,7 +251,7 @@ static unsigned int pmac_pic_get_irq(void)
 	}
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 	if (unlikely(irq < 0))
-		return NO_IRQ;
+		return 0;
 	return irq_linear_revmap(pmac_pic_host, irq);
 }
 
@@ -389,7 +389,7 @@ static void __init pmac_pic_probe_oldstyle(void)
 		out_le32(&pmac_irq_hw[i]->enable, 0);
 
 	/* Hookup cascade irq */
-	if (slave && pmac_irq_cascade != NO_IRQ)
+	if (slave && pmac_irq_cascade)
 		setup_irq(pmac_irq_cascade, &gatwick_cascade_action);
 
 	printk(KERN_INFO "irq: System has %d possible interrupts\n", max_irqs);
@@ -444,7 +444,7 @@ static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
 	pswitch = of_find_node_by_name(NULL, "programmer-switch");
 	if (pswitch) {
 		nmi_irq = irq_of_parse_and_map(pswitch, 0);
-		if (nmi_irq != NO_IRQ) {
+		if (nmi_irq) {
 			mpic_irq_set_priority(nmi_irq, 9);
 			setup_irq(nmi_irq, &xmon_action);
 		}
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index ed8bba68a162..998316bf2dad 100644
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
@@ -260,7 +260,7 @@ machine_arch_initcall(powernv, opal_event_init);
 int opal_event_request(unsigned int opal_event_nr)
 {
 	if (WARN_ON_ONCE(!opal_event_irqchip.domain))
-		return NO_IRQ;
+		return 0;
 
 	return irq_create_mapping(opal_event_irqchip.domain, opal_event_nr);
 }
diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
index 1349a099c74c..94498a04558b 100644
--- a/arch/powerpc/platforms/powernv/pci-cxl.c
+++ b/arch/powerpc/platforms/powernv/pci-cxl.c
@@ -344,7 +344,7 @@ int pnv_cxl_cx4_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			return (hwirq ? hwirq : -ENOMEM);
 
 		virq = irq_create_mapping(NULL, hwirq);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			pr_warn("%s: Failed to map cxl mode MSI to linux irq\n",
 				pci_name(pdev));
 			return -ENOMEM;
@@ -374,7 +374,7 @@ void pnv_cxl_cx4_teardown_msi_irqs(struct pci_dev *pdev)
 		return;
 
 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a21d831c1114..d6a4a61ede3d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -186,7 +186,7 @@ int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 			return -ENOSPC;
 		}
 		virq = irq_create_mapping(NULL, phb->msi_base + hwirq);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			pr_warn("%s: Failed to map MSI to linux irq\n",
 				pci_name(pdev));
 			msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq, 1);
@@ -217,7 +217,7 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 		return;
 
 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index b831638e6f4a..98f8c3611133 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -192,7 +192,7 @@ static int ps3_virq_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 
 	*virq = irq_create_mapping(NULL, outlet);
 
-	if (*virq == NO_IRQ) {
+	if (!*virq) {
 		FAIL("%s:%d: irq_create_mapping failed: outlet %lu\n",
 			__func__, __LINE__, outlet);
 		result = -ENOMEM;
@@ -339,7 +339,7 @@ int ps3_event_receive_port_setup(enum ps3_cpu_binding cpu, unsigned int *virq)
 	if (result) {
 		FAIL("%s:%d: lv1_construct_event_receive_port failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
-		*virq = NO_IRQ;
+		*virq = 0;
 		return result;
 	}
 
@@ -418,7 +418,7 @@ int ps3_sb_event_receive_port_setup(struct ps3_system_bus_device *dev,
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
diff --git a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
index 3c7707af3384..60154d08debf 100644
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
diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index 492b2575e0d2..b54850845466 100644
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
 
@@ -334,7 +334,7 @@ static int ps3_destroy_spu(struct spu *spu)
 	ps3_spe_irq_destroy(spu->irqs[1]);
 	ps3_spe_irq_destroy(spu->irqs[0]);
 
-	spu->irqs[0] = spu->irqs[1] = spu->irqs[2] = NO_IRQ;
+	spu->irqs[0] = spu->irqs[1] = spu->irqs[2] = 0;
 
 	spu_unmap(spu);
 
diff --git a/arch/powerpc/platforms/pseries/event_sources.c b/arch/powerpc/platforms/pseries/event_sources.c
index a6ddca833119..32187dc76730 100644
--- a/arch/powerpc/platforms/pseries/event_sources.c
+++ b/arch/powerpc/platforms/pseries/event_sources.c
@@ -34,7 +34,7 @@ void request_event_sources_irqs(struct device_node *np,
 		if (count > 15)
 			break;
 		virqs[count] = irq_create_of_mapping(&oirq);
-		if (virqs[count] == NO_IRQ) {
+		if (!virqs[count]) {
 			pr_err("event-sources: Unable to allocate "
 			       "interrupt number for %s\n",
 			       np->full_name);
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 543a6386f3eb..326ef0dd6038 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -119,7 +119,7 @@ static void rtas_teardown_msi_irqs(struct pci_dev *pdev)
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
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 4ffcaa6f8670..776900043e2a 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -114,7 +114,7 @@ static void pseries_8259_cascade(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
@@ -141,7 +141,7 @@ static void __init pseries_setup_i8259_cascade(void)
 	}
 
 	cascade = irq_of_parse_and_map(found, 0);
-	if (cascade == NO_IRQ) {
+	if (!cascade) {
 		printk(KERN_ERR "pic: failed to map cascade interrupt");
 		return;
 	}
diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 9144204442eb..ada29eaed6e2 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -240,7 +240,7 @@ static int axon_ram_probe(struct platform_device *device)
 	device_add_disk(&device->dev, bank->disk);
 
 	bank->irq_id = irq_of_parse_and_map(device->dev.of_node, 0);
-	if (bank->irq_id == NO_IRQ) {
+	if (!bank->irq_id) {
 		dev_err(&device->dev, "Cannot access ECC interrupt ID\n");
 		rc = -EFAULT;
 		goto failed;
@@ -250,7 +250,7 @@ static int axon_ram_probe(struct platform_device *device)
 			AXON_RAM_IRQ_FLAGS, bank->disk->disk_name, device);
 	if (rc != 0) {
 		dev_err(&device->dev, "Cannot register ECC interrupt handler\n");
-		bank->irq_id = NO_IRQ;
+		bank->irq_id = 0;
 		rc = -EFAULT;
 		goto failed;
 	}
@@ -268,7 +268,7 @@ static int axon_ram_probe(struct platform_device *device)
 
 failed:
 	if (bank != NULL) {
-		if (bank->irq_id != NO_IRQ)
+		if (bank->irq_id)
 			free_irq(bank->irq_id, device);
 		if (bank->disk != NULL) {
 			if (bank->disk->major > 0)
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 81d49476c47e..3c0eb9b25535 100644
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
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index bffcc7a486a1..48866e6c1efb 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -155,7 +155,7 @@ static struct irq_chip ehv_pic_direct_eoi_irq_chip = {
 	.irq_set_type	= ehv_pic_set_irq_type,
 };
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+/* Return an interrupt vector or 0 if no interrupt is pending. */
 unsigned int ehv_pic_get_irq(void)
 {
 	int irq;
@@ -168,7 +168,7 @@ unsigned int ehv_pic_get_irq(void)
 		ev_int_iack(0, &irq); /* legacy mode */
 
 	if (irq == 0xFFFF)    /* 0xFFFF --> no irq is pending */
-		return NO_IRQ;
+		return 0;
 
 	/*
 	 * this will also setup revmap[] in the slow path for the first
diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
index 06ac3c61b3d0..a6f0b96ce2c9 100644
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
diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpic_err.c
index b83f32562a37..488ec453038a 100644
--- a/arch/powerpc/sysdev/fsl_mpic_err.c
+++ b/arch/powerpc/sysdev/fsl_mpic_err.c
@@ -115,8 +115,8 @@ static irqreturn_t fsl_error_int_handler(int irq, void *data)
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
@@ -134,7 +134,7 @@ void mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum)
 	int ret;
 
 	virq = irq_create_mapping(mpic->irqhost, irqnum);
-	if (virq == NO_IRQ) {
+	if (!virq) {
 		pr_err("Error interrupt setup failed\n");
 		return;
 	}
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 3a2be3676f43..8a244828782e 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -131,7 +131,7 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 	irq_hw_number_t hwirq;
 
 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 		hwirq = virq_to_hw(entry->irq);
 		msi_data = irq_get_chip_data(entry->irq);
@@ -250,7 +250,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 
 		virq = irq_create_mapping(msi_data->irqhost, hwirq);
 
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			dev_err(&pdev->dev, "fail mapping hwirq %i\n", hwirq);
 			msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
 			rc = -ENOSPC;
@@ -285,7 +285,7 @@ static irqreturn_t fsl_msi_cascade(int irq, void *data)
 	msir_index = cascade_data->index;
 
 	if (msir_index >= NR_MSI_REG_MAX)
-		cascade_irq = NO_IRQ;
+		cascade_irq = 0;
 
 	switch (msi_data->feature & FSL_PIC_IP_MASK) {
 	case FSL_PIC_IP_MPIC:
@@ -315,7 +315,7 @@ static irqreturn_t fsl_msi_cascade(int irq, void *data)
 		cascade_irq = irq_linear_revmap(msi_data->irqhost,
 				msi_hwirq(msi_data, msir_index,
 					  intr_index + have_shift));
-		if (cascade_irq != NO_IRQ) {
+		if (cascade_irq) {
 			generic_handle_irq(cascade_irq);
 			ret = IRQ_HANDLED;
 		}
@@ -337,7 +337,7 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 		if (msi->cascade_array[i]) {
 			virq = msi->cascade_array[i]->virq;
 
-			BUG_ON(virq == NO_IRQ);
+			BUG_ON(!virq);
 
 			free_irq(virq, msi->cascade_array[i]);
 			kfree(msi->cascade_array[i]);
@@ -362,7 +362,7 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 	int virt_msir, i, ret;
 
 	virt_msir = irq_of_parse_and_map(dev->dev.of_node, irq_index);
-	if (virt_msir == NO_IRQ) {
+	if (!virt_msir) {
 		dev_err(&dev->dev, "%s: Cannot translate IRQ index %d\n",
 			__func__, irq_index);
 		return 0;
diff --git a/arch/powerpc/sysdev/ge/ge_pic.c b/arch/powerpc/sysdev/ge/ge_pic.c
index d57b77573068..02553a8ce191 100644
--- a/arch/powerpc/sysdev/ge/ge_pic.c
+++ b/arch/powerpc/sysdev/ge/ge_pic.c
@@ -102,7 +102,7 @@ static void gef_pic_cascade(struct irq_desc *desc)
 	 */
 	cascade_irq = gef_pic_get_irq();
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
@@ -206,7 +206,7 @@ void __init gef_pic_init(struct device_node *np)
 
 	/* Map controller */
 	gef_pic_cascade_irq = irq_of_parse_and_map(np, 0);
-	if (gef_pic_cascade_irq == NO_IRQ) {
+	if (!gef_pic_cascade_irq) {
 		printk(KERN_ERR "SBC610: failed to map cascade interrupt");
 		return;
 	}
@@ -223,12 +223,12 @@ void __init gef_pic_init(struct device_node *np)
 
 /*
  * This is called when we receive an interrupt with apparently comes from this
- * chip - check, returning the highest interrupt generated or return NO_IRQ
+ * chip - check, returning the highest interrupt generated or return 0.
  */
 unsigned int gef_pic_get_irq(void)
 {
 	u32 cause, mask, active;
-	unsigned int virq = NO_IRQ;
+	unsigned int virq = 0;
 	int hwirq;
 
 	cause = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_STATUS);
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index aa2c186d3115..bafb014e1a7e 100644
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
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index f76ee39cb337..f267ee0afc08 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -853,7 +853,7 @@ void ipic_clear_mcp_status(u32 mask)
 	ipic_write(primary_ipic->regs, IPIC_SERMR, mask);
 }
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+/* Return an interrupt vector or 0 if no interrupt is pending. */
 unsigned int ipic_get_irq(void)
 {
 	int irq;
@@ -864,7 +864,7 @@ unsigned int ipic_get_irq(void)
 	irq = ipic_read(primary_ipic->regs, IPIC_SIVCR) & IPIC_SIVCR_VECTOR_MASK;
 
 	if (irq == 0)    /* 0 --> no irq is pending */
-		return NO_IRQ;
+		return 0;
 
 	return irq_linear_revmap(primary_ipic->irqhost, irq);
 }
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index b7cf7abff2eb..3e828b20c21e 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -79,7 +79,7 @@ unsigned int mpc8xx_get_irq(void)
 	irq = in_be32(&siu_reg->sc_sivec) >> 26;
 
 	if (irq == PIC_VEC_SPURRIOUS)
-		irq = NO_IRQ;
+		irq = 0;
 
         return irq_linear_revmap(mpc8xx_pic_host, irq);
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7de45b2df366..4d48cecfedd1 100644
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
@@ -1778,13 +1778,13 @@ static unsigned int _mpic_get_one_irq(struct mpic *mpic, int reg)
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
diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
index 3f165d972a0e..db2286be5d9a 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -238,7 +238,7 @@ static int mpic_msgr_probe(struct platform_device *dev)
 
 		if (receive_mask & (1 << i)) {
 			msgr->irq = irq_of_parse_and_map(np, irq_index);
-			if (msgr->irq == NO_IRQ) {
+			if (!msgr->irq) {
 				dev_err(&dev->dev,
 						"Missing interrupt specifier");
 				kfree(msgr);
@@ -246,7 +246,7 @@ static int mpic_msgr_probe(struct platform_device *dev)
 			}
 			irq_index += 1;
 		} else {
-			msgr->irq = NO_IRQ;
+			msgr->irq = 0;
 		}
 
 		mpic_msgrs[reg_number] = msgr;
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 2cbc7e29b85f..cfc1c57d760f 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -110,7 +110,7 @@ static void u3msi_teardown_msi_irqs(struct pci_dev *pdev)
 	irq_hw_number_t hwirq;
 
 	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 
 		hwirq = virq_to_hw(entry->irq);
@@ -155,7 +155,7 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		msg.address_hi = addr >> 32;
 
 		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			pr_debug("u3msi: failed mapping hwirq 0x%x\n", hwirq);
 			msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, 1);
 			return -ENOSPC;
diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
index 0f842dd16bcd..a79953deb489 100644
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
diff --git a/arch/powerpc/sysdev/pmi.c b/arch/powerpc/sysdev/pmi.c
index 8a0b77a3ec0c..9ea6a221d9d5 100644
--- a/arch/powerpc/sysdev/pmi.c
+++ b/arch/powerpc/sysdev/pmi.c
@@ -158,7 +158,7 @@ static int pmi_of_probe(struct platform_device *dev)
 	data->dev = dev;
 
 	data->irq = irq_of_parse_and_map(np, 0);
-	if (data->irq == NO_IRQ) {
+	if (!data->irq) {
 		printk(KERN_ERR "pmi: invalid interrupt.\n");
 		rc = -EFAULT;
 		goto error_cleanup_iomap;
diff --git a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
index 52a93dcae262..9926ad67af76 100644
--- a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
@@ -60,7 +60,7 @@ static int hsta_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		}
 
 		hwirq = ppc4xx_hsta_msi.irq_map[irq];
-		if (hwirq == NO_IRQ) {
+		if (!hwirq) {
 			pr_err("%s: Failed mapping irq %d\n", __func__, irq);
 			return -EINVAL;
 		}
@@ -110,7 +110,7 @@ static void hsta_teardown_msi_irqs(struct pci_dev *dev)
 	int irq;
 
 	for_each_pci_msi_entry(entry, dev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 
 		irq = hsta_find_hwirq_offset(entry->irq);
@@ -166,7 +166,7 @@ static int hsta_msi_probe(struct platform_device *pdev)
 	for (irq = 0; irq < irq_count; irq++) {
 		ppc4xx_hsta_msi.irq_map[irq] =
 			irq_of_parse_and_map(dev->of_node, irq);
-		if (ppc4xx_hsta_msi.irq_map[irq] == NO_IRQ) {
+		if (!ppc4xx_hsta_msi.irq_map[irq]) {
 			dev_err(dev, "Unable to map IRQ\n");
 			ret = -EINVAL;
 			goto out2;
diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 8fb806135043..590dab4f47d6 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -102,7 +102,7 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 					__func__);
 		}
 		virq = irq_of_parse_and_map(msi_data->msi_dev, int_no);
-		if (virq == NO_IRQ) {
+		if (!virq) {
 			dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
 			msi_bitmap_free_hwirqs(&msi_data->bitmap, int_no, 1);
 			return -ENOSPC;
@@ -129,7 +129,7 @@ void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
 	dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
 
 	for_each_pci_msi_entry(entry, dev) {
-		if (entry->irq == NO_IRQ)
+		if (!entry->irq)
 			continue;
 		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
@@ -201,7 +201,7 @@ static int ppc4xx_of_msi_remove(struct platform_device *dev)
 
 	for (i = 0; i < msi_irqs; i++) {
 		virq = msi->msi_virqs[i];
-		if (virq != NO_IRQ)
+		if (virq)
 			irq_dispose_mapping(virq);
 	}
 
diff --git a/arch/powerpc/sysdev/ppc4xx_soc.c b/arch/powerpc/sysdev/ppc4xx_soc.c
index 5c77c9ba33aa..d41134d2f786 100644
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
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 379de955aae3..57c971b7839c 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -433,7 +433,7 @@ void tsi108_irq_cascade(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq = get_pci_source();
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 6893d8f236df..a00949f3e378 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -319,7 +319,7 @@ void __init uic_init_tree(void)
 	}
 }
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+/* Return an interrupt vector or 0 if no interrupt is pending. */
 unsigned int uic_get_irq(void)
 {
 	u32 msr;
diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index c1917cf67c3d..e7fa26c4ff73 100644
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
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index afdf62f2a695..8a6a043e239b 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -124,10 +124,10 @@ static unsigned int icp_native_get_irq(void)
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
@@ -138,7 +138,7 @@ static unsigned int icp_native_get_irq(void)
 	/* We might learn about it later, so EOI it */
 	icp_native_set_xirr(xirr);
 
-	return NO_IRQ;
+	return 0;
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index 57d72f10a97f..7357cfddb040 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -51,14 +51,14 @@ static unsigned int icp_opal_get_irq(void)
 
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
@@ -69,7 +69,7 @@ static unsigned int icp_opal_get_irq(void)
 	/* We might learn about it later, so EOI it */
 	opal_int_eoi(xirr);
 
-	return NO_IRQ;
+	return 0;
 }
 
 static void icp_opal_set_cpu_priority(unsigned char cppr)
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 9d530f479588..69d858e51ac7 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -131,7 +131,7 @@ static void xics_request_ipi(void)
 	unsigned int ipi;
 
 	ipi = irq_create_mapping(xics_host, XICS_IPI);
-	BUG_ON(ipi == NO_IRQ);
+	BUG_ON(!ipi);
 
 	/*
 	 * IPIs are marked IRQF_PERCPU. The handler was set in map.
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index b6819f0fc608..3f041b187033 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -236,7 +236,7 @@ static void macio_create_fixup_irq(struct macio_dev *dev, int index,
 	unsigned int irq;
 
 	irq = irq_create_mapping(NULL, line);
-	if (irq != NO_IRQ) {
+	if (!irq) {
 		dev->interrupt[index].start = irq;
 		dev->interrupt[index].flags = IORESOURCE_IRQ;
 		dev->interrupt[index].name = dev_name(&dev->ofdev.dev);
@@ -299,7 +299,7 @@ static void macio_setup_interrupts(struct macio_dev *dev)
 			break;
 		res = &dev->interrupt[j];
 		irq = irq_of_parse_and_map(np, i++);
-		if (irq == NO_IRQ)
+		if (!irq)
 			break;
 		res->start = irq;
 		res->flags = IORESOURCE_IRQ;
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 465c52219639..775527135b93 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -427,7 +427,7 @@ static int rackmeter_probe(struct macio_dev* mdev,
 	rm->irq = macio_irq(mdev, 1);
 #else
 	rm->irq = irq_of_parse_and_map(i2s, 1);
-	if (rm->irq == NO_IRQ ||
+	if (!rm->irq ||
 	    of_address_to_resource(i2s, 0, &ri2s) ||
 	    of_address_to_resource(i2s, 1, &rdma)) {
 		printk(KERN_ERR
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index d6f72c826c1c..08edb2c25b60 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -279,7 +279,7 @@ int smu_queue_cmd(struct smu_cmd *cmd)
 	spin_unlock_irqrestore(&smu->lock, flags);
 
 	/* Workaround for early calls when irq isn't available */
-	if (!smu_irq_inited || smu->db_irq == NO_IRQ)
+	if (!smu_irq_inited || !smu->db_irq)
 		smu_spinwait_cmd(cmd);
 
 	return 0;
@@ -498,8 +498,8 @@ int __init smu_init (void)
 	INIT_LIST_HEAD(&smu->cmd_list);
 	INIT_LIST_HEAD(&smu->cmd_i2c_list);
 	smu->of_node = np;
-	smu->db_irq = NO_IRQ;
-	smu->msg_irq = NO_IRQ;
+	smu->db_irq = 0;
+	smu->msg_irq = 0;
 
 	/* smu_cmdbuf_abs is in the low 2G of RAM, can be converted to a
 	 * 32 bits value safely
@@ -587,13 +587,13 @@ static int smu_late_init(void)
 
 	if (smu->db_node) {
 		smu->db_irq = irq_of_parse_and_map(smu->db_node, 0);
-		if (smu->db_irq == NO_IRQ)
+		if (!smu->db_irq)
 			printk(KERN_ERR "smu: failed to map irq for node %s\n",
 			       smu->db_node->full_name);
 	}
 	if (smu->msg_node) {
 		smu->msg_irq = irq_of_parse_and_map(smu->msg_node, 0);
-		if (smu->msg_irq == NO_IRQ)
+		if (!smu->msg_irq)
 			printk(KERN_ERR "smu: failed to map irq for node %s\n",
 			       smu->msg_node->full_name);
 	}
@@ -602,23 +602,23 @@ static int smu_late_init(void)
 	 * Try to request the interrupts
 	 */
 
-	if (smu->db_irq != NO_IRQ) {
+	if (smu->db_irq) {
 		if (request_irq(smu->db_irq, smu_db_intr,
 				IRQF_SHARED, "SMU doorbell", smu) < 0) {
 			printk(KERN_WARNING "SMU: can't "
 			       "request interrupt %d\n",
 			       smu->db_irq);
-			smu->db_irq = NO_IRQ;
+			smu->db_irq = 0;
 		}
 	}
 
-	if (smu->msg_irq != NO_IRQ) {
+	if (smu->msg_irq) {
 		if (request_irq(smu->msg_irq, smu_msg_intr,
 				IRQF_SHARED, "SMU message", smu) < 0) {
 			printk(KERN_WARNING "SMU: can't "
 			       "request interrupt %d\n",
 			       smu->msg_irq);
-			smu->msg_irq = NO_IRQ;
+			smu->msg_irq = 0;
 		}
 	}
 
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index bad18130f125..2088e23a8002 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -209,7 +209,7 @@ static int __init via_cuda_start(void)
     cuda_irq = IRQ_MAC_ADB;
 #else
     cuda_irq = irq_of_parse_and_map(vias, 0);
-    if (cuda_irq == NO_IRQ) {
+    if (!cuda_irq) {
 	printk(KERN_ERR "via-cuda: can't map interrupts for %s\n",
 	       vias->full_name);
 	return -ENODEV;
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index f8b6d1403c16..91081dcdc272 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -145,7 +145,7 @@ static int pmu_fully_inited;
 static int pmu_has_adb;
 static struct device_node *gpio_node;
 static unsigned char __iomem *gpio_reg;
-static int gpio_irq = NO_IRQ;
+static int gpio_irq = 0;
 static int gpio_irq_enabled = -1;
 static volatile int pmu_suspended;
 static spinlock_t pmu_lock;
@@ -402,7 +402,7 @@ static int __init via_pmu_start(void)
 	batt_req.complete = 1;
 
 	irq = irq_of_parse_and_map(vias, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		printk(KERN_ERR "via-pmu: can't map interrupt\n");
 		return -ENODEV;
 	}
@@ -424,7 +424,7 @@ static int __init via_pmu_start(void)
 		if (gpio_node)
 			gpio_irq = irq_of_parse_and_map(gpio_node, 0);
 
-		if (gpio_irq != NO_IRQ) {
+		if (gpio_irq) {
 			if (request_irq(gpio_irq, gpio1_interrupt,
 					IRQF_NO_SUSPEND, "GPIO1 ADB",
 					(void *)0))
diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index 632701a1d993..b7f300b79ffd 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -958,7 +958,7 @@ static int ps3_vuart_bus_interrupt_get(void)
 
 fail_request_irq:
 	ps3_vuart_irq_destroy(vuart_bus_priv.virq);
-	vuart_bus_priv.virq = NO_IRQ;
+	vuart_bus_priv.virq = 0;
 fail_alloc_irq:
 	kfree(vuart_bus_priv.bmp);
 	vuart_bus_priv.bmp = NULL;
@@ -982,7 +982,7 @@ static int ps3_vuart_bus_interrupt_put(void)
 	free_irq(vuart_bus_priv.virq, &vuart_bus_priv);
 
 	ps3_vuart_irq_destroy(vuart_bus_priv.virq);
-	vuart_bus_priv.virq = NO_IRQ;
+	vuart_bus_priv.virq = 0;
 
 	kfree(vuart_bus_priv.bmp);
 	vuart_bus_priv.bmp = NULL;
diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index f34153962d07..71960089e207 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -118,7 +118,7 @@ static void get_irq(struct device_node * np, int *irqptr)
 	if (np)
 		*irqptr = irq_of_parse_and_map(np, 0);
 	else
-		*irqptr = NO_IRQ;
+		*irqptr = 0;
 }
 
 /* 0x4 is outenable, 0x1 is out, thus 4 or 5 */
@@ -336,7 +336,7 @@ static int ftr_set_notify(struct gpio_runtime *rt,
 		return -EINVAL;
 	}
 
-	if (irq == NO_IRQ)
+	if (!irq)
 		return -ENODEV;
 
 	mutex_lock(&notif->mutex);
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index c8fafba218a5..58ee8089bbf9 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1303,19 +1303,19 @@ static int tumbler_init(struct snd_pmac *chip)
 				    &mix->line_mute, 1);
 	irq = tumbler_find_device("headphone-detect",
 				  NULL, &mix->hp_detect, 0);
-	if (irq <= NO_IRQ)
+	if (irq <= 0)
 		irq = tumbler_find_device("headphone-detect",
 					  NULL, &mix->hp_detect, 1);
-	if (irq <= NO_IRQ)
+	if (irq <= 0)
 		irq = tumbler_find_device("keywest-gpio15",
 					  NULL, &mix->hp_detect, 1);
 	mix->headphone_irq = irq;
  	irq = tumbler_find_device("line-output-detect",
 				  NULL, &mix->line_detect, 0);
- 	if (irq <= NO_IRQ)
+	if (irq <= 0)
 		irq = tumbler_find_device("line-output-detect",
 					  NULL, &mix->line_detect, 1);
-	if (IS_G4DA && irq <= NO_IRQ)
+	if (IS_G4DA && irq <= 0)
 		irq = tumbler_find_device("keywest-gpio16",
 					  NULL, &mix->line_detect, 1);
 	mix->lineout_irq = irq;
-- 
2.7.4
