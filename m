Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJX9M3G36zDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 23:59:01 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/8xx: use SPRN_EIE and SPRN_EID to enable/disable
 interrupts
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160823135856.DDF231A2459@localhost.localdomain>
Date: Tue, 23 Aug 2016 15:58:56 +0200 (CEST)
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
mfmsr/rlwinm/mtmsr and it avoids using a general register.

We just have to write something in the special register to change MSR EE
bit. So we write r0 into the register, regardless of r0 value.

Writing to one of those two special registers also set the MSR RI bit,
but this bit is only unset during beginning of exception prolog and end
of exception epilog. When executing C-functions MSR RI is always set.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: removed definition of SPRN_NRI which is not used. Enhanced the
     commit text. Moved down the SPRN_EIE and SPRN_EID definition to
     keep this patch independant of the hugepage patch I'm working on.

 arch/powerpc/include/asm/hw_irq.h  | 6 ++++++
 arch/powerpc/include/asm/reg.h     | 2 ++
 arch/powerpc/include/asm/reg_8xx.h | 4 ++++
 3 files changed, 12 insertions(+)

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
index 94d01f8..0197e12 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -25,6 +25,10 @@
 #define SPRN_MD_RAM0	825
 #define SPRN_MD_RAM1	826
 
+/* Special MSR manipulation registers */
+#define SPRN_EIE	80	/* External interrupt enable (EE=1, RI=1) */
+#define SPRN_EID	81	/* External interrupt disable (EE=0, RI=1) */
+
 /* Commands.  Only the first few are available to the instruction cache.
 */
 #define	IDC_ENABLE	0x02000000	/* Cache enable */
-- 
2.1.0
