Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C69322C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 18:47:44 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 24 Aug 2013 04:47:41 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EFB6E38C8027
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 04:47:35 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7O8lbcK206016
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 04:47:37 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7O8laHb017615
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 02:47:37 -0600
Date: Sat, 24 Aug 2013 01:47:34 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Detecting LD/ST instruction
Message-ID: <20130824084734.GA30210@us.ibm.com>
References: <20130822225525.GA5214@us.ibm.com>
 <5184.1377214264@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5184.1377214264@ale.ozlabs.ibm.com>
Cc: eraninan@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling [mikey@neuling.org] wrote:
| > I am working on implementing the 'perf mem' command for Power
| > systems. This would for instance, let us know where in the memory
| > hierarchy (L1, L2, Local RAM etc) the data for a load/store
| > instruction was found (hit).
| > 
| > On Power7, if the mcmcra[DCACHE_MISS] is clear _and_ the
| > instruction is a load/store, then it implies a L1-hit.
| > 
| > Unlike on Power8, the Power7 event vector has no indication
| > if the instruction was load/store.
| > 
| > In the context of a PMU interrupt, is there any way to determine
| > if an instruction is a load/store ?
| 
| You could read the instruction from memory and work it out.  
| 
| We do something similar to this in power_pmu_bhrb_to() where we read the
| instruction and work out where the branch is going to.
| 
| If you do this, please use and/or extend the functions in
| arch/powerpc/lib/code-patching.c

Here is a draft of what I could come up with.  With this patch, 
the number of L1 hits on Power7 matches that on Power8 for one
application.

But, wondering if there is a more efficient way to do this - there
are over 50 flavors of load and store!

(btw, I will resend my whole patchset after some time-off).
---

>From db90cd382f4c1c0d84a0cfb07c9ffdb05d529456 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 23 Aug 2013 18:35:02 -0700
Subject: [PATCH 1/1] Try to detect load/store instruction on Power7

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/code-patching.h |    1 +
 arch/powerpc/lib/code-patching.c         |   97 ++++++++++++++++++++++++++++++
 arch/powerpc/perf/power7-pmu.c           |   21 +++++++
 3 files changed, 119 insertions(+)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index a6f8c7a..3e47fe0 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -34,6 +34,7 @@ int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
 unsigned long branch_target(const unsigned int *instr);
 unsigned int translate_branch(const unsigned int *dest,
 			      const unsigned int *src);
+int instr_is_load_store(const unsigned int *instr);
 
 static inline unsigned long ppc_function_entry(void *func)
 {
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 17e5b23..10e7839 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -159,6 +159,103 @@ unsigned int translate_branch(const unsigned int *dest, const unsigned int *src)
 	return 0;
 }
 
