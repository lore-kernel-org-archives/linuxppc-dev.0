Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtk0Fz0zDrLh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 16/21] powerpc: Move cpu_has_feature() to a separate file
Date: Thu, 28 Jul 2016 00:18:12 +1000
Message-Id: <1469629097-30859-16-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kevin Hao <haokexin@gmail.com>

We plan to use jump label for cpu_has_feature(). In order to implement
this we need to include the linux/jump_label.h in asm/cputable.h.

Unfortunately if we do that it leads to an include loop. The root of the
problem seems to be that reg.h needs cputable.h (for CPU_FTRs), and then
cputable.h via jump_label.h eventually pulls in hw_irq.h which needs
reg.h (for MSR_EE).

So move cpu_has_feature() to a separate file on its own.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  1 +
 arch/powerpc/include/asm/cacheflush.h         |  1 +
 arch/powerpc/include/asm/cpu_has_feature.h    | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/cputable.h           | 11 -----------
 arch/powerpc/include/asm/cputime.h            |  1 +
 arch/powerpc/include/asm/dbell.h              |  1 +
 arch/powerpc/include/asm/dcr-native.h         |  1 +
 arch/powerpc/include/asm/mman.h               |  1 +
 arch/powerpc/include/asm/time.h               |  1 +
 arch/powerpc/include/asm/xor.h                |  1 +
 arch/powerpc/kernel/align.c                   |  1 +
 arch/powerpc/kernel/irq.c                     |  1 +
 arch/powerpc/kernel/process.c                 |  1 +
 arch/powerpc/kernel/setup-common.c            |  1 +
 arch/powerpc/kernel/setup_32.c                |  1 +
 arch/powerpc/kernel/smp.c                     |  1 +
 arch/powerpc/platforms/cell/pervasive.c       |  1 +
 arch/powerpc/xmon/ppc-dis.c                   |  1 +
 18 files changed, 36 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpu_has_feature.h

v3: Change the header name, and flesh out change log.

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 5eaf86ac143d..032e9f0bc708 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -24,6 +24,7 @@
 #include <asm/book3s/64/pgtable.h>
 #include <asm/bug.h>
 #include <asm/processor.h>
+#include <asm/cpu_has_feature.h>
 
 /*
  * SLB
diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 69fb16d7a811..b77f0364df94 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -11,6 +11,7 @@
 
 #include <linux/mm.h>
 #include <asm/cputable.h>
+#include <asm/cpu_has_feature.h>
 
 /*
  * No cache flushing is required when address mappings are changed,
diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
new file mode 100644
index 000000000000..ad296b2f1d84
--- /dev/null
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -0,0 +1,20 @@
+#ifndef __ASM_POWERPC_CPUFEATURES_H
+#define __ASM_POWERPC_CPUFEATURES_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/cputable.h>
+
+static inline bool __cpu_has_feature(unsigned long feature)
+{
+	return !!((CPU_FTRS_ALWAYS & feature) ||
+		  (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature));
+}
+
+static inline bool cpu_has_feature(unsigned long feature)
+{
+	return __cpu_has_feature(feature);
+}
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_POWERPC_CPUFEATURE_H */
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 85a6797f9231..92961bcfbe3f 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -577,17 +577,6 @@ enum {
 };
 #endif /* __powerpc64__ */
 
-static inline bool __cpu_has_feature(unsigned long feature)
-{
-	return !!((CPU_FTRS_ALWAYS & feature) ||
-		  (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature));
-}
-
-static inline bool cpu_has_feature(unsigned long feature)
-{
-	return __cpu_has_feature(feature);
-}
-
 #define HBP_NUM 1
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index e2452550bcb1..465653b6b393 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -28,6 +28,7 @@ static inline void setup_cputime_one_jiffy(void) { }
 #include <asm/div64.h>
 #include <asm/time.h>
 #include <asm/param.h>
+#include <asm/cpu_has_feature.h>
 
 typedef u64 __nocast cputime_t;
 typedef u64 __nocast cputime64_t;
diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 5fa6b20eba10..378167377065 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -16,6 +16,7 @@
 #include <linux/threads.h>
 
 #include <asm/ppc-opcode.h>
+#include <asm/cpu_has_feature.h>
 
 #define PPC_DBELL_MSG_BRDCAST	(0x04000000)
 #define PPC_DBELL_TYPE(x)	(((x) & 0xf) << (63-36))
diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/include/asm/dcr-native.h
index 4efc11dacb98..4a2beef74277 100644
--- a/arch/powerpc/include/asm/dcr-native.h
+++ b/arch/powerpc/include/asm/dcr-native.h
@@ -24,6 +24,7 @@
 
 #include <linux/spinlock.h>
 #include <asm/cputable.h>
+#include <asm/cpu_has_feature.h>
 
 typedef struct {
 	unsigned int base;
diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 2563c435a4b1..ef2d9ac1bc52 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -13,6 +13,7 @@
 
 #include <asm/cputable.h>
 #include <linux/mm.h>
+#include <asm/cpu_has_feature.h>
 
 /*
  * This file is included by linux/mman.h, so we can't use cacl_vm_prot_bits()
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index cbbeaf0a6597..b240666b7bc1 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -18,6 +18,7 @@
 #include <linux/percpu.h>
 
 #include <asm/processor.h>
+#include <asm/cpu_has_feature.h>
 
 /* time.c */
 extern unsigned long tb_ticks_per_jiffy;
diff --git a/arch/powerpc/include/asm/xor.h b/arch/powerpc/include/asm/xor.h
index 0abb97f3be10..a36c2069d8ed 100644
--- a/arch/powerpc/include/asm/xor.h
+++ b/arch/powerpc/include/asm/xor.h
@@ -23,6 +23,7 @@
 #ifdef CONFIG_ALTIVEC
 
 #include <asm/cputable.h>
+#include <asm/cpu_has_feature.h>
 
 void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
 		   unsigned long *v2_in);
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index c7097f933114..033f3385fa49 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -26,6 +26,7 @@
 #include <asm/emulated_ops.h>
 #include <asm/switch_to.h>
 #include <asm/disassemble.h>
+#include <asm/cpu_has_feature.h>
 
 struct aligninfo {
 	unsigned char len;
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ac910d9982df..08887cf2b20e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -75,6 +75,7 @@
 #endif
 #define CREATE_TRACE_POINTS
 #include <asm/trace.h>
+#include <asm/cpu_has_feature.h>
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a8cca88e972f..9ee2623e0f67 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -58,6 +58,7 @@
 #include <asm/code-patching.h>
 #include <asm/exec.h>
 #include <asm/livepatch.h>
+#include <asm/cpu_has_feature.h>
 
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 714b4ba7ab86..dba265c586df 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -66,6 +66,7 @@
 #include <asm/hugetlb.h>
 #include <asm/livepatch.h>
 #include <asm/mmu_context.h>
+#include <asm/cpu_has_feature.h>
 
 #include "setup.h"
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 00f57754407e..c3e861df4b20 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -37,6 +37,7 @@
 #include <asm/serial.h>
 #include <asm/udbg.h>
 #include <asm/code-patching.h>
+#include <asm/cpu_has_feature.h>
 
 #define DBG(fmt...)
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5a1f015ea9f3..25a39052bf6b 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -55,6 +55,7 @@
 #include <asm/debug.h>
 #include <asm/kexec.h>
 #include <asm/asm-prototypes.h>
+#include <asm/cpu_has_feature.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
index d17e98bc0c10..e7d075077cb0 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
@@ -35,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/reg.h>
 #include <asm/cell-regs.h>
+#include <asm/cpu_has_feature.h>
 
 #include "pervasive.h"
 
diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 89098f320ad5..ee9891734149 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -20,6 +20,7 @@ along with this file; see the file COPYING.  If not, write to the Free
 Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */
 
 #include <asm/cputable.h>
+#include <asm/cpu_has_feature.h>
 #include "nonstdio.h"
 #include "ansidecl.h"
 #include "ppc.h"
-- 
2.7.4
