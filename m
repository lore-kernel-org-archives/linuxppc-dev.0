Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93619B700C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 20:37:54 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 1 Jun 2012 10:03:23 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5194aBk15859912
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 19:05:22 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q519BWu2003283
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 19:11:34 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 03/27] smpboot: Define and use cpu_state per-cpu variable in
 generic code
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com
Date: Fri, 01 Jun 2012 14:40:44 +0530
Message-ID: <20120601091038.31979.67878.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Venkatesh Pallipadi <venki@google.com>,
 Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, mingo@kernel.org, linux-arch@vger.kernel.org,
 xen-devel@lists.xensource.com, Suresh Siddha <suresh.b.siddha@intel.com>,
 linux-sh@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Mike Frysinger <vapier@gentoo.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, nikunj@linux.vnet.ibm.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, rusty@rustcorp.com.au,
 Chris Metcalf <cmetcalf@tilera.com>, rjw@sisk.pl,
 Yong Zhang <yong.zhang0@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 vatsa@linux.vnet.ibm.com, Ralf Baechle <ralf@linux-mips.org>,
 Paul Mundt <lethal@linux-sh.org>, srivatsa.bhat@linux.vnet.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The per-cpu variable cpu_state is used in x86 and also used in other
architectures, to track the state of the cpu during bringup and hotplug.
Pull it out into generic code.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Yong Zhang <yong.zhang0@gmail.com>
Cc: Venkatesh Pallipadi <venki@google.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: xen-devel@lists.xensource.com
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/ia64/include/asm/cpu.h   |    2 --
 arch/ia64/kernel/process.c    |    1 +
 arch/ia64/kernel/smpboot.c    |    6 +-----
 arch/mips/cavium-octeon/smp.c |    4 +---
 arch/powerpc/kernel/smp.c     |    6 +-----
 arch/sh/include/asm/smp.h     |    2 --
 arch/sh/kernel/smp.c          |    4 +---
 arch/tile/kernel/smpboot.c    |    4 +---
 arch/x86/include/asm/cpu.h    |    2 --
 arch/x86/kernel/smpboot.c     |    4 +---
 arch/x86/xen/smp.c            |    1 +
 include/linux/smpboot.h       |    1 +
 kernel/smpboot.c              |    4 ++++
 13 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
