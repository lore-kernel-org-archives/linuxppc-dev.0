Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA0382C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 15:46:26 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 1/3] powerpc: move the cpu_has_feature to a separate file
Date: Mon, 2 Sep 2013 13:45:24 +0800
Message-ID: <1378100726-32545-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1378100726-32545-1-git-send-email-haokexin@gmail.com>
References: <1378100726-32545-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
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
v2: Update the commit log to replace the jump_label_base.h with jump_label.h.

 arch/powerpc/include/asm/cacheflush.h   |  1 +
 arch/powerpc/include/asm/cpufeatures.h  | 14 ++++++++++++++
 arch/powerpc/include/asm/cputable.h     |  8 --------
 arch/powerpc/include/asm/cputime.h      |  1 +
 arch/powerpc/include/asm/dbell.h        |  1 +
 arch/powerpc/include/asm/dcr-native.h   |  1 +
 arch/powerpc/include/asm/mman.h         |  1 +
 arch/powerpc/include/asm/time.h         |  1 +
 arch/powerpc/kernel/align.c             |  1 +
 arch/powerpc/kernel/irq.c               |  1 +
 arch/powerpc/kernel/process.c           |  1 +
 arch/powerpc/kernel/setup-common.c      |  1 +
 arch/powerpc/kernel/setup_32.c          |  1 +
 arch/powerpc/kernel/smp.c               |  1 +
 arch/powerpc/oprofile/op_model_rs64.c   |  1 +
 arch/powerpc/platforms/cell/pervasive.c |  1 +
 arch/powerpc/xmon/ppc-dis.c             |  1 +
 17 files changed, 29 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpufeatures.h

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 5b93122..8d2d4c3 100644
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
index 0000000..37650db
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
index 0d4939b..ca177b2 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -546,14 +546,6 @@ enum {
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
index 607559a..15481e2 100644
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
index 5fa6b20..2d9eae3 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -16,6 +16,7 @@
 #include <linux/threads.h>
 
 #include <asm/ppc-opcode.h>
+#include <asm/cpufeatures.h>
 
 #define PPC_DBELL_MSG_BRDCAST	(0x04000000)
 #define PPC_DBELL_TYPE(x)	(((x) & 0xf) << (63-36))
diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/include/asm/dcr-native.h
index 7d2e623..3372650 100644
--- a/arch/powerpc/include/asm/dcr-native.h
+++ b/arch/powerpc/include/asm/dcr-native.h
@@ -24,6 +24,7 @@
 
 #include <linux/spinlock.h>
 #include <asm/cputable.h>
+#include <asm/cpufeatures.h>
 
 typedef struct {
 	unsigned int base;
diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 8565c25..74922ad 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -13,6 +13,7 @@
 
 #include <asm/cputable.h>
 #include <linux/mm.h>
+#include <asm/cpufeatures.h>
 
 /*
  * This file is included by linux/mman.h, so we can't use cacl_vm_prot_bits()
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index c1f2676..20e6ee9 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -18,6 +18,7 @@
 #include <linux/percpu.h>
 
 #include <asm/processor.h>
+#include <asm/cpufeatures.h>
 
 /* time.c */
 extern unsigned long tb_ticks_per_jiffy;
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index a27ccd5..4f49cb1 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -25,6 +25,7 @@
 #include <asm/cputable.h>
 #include <asm/emulated_ops.h>
 #include <asm/switch_to.h>
+#include <asm/cpufeatures.h>
 
 struct aligninfo {
 	unsigned char len;
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index c69440c..164a9ad 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -75,6 +75,7 @@
 #endif
 #define CREATE_TRACE_POINTS
 #include <asm/trace.h>
+#include <asm/cpufeatures.h>
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 6f428da..cc65650 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -57,6 +57,7 @@
 #endif
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
+#include <asm/cpufeatures.h>
 
 /* Transactional Memory debug */
 #ifdef TM_DEBUG_SW
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 3d261c0..6e3e595 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -61,6 +61,7 @@
 #include <asm/cputhreads.h>
 #include <mm/mmu_decl.h>
 #include <asm/fadump.h>
+#include <asm/cpufeatures.h>
 
 #include "setup.h"
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a4bbcae..304a85b 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -39,6 +39,7 @@
 #include <asm/udbg.h>
 #include <asm/mmu_context.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/cpufeatures.h>
 
 #include "setup.h"
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 442d8e2..e793c0d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -50,6 +50,7 @@
 #endif
 #include <asm/vdso.h>
 #include <asm/debug.h>
+#include <asm/cpufeatures.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
diff --git a/arch/powerpc/oprofile/op_model_rs64.c b/arch/powerpc/oprofile/op_model_rs64.c
index 9b801b8..924b66c8 100644
--- a/arch/powerpc/oprofile/op_model_rs64.c
+++ b/arch/powerpc/oprofile/op_model_rs64.c
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/oprofile_impl.h>
+#include <asm/cpufeatures.h>
 
 #define dbg(args...)
 
diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
index d17e98b..036215b 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
@@ -35,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/reg.h>
 #include <asm/cell-regs.h>
+#include <asm/cpufeatures.h>
 
 #include "pervasive.h"
 
diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 89098f32..a642155 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -24,6 +24,7 @@ Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, US
 #include "ansidecl.h"
 #include "ppc.h"
 #include "dis-asm.h"
+#include <asm/cpufeatures.h>
 
 /* Print a PowerPC or POWER instruction.  */
 
-- 
1.8.3.1
