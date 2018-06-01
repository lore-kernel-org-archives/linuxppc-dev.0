Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80N6XJyzF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:40 +1000 (AEST)
Message-Id: <1fb79672b11370ab28172c1a52a00e2d5d49d6f2.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 06/14] powerpc: clean inclusions of asm/feature-fixups.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:37 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

files not using feature fixup don't need asm/feature-fixups.h
files using feature fixup need asm/feature-fixups.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cputable.h            | 1 -
 arch/powerpc/include/asm/dbell.h               | 1 +
 arch/powerpc/include/asm/dt_cpu_ftrs.h         | 1 -
 arch/powerpc/include/asm/exception-64s.h       | 1 +
 arch/powerpc/include/asm/firmware.h            | 1 -
 arch/powerpc/include/asm/kvm_booke_hv_asm.h    | 2 ++
 arch/powerpc/include/asm/mmu.h                 | 1 -
 arch/powerpc/include/asm/ppc_asm.h             | 1 +
 arch/powerpc/include/asm/reg.h                 | 1 +
 arch/powerpc/kernel/cpu_setup_6xx.S            | 1 +
 arch/powerpc/kernel/entry_32.S                 | 1 +
 arch/powerpc/kernel/entry_64.S                 | 1 +
 arch/powerpc/kernel/exceptions-64e.S           | 1 +
 arch/powerpc/kernel/exceptions-64s.S           | 1 +
 arch/powerpc/kernel/fpu.S                      | 1 +
 arch/powerpc/kernel/head_32.S                  | 1 +
 arch/powerpc/kernel/head_64.S                  | 1 +
 arch/powerpc/kernel/head_fsl_booke.S           | 1 +
 arch/powerpc/kernel/idle_6xx.S                 | 1 +
 arch/powerpc/kernel/idle_book3s.S              | 1 +
 arch/powerpc/kernel/idle_e500.S                | 1 +
 arch/powerpc/kernel/idle_power4.S              | 1 +
 arch/powerpc/kernel/l2cr_6xx.S                 | 1 +
 arch/powerpc/kernel/misc_32.S                  | 1 +
 arch/powerpc/kernel/misc_64.S                  | 1 +
 arch/powerpc/kernel/setup_32.c                 | 1 +
 arch/powerpc/kernel/setup_64.c                 | 1 +
 arch/powerpc/kernel/swsusp_32.S                | 1 +
 arch/powerpc/kernel/swsusp_asm64.S             | 1 +
 arch/powerpc/kernel/tm.S                       | 1 +
 arch/powerpc/kvm/book3s_64_slb.S               | 1 +
 arch/powerpc/kvm/book3s_hv_interrupts.S        | 1 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        | 1 +
 arch/powerpc/kvm/book3s_segment.S              | 1 +
 arch/powerpc/lib/copypage_64.S                 | 1 +
 arch/powerpc/lib/copyuser_64.S                 | 1 +
 arch/powerpc/lib/hweight_64.S                  | 1 +
 arch/powerpc/lib/memcpy_64.S                   | 1 +
 arch/powerpc/mm/hash_low_32.S                  | 1 +
 arch/powerpc/mm/hash_native_64.c               | 1 +
 arch/powerpc/mm/slb_low.S                      | 1 +
 arch/powerpc/mm/tlb_low_64e.S                  | 1 +
 arch/powerpc/mm/tlb_nohash_low.S               | 1 +
 arch/powerpc/platforms/powermac/cache.S        | 1 +
 arch/powerpc/platforms/powermac/sleep.S        | 1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 arch/powerpc/platforms/pseries/hvCall.S        | 1 +
 47 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 5e29b8a2106a..c36360be2491 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -4,7 +4,6 @@
 
 
 #include <linux/types.h>
-#include <asm/feature-fixups.h>
 #include <uapi/asm/cputable.h>
 #include <asm/asm-const.h>
 
diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 998c42ff1caa..99b84db23e8c 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -16,6 +16,7 @@
 #include <linux/threads.h>
 
 #include <asm/ppc-opcode.h>
+#include <asm/feature-fixups.h>
 
 #define PPC_DBELL_MSG_BRDCAST	(0x04000000)
 #define PPC_DBELL_TYPE(x)	(((x) & 0xf) << (63-36))
