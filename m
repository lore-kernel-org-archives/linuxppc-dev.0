Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8372A2C007A
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Aug 2013 21:30:41 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 6 Aug 2013 21:23:46 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 51C202BB004F
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Aug 2013 21:30:37 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r76BEvBi8847662
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Aug 2013 21:14:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r76BUaHM010613
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Aug 2013 21:30:36 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Convert out of line __arch_hweight to inline
Date: Tue,  6 Aug 2013 17:00:27 +0530
Message-Id: <1375788627-22281-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch attempts to improve the performace of __arch_hweight functions by
making them inline instead of current out of line implementation.

Testcase is to disable/enable SMT on a large (192 thread) POWER7 lpar.
Program used for SMT disable/enable is "ppc64_cpu" with "--smt=[off/on]"
option. Here are the perf output. In this case, __arch_hweight64 is
called by __bitmap_weight.

Without patch (ppc64_cpu --smt=off):

 17.60%  ppc64_cpu  [kernel.kallsyms]               [k] .deactivate_slab
....
  4.85%  ppc64_cpu  [kernel.kallsyms]               [k] .__bitmap_weight
....
  1.36%  ppc64_cpu  [kernel.kallsyms]               [k] .__disable_runtime
  1.29%  ppc64_cpu  [kernel.kallsyms]               [k] .__arch_hweight64


With patch (ppc64_cpu --smt=off):

 17.29%  ppc64_cpu  [kernel.kallsyms]               [k] .deactivate_slab
....
  3.71%  ppc64_cpu  [kernel.kallsyms]               [k] .__bitmap_weight
  3.26%  ppc64_cpu  [kernel.kallsyms]               [k]
.build_overlap_sched_groups
....

Without patch (ppc64_cpu --smt=on):

  8.35%  ppc64_cpu  [kernel.kallsyms]               [k] .strlen
  7.00%  ppc64_cpu  [kernel.kallsyms]               [k] .memset
  6.78%  ppc64_cpu  [kernel.kallsyms]               [k] .__bitmap_weight
  4.23%  ppc64_cpu  [kernel.kallsyms]               [k] .deactivate_slab
....
  1.58%  ppc64_cpu  [kernel.kallsyms]               [k]
.refresh_zone_stat_thresholds
  1.57%  ppc64_cpu  [kernel.kallsyms]               [k] .__arch_hweight64
  1.54%  ppc64_cpu  [kernel.kallsyms]               [k] .__enable_runtime
....

With patch (ppc64_cpu --smt=on):

  9.44%  ppc64_cpu  [kernel.kallsyms]               [k] .strlen
  6.43%  ppc64_cpu  [kernel.kallsyms]               [k] .memset
  5.48%  ppc64_cpu  [kernel.kallsyms]               [k] .__bitmap_weight
  4.59%  ppc64_cpu  [kernel.kallsyms]               [k] .insert_entry
  4.29%  ppc64_cpu  [kernel.kallsyms]               [k] .deactivate_slab
....

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/bitops.h     |  130 ++++++++++++++++++++++++++++++++-
 arch/powerpc/include/asm/ppc-opcode.h |    6 ++
 arch/powerpc/lib/Makefile             |    2 +-
 3 files changed, 133 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 910194e..136fe6a 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -43,8 +43,10 @@
 #endif
 
 #include <linux/compiler.h>
+#include <linux/types.h>
 #include <asm/asm-compat.h>
 #include <asm/synch.h>
+#include <asm/cputable.h>
 
 /*
  * clear_bit doesn't imply a memory barrier
@@ -263,10 +265,130 @@ static __inline__ int fls64(__u64 x)
 #endif /* __powerpc64__ */
 
 #ifdef CONFIG_PPC64
