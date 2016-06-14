Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTL4n0fZ8zDqhc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 16:55:20 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E6s1gR038967
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:19 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gbhfqsue-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:19 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 00:55:18 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 07/10] powerpc: move the cpu_has_feature to a separate
 file
Date: Tue, 14 Jun 2016 12:24:45 +0530
In-Reply-To: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465887288-12952-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kevin Hao <haokexin@gmail.com>

We plan to use jump label for cpu_has_feature. In order to implement
this we need to include the linux/jump_label.h in asm/cputable.h.
But it seems that asm/cputable.h is so basic header file for ppc that
it is almost included by all the other header files. The including of
the linux/jump_label.h will introduces various recursive inclusion.
And it is very hard to fix that. So we choose to move the function
cpu_has_feature to a separate header file before using the jump label
for it. No functional change.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  1 +
 arch/powerpc/include/asm/cacheflush.h         |  1 +
 arch/powerpc/include/asm/cpufeatures.h        | 22 ++++++++++++++++++++++
 arch/powerpc/include/asm/cputable.h           | 13 -------------
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
 18 files changed, 38 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpufeatures.h

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index fde50026603e..55025dc4c922 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -24,6 +24,7 @@
 #include <asm/book3s/64/pgtable.h>
 #include <asm/bug.h>
 #include <asm/processor.h>
+#include <asm/cpufeatures.h>
 
 /*
  * SLB
diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 69fb16d7a811..e650819acc95 100644
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
index 000000000000..bfa6cb8f5629
--- /dev/null
+++ b/arch/powerpc/include/asm/cpufeatures.h
@@ -0,0 +1,22 @@
+#ifndef __ASM_POWERPC_CPUFEATURES_H
+#define __ASM_POWERPC_CPUFEATURES_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/cputable.h>
+
+static inline bool __cpu_has_feature(unsigned long feature)
+{
+	if (CPU_FTRS_ALWAYS & feature)
+		return true;
+
+	return !!(CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature);
+}
+
+static inline bool cpu_has_feature(unsigned long feature)
+{
+
+	return __cpu_has_feature(feature);
+}
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_POWERPC_CPUFEATURE_H */
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index dfdf36bc2664..a49ea95849f8 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -576,19 +576,6 @@ enum {
 };
 #endif /* __powerpc64__ */
 
-static inline bool __cpu_has_feature(unsigned long feature)
-{
-	if (CPU_FTRS_ALWAYS & feature)
-		return true;
-
-	return !!(CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature);
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
index 2563c435a4b1..b0db2cc88900 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -13,6 +13,7 @@
 
 #include <asm/cputable.h>
 #include <linux/mm.h>
+#include <asm/cpufeatures.h>
 
 /*
  * This file is included by linux/mman.h, so we can't use cacl_vm_prot_bits()
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 3a4d7e0cfbe7..bafd0df4d47c 100644
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
index 8e7cb8e2b21a..d916bc6cb280 100644
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
index 3cb46a3b1de7..33c46a39c892 100644
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
index e2f12cbcade9..3d1f3d07e0d5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -58,6 +58,7 @@
 #include <asm/code-patching.h>
 #include <asm/exec.h>
 #include <asm/livepatch.h>
+#include <asm/cpufeatures.h>
 
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index f43d2d76d81f..e2d7b8843a7c 100644
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
index 8831738c3dcb..ccac1cfd877d 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -39,6 +39,7 @@
 #include <asm/mmu_context.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/code-patching.h>
+#include <asm/cpufeatures.h>
 
 #define DBG(fmt...)
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8c0ee8fae5d9..0ee6f92154d0 100644
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
index f053602e63fa..24310e58d107 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
@@ -35,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/reg.h>
 #include <asm/cell-regs.h>
+#include <asm/cpufeatures.h>
 
 #include "pervasive.h"
 
diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index acad77b4f7b6..88435c75139a 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -21,6 +21,7 @@ Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, US
 
 #include <linux/types.h>
 #include <asm/cputable.h>
+#include <asm/cpufeatures.h>
 #include "nonstdio.h"
 #include "ansidecl.h"
 #include "ppc.h"
-- 
2.7.4