diff --git a/arch/powerpc/include/asm/dt_cpu_ftrs.h b/arch/powerpc/include/asm/dt_cpu_ftrs.h
index 55113432fc91..0c729e2d0e8a 100644
--- a/arch/powerpc/include/asm/dt_cpu_ftrs.h
+++ b/arch/powerpc/include/asm/dt_cpu_ftrs.h
@@ -10,7 +10,6 @@
  */
 
 #include <linux/types.h>
-#include <asm/feature-fixups.h>
 #include <uapi/asm/cputable.h>
 
 #ifdef CONFIG_PPC_DT_CPU_FTRS
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index c40b4380951c..1f2efc1a9769 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -35,6 +35,7 @@
  * implementations as possible.
  */
 #include <asm/head-64.h>
+#include <asm/feature-fixups.h>
 
 /* PACA save area offsets (exgen, exmc, etc) */
 #define EX_R9		0
diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index ce8aab72c21b..7a051bd21f87 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -14,7 +14,6 @@
 
 #ifdef __KERNEL__
 
-#include <asm/feature-fixups.h>
 #include <asm/asm-const.h>
 
 /* firmware feature bitmask values */
diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
index e5f048bbcb7c..931260b59ac6 100644
--- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
+++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
@@ -9,6 +9,8 @@
 #ifndef ASM_KVM_BOOKE_HV_ASM_H
 #define ASM_KVM_BOOKE_HV_ASM_H
 
+#include <asm/feature-fixups.h>
+
 #ifdef __ASSEMBLY__
 
 /*
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 8418d83b5eb0..13ea441ac531 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -5,7 +5,6 @@
 
 #include <linux/types.h>
 
-#include <asm/feature-fixups.h>
 #include <asm/asm-const.h>
 
 /*
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 75ece56dcd62..b5d023680801 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/ppc-opcode.h>
 #include <asm/firmware.h>
+#include <asm/feature-fixups.h>
 
 #ifdef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 11bcbe1ba134..b59a633dc349 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -14,6 +14,7 @@
 #include <linux/stringify.h>
 #include <asm/cputable.h>
 #include <asm/asm-const.h>
+#include <asm/feature-fixups.h>
 
 /* Pickup Book E specific registers. */
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index a9f3970693e1..fa3c2c91290c 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -16,6 +16,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 #include <asm/mmu.h>
+#include <asm/feature-fixups.h>
 
 _GLOBAL(__setup_cpu_603)
 	mflr	r5
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 20315b948f21..24e274835b8e 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -34,6 +34,7 @@
 #include <asm/ptrace.h>
 #include <asm/export.h>
 #include <asm/asm-405.h>
+#include <asm/feature-fixups.h>
 
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 47fa78de602d..768e5b766e12 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -43,6 +43,7 @@
 #else
 #include <asm/exception-64e.h>
 #endif