index fcca30b..1c3acac 100644
--- a/arch/ia64/include/asm/cpu.h
+++ b/arch/ia64/include/asm/cpu.h
@@ -12,8 +12,6 @@ struct ia64_cpu {
 
 DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
 
-DECLARE_PER_CPU(int, cpu_state);
-
 #ifdef CONFIG_HOTPLUG_CPU
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 5e0e86d..32566c7 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/kdebug.h>
 #include <linux/utsname.h>
 #include <linux/tracehook.h>
+#include <linux/smpboot.h>
 
 #include <asm/cpu.h>
 #include <asm/delay.h>
diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
index 963d2db..df00a3c 100644
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -39,6 +39,7 @@
 #include <linux/efi.h>
 #include <linux/percpu.h>
 #include <linux/bitops.h>
+#include <linux/smpboot.h>
 
 #include <linux/atomic.h>
 #include <asm/cache.h>
@@ -111,11 +112,6 @@ extern unsigned long ia64_iobase;
 
 struct task_struct *task_for_booting_cpu;
 
-/*
- * State for each CPU
- */
-DEFINE_PER_CPU(int, cpu_state);
-
 cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
 EXPORT_SYMBOL(cpu_core_map);
 DEFINE_PER_CPU_SHARED_ALIGNED(cpumask_t, cpu_sibling_map);
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 97e7ce9..93cd4b0 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -13,6 +13,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/smpboot.h>
 
 #include <asm/mmu_context.h>
 #include <asm/time.h>
@@ -252,9 +253,6 @@ static void octeon_cpus_done(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-/* State of each CPU. */
-DEFINE_PER_CPU(int, cpu_state);
-
 extern void fixup_irqs(void);
 
 static DEFINE_SPINLOCK(smp_reserve_lock);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e1417c4..1928058a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -31,6 +31,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/topology.h>
+#include <linux/smpboot.h>
 
 #include <asm/ptrace.h>
 #include <linux/atomic.h>
@@ -57,11 +58,6 @@
 #define DBG(fmt...)
 #endif
 
-#ifdef CONFIG_HOTPLUG_CPU
-/* State of each CPU during hotplug phases */
-static DEFINE_PER_CPU(int, cpu_state) = { 0 };
-#endif
-
 struct thread_info *secondary_ti;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
diff --git a/arch/sh/include/asm/smp.h b/arch/sh/include/asm/smp.h
index 78b0d0f4..bda041e 100644
--- a/arch/sh/include/asm/smp.h
+++ b/arch/sh/include/asm/smp.h
@@ -31,8 +31,6 @@ enum {
 	SMP_MSG_NR,	/* must be last */
 };
 
-DECLARE_PER_CPU(int, cpu_state);
-
 void smp_message_recv(unsigned int msg);
 void smp_timer_broadcast(const struct cpumask *mask);
 
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index b86e9ca..8e0fde0 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/atomic.h>
+#include <linux/smpboot.h>
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
 #include <asm/smp.h>
@@ -34,9 +35,6 @@ int __cpu_logical_map[NR_CPUS];		/* Map logical to physical */
 
 struct plat_smp_ops *mp_ops = NULL;
 
-/* State of each CPU */
-DEFINE_PER_CPU(int, cpu_state) = { 0 };
-
 void __cpuinit register_smp_ops(struct plat_smp_ops *ops)
 {
 	if (mp_ops)
diff --git a/arch/tile/kernel/smpboot.c b/arch/tile/kernel/smpboot.c
index e686c5a..24a9c06 100644
--- a/arch/tile/kernel/smpboot.c
+++ b/arch/tile/kernel/smpboot.c
@@ -25,13 +25,11 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/irq.h>
+#include <linux/smpboot.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 
-/* State of each CPU. */
-static DEFINE_PER_CPU(int, cpu_state) = { 0 };
-
 /* The messaging code jumps to this pointer during boot-up */
 unsigned long start_cpu_function_addr;
 
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 4564c8e..2d0b239 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -30,8 +30,6 @@ extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 #endif
 
-DECLARE_PER_CPU(int, cpu_state);
-
 int mwait_usable(const struct cpuinfo_x86 *);
 
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index bfbe30e..269bc1f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -51,6 +51,7 @@
 #include <linux/stackprotector.h>
 #include <linux/gfp.h>
 #include <linux/cpuidle.h>
+#include <linux/smpboot.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -73,9 +74,6 @@
 #include <asm/smpboot_hooks.h>
 #include <asm/i8259.h>
 
-/* State of each CPU */
-DEFINE_PER_CPU(int, cpu_state) = { 0 };
-
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * We need this for trampoline_base protection from concurrent accesses when
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 2ef5948..09a7199 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
+#include <linux/smpboot.h>
 
 #include <asm/paravirt.h>
 #include <asm/desc.h>
diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index 63bbedd..834d90c 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -5,6 +5,7 @@
 #ifndef SMPBOOT_H
 #define SMPBOOT_H
 
+DECLARE_PER_CPU(int, cpu_state);
 extern void smpboot_start_secondary(void *arg);
 
 #endif
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 5ae1805..0df43b0 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -67,6 +67,8 @@ void __init idle_threads_init(void)
 }
 #endif
 
+/* State of each CPU during bringup/teardown */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
 
 /* Implement the following functions in your architecture, as appropriate. */
 
@@ -141,6 +143,8 @@ void __cpuinit smpboot_start_secondary(void *arg)
 	set_cpu_online(cpu, true);
 	arch_vector_unlock();
 
+	per_cpu(cpu_state, cpu) = CPU_ONLINE;
+
 	__cpu_post_online(arg);
 
 	/* Enable local interrupts now */