+/*
+ * TODO: this is same as branch_opcode(). Rename that function
+ * and re-use it ?
+ */
+static unsigned int load_store_opcode(const unsigned int instr)
+{
+	return (instr >> 26) & 0X3F;
+}
+
+static unsigned int load_store_xval(const unsigned int instr)
+{
+	return (instr >> 1) & 0x3FF;	/* bits 21..30 */
+}
+
+/*
+ * Values of bits 21:30 of Fixed-point load and store instructions
+ * Reference: PowerISA_V2.06B_Public.pdf, Sections 3.3.2 through 3.3.6
+ * 4.6.2 through 4.6.4.
+ */
+#define	x_lbzx		87
+#define	x_lbzux		119
+#define	x_lhzx		279
+#define	x_lhzux		311
+#define	x_lhax		343
+#define	x_lhaux		375
+#define	x_lwzx		23
+#define	x_lwzux		55
+#define	x_lwax		341
+#define	x_lwaux		373
+#define	x_ldx		21
+#define	x_ldux		53
+#define	x_stbx		215
+#define	x_stbux		247
+#define	x_sthx		407
+#define	x_sthux		439
+#define	x_stwx		151
+#define	x_stwux		183
+#define	x_stdx		149
+#define	x_stdux		181
+#define	x_lhbrx		790
+#define	x_lwbrx		534
+#define	x_sthbrx	918
+#define	x_stwbrx	662
+#define	x_ldbrx		532
+#define	x_stdbrx	660
+#define	x_lswi		597
+#define	x_lswx		533
+#define	x_stswi		725
+#define	x_stswx		661
+#define	x_lfsx		535
+#define	x_lfsux		567
+#define	x_lfdx		599
+#define	x_lfdux		631
+#define	x_lfiwax	855
+#define	x_lfiwzx	887
+#define	x_stfsx		663
+#define	x_stfsux	695
+#define	x_stfdx		727
+#define	x_stfdux	759
+#define	x_stfiwax	983
+#define	x_lfdpx		791
+#define	x_stfdpx	919
+
+static unsigned int x_form_load_store[] = {
+	x_lbzx,     x_lbzux,    x_lhzx,     x_lhzux,    x_lhax,
+	x_lhaux,    x_lwzx,     x_lwzux,    x_lwax,     x_lwaux,
+	x_ldx,      x_ldux,     x_stbx,     x_stbux,    x_sthx,
+	x_sthux,    x_stwx,     x_stwux,    x_stdx,     x_stdux,
+	x_lhbrx,    x_lwbrx,    x_sthbrx,   x_stwbrx,   x_ldbrx,
+	x_stdbrx,   x_lswi,     x_lswx,     x_stswi,    x_stswx,
+	x_lfsx,     x_lfsux,    x_lfdx,     x_lfdux,    x_lfiwax,
+	x_lfiwzx,   x_stfsx,    x_stfsux,   x_stfdx,    x_stfdux,
+	x_stfiwax,  x_lfdpx,    x_stfdpx
+};
+
+int instr_is_load_store(const unsigned int *instr)
+{
+	unsigned int op;
+	int i, n;
+
+	op = load_store_opcode(*instr);
+
+	if ((op >= 32 && op <= 58) || (op == 61 || op == 62))
+		return 1;
+
+	if (op == 31) {
+		n = sizeof(x_form_load_store) / sizeof(int);
+
+		for (i = 0; i < n; i++) {
+			if (x_form_load_store[i] == load_store_xval(*instr))
+				return 1;
+		}
+	}
+
+	return 0;
+}
+
 
 #ifdef CONFIG_CODE_PATCHING_SELFTEST
 
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index f8143d6..6e1ca90 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -11,8 +11,10 @@
 #include <linux/kernel.h>
 #include <linux/perf_event.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 #include <asm/reg.h>
 #include <asm/cputable.h>
+#include <asm/code-patching.h>
 
 /*
  * Bits in event code for POWER7
@@ -383,13 +385,32 @@ static void power7_get_mem_data_src(union perf_mem_data_src *dsrc,
 {
 	u64 idx;
 	u64 mmcra = regs->dsisr;
+	u64 addr;
+	int ret;
+	unsigned int instr;
 
 	if (mmcra & POWER7_MMCRA_DCACHE_MISS) {
 		idx = mmcra & POWER7_MMCRA_DCACHE_SRC_MASK;
 		idx >>= POWER7_MMCRA_DCACHE_SRC_SHIFT;
 
 		dsrc->val |= dcache_src_map[idx];
+		return;
 	}
+
+	instr = 0;
+	addr = perf_instruction_pointer(regs);
+
+	if (is_kernel_addr(addr))
+		instr = *(unsigned int *)addr;
+	else {
+		pagefault_disable();
+		ret = __get_user_inatomic(instr, (unsigned int __user *)addr);
+		pagefault_enable();
+		if (ret)
+			instr = 0;
+	}
+	if (instr && instr_is_load_store(&instr))
+		dsrc->val |= PLH(LVL, L1);
 }
 
 
-- 
1.7.9.5
