Date: Wed, 31 Mar 2004 15:07:41 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: John Whitney <johnw@sands-edge.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
Message-ID: <20040331150741.D17284@home.com>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331164423.GA417@gate.ebshome.net> <20040331100318.B17284@home.com> <9B139B02-834D-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9B139B02-834D-11D8-9FF0-000A95A07384@sands-edge.com>; from johnw@sands-edge.com on Wed, Mar 31, 2004 at 02:57:14PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 31, 2004 at 02:57:14PM -0500, John Whitney wrote:
> I don't see this in arch/ppc/Kconfig (or anywhere else) in the 2.6.5
> kernel which I am using (or in arch/ppc/config.in, for 2.4.25).  I can
> certainly create a patch to Kconfig that does this, or I could check
> for PPC_FEATURE_HAS_FPU in cur_cpu_spec[0]->cpu_user_features  in
> __raw_readq/writeq():
>
> unsigned long long __raw_readq (int addr)
> {
>    if (cur_cpu_spec[0]->cpu_user_features & PPC_FEATURE_HAS_FPU) {
>      ...
>    } else {
>      return *((volatile unsigned long long *) addr);
> }
>
> or somesuch.  This would work as long as the compiler doesn't have a
> snitfit with FP instructions, even if the processor can't use them...
>
> Which would the maintainers prefer?

Here's my preference, hopefully Paul reads this. I personally don't
see why we need to use a runtime flag when we pretty much have the
info available at build time anyway.  If e500 wanted a version they
can use the SPE option to add some code. It might be better to warn
at build time for !fpu in addition to BUGging at runtime.

-Matt

===== arch/ppc/Kconfig 1.56 vs edited =====
--- 1.56/arch/ppc/Kconfig	Thu Mar 18 23:04:54 2004
+++ edited/arch/ppc/Kconfig	Wed Mar 31 14:06:56 2004
@@ -79,6 +79,11 @@
 	depends on 44x
 	default y

+config PPC_FPU
+	bool
+	depends on 6xx || POWER3 || POWER4
+	default y
+
 config ALTIVEC
 	bool "AltiVec Support"
 	depends on 6xx || POWER4
===== include/asm-ppc/io.h 1.19 vs edited =====
--- 1.19/include/asm-ppc/io.h	Fri Mar 12 14:17:57 2004
+++ edited/include/asm-ppc/io.h	Wed Mar 31 14:57:41 2004
@@ -69,6 +69,77 @@
 #define __raw_writew(v, addr)	(*(volatile unsigned short *)(addr) = (v))
 #define __raw_writel(v, addr)	(*(volatile unsigned int *)(addr) = (v))

+#ifdef CONFIG_PPC_FPU
+/*
+ * For reading and writing 64-bit values, we need to use the floating
+ * point registers.  The code will enable MSR_FP in the MSR register,
+ * use FPR1 to read from and write to memory, and then restore
+ * everything to the previous values.
+ */
+static inline unsigned long long ___raw_readq(int addr)
+{
+	unsigned long flags;
+	unsigned long msr;
+	unsigned long msr_save;
+	unsigned long long result;
+	unsigned long long fp_save;
+
+	local_irq_save (flags);
+	asm volatile ("sync\n"
+			"mfmsr    %0\n"
+			"ori      %1,%0,0x2000\n"
+			"mtmsr    %1\n"
+			"isync\n"
+			"stfdx    1,0,%2\n"
+			"lfdx     1,0,%4\n"
+			"stfdx    1,0,%3\n"
+			"sync\n"
+			"lfdx     1,0,%2\n"
+			"mtmsr    %0\n"
+			"sync\n"
+			"isync\n"
+			: "=&r" (msr_save), "=&r" (msr)
+			: "r" (&fp_save), "r" (&result), "r" (addr)
+			: "memory" );
+	local_irq_restore (flags);
+
+	return result;
+}
+
+static inline void ___raw_writeq(unsigned long long value, int addr)
+{
+	unsigned long flags;
+	unsigned long msr;
+	unsigned long msr_save;
+	unsigned long long fp_save;
+
+	local_irq_save (flags);
+	asm volatile ("sync\n"
+			"mfmsr    %0\n"
+			"ori      %1,%0,0x2000\n"
+			"mtmsr    %1\n"
+			"isync\n"
+			"stfdx    1,0,%2\n"
+			"lfdx     1,0,%3\n"
+			"stfdx    1,0,%4\n"
+			"sync\n"
+			"lfdx     1,0,%2\n"
+			"mtmsr    %0\n"
+			"sync\n"
+			"isync\n"
+			: "=&r" (msr_save), "=&r" (msr)
+			: "r" (&fp_save), "r" (&value), "r" (addr)
+			: "memory" );
+	local_irq_restore (flags);
+	return;
+}
+#define __raw_readq		___raw_readq
+#define __raw_writeq		___raw_writeq
+#else /* !CONFIG_PPC_FPU */
+#define __raw_readq(addr)		({ BUG(); })
+#define __raw_writeq(addr)		({ BUG(); })
+#endif /* CONFIG_PPC_FPU */
+
 /*
  * The insw/outsw/insl/outsl macros don't do byte-swapping.
  * They are only used in practice for transferring buffers which

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
