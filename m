Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSkjd611VzDrpQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 08:21:57 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85MHqpt044064
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 18:21:55 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 259d48qmsd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 18:21:55 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 5 Sep 2016 19:21:53 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id DD04E352005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 18:21:26 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85MLnwm4960300
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:21:49 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85MLmbx015542
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:21:49 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v8 04/13] powerpc: Change places using CONFIG_KEXEC to use
 CONFIG_KEXEC_CORE instead.
Date: Mon,  5 Sep 2016 19:20:05 -0300
In-Reply-To: <1473114014-20769-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1473114014-20769-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1473114014-20769-5-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 2965faa5e03d ("kexec: split kexec_load syscall from kexec core
code") introduced CONFIG_KEXEC_CORE so that CONFIG_KEXEC means whether
the kexec_load system call should be compiled-in and CONFIG_KEXEC_FILE
means whether the kexec_file_load system call should be compiled-in.
These options can be set independently from each other.

Since until now powerpc only supported kexec_load, CONFIG_KEXEC and
CONFIG_KEXEC_CORE were synonyms. That is not the case anymore, so we
need to make a distinction. Almost all places where CONFIG_KEXEC was
being used should be using CONFIG_KEXEC_CORE instead, since
kexec_file_load also needs that code compiled in.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                          | 2 +-
 arch/powerpc/include/asm/debug.h              | 2 +-
 arch/powerpc/include/asm/kexec.h              | 6 +++---
 arch/powerpc/include/asm/machdep.h            | 4 ++--
 arch/powerpc/include/asm/smp.h                | 2 +-
 arch/powerpc/kernel/Makefile                  | 4 ++--
 arch/powerpc/kernel/head_64.S                 | 2 +-
 arch/powerpc/kernel/misc_32.S                 | 2 +-
 arch/powerpc/kernel/misc_64.S                 | 6 +++---
 arch/powerpc/kernel/prom.c                    | 2 +-
 arch/powerpc/kernel/setup_64.c                | 4 ++--
 arch/powerpc/kernel/smp.c                     | 6 +++---
 arch/powerpc/kernel/traps.c                   | 2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c | 2 +-
 arch/powerpc/platforms/85xx/smp.c             | 8 ++++----
 arch/powerpc/platforms/cell/spu_base.c        | 2 +-
 arch/powerpc/platforms/powernv/setup.c        | 6 +++---
 arch/powerpc/platforms/ps3/setup.c            | 4 ++--
 arch/powerpc/platforms/pseries/Makefile       | 2 +-
 arch/powerpc/platforms/pseries/setup.c        | 4 ++--
 20 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 927d2ab2ce08..140a1b84019a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -494,7 +494,7 @@ config CRASH_DUMP
 
 config FA_DUMP
 	bool "Firmware-assisted dump"
-	depends on PPC64 && PPC_RTAS && CRASH_DUMP && KEXEC
+	depends on PPC64 && PPC_RTAS && CRASH_DUMP && KEXEC_CORE
 	help
 	  A robust mechanism to get reliable kernel crash dump with
 	  assistance from firmware. This approach does not use kexec,
diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index a954e4975049..86308f177f2d 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -10,7 +10,7 @@ struct pt_regs;
 
 extern struct dentry *powerpc_debugfs_root;
 
-#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
+#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 
 extern int (*__debugger)(struct pt_regs *regs);
 extern int (*__debugger_ipi)(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index a46f5f45570c..eca2f975bf44 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -53,7 +53,7 @@
 
 typedef void (*crash_shutdown_t)(void);
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 
 /*
  * This function is responsible for capturing register states if coming
@@ -91,7 +91,7 @@ static inline bool kdump_in_progress(void)
 	return crashing_cpu >= 0;
 }
 
-#else /* !CONFIG_KEXEC */
+#else /* !CONFIG_KEXEC_CORE */
 static inline void crash_kexec_secondary(struct pt_regs *regs) { }
 
 static inline int overlaps_crashkernel(unsigned long start, unsigned long size)
@@ -116,7 +116,7 @@ static inline bool kdump_in_progress(void)
 	return false;
 }
 
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_KEXEC_CORE */
 #endif /* ! __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_KEXEC_H */
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 0420b388dd83..3200a4403de3 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -183,7 +183,7 @@ struct machdep_calls {
 	 */
 	void (*machine_shutdown)(void);
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	void (*kexec_cpu_down)(int crash_shutdown, int secondary);
 
 	/* Called to do what every setup is needed on image and the
@@ -198,7 +198,7 @@ struct machdep_calls {
 	 * no return.
 	 */
 	void (*machine_kexec)(struct kimage *image);
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_SUSPEND
 	/* These are called to disable and enable, respectively, IRQs when
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 0d02c11dc331..32db16d2e7ad 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -176,7 +176,7 @@ static inline void set_hard_smp_processor_id(int cpu, int phys)
 #endif /* !CONFIG_SMP */
 #endif /* !CONFIG_PPC64 */
 
-#if defined(CONFIG_PPC64) && (defined(CONFIG_SMP) || defined(CONFIG_KEXEC))
+#if defined(CONFIG_PPC64) && (defined(CONFIG_SMP) || defined(CONFIG_KEXEC_CORE))
 extern void smp_release_cpus(void);
 #else
 static inline void smp_release_cpus(void) { };
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index fe4c075bcf50..79a9821cf129 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -107,7 +107,7 @@ pci64-$(CONFIG_PPC64)		+= pci_dn.o pci-hotplug.o isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
 				   pci-common.o pci_of_scan.o
 obj-$(CONFIG_PCI_MSI)		+= msi.o
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o \
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o crash.o \
 				   machine_kexec_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
@@ -128,7 +128,7 @@ obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 obj-$(CONFIG_PPC32)		+= $(obj32-y)
 
-ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
+ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC_CORE),)
 obj-y				+= ppc_save_regs.o
 endif
 
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index f765b0434731..95c74ecd2e8a 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -145,7 +145,7 @@ __secondary_hold:
 	cmpdi	0,r12,0
 	beq	100b
 
