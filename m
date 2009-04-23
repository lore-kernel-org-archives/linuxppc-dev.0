Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1172bff338316019112e982bafe61e862d1847a2.1240450296.git.michael@ellerman.id.au>
In-Reply-To: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/6] powerpc: Move get_irq() comment into header
Date: Thu, 23 Apr 2009 11:31:38 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The guts of do_IRQ() isn't really the right place to be documenting
the ppc_md.get_irq() interface. So move the comment into machdep.h

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/machdep.h |    4 ++++
 arch/powerpc/kernel/irq.c          |    7 -------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 0efdb1d..11d1fc3 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -110,6 +110,10 @@ struct machdep_calls {
 	void		(*show_percpuinfo)(struct seq_file *m, int i);
 
 	void		(*init_IRQ)(void);
+
+	/* Return an irq, or NO_IRQ to indicate there are none pending.
+	 * If for some reason there is no irq, but the interrupt
+	 * shouldn't be counted as spurious, return NO_IRQ_IGNORE. */
 	unsigned int	(*get_irq)(void);
 #ifdef CONFIG_KEXEC
 	void		(*kexec_cpu_down)(int crash_shutdown, int secondary);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f725610..b8f09bd 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -326,13 +326,6 @@ void do_IRQ(struct pt_regs *regs)
 
 	check_stack_overflow();
 
-	/*
-	 * Every platform is required to implement ppc_md.get_irq.
-	 * This function will either return an irq number or NO_IRQ to
-	 * indicate there are no more pending.
-	 * The value NO_IRQ_IGNORE is for buggy hardware and means that this
-	 * IRQ has already been handled. -- Tom
-	 */
 	irq = ppc_md.get_irq();
 
 	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE)
-- 
1.6.2.1
