Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-04.nyroc.rr.com (ms-smtp-04.nyroc.rr.com [24.24.2.58])
	by ozlabs.org (Postfix) with ESMTP id 702D667AA0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 19:57:53 +1000 (EST)
Date: Wed, 17 May 2006 05:57:37 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 03/09] robust VM per_cpu generic header
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605170557050.8408@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, benedict.gaster@superh.com,
	sam@ravnborg.org, bjornw@axis.com, kenneth.w.chen@intel.com,
	Ingo Molnar <mingo@elte.hu>, kiran@scalex86.org,
	clameter@sgi.com, Nick Piggin <nickpiggin@yahoo.com.au>,
	grundler@parisc-linux.org, arnd@arndb.de,
	Rusty Russell <rusty@rustcorp.com.au>, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
	Andi Kleen <ak@suse.de>, ralf@linux-mips.org,
	Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the VM per_cpu to the generic per_cpu.h header.

If __ARCH_HAS_VM_PERCPU is defined, it is expected that the arch
also defined the following:

PERCPU_START - start of VM area that per_cpu variables will be stored.
PERCPU_SIZE - size of the VM area for each CPU.  So the total size
		would be PERCPU_SIZE * NR_CPU

If __ARCH_HAS_VM_PERCPU is not defined, it falls back to the old
percpu hack.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-test/include/asm-generic/percpu.h
===================================================================
--- linux-2.6.16-test.orig/include/asm-generic/percpu.h	2006-05-17 04:32:27.000000000 -0400
+++ linux-2.6.16-test/include/asm-generic/percpu.h	2006-05-17 04:57:21.000000000 -0400
@@ -5,25 +5,52 @@
 #define __GENERIC_PER_CPU
 #ifdef CONFIG_SMP

-extern unsigned long __per_cpu_offset[NR_CPUS];
-
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name

+#ifdef __ARCH_HAS_VM_PERCPU
+
+#include <asm/sections.h>
+
+/*
+ * This is included in linux/percpu.h and if PERCPU_ENOUGH_ROOM is already
+ * defined, it wont overwrite it.
+ * This allows kernel/module.c to be the same for both archs with VM
+ * per_cpu and without.
+ */
+#define PERCPU_ENOUGH_ROOM PERCPU_SIZE
+
+#define __PERCPU_OFFSET_ADDRESS(i) ((PERCPU_START+PERCPU_SIZE*(i)) - \
+			(unsigned long)__per_cpu_start)
+
+extern void setup_per_cpu_areas (void);
+extern int percpu_modcopy(void *pcpudst, void *src, unsigned long size);
+
+#else /* !__ARCH_HAS_VM_PERCPU */
+
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+#define __PERCPU_OFFSET_ADDRESS(i) __per_cpu_offset[i]
+
+/* A macro to avoid #include hell... */
+#define percpu_modcopy(pcpudst, src, size)				\
+({									\
+	unsigned int __i;						\
+	for (__i = 0; __i < NR_CPUS; __i++)				\
+		if (cpu_possible(__i))					\
+			memcpy((pcpudst)+__PERCPU_OFFSET_ADDRESS(__i),	\
+			       (src), (size));				\
+	0;								\
+})
+
+#endif /* __ARCH_HAS_VM_PERCPU */
+
 /* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
+#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, \
+					__PERCPU_OFFSET_ADDRESS(cpu)))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())

-/* A macro to avoid #include hell... */
-#define percpu_modcopy(pcpudst, src, size)			\
-do {								\
-	unsigned int __i;					\
-	for (__i = 0; __i < NR_CPUS; __i++)			\
-		if (cpu_possible(__i))				\
-			memcpy((pcpudst)+__per_cpu_offset[__i],	\
-			       (src), (size));			\
-} while (0)
 #else /* ! SMP */

 #define DEFINE_PER_CPU(type, name) \
