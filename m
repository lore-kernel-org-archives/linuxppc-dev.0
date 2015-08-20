Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22f.google.com (mail-yk0-x22f.google.com
 [IPv6:2607:f8b0:4002:c07::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D97C1A1D80
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 22:15:15 +1000 (AEST)
Received: by ykdt205 with SMTP id t205so35186997ykd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 05:15:13 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 6/8] powerpc: move the cpu_has_feature to a separate file
Date: Thu, 20 Aug 2015 20:14:34 +0800
Message-Id: <1440072876-8321-7-git-send-email-haokexin@gmail.com>
In-Reply-To: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We plan to use jump label for cpu_has_feature. In order to implement
this we need to include the linux/jump_label.h in asm/cputable.h.
But it seems that asm/cputable.h is so basic header file for ppc that
it is almost included by all the other header files. The including of
the linux/jump_label.h will introduces various recursive inclusion.
And it is very hard to fix that. So we choose to move the function
cpu_has_feature to a separate header file before using the jump label
for it. No functional change.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/cacheflush.h   |  1 +
 arch/powerpc/include/asm/cpufeatures.h  | 14 ++++++++++++++
 arch/powerpc/include/asm/cputable.h     |  8 --------
 arch/powerpc/include/asm/cputime.h      |  1 +
 arch/powerpc/include/asm/dbell.h        |  1 +
 arch/powerpc/include/asm/dcr-native.h   |  1 +
 arch/powerpc/include/asm/mman.h         |  1 +
 arch/powerpc/include/asm/time.h         |  1 +
 arch/powerpc/include/asm/xor.h          |  1 +
 arch/powerpc/kernel/align.c             |  1 +
 arch/powerpc/kernel/irq.c               |  1 +
 arch/powerpc/kernel/process.c           |  1 +
 arch/powerpc/kernel/setup-common.c      |  1 +
 arch/powerpc/kernel/setup_32.c          |  1 +
 arch/powerpc/kernel/smp.c               |  1 +
 arch/powerpc/platforms/cell/pervasive.c |  1 +
 arch/powerpc/xmon/ppc-dis.c             |  1 +
 17 files changed, 29 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpufeatures.h

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 6229e6b6037b..3bdcd9231852 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -11,6 +11,7 @@
 
 #include <linux/mm.h>
 #include <asm/cputable.h>
+#include <asm/cpufeatures.h>
 
 /*
  * No cache flushing is required when address mappings are changed,
diff --git a/arch/powerpc/include/asm/cpufeatures.h b/arch/powerpc/include/asm/cpufeatures.h
new file mode 100644
index 000000000000..37650db5044f
--- /dev/null
+++ b/arch/powerpc/include/asm/cpufeatures.h
@@ -0,0 +1,14 @@
+#ifndef __ASM_POWERPC_CPUFEATURES_H
+#define __ASM_POWERPC_CPUFEATURES_H
+
+#include <asm/cputable.h>
+
+static inline int cpu_has_feature(unsigned long feature)
+{
+	return (CPU_FTRS_ALWAYS & feature) ||
+	       (CPU_FTRS_POSSIBLE
+		& cur_cpu_spec->cpu_features
+		& feature);
+}
+
+#endif /* __ASM_POWERPC_CPUFEATURE_H */
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index b118072670fb..ae4b6ef341cd 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -556,14 +556,6 @@ enum {
 };
 #endif /* __powerpc64__ */
 
-static inline int cpu_has_feature(unsigned long feature)
-{
-	return (CPU_FTRS_ALWAYS & feature) ||
-	       (CPU_FTRS_POSSIBLE
-		& cur_cpu_spec->cpu_features
-		& feature);
-}
-
 #define HBP_NUM 1
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index e2452550bcb1..b91837865c0e 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -28,6 +28,7 @@ static inline void setup_cputime_one_jiffy(void) { }
 #include <asm/div64.h>
 #include <asm/time.h>
 #include <asm/param.h>
+#include <asm/cpufeatures.h>
 
 typedef u64 __nocast cputime_t;
 typedef u64 __nocast cputime64_t;
diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 5fa6b20eba10..2d9eae338f70 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -16,6 +16,7 @@
 #include <linux/threads.h>
 
 #include <asm/ppc-opcode.h>
+#include <asm/cpufeatures.h>
 
 #define PPC_DBELL_MSG_BRDCAST	(0x04000000)
 #define PPC_DBELL_TYPE(x)	(((x) & 0xf) << (63-36))
diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/include/asm/dcr-native.h
index 4efc11dacb98..0186ba05bfe1 100644
--- a/arch/powerpc/include/asm/dcr-native.h
+++ b/arch/powerpc/include/asm/dcr-native.h
@@ -24,6 +24,7 @@
 
 #include <linux/spinlock.h>
 #include <asm/cputable.h>
+#include <asm/cpufeatures.h>
 
 typedef struct {
 	unsigned int base;
diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 8565c254151a..74922ad05e6c 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -13,6 +13,7 @@
 
 #include <asm/cputable.h>
 #include <linux/mm.h>
+#include <asm/cpufeatures.h>
 
 /*
  * This file is included by linux/mman.h, so we can't use cacl_vm_prot_bits()
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 6f69828458fb..fa63005f827f 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -18,6 +18,7 @@
 #include <linux/percpu.h>
 
 #include <asm/processor.h>
+#include <asm/cpufeatures.h>
 
 /* time.c */
 extern unsigned long tb_ticks_per_jiffy;
diff --git a/arch/powerpc/include/asm/xor.h b/arch/powerpc/include/asm/xor.h
index 0abb97f3be10..15ba0d07937f 100644
--- a/arch/powerpc/include/asm/xor.h
+++ b/arch/powerpc/include/asm/xor.h
@@ -23,6 +23,7 @@
 #ifdef CONFIG_ALTIVEC
 
 #include <asm/cputable.h>
+#include <asm/cpufeatures.h>
 
 void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
 		   unsigned long *v2_in);
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 86150fbb42c3..eaf1c04e51a6 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -26,6 +26,7 @@
 #include <asm/emulated_ops.h>
 #include <asm/switch_to.h>
 #include <asm/disassemble.h>
+#include <asm/cpufeatures.h>
 
 struct aligninfo {
 	unsigned char len;
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 45096033d37b..60355e06ae86 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -74,6 +74,7 @@
 #endif
 #define CREATE_TRACE_POINTS
 #include <asm/trace.h>
+#include <asm/cpufeatures.h>
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 75b6676c1a0b..3e35b19288fc 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -57,6 +57,7 @@
 #include <asm/code-patching.h>
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
+#include <asm/cpufeatures.h>
 
 /* Transactional Memory debug */
 #ifdef TM_DEBUG_SW
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 44c8d03558ac..7648b532b330 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -61,6 +61,7 @@
 #include <asm/cputhreads.h>
 #include <mm/mmu_decl.h>
 #include <asm/fadump.h>
+#include <asm/cpufeatures.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 35980a2785ba..f0868f510b3b 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -38,6 +38,7 @@
 #include <asm/udbg.h>
 #include <asm/mmu_context.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/cpufeatures.h>
 
 #define DBG(fmt...)
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ec9ec2058d2d..9188823fb0e3 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -53,6 +53,7 @@
 #include <asm/vdso.h>
 #include <asm/debug.h>
 #include <asm/kexec.h>
+#include <asm/cpufeatures.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
index d17e98bc0c10..036215b8192c 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
@@ -35,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/reg.h>
 #include <asm/cell-regs.h>
+#include <asm/cpufeatures.h>
 
 #include "pervasive.h"
 
diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 89098f320ad5..ca556b8be9ea 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -20,6 +20,7 @@ along with this file; see the file COPYING.  If not, write to the Free
 Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */
 
 #include <asm/cputable.h>
+#include <asm/cpufeatures.h>
 #include "nonstdio.h"
 #include "ansidecl.h"
 #include "ppc.h"
-- 
2.1.0
