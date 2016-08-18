Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFW0l4MXxzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 01:56:07 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: use SPRN_EIE and SPRN_EID to enable/disable
 interrupts
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160818155602.DAD601A2459@localhost.localdomain>
Date: Thu, 18 Aug 2016 17:56:02 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 8xx has two special registers called EID (External Interrupt
Disable) and EIE (External Interrupt Enable) for clearing/setting
EE in MSR. It avoids the three instructions set mfmsr/ori/mtmsr or
mfmsr/rlwinm/mtmsr.

We just have to write something in the register to change MSR EE
bit. So we write r0 into the register, regardless of r0 value.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hw_irq.h  | 6 ++++++
 arch/powerpc/include/asm/reg.h     | 2 ++
 arch/powerpc/include/asm/reg_8xx.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index c7d82ff..7ffb392 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -155,6 +155,8 @@ static inline unsigned long arch_local_irq_save(void)
 	unsigned long flags = arch_local_save_flags();
 #ifdef CONFIG_BOOKE
 	asm volatile("wrteei 0" : : : "memory");
+#elif defined(CONFIG_PPC_8xx)
+	wrtspr(SPRN_EID);
 #else
 	SET_MSR_EE(flags & ~MSR_EE);
 #endif
@@ -165,6 +167,8 @@ static inline void arch_local_irq_disable(void)
 {
 #ifdef CONFIG_BOOKE
 	asm volatile("wrteei 0" : : : "memory");
+#elif defined(CONFIG_PPC_8xx)
+	wrtspr(SPRN_EID);
 #else
 	arch_local_irq_save();
 #endif
@@ -174,6 +178,8 @@ static inline void arch_local_irq_enable(void)
 {
 #ifdef CONFIG_BOOKE
 	asm volatile("wrteei 1" : : : "memory");
+#elif defined(CONFIG_PPC_8xx)
+	wrtspr(SPRN_EIE);
 #else
 	unsigned long msr = mfmsr();
 	SET_MSR_EE(msr | MSR_EE);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index f69f40f..4bbd9be 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1246,6 +1246,8 @@ static inline void mtmsr_isync(unsigned long val)
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
 #endif
+#define wrtspr(rn)	asm volatile("mtspr " __stringify(rn) ",0" : \
+				     : : "memory")
 
 extern void msr_check_and_set(unsigned long bits);
 extern bool strict_msr_control;
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index 6dae71f..d4bca3de 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -6,6 +6,11 @@
 
 #include <asm/mmu.h>
 
+/* Special MSR manipulation registers */
+#define SPRN_EIE	80	/* External interrupt enable (EE=1, RI=1) */
+#define SPRN_EID	81	/* External interrupt disable (EE=0, RI=1) */
+#define SPRN_NRI	81	/* Non Recoverable interrupt (EE=0, RI=0) */
+
 /* Cache control on the MPC8xx is provided through some additional
  * special purpose registers.
  */
-- 
2.1.0
