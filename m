Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 6DF4067A85
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 05:07:26 +1100 (EST)
Date: Fri, 28 Jan 2005 11:06:39 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20050128110639.B9216@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Add platform specific machine check output handlers
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Patch adds generic way for platform port to extend 
MachineCheckException print-out and adds 44x bus error registers 
output. It also removes 40x #ifdefs from show_regs and makes 
40x use this new platform extension. 

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/kernel/process.c 1.59 vs edited =====
--- 1.59/arch/ppc/kernel/process.c	2004-12-14 13:59:07 -08:00
+++ edited/arch/ppc/kernel/process.c	2004-12-18 12:12:04 -08:00
@@ -325,17 +325,6 @@
 	       current, current->pid, current->comm, current->thread_info);
 	printk("Last syscall: %ld ", current->thread.last_syscall);
 
-#if defined(CONFIG_4xx) && defined(DCRN_PLB0_BEAR)
-	printk("\nPLB0: bear= 0x%8.8x acr=   0x%8.8x besr=  0x%8.8x\n",
-	    mfdcr(DCRN_PLB0_BEAR), mfdcr(DCRN_PLB0_ACR),
-	    mfdcr(DCRN_PLB0_BESR));
-#endif
-#if defined(CONFIG_4xx) && defined(DCRN_POB0_BEAR)
-	printk("PLB0 to OPB: bear= 0x%8.8x besr0= 0x%8.8x besr1= 0x%8.8x\n",
-	    mfdcr(DCRN_POB0_BEAR), mfdcr(DCRN_POB0_BESR0),
-	    mfdcr(DCRN_POB0_BESR1));
-#endif
-
 #ifdef CONFIG_SMP
 	printk(" CPU: %d", smp_processor_id());
 #endif /* CONFIG_SMP */
===== arch/ppc/kernel/traps.c 1.36 vs edited =====
--- 1.36/arch/ppc/kernel/traps.c	2004-11-02 06:40:33 -08:00
+++ edited/arch/ppc/kernel/traps.c	2004-12-18 13:26:33 -08:00
@@ -199,6 +199,15 @@
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
 #endif
 
+/* 
+ * This is "fall-back" implementation for configurations 
+ * which don't provide platform-specific machine check info
+ */
+void __attribute__ ((weak)) 
+platform_machine_check(struct pt_regs *regs)
+{
+}
+
 void MachineCheckException(struct pt_regs *regs)
 {
 	unsigned long reason = get_mc_reason(regs);
@@ -322,6 +331,12 @@
 		printk("Unknown values in msr\n");
 	}
 #endif /* CONFIG_4xx */
+
+	/*
+	 * Optional platform-provided routine to print out 
+	 * additional info, e.g. bus error registers.
+	 */
+	platform_machine_check(regs);
 
 	debugger(regs);
 	die("machine check", regs, SIGBUS);
===== arch/ppc/syslib/ibm44x_common.c 1.6 vs edited =====
--- 1.6/arch/ppc/syslib/ibm44x_common.c	2004-11-07 16:00:31 -08:00
+++ edited/arch/ppc/syslib/ibm44x_common.c	2004-12-18 12:07:37 -08:00
@@ -170,3 +170,16 @@
 #endif
 }
 
+/* Called from MachineCheckException */
+void platform_machine_check(struct pt_regs *regs)
+{
+    	printk("PLB0: BEAR=0x%08x%08x ACR=  0x%08x BESR= 0x%08x\n",
+		mfdcr(DCRN_PLB0_BEARH), mfdcr(DCRN_PLB0_BEARL), 
+		mfdcr(DCRN_PLB0_ACR),  mfdcr(DCRN_PLB0_BESR));
+	printk("POB0: BEAR=0x%08x%08x BESR0=0x%08x BESR1=0x%08x\n",
+		mfdcr(DCRN_POB0_BEARH), mfdcr(DCRN_POB0_BEARL), 
+		mfdcr(DCRN_POB0_BESR0), mfdcr(DCRN_POB0_BESR1));
+	printk("OPB0: BEAR=0x%08x%08x BSTAT=0x%08x\n",
+		mfdcr(DCRN_OPB0_BEARH), mfdcr(DCRN_OPB0_BEARL), 
+		mfdcr(DCRN_OPB0_BSTAT));
+}
===== arch/ppc/syslib/ppc4xx_setup.c 1.17 vs edited =====
--- 1.17/arch/ppc/syslib/ppc4xx_setup.c	2004-11-07 16:00:31 -08:00
+++ edited/arch/ppc/syslib/ppc4xx_setup.c	2004-12-18 12:11:45 -08:00
@@ -303,3 +303,19 @@
 	ppc_ide_md.ide_init_hwif = ppc4xx_ide_init_hwif_ports;
 #endif /* defined(CONFIG_PCI) && defined(CONFIG_IDE) */
 }
+
+/* Called from MachineCheckException */
+void platform_machine_check(struct pt_regs *regs)
+{
+#if defined(DCRN_PLB0_BEAR)
+	printk("PLB0: BEAR= 0x%08x ACR=   0x%08x BESR=  0x%08x\n",
+	    mfdcr(DCRN_PLB0_BEAR), mfdcr(DCRN_PLB0_ACR),
+	    mfdcr(DCRN_PLB0_BESR));
+#endif
+#if defined(DCRN_POB0_BEAR)
+	printk("PLB0 to OPB: BEAR= 0x%08x BESR0= 0x%08x BESR1= 0x%08x\n",
+	    mfdcr(DCRN_POB0_BEAR), mfdcr(DCRN_POB0_BESR0),
+	    mfdcr(DCRN_POB0_BESR1));
+#endif
+
+}
===== include/asm-ppc/ibm44x.h 1.6 vs edited =====
--- 1.6/include/asm-ppc/ibm44x.h	2004-11-07 16:00:31 -08:00
+++ edited/include/asm-ppc/ibm44x.h	2004-12-18 12:28:26 -08:00
@@ -244,13 +244,24 @@
 #define MALOBISR_CH0		0x80000000	/* EOB channel 1 bit */
 #define MALOBISR_CH2		0x40000000	/* EOB channel 2 bit */
 
-/* 440GP PLB Arbiter DCRs */
+/* 440GP/GX PLB Arbiter DCRs */
 #define DCRN_PLB0_REVID		0x082		/* PLB Arbiter Revision ID */
 #define DCRN_PLB0_ACR		0x083		/* PLB Arbiter Control */
 #define DCRN_PLB0_BESR		0x084		/* PLB Error Status */
 #define DCRN_PLB0_BEARL		0x086		/* PLB Error Address Low */
 #define DCRN_PLB0_BEAR		DCRN_PLB0_BEARL	/* 40x compatibility */
 #define DCRN_PLB0_BEARH		0x087		/* PLB Error Address High */
+
+/* 440GP/GX PLB to OPB bridge DCRs */
+#define DCRN_POB0_BESR0		0x090
+#define DCRN_POB0_BESR1		0x094
+#define DCRN_POB0_BEARL		0x092
+#define DCRN_POB0_BEARH		0x093
+
+/* 440GP/GX OPB to PLB bridge DCRs */
+#define DCRN_OPB0_BSTAT		0x0a9
+#define DCRN_OPB0_BEARL		0x0aa
+#define DCRN_OPB0_BEARH		0x0ab
 
 /* 440GP Clock, PM, chip control */
 #define DCRN_CPC0_SR		0x0b0
