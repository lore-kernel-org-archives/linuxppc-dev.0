Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9955B7166
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 22:01:55 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7513DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 22:01:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18994.17266.721207.48859@cargo.ozlabs.ibm.com>
Date: Fri, 12 Jun 2009 22:00:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add compiler memory barrier to mtmsr macro
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 32-bit non-Book E, local_irq_restore() turns into just mtmsr(),
which doesn't currently have a compiler memory barrier.  This means
that accesses to memory inside a local_irq_save/restore section,
or a spin_lock_irqsave/spin_unlock_irqrestore section on UP, can
be reordered by the compiler to occur outside that section.

To fix this, this adds a compiler memory barrier to mtmsr for both
32-bit and 64-bit.  Having a compiler memory barrier in mtmsr makes
sense because it will almost always be changing something about the
context in which memory accesses are done, so in general we don't want
memory accesses getting moved from one side of an mtmsr to the other.

With the barrier in mtmsr(), some of the explicit barriers in
hw_irq.h are now redundant, so this removes them.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/hw_irq.h |    5 ++---
 arch/powerpc/include/asm/reg.h    |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 20a44d0..7eada1a 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -80,7 +80,7 @@ static inline void local_irq_disable(void)
 	__asm__ __volatile__("wrteei 0": : :"memory");
 #else
 	unsigned long msr;
-	__asm__ __volatile__("": : :"memory");
+
 	msr = mfmsr();
 	SET_MSR_EE(msr & ~MSR_EE);
 #endif
@@ -92,7 +92,7 @@ static inline void local_irq_enable(void)
 	__asm__ __volatile__("wrteei 1": : :"memory");
 #else
 	unsigned long msr;
-	__asm__ __volatile__("": : :"memory");
+
 	msr = mfmsr();
 	SET_MSR_EE(msr | MSR_EE);
 #endif
@@ -108,7 +108,6 @@ static inline void local_irq_save_ptr(unsigned long *flags)
 #else
 	SET_MSR_EE(msr & ~MSR_EE);
 #endif
-	__asm__ __volatile__("": : :"memory");
 }
 
 #define local_save_flags(flags)	((flags) = mfmsr())
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index fb359b0..a3c28e4 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -745,11 +745,11 @@
 			asm volatile("mfmsr %0" : "=r" (rval)); rval;})
 #ifdef CONFIG_PPC64
 #define __mtmsrd(v, l)	asm volatile("mtmsrd %0," __stringify(l) \
-				     : : "r" (v))
+				     : : "r" (v) : "memory")
 #define mtmsrd(v)	__mtmsrd((v), 0)
 #define mtmsr(v)	mtmsrd(v)
 #else
-#define mtmsr(v)	asm volatile("mtmsr %0" : : "r" (v))
+#define mtmsr(v)	asm volatile("mtmsr %0" : : "r" (v) : "memory")
 #endif
 
 #define mfspr(rn)	({unsigned long rval; \
-- 
1.6.0.4