-unsigned int __arch_hweight8(unsigned int w);
-unsigned int __arch_hweight16(unsigned int w);
-unsigned int __arch_hweight32(unsigned int w);
-unsigned long __arch_hweight64(__u64 w);
+
+static inline unsigned int __arch_hweight8(unsigned int w)
+{
+	unsigned int register iop asm("r3") = w;
+	unsigned int register tmp asm("r4");
+	__asm__ __volatile__ (
+	stringify_in_c(BEGIN_FTR_SECTION)
+	"bl .__sw_hweight8;"
+	"nop;"
+	stringify_in_c(FTR_SECTION_ELSE)
+	PPC_POPCNTB_M(%1,%2) ";"
+	"clrldi %0,%1,64-8;"
+	stringify_in_c(ALT_FTR_SECTION_END_IFCLR((%3)))
+	: "=r" (iop), "=r" (tmp)
+	: "r" (iop), "i" (CPU_FTR_POPCNTB)
+	: "r0", "r1", "r5", "r6", "r7", "r8", "r9",
+	"r10", "r11", "r12", "r13", "r31", "lr", "cr0", "xer");
+
+	return iop;
+}
+
+static inline unsigned int __arch_hweight16(unsigned int w)
+{
+	unsigned int register iop asm("r3") = w;
+	unsigned int register tmp asm("r4");
+	__asm__ __volatile__ (
+	stringify_in_c(BEGIN_FTR_SECTION)
+	"bl .__sw_hweight16;"
+	"nop;"
+	"nop;"
+	"nop;"
+	"nop;"
+	stringify_in_c(FTR_SECTION_ELSE)
+		stringify_in_c(BEGIN_FTR_SECTION_NESTED(50))
+		PPC_POPCNTB_M(%0,%2) ";"
+		"srdi %1,%0,8;"
+		"add %0,%1,%0;"
+		"clrldi %0,%0,64-8;"
+		stringify_in_c(FTR_SECTION_ELSE_NESTED(50))
+		"clrlwi %0,%2,16;"
+		PPC_POPCNTW_M(%1,%0) ";"
+		"clrldi %0,%1,64-8;"
+		stringify_in_c(ALT_FTR_SECTION_END_NESTED_IFCLR(%4,50))
+	stringify_in_c(ALT_FTR_SECTION_END_IFCLR((%3)))
+	: "=r" (iop), "=r" (tmp)
+	: "r" (iop), "i" (CPU_FTR_POPCNTB), "i" (CPU_FTR_POPCNTD)
+	: "r0", "r1", "r5", "r6", "r7", "r8", "r9",
+	"r10", "r11", "r12", "r13", "r31", "lr", "cr0", "xer");
+
+	return iop;
+}
+
+static inline unsigned int __arch_hweight32(unsigned int w)
+{
+	unsigned int register iop asm("r3") = w;
+	unsigned int register tmp asm("r4");
+	__asm__ __volatile__ (
+	stringify_in_c(BEGIN_FTR_SECTION)
+	"bl .__sw_hweight32;"
+	"nop;"
+	"nop;"
+	"nop;"
+	"nop;"
+	"nop;"
+	"nop;"
+	stringify_in_c(FTR_SECTION_ELSE)
+		stringify_in_c(BEGIN_FTR_SECTION_NESTED(51))
+		PPC_POPCNTB_M(%0,%2) ";"
+		"srdi %1,%0,16;"
+		"add %0,%1,%0;"
+		"srdi %1,%0,8;"
+		"add %0,%1,%0;"
+		"clrldi %0,%0,64-8;"
+		stringify_in_c(FTR_SECTION_ELSE_NESTED(51))
+		PPC_POPCNTW_M(%1,%2) ";"
+		"clrldi %0,%1,64-8;"
+		stringify_in_c(ALT_FTR_SECTION_END_NESTED_IFCLR(%4,51))
+	stringify_in_c(ALT_FTR_SECTION_END_IFCLR((%3)))
+	: "=r" (iop), "=r" (tmp)
+	: "r" (iop), "i" (CPU_FTR_POPCNTB), "i" (CPU_FTR_POPCNTD)
+	: "r0", "r1", "r5", "r6", "r7", "r8", "r9",
+	"r10", "r11", "r12", "r13", "r31", "lr", "cr0", "xer");
+
+	return iop;
+}
+
+static inline __u64 __arch_hweight64(__u64 w)
+{
+	__u64 register iop asm("r3") = w;
+	__u64 register tmp asm("r4");
+	__asm__ __volatile__ (
+	stringify_in_c(BEGIN_FTR_SECTION)
+	"bl .__sw_hweight64;"
+	"nop;"
+	"nop;"
+	"nop;"
+	"nop;"
+	"nop;"
+	"nop;"
+	"nop;"
+	"nop;"
+	stringify_in_c(FTR_SECTION_ELSE)
+		stringify_in_c(BEGIN_FTR_SECTION_NESTED(52))
+		PPC_POPCNTB_M(%0,%2) ";"
+		"srdi %1,%0,32;"
+		"add %0,%1,%0;"
+		"srdi %1,%0,16;"
+		"add %0,%1,%0;"
+		"srdi %1,%0,8;"
+		"add %0,%1,%0;"
+		"clrldi %0,%0,64-8;"
+		stringify_in_c(FTR_SECTION_ELSE_NESTED(52))
+		PPC_POPCNTD_M(%1,%2) ";"
+		"clrldi %0,%1,64-8;"
+		stringify_in_c(ALT_FTR_SECTION_END_NESTED_IFCLR(%4,52))
+	stringify_in_c(ALT_FTR_SECTION_END_IFCLR((%3)))
+	: "=r" (iop), "=r" (tmp)
+	: "r" (iop), "i" (CPU_FTR_POPCNTB), "i" (CPU_FTR_POPCNTD)
+	: "r0", "r1", "r5", "r6", "r7", "r8", "r9",
+	"r10", "r11", "r12", "r13", "r31", "lr", "cr0", "xer");
+
+	return iop;
+}
+
 #include <asm-generic/bitops/const_hweight.h>
 #else
 #include <asm-generic/bitops/hweight.h>
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index eccfc16..fc8767a 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -245,6 +245,12 @@
 					__PPC_RA(a) | __PPC_RS(s))
 #define PPC_POPCNTW(a, s)	stringify_in_c(.long PPC_INST_POPCNTW | \
 					__PPC_RA(a) | __PPC_RS(s))
+#define PPC_POPCNTB_M(a, s)	stringify_in_c(.long PPC_INST_POPCNTB | \
+					___PPC_RA(a) | ___PPC_RS(s))
+#define PPC_POPCNTD_M(a, s)	stringify_in_c(.long PPC_INST_POPCNTD | \
+					___PPC_RA(a) | ___PPC_RS(s))
+#define PPC_POPCNTW_M(a, s)	stringify_in_c(.long PPC_INST_POPCNTW | \
+					___PPC_RA(a) | ___PPC_RS(s))
 #define PPC_RFCI		stringify_in_c(.long PPC_INST_RFCI)
 #define PPC_RFDI		stringify_in_c(.long PPC_INST_RFDI)
 #define PPC_RFMCI		stringify_in_c(.long PPC_INST_RFMCI)
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 4504332..66f553d 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
-			   checksum_wrappers_64.o hweight_64.o \
+			   checksum_wrappers_64.o \
 			   copyuser_power7.o string_64.o copypage_power7.o \
 			   memcpy_power7.o
 obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
-- 
1.7.10.4