-#if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
+#if defined(CONFIG_SMP) || defined(CONFIG_KEXEC_CORE)
 #ifdef CONFIG_PPC_BOOK3E
 	tovirt(r12,r12)
 #endif
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index d9c912b6e632..b8680fe47f5e 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -602,7 +602,7 @@ _GLOBAL(start_secondary_resume)
 _GLOBAL(__main)
 	blr
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	/*
 	 * Must be relocatable PIC code callable as a C function.
 	 */
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index cb195157b318..47b15b3a0938 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -473,7 +473,7 @@ _GLOBAL(kexec_wait)
 	addi	r5,r5,kexec_flag-1b
 
 99:	HMT_LOW
-#ifdef CONFIG_KEXEC		/* use no memory without kexec */
+#ifdef CONFIG_KEXEC_CORE	/* use no memory without kexec */
 	lwz	r4,0(r5)
 	cmpwi	0,r4,0
 	beq	99b
@@ -498,7 +498,7 @@ kexec_flag:
 	.long	0
 
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 #ifdef CONFIG_PPC_BOOK3E
 /*
  * BOOK3E has no real MMU mode, so we have to setup the initial TLB
@@ -700,4 +700,4 @@ _GLOBAL(kexec_sequence)
 	mtlr	4
 	li	r5,0
 	blr	/* image->start(physid, image->start, 0); */
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_KEXEC_CORE */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b0245bed6f54..fa7aea479fba 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -427,7 +427,7 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
 		tce_alloc_end = *lprop;
 #endif
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	lprop = of_get_flat_dt_prop(node, "linux,crashkernel-base", NULL);
 	if (lprop)
 		crashk_res.start = *lprop;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 7ac8e6eaab5b..c3e129080c31 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -346,7 +346,7 @@ void early_setup_secondary(void)
 
 #endif /* CONFIG_SMP */
 
-#if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
+#if defined(CONFIG_SMP) || defined(CONFIG_KEXEC_CORE)
 static bool use_spinloop(void)
 {
 	if (!IS_ENABLED(CONFIG_PPC_BOOK3E))
@@ -391,7 +391,7 @@ void smp_release_cpus(void)
 
 	DBG(" <- smp_release_cpus()\n");
 }
-#endif /* CONFIG_SMP || CONFIG_KEXEC */
+#endif /* CONFIG_SMP || CONFIG_KEXEC_CORE */
 
 /*
  * Initialize some remaining members of the ppc64_caches and systemcfg
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9c6f3fd58059..893bd7f79be6 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -193,7 +193,7 @@ int smp_request_message_ipi(int virq, int msg)
 	if (msg < 0 || msg > PPC_MSG_DEBUGGER_BREAK) {
 		return -EINVAL;
 	}
-#if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC)
+#if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC_CORE)
 	if (msg == PPC_MSG_DEBUGGER_BREAK) {
 		return 1;
 	}
@@ -325,7 +325,7 @@ void tick_broadcast(const struct cpumask *mask)
 }
 #endif
 
-#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
+#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 void smp_send_debugger_break(void)
 {
 	int cpu;
@@ -340,7 +340,7 @@ void smp_send_debugger_break(void)
 }
 #endif
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 {
 	crash_ipi_function_ptr = crash_ipi_callback;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 62859ebe0062..6828d6581e8e 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -65,7 +65,7 @@
 #include <asm/hmi.h>
 #include <sysdev/fsl_pci.h>
 
-#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
+#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
 int (*__debugger_ipi)(struct pt_regs *regs) __read_mostly;
 int (*__debugger_bpt)(struct pt_regs *regs) __read_mostly;
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 3a6a84f07f43..f5f100df1e0b 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -220,7 +220,7 @@ define_machine(corenet_generic) {
  *
  * Likewise, problems have been seen with kexec when coreint is enabled.
  */
