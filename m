Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0BCFDDE424
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:02:32 +1000 (EST)
Date: Tue, 4 Sep 2007 21:09:23 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [POWERPC] pasemi: Print more information at machine check
Message-ID: <20070905020923.GE25900@lixom.net>
References: <20070905020733.GA25900@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905020733.GA25900@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit c456a6cdfe86cb0e2e2187f5e76768f9215e0693
Author: Olof Johansson <olof@lixom.net>
Date:   Tue Sep 4 21:49:51 2007 -0500

    [POWERPC] pasemi: Print more information at machine check
    
    Add printout of some SoC error status registers, and dump the SLB contents
    for those machine check events where it makes sense.
    
    Since we can't go about and ioremap registers at machine check time,
    and we generally want to do as little as possible to print out the
    information, pre-build a table of the registers to dump and their address
    in the common PCI config space range.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 05def62..fe9a5d6 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -39,8 +39,21 @@
 
 #include "pasemi.h"
 
+/* SDC reset register, must be pre-mapped at reset time */
 static void __iomem *reset_reg;
 
+/* Various error status registers, must be pre-mapped at MCE time */
+
+#define MAX_MCE_REGS	32
+struct mce_regs {
+	char *name;
+	void __iomem *addr;
+};
+
+static struct mce_regs mce_regs[MAX_MCE_REGS];
+static int num_mce_regs;
+
+
 static void pas_restart(char *cmd)
 {
 	printk("Restarting...\n");
@@ -106,6 +119,59 @@ void __init pas_setup_arch(void)
 	pasemi_idle_init();
 }
 
+static int __init pas_setup_mce_regs(void)
+{
+	struct pci_dev *dev;
+	int reg;
+
+	if (!machine_is(pasemi))
+		return -ENODEV;
+
+	/* Remap various SoC status registers for use by the MCE handler */
+
+	reg = 0;
+
+	dev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa00a, NULL);
+	while (dev && reg < MAX_MCE_REGS) {
+		mce_regs[reg].name = kasprintf(GFP_KERNEL,
+						"mc%d_mcdebug_errsta", reg);
+		mce_regs[reg].addr = pasemi_pci_getcfgaddr(dev, 0x730);
+		dev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa00a, dev);
+		reg++;
+	}
+
+	dev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
+	if (dev && reg+4 < MAX_MCE_REGS) {
+		mce_regs[reg].name = "iobdbg_IntStatus1";
+		mce_regs[reg].addr = pasemi_pci_getcfgaddr(dev, 0x438);
+		reg++;
+		mce_regs[reg].name = "iobdbg_IOCTbusIntDbgReg";
+		mce_regs[reg].addr = pasemi_pci_getcfgaddr(dev, 0x454);
+		reg++;
+		mce_regs[reg].name = "iobiom_IntStatus";
+		mce_regs[reg].addr = pasemi_pci_getcfgaddr(dev, 0xc10);
+		reg++;
+		mce_regs[reg].name = "iobiom_IntDbgReg";
+		mce_regs[reg].addr = pasemi_pci_getcfgaddr(dev, 0xc1c);
+		reg++;
+	}
+
+	dev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa009, NULL);
+	if (dev && reg+2 < MAX_MCE_REGS) {
+		mce_regs[reg].name = "l2csts_IntStatus";
+		mce_regs[reg].addr = pasemi_pci_getcfgaddr(dev, 0x200);
+		reg++;
+		mce_regs[reg].name = "l2csts_Cnt";
+		mce_regs[reg].addr = pasemi_pci_getcfgaddr(dev, 0x214);
+		reg++;
+	}
+
+	num_mce_regs = reg;
+
+	return 0;
+}
+device_initcall(pas_setup_mce_regs);
+
 static __init void pas_init_IRQ(void)
 {
 	struct device_node *np;
@@ -166,25 +232,34 @@ static int pas_machine_check_handler(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 	unsigned long srr0, srr1, dsisr;
+	int dump_slb = 0;
+	int i;
 
 	srr0 = regs->nip;
 	srr1 = regs->msr;
 	dsisr = mfspr(SPRN_DSISR);
 	printk(KERN_ERR "Machine Check on CPU %d\n", cpu);
-	printk(KERN_ERR "SRR0 0x%016lx SRR1 0x%016lx\n", srr0, srr1);
-	printk(KERN_ERR "DSISR 0x%016lx DAR 0x%016lx\n", dsisr, regs->dar);
+	printk(KERN_ERR "SRR0  0x%016lx SRR1 0x%016lx\n", srr0, srr1);
+	printk(KERN_ERR "DSISR 0x%016lx DAR  0x%016lx\n", dsisr, regs->dar);
+	printk(KERN_ERR "BER   0x%016lx MER  0x%016lx\n", mfspr(SPRN_PA6T_BER),
+		mfspr(SPRN_PA6T_MER));
+	printk(KERN_ERR "IER   0x%016lx DER  0x%016lx\n", mfspr(SPRN_PA6T_IER),
+		mfspr(SPRN_PA6T_DER));
 	printk(KERN_ERR "Cause:\n");
 
 	if (srr1 & 0x200000)
 		printk(KERN_ERR "Signalled by SDC\n");
+
 	if (srr1 & 0x100000) {
 		printk(KERN_ERR "Load/Store detected error:\n");
 		if (dsisr & 0x8000)
 			printk(KERN_ERR "D-cache ECC double-bit error or bus error\n");
 		if (dsisr & 0x4000)
 			printk(KERN_ERR "LSU snoop response error\n");
-		if (dsisr & 0x2000)
+		if (dsisr & 0x2000) {
 			printk(KERN_ERR "MMU SLB multi-hit or invalid B field\n");
+			dump_slb = 1;
+		}
 		if (dsisr & 0x1000)
 			printk(KERN_ERR "Recoverable Duptags\n");
 		if (dsisr & 0x800)
@@ -192,13 +267,40 @@ static int pas_machine_check_handler(struct pt_regs *regs)
 		if (dsisr & 0x400)
 			printk(KERN_ERR "TLB parity error count overflow\n");
 	}
+
 	if (srr1 & 0x80000)
 		printk(KERN_ERR "Bus Error\n");
-	if (srr1 & 0x40000)
+
+	if (srr1 & 0x40000) {
 		printk(KERN_ERR "I-side SLB multiple hit\n");
+		dump_slb = 1;
+	}
+
 	if (srr1 & 0x20000)
 		printk(KERN_ERR "I-cache parity error hit\n");
 
+	if (num_mce_regs == 0)
+		printk(KERN_ERR "No MCE registers mapped yet, can't dump\n");
+	else
+		printk(KERN_ERR "SoC debug registers:\n");
+
+	for (i = 0; i < num_mce_regs; i++)
+		printk(KERN_ERR "%s: 0x%08x\n", mce_regs[i].name,
+			in_le32(mce_regs[i].addr));
+
+	if (dump_slb) {
+		unsigned long e, v;
+		int i;
+
+		printk(KERN_ERR "slb contents:\n");
+		for (i = 0; i < SLB_NUM_ENTRIES; i++) {
+			asm volatile("slbmfee  %0,%1" : "=r" (e) : "r" (i));
+			asm volatile("slbmfev  %0,%1" : "=r" (v) : "r" (i));
+			printk(KERN_ERR "%02d %016lx %016lx\n", i, e, v);
+		}
+	}
+
+
 	/* SRR1[62] is from MSR[62] if recoverable, so pass that back */
 	return !!(srr1 & 0x2);
 }
