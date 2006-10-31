Return-Path: <hugh_dickins@symantec.com>
Received: from extu-mxob-2.symantec.com (extu-mxob-2.symantec.com
	[216.10.194.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B110B67B83
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 06:05:00 +1100 (EST)
Date: Tue, 31 Oct 2006 18:44:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/5] ppc64: support CONFIG_DEBUG_PREEMPT
In-Reply-To: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0610311843290.26470@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add CONFIG_DEBUG_PREEMPT support to ppc64: it was useful for testing
get_paca() preemption.  Cheat a little, just use debug_smp_processor_id()
in the debug version of get_paca(): it contains all the right checks and
reporting, though get_paca() doesn't really use smp_processor_id().

Use local_paca for what might have been called __raw_get_paca().
Silence harmless warnings from io.h and lparcfg.c with local_paca - I
assume it is okay for iseries_lparcfg_data to be referencing shared_proc
with preemption enabled: all cpus show the same value for shared_proc?

Why do other architectures need TRACE_IRQFLAGS_SUPPORT for DEBUG_PREEMPT?
I don't know, ppc64 appears to get along fine without it.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
I've only tested this on one particular PowerMac G5 configuration:
it's quite likely that once integrated, defaulting to y when PREEMPT,
it'll show up a bunch of noisy warnings on other configurations:
not something to rush into mainline.

 arch/powerpc/kernel/lparcfg.c |    2 +-
 include/asm-powerpc/io.h      |   14 +++++++-------
 include/asm-powerpc/paca.h    |   11 +++++++++++
 include/asm-powerpc/percpu.h  |    2 +-
 include/asm-powerpc/smp.h     |    2 +-
 lib/Kconfig.debug             |    2 +-
 6 files changed, 22 insertions(+), 11 deletions(-)

--- git-powerpc/arch/powerpc/kernel/lparcfg.c	2006-10-24 04:34:08.000000000 +0100
+++ linux/arch/powerpc/kernel/lparcfg.c	2006-10-30 19:50:54.000000000 +0000
@@ -77,7 +77,7 @@ static int iseries_lparcfg_data(struct s
 	int processors, max_processors;
 	unsigned long purr = get_purr();
 
-	shared = (int)(get_lppaca()->shared_proc);
+	shared = (int)(local_paca->lppaca_ptr->shared_proc);
 
 	seq_printf(m, "system_active_processors=%d\n",
 		   (int)HvLpConfig_getSystemPhysicalProcessors());
--- git-powerpc/include/asm-powerpc/io.h	2006-10-24 04:34:33.000000000 +0100
+++ linux/include/asm-powerpc/io.h	2006-10-30 19:50:54.000000000 +0000
@@ -282,7 +282,7 @@ static inline void __out_8(volatile unsi
 {
 	__asm__ __volatile__("sync; stb%U0%X0 %1,%0"
 			     : "=m" (*addr) : "r" (val));
-	get_paca()->io_sync = 1;
+	local_paca->io_sync = 1;
 }
 
 static inline int __in_le16(const volatile unsigned short __iomem *addr)
@@ -307,14 +307,14 @@ static inline void __out_le16(volatile u
 {
 	__asm__ __volatile__("sync; sthbrx %1,0,%2"
 			     : "=m" (*addr) : "r" (val), "r" (addr));
-	get_paca()->io_sync = 1;
+	local_paca->io_sync = 1;
 }
 
 static inline void __out_be16(volatile unsigned short __iomem *addr, int val)
 {
 	__asm__ __volatile__("sync; sth%U0%X0 %1,%0"
 			     : "=m" (*addr) : "r" (val));
-	get_paca()->io_sync = 1;
+	local_paca->io_sync = 1;
 }
 
 static inline unsigned __in_le32(const volatile unsigned __iomem *addr)
@@ -339,14 +339,14 @@ static inline void __out_le32(volatile u
 {
 	__asm__ __volatile__("sync; stwbrx %1,0,%2" : "=m" (*addr)
 			     : "r" (val), "r" (addr));
-	get_paca()->io_sync = 1;
+	local_paca->io_sync = 1;
 }
 
 static inline void __out_be32(volatile unsigned __iomem *addr, int val)
 {
 	__asm__ __volatile__("sync; stw%U0%X0 %1,%0"
 			     : "=m" (*addr) : "r" (val));
-	get_paca()->io_sync = 1;
+	local_paca->io_sync = 1;
 }
 
 static inline unsigned long __in_le64(const volatile unsigned long __iomem *addr)
@@ -393,13 +393,13 @@ static inline void __out_le64(volatile u
 			     "sync\n"
 			     "std %0,0(%3)"
 			     : "=&r" (tmp) , "=&r" (val) : "1" (val) , "b" (addr) , "m" (*addr));
-	get_paca()->io_sync = 1;
+	local_paca->io_sync = 1;
 }
 
 static inline void __out_be64(volatile unsigned long __iomem *addr, unsigned long val)
 {
 	__asm__ __volatile__("sync; std%U0%X0 %1,%0" : "=m" (*addr) : "r" (val));
-	get_paca()->io_sync = 1;
+	local_paca->io_sync = 1;
 }
 
 #include <asm/eeh.h>
--- git-powerpc/include/asm-powerpc/paca.h	2006-10-30 19:30:57.000000000 +0000
+++ linux/include/asm-powerpc/paca.h	2006-10-30 19:50:54.000000000 +0000
@@ -21,7 +21,18 @@
 #include	<asm/mmu.h>
 
 register struct paca_struct *local_paca asm("r13");
+
+#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
+extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
+/*
+ * Add standard checks that preemption cannot occur when using get_paca():
+ * otherwise the paca_struct it points to may be the wrong one just after.
+ */
+#define get_paca()	((void) debug_smp_processor_id(), local_paca)
+#else
 #define get_paca()	local_paca
+#endif
+
 #define get_lppaca()	(get_paca()->lppaca_ptr)
 #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
--- git-powerpc/include/asm-powerpc/percpu.h	2006-09-20 04:42:06.000000000 +0100
+++ linux/include/asm-powerpc/percpu.h	2006-10-30 19:50:54.000000000 +0000
@@ -23,7 +23,7 @@
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)))
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
-#define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
+#define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, local_paca->data_offset))
 
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\
--- git-powerpc/include/asm-powerpc/smp.h	2006-10-24 04:34:33.000000000 +0100
+++ linux/include/asm-powerpc/smp.h	2006-10-30 19:50:54.000000000 +0000
@@ -45,7 +45,7 @@ void generic_mach_cpu_die(void);
 #endif
 
 #ifdef CONFIG_PPC64
-#define raw_smp_processor_id()	(get_paca()->paca_index)
+#define raw_smp_processor_id()	(local_paca->paca_index)
 #define hard_smp_processor_id() (get_paca()->hw_cpu_id)
 #else
 /* 32-bit */
--- git-powerpc/lib/Kconfig.debug	2006-10-30 19:15:49.000000000 +0000
+++ linux/lib/Kconfig.debug	2006-10-30 19:50:54.000000000 +0000
@@ -114,7 +114,7 @@ config DEBUG_SLAB_LEAK
 
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
-	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
+	depends on DEBUG_KERNEL && PREEMPT && (TRACE_IRQFLAGS_SUPPORT || PPC64)
 	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