-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC_CORE)
 	.get_irq		= mpic_get_irq,
 #else
 	.get_irq		= mpic_get_coreint_irq,
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index fe9f19e5e935..a83a6d26090d 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -349,13 +349,13 @@ struct smp_ops_t smp_85xx_ops = {
 	.cpu_disable	= generic_cpu_disable,
 	.cpu_die	= generic_cpu_die,
 #endif
-#if defined(CONFIG_KEXEC) && !defined(CONFIG_PPC64)
+#if defined(CONFIG_KEXEC_CORE) && !defined(CONFIG_PPC64)
 	.give_timebase	= smp_generic_give_timebase,
 	.take_timebase	= smp_generic_take_timebase,
 #endif
 };
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 #ifdef CONFIG_PPC32
 atomic_t kexec_down_cpus = ATOMIC_INIT(0);
 
@@ -458,7 +458,7 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 
 	default_machine_kexec(image);
 }
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_KEXEC_CORE */
 
 static void smp_85xx_basic_setup(int cpu_nr)
 {
@@ -512,7 +512,7 @@ void __init mpc85xx_smp_init(void)
 #endif
 	smp_ops = &smp_85xx_ops;
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	ppc_md.kexec_cpu_down = mpc85xx_smp_kexec_cpu_down;
 	ppc_md.machine_kexec = mpc85xx_smp_machine_kexec;
 #endif
diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index bb4a8e07c229..3689bb2b8597 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -676,7 +676,7 @@ static ssize_t spu_stat_show(struct device *dev,
 
 static DEVICE_ATTR(stat, 0444, spu_stat_show, NULL);
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 
 struct crash_spu_info {
 	struct spu *spu;
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index efe8b6bb168b..d50c7d99baaf 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -174,7 +174,7 @@ static void pnv_shutdown(void)
 	opal_shutdown();
 }
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 static void pnv_kexec_wait_secondaries_down(void)
 {
 	int my_cpu, i, notified = -1;
@@ -245,7 +245,7 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 		opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_BE);
 	}
 }
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 static unsigned long pnv_memory_block_size(void)
@@ -311,7 +311,7 @@ define_machine(powernv) {
 	.machine_shutdown	= pnv_shutdown,
 	.power_save             = NULL,
 	.calibrate_decr		= generic_calibrate_decr,
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
 #endif
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 3a487e7f4a5e..6244bc849469 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -250,7 +250,7 @@ static int __init ps3_probe(void)
 	return 1;
 }
 
-#if defined(CONFIG_KEXEC)
+#if defined(CONFIG_KEXEC_CORE)
 static void ps3_kexec_cpu_down(int crash_shutdown, int secondary)
 {
 	int cpu = smp_processor_id();
@@ -276,7 +276,7 @@ define_machine(ps3) {
 	.progress			= ps3_progress,
 	.restart			= ps3_restart,
 	.halt				= ps3_halt,
-#if defined(CONFIG_KEXEC)
+#if defined(CONFIG_KEXEC_CORE)
 	.kexec_cpu_down			= ps3_kexec_cpu_down,
 #endif
 };
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index fedc2ccf029d..dd9d9c2ba71b 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -8,7 +8,7 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   pci.o pci_dlpar.o eeh_pseries.o msi.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
-obj-$(CONFIG_KEXEC)	+= kexec.o
+obj-$(CONFIG_KEXEC_CORE)	+= kexec.o
 obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 4ffcaa6f8670..2eb75095f9fa 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -367,7 +367,7 @@ void pseries_disable_reloc_on_exc(void)
 }
 EXPORT_SYMBOL(pseries_disable_reloc_on_exc);
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 static void pSeries_machine_kexec(struct kimage *image)
 {
 	if (firmware_has_feature(FW_FEATURE_SET_MODE))
@@ -725,7 +725,7 @@ define_machine(pseries) {
 	.progress		= rtas_progress,
 	.system_reset_exception = pSeries_system_reset_exception,
 	.machine_check_exception = pSeries_machine_check_exception,
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	.machine_kexec          = pSeries_machine_kexec,
 	.kexec_cpu_down         = pseries_kexec_cpu_down,
 #endif
-- 
1.9.1
