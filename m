Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bTgw6SLhzF09c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 08:01:00 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Olof Johansson <olof@lixom.net>
Date: Wed, 25 Jul 2018 21:45:01 +0100 (BST)
Message-ID: <4c4cb05c4d.141a83d@auth.smtp.1and1.co.uk>
Subject: [PATCH] powerpc/pasemi: Use pr_err/pr_warn... for kernel messages
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pasemi code still uses printk(KERN_ERR/KERN_WARN ... change these to
pr_err(, pr_warn(... to match other powerpc arch code.

No functional changes.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>
---
 arch/powerpc/platforms/pasemi/dma_lib.c   |    6 ++--
 arch/powerpc/platforms/pasemi/gpio_mdio.c |    2 +-
 arch/powerpc/platforms/pasemi/idle.c      |    4 +--
 arch/powerpc/platforms/pasemi/iommu.c     |    2 +-
 arch/powerpc/platforms/pasemi/misc.c      |    3 +-
 arch/powerpc/platforms/pasemi/pci.c       |    4 +--
 arch/powerpc/platforms/pasemi/setup.c     |   53 ++++++++++++++---------------
 7 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 2c72263..c80f72c 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -531,7 +531,7 @@ int pasemi_dma_init(void)
    iob_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
    if (!iob_pdev) {
        BUG();
-       printk(KERN_WARNING "Can't find I/O Bridge\n");
+       pr_warn("Can't find I/O Bridge\n");
        err = -ENODEV;
        goto out;
    }
@@ -540,7 +540,7 @@ int pasemi_dma_init(void)
    dma_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa007, NULL);
    if (!dma_pdev) {
        BUG();
-       printk(KERN_WARNING "Can't find DMA controller\n");
+       pr_warn("Can't find DMA controller\n");
        err = -ENODEV;
        goto out;
    }
@@ -623,7 +623,7 @@ int pasemi_dma_init(void)
    pasemi_write_dma_reg(PAS_DMA_TXF_CFLG0, 0xffffffff);
    pasemi_write_dma_reg(PAS_DMA_TXF_CFLG1, 0xffffffff);
 
-   printk(KERN_INFO "PA Semi PWRficient DMA library initialized "
+   pr_info("PA Semi PWRficient DMA library initialized "
        "(%d tx, %d rx channels)\n", num_txch, num_rxch);
 
 out:
diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index c23e609..6f35a2a 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -256,7 +256,7 @@ static int gpio_mdio_probe(struct platform_device *ofdev)
    err = of_mdiobus_register(new_bus, np);
 
    if (err != 0) {
-       printk(KERN_ERR "%s: Cannot register as MDIO bus, err %d\n",
+       pr_err("%s: Cannot register as MDIO bus, err %d\n",
                new_bus->name, err);
        goto out_free_irq;
    }
diff --git a/arch/powerpc/platforms/pasemi/idle.c b/arch/powerpc/platforms/pasemi/idle.c
index 44e0d92..8bb4e80 100644
--- a/arch/powerpc/platforms/pasemi/idle.c
+++ b/arch/powerpc/platforms/pasemi/idle.c
@@ -78,13 +78,13 @@ static int pasemi_system_reset_exception(struct pt_regs *regs)
 static int __init pasemi_idle_init(void)
 {
 #ifndef CONFIG_PPC_PASEMI_CPUFREQ
-   printk(KERN_WARNING "No cpufreq driver, powersavings modes disabled\n");
+   pr_warn("No cpufreq driver, powersavings modes disabled\n");
    current_mode = 0;
 #endif
 
    ppc_md.system_reset_exception = pasemi_system_reset_exception;
    ppc_md.power_save = modes[current_mode].entry;
-   printk(KERN_INFO "Using PA6T idle loop (%s)\n", modes[current_mode].name);
+   pr_info("Using PA6T idle loop (%s)\n", modes[current_mode].name);
 
    return 0;
 }
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 78b80cb..f06c83f 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -210,7 +210,7 @@ static int __init iob_init(struct device_node *dn)
    /* For 2G space, 8x64 pages (2^21 bytes) is max total l2 size */
    iob_l2_base = (u32 *)__va(memblock_alloc_base(1UL<<21, 1UL<<21, 0x80000000));
 
-   printk(KERN_INFO "IOBMAP L2 allocated at: %p\n", iob_l2_base);
+   pr_info("IOBMAP L2 allocated at: %p\n", iob_l2_base);
 
    /* Allocate a spare page to map all invalid IOTLB pages. */
    tmp = memblock_alloc(IOBMAP_PAGE_SIZE, IOBMAP_PAGE_SIZE);
diff --git a/arch/powerpc/platforms/pasemi/misc.c b/arch/powerpc/platforms/pasemi/misc.c
index 8571e7b..f60f4b7 100644
--- a/arch/powerpc/platforms/pasemi/misc.c
+++ b/arch/powerpc/platforms/pasemi/misc.c
@@ -69,8 +69,7 @@ static int __init pasemi_register_i2c_devices(void)
            addr = of_get_property(node, "reg", &len);
            if (!addr || len < sizeof(int) ||
                *addr > (1 << 10) - 1) {
-               printk(KERN_WARNING
-                   "pasemi_register_i2c_devices: "
+               pr_warn("pasemi_register_i2c_devices: "
                    "invalid i2c device entry\n");
                continue;
            }
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index aea9ff2..c7c8607 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -205,7 +205,7 @@ static int __init pas_add_bridge(struct device_node *dev)
 
    setup_pa_pxp(hose);
 
-   printk(KERN_INFO "Found PA-PXP PCI host bridge.\n");
+   pr_info("Found PA-PXP PCI host bridge.\n");
 
    /* Interpret the "ranges" property */
    pci_process_bridge_OF_ranges(hose, dev, 1);
@@ -219,7 +219,7 @@ void __init pas_pci_init(void)
 
    root = of_find_node_by_path("/");
    if (!root) {
-       printk(KERN_CRIT "pas_pci_init: can't find root "
+       pr_crit("pas_pci_init: can't find root "
            "of device tree\n");
        return;
    }
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index d0b8ae5..9a6eb04 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -207,8 +207,7 @@ static __init void pas_init_IRQ(void)
            break;
        }
    if (!mpic_node) {
-       printk(KERN_ERR
-           "Failed to locate the MPIC interrupt controller\n");
+       pr_err("Failed to locate the MPIC interrupt controller\n");
        return;
    }
 
@@ -217,12 +216,12 @@ static __init void pas_init_IRQ(void)
    naddr = of_n_addr_cells(root);
    opprop = of_get_property(root, "platform-open-pic", &opplen);
    if (!opprop) {
-       printk(KERN_ERR "No platform-open-pic property.\n");
+       pr_err("No platform-open-pic property.\n");
        of_node_put(root);
        return;
    }
    openpic_addr = of_read_number(opprop, naddr);
-   printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
+   pr_debug("OpenPIC addr: %lx\n", openpic_addr);
 
    mpic_flags = MPIC_LARGE_VECTORS | MPIC_NO_BIAS | MPIC_NO_RESET;
 
@@ -265,72 +264,72 @@ static int pas_machine_check_handler(struct pt_regs *regs)
    srr1 = regs->msr;
 
    if (nmi_virq && mpic_get_mcirq() == nmi_virq) {
-       printk(KERN_ERR "NMI delivered\n");
+       pr_err("NMI delivered\n");
        debugger(regs);
        mpic_end_irq(irq_get_irq_data(nmi_virq));
        goto out;
    }
 
    dsisr = mfspr(SPRN_DSISR);
-   printk(KERN_ERR "Machine Check on CPU %d\n", cpu);
-   printk(KERN_ERR "SRR0  0x%016lx SRR1 0x%016lx\n", srr0, srr1);
-   printk(KERN_ERR "DSISR 0x%016lx DAR  0x%016lx\n", dsisr, regs->dar);
-   printk(KERN_ERR "BER   0x%016lx MER  0x%016lx\n", mfspr(SPRN_PA6T_BER),
+   pr_err("Machine Check on CPU %d\n", cpu);
+   pr_err("SRR0  0x%016lx SRR1 0x%016lx\n", srr0, srr1);
+   pr_err("DSISR 0x%016lx DAR  0x%016lx\n", dsisr, regs->dar);
+   pr_err("BER   0x%016lx MER  0x%016lx\n", mfspr(SPRN_PA6T_BER),
        mfspr(SPRN_PA6T_MER));
-   printk(KERN_ERR "IER   0x%016lx DER  0x%016lx\n", mfspr(SPRN_PA6T_IER),
+   pr_err("IER   0x%016lx DER  0x%016lx\n", mfspr(SPRN_PA6T_IER),
        mfspr(SPRN_PA6T_DER));
-   printk(KERN_ERR "Cause:\n");
+   pr_err("Cause:\n");
 
    if (srr1 & 0x200000)
-       printk(KERN_ERR "Signalled by SDC\n");
+       pr_err("Signalled by SDC\n");
 
    if (srr1 & 0x100000) {
-       printk(KERN_ERR "Load/Store detected error:\n");
+       pr_err("Load/Store detected error:\n");
        if (dsisr & 0x8000)
-           printk(KERN_ERR "D-cache ECC double-bit error or bus error\n");
+           pr_err("D-cache ECC double-bit error or bus error\n");
        if (dsisr & 0x4000)
-           printk(KERN_ERR "LSU snoop response error\n");
+           pr_err("LSU snoop response error\n");
        if (dsisr & 0x2000) {
-           printk(KERN_ERR "MMU SLB multi-hit or invalid B field\n");
+           pr_err("MMU SLB multi-hit or invalid B field\n");
            dump_slb = 1;
        }
        if (dsisr & 0x1000)
-           printk(KERN_ERR "Recoverable Duptags\n");
+           pr_err("Recoverable Duptags\n");
        if (dsisr & 0x800)
-           printk(KERN_ERR "Recoverable D-cache parity error count overflow\n");
+           pr_err("Recoverable D-cache parity error count overflow\n");
        if (dsisr & 0x400)
-           printk(KERN_ERR "TLB parity error count overflow\n");
+           pr_err("TLB parity error count overflow\n");
    }
 
    if (srr1 & 0x80000)
-       printk(KERN_ERR "Bus Error\n");
+       pr_err("Bus Error\n");
 
    if (srr1 & 0x40000) {
-       printk(KERN_ERR "I-side SLB multiple hit\n");
+       pr_err("I-side SLB multiple hit\n");
        dump_slb = 1;
    }
 
    if (srr1 & 0x20000)
-       printk(KERN_ERR "I-cache parity error hit\n");
+       pr_err("I-cache parity error hit\n");
 
    if (num_mce_regs == 0)
-       printk(KERN_ERR "No MCE registers mapped yet, can't dump\n");
+       pr_err("No MCE registers mapped yet, can't dump\n");
    else
-       printk(KERN_ERR "SoC debug registers:\n");
+       pr_err("SoC debug registers:\n");
 
    for (i = 0; i < num_mce_regs; i++)
-       printk(KERN_ERR "%s: 0x%08x\n", mce_regs[i].name,
+       pr_err("%s: 0x%08x\n", mce_regs[i].name,
            in_le32(mce_regs[i].addr));
 
    if (dump_slb) {
        unsigned long e, v;
        int i;
 
-       printk(KERN_ERR "slb contents:\n");
+       pr_err("slb contents:\n");
        for (i = 0; i < mmu_slb_size; i++) {
            asm volatile("slbmfee  %0,%1" : "=r" (e) : "r" (i));
            asm volatile("slbmfev  %0,%1" : "=r" (v) : "r" (i));
-           printk(KERN_ERR "%02d %016lx %016lx\n", i, e, v);
+           pr_err("%02d %016lx %016lx\n", i, e, v);
        }
    }
 