+#include <asm/feature-fixups.h>
 
 /*
  * System calls.
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 9b6e653e501a..419efdd567be 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -27,6 +27,7 @@
 #include <asm/hw_irq.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_booke_hv_asm.h>
+#include <asm/feature-fixups.h>
 
 /* XXX This will ultimately add space for a special exception save
  *     structure used to save things like SRR0/SRR1, SPRGs, MAS, etc...
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f283958129f2..d15c01198573 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -18,6 +18,7 @@
 #include <asm/ptrace.h>
 #include <asm/cpuidle.h>
 #include <asm/head-64.h>
+#include <asm/feature-fixups.h>
 
 /*
  * There are a few constraints to be concerned with.
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 07c913fd5aba..529dcc21c3f9 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -26,6 +26,7 @@
 #include <asm/ptrace.h>
 #include <asm/export.h>
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 #ifdef CONFIG_VSX
 #define __REST_32FPVSRS(n,c,base)					\
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 29b2fed93289..61ca27929355 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -35,6 +35,7 @@
 #include <asm/bug.h>
 #include <asm/kvm_book3s_asm.h>
 #include <asm/export.h>
+#include <asm/feature-fixups.h>
 
 /* 601 only have IBAT; cr0.eq is set on 601 when using this macro */
 #define LOAD_BAT(n, reg, RA, RB)	\
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 6eca15f25c73..4898e9491a1c 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -44,6 +44,7 @@
 #include <asm/cputhreads.h>
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
+#include <asm/feature-fixups.h>
 
 /* The physical memory is laid out such that the secondary processor
  * spin code sits at 0x0000...0x00ff. On server, the vectors follow
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index bf4c6021515f..e2750b856c8f 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -43,6 +43,7 @@
 #include <asm/cache.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/feature-fixups.h>
 #include "head_booke.h"
 
 /* As with the other PowerPC ports, it is expected that when code
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 1686916cc7f0..ff026c9d3cab 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -20,6 +20,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/feature-fixups.h>
 
 	.text
 
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 3db0513d8442..0cb6ffe992c2 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -24,6 +24,7 @@
 #include <asm/book3s/64/mmu-hash.h>
 #include <asm/mmu.h>
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 #undef DEBUG
 
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index b9b6ef510be1..583e55ac7d26 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -17,6 +17,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/feature-fixups.h>
 
 	.text
 
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index 08faa93755f9..dd7471fe20bd 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -16,6 +16,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/irqflags.h>
 #include <asm/hw_irq.h>
+#include <asm/feature-fixups.h>
 
 #undef DEBUG
 
diff --git a/arch/powerpc/kernel/l2cr_6xx.S b/arch/powerpc/kernel/l2cr_6xx.S
index 6408f09dbbd9..6e7dbb7d527c 100644
--- a/arch/powerpc/kernel/l2cr_6xx.S
+++ b/arch/powerpc/kernel/l2cr_6xx.S
@@ -45,6 +45,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/cache.h>
 #include <asm/page.h>
+#include <asm/feature-fixups.h>
 
 /* Usage:
 
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 3f7a9a2d2435..695b24a2d954 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -34,6 +34,7 @@
 #include <asm/bug.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/feature-fixups.h>
 
 	.text
 
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index fa267e94090a..262ba9481781 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -28,6 +28,7 @@
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
 #include <asm/export.h>
+#include <asm/feature-fixups.h>
 
 	.text
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index ef747a5a30b9..0e3743343280 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -41,6 +41,7 @@
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
 #include <asm/kdump.h>
+#include <asm/feature-fixups.h>
 
 #define DBG(fmt...)
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 7a7ce8ad455e..f369064460d2 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,6 +68,7 @@
 #include <asm/opal.h>
 #include <asm/cputhreads.h>
 #include <asm/hw_irq.h>
+#include <asm/feature-fixups.h>
 
 #include "setup.h"
 
diff --git a/arch/powerpc/kernel/swsusp_32.S b/arch/powerpc/kernel/swsusp_32.S
index 34b73a262709..7a919e9a3400 100644
--- a/arch/powerpc/kernel/swsusp_32.S
+++ b/arch/powerpc/kernel/swsusp_32.S
@@ -7,6 +7,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/mmu.h>
+#include <asm/feature-fixups.h>
 
 /*
  * Structure for storing CPU registers on the save area.
diff --git a/arch/powerpc/kernel/swsusp_asm64.S b/arch/powerpc/kernel/swsusp_asm64.S
index 82d8aae81c6a..f83bf6f72cb0 100644
--- a/arch/powerpc/kernel/swsusp_asm64.S
+++ b/arch/powerpc/kernel/swsusp_asm64.S
@@ -13,6 +13,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/feature-fixups.h>
 
 /*
  * Structure for storing CPU registers on the save area.
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index b92ac8e711db..f717e1f50faf 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -12,6 +12,7 @@
 #include <asm/ptrace.h>
 #include <asm/reg.h>
 #include <asm/bug.h>
+#include <asm/feature-fixups.h>
 
 #ifdef CONFIG_VSX
 /* See fpu.S, this is borrowed from there */
diff --git a/arch/powerpc/kvm/book3s_64_slb.S b/arch/powerpc/kvm/book3s_64_slb.S
index d293485c1a60..066c665dc86f 100644
--- a/arch/powerpc/kvm/book3s_64_slb.S
+++ b/arch/powerpc/kvm/book3s_64_slb.S
@@ -18,6 +18,7 @@
  */
 
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 #define SHADOW_SLB_ENTRY_LEN	0x10
 #define OFFSET_ESID(x)		(SHADOW_SLB_ENTRY_LEN * x)
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index eb918756f54e..1912fc2458c2 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -28,6 +28,7 @@
 #include <asm/exception-64s.h>
 #include <asm/ppc-opcode.h>
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 /*****************************************************************************
  *                                                                           *
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 849063a5d39b..a919676fb60f 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -33,6 +33,7 @@
 #include <asm/xive-regs.h>
 #include <asm/thread_info.h>
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 /* Sign-extend HDEC if not on POWER9 */
 #define EXTEND_HDEC(reg)			\
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index e19dabea22cc..4b0fffd1937b 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -20,6 +20,7 @@
 /* Real mode helpers */
 
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 
diff --git a/arch/powerpc/lib/copypage_64.S b/arch/powerpc/lib/copypage_64.S
index 8d5034f645f3..694390357667 100644
--- a/arch/powerpc/lib/copypage_64.S
+++ b/arch/powerpc/lib/copypage_64.S
@@ -11,6 +11,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/export.h>
+#include <asm/feature-fixups.h>
 
         .section        ".toc","aw"
 PPC64_CACHES:
diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index 65244263b6a3..2d6f128d3ebe 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -10,6 +10,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 #ifdef __BIG_ENDIAN__
 #define sLd sld		/* Shift towards low-numbered address. */
diff --git a/arch/powerpc/lib/hweight_64.S b/arch/powerpc/lib/hweight_64.S
index 3de7ac154f24..0526b2225260 100644
--- a/arch/powerpc/lib/hweight_64.S
+++ b/arch/powerpc/lib/hweight_64.S
@@ -20,6 +20,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
+#include <asm/feature-fixups.h>
 
 /* Note: This code relies on -mminimal-toc */
 
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index 26ea02b7311f..94650d6eae9c 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -10,6 +10,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 	.align	7
 _GLOBAL_TOC(memcpy)
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index ffbd7c0bda96..26acf6c8c20c 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -27,6 +27,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 #include <asm/export.h>
+#include <asm/feature-fixups.h>
 
 #ifdef CONFIG_SMP
 	.section .bss
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 1d049c78c82a..1baabc74c4ae 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -30,6 +30,7 @@
 #include <asm/udbg.h>
 #include <asm/kexec.h>
 #include <asm/ppc-opcode.h>
+#include <asm/feature-fixups.h>
 
 #include <misc/cxl-base.h>
 
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index a83fbd2a4a24..4ac5057ad439 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -22,6 +22,7 @@
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
 #include <asm/firmware.h>
+#include <asm/feature-fixups.h>
 
 /*
  * This macro generates asm code to compute the VSID scramble
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index eb82d787d99a..7fd20c52a8ec 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -22,6 +22,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_booke_hv_asm.h>
+#include <asm/feature-fixups.h>
 
 #ifdef CONFIG_PPC_64K_PAGES
 #define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE+1)
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index 505a3d010c47..e066a658acac 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -35,6 +35,7 @@
 #include <asm/processor.h>
 #include <asm/bug.h>
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 #if defined(CONFIG_40x)
 
diff --git a/arch/powerpc/platforms/powermac/cache.S b/arch/powerpc/platforms/powermac/cache.S
index cc5347eb1662..27862feee4a5 100644
--- a/arch/powerpc/platforms/powermac/cache.S
+++ b/arch/powerpc/platforms/powermac/cache.S
@@ -17,6 +17,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
+#include <asm/feature-fixups.h>
 
 /*
  * Flush and disable all data caches (dL1, L2, L3). This is used
diff --git a/arch/powerpc/platforms/powermac/sleep.S b/arch/powerpc/platforms/powermac/sleep.S
index 1c2802fabd57..f89808b9713d 100644
--- a/arch/powerpc/platforms/powermac/sleep.S
+++ b/arch/powerpc/platforms/powermac/sleep.S
@@ -18,6 +18,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 #include <asm/mmu.h>
+#include <asm/feature-fixups.h>
 
 #define MAGIC	0x4c617273	/* 'Lars' */
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 974885ff14c4..6a65583da86a 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -15,6 +15,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/opal.h>
 #include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
 
 	.section	".text"
 
diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index c511a1743a44..d91412c591ef 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -13,6 +13,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
+#include <asm/feature-fixups.h>
 
 	.section	".text"
 	
-- 
2.13.3
