Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BD17E140196
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 19:11:01 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 5 May 2014 14:40:58 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C414FE005F
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 14:41:21 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s459B5iH6095168
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 14:41:05 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s459As3d025022
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 14:40:56 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V6 08/11] powerpc, lib: Add new branch analysis support functions
Date: Mon,  5 May 2014 14:39:10 +0530
Message-Id: <1399280953-31442-9-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1399280953-31442-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1399280953-31442-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, eranian@google.com,
 michael@ellerman.id.au, acme@ghostprotocols.net, sukadev@linux.vnet.ibm.com,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Generic powerpc branch analysis support added in the code patching
library which will help the subsequent patch on SW based filtering
of branch records in perf.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/code-patching.h | 16 +++++++
 arch/powerpc/lib/code-patching.c         | 80 ++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 97e02f9..39919d4 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -22,6 +22,16 @@
 #define BRANCH_SET_LINK	0x1
 #define BRANCH_ABSOLUTE	0x2
 
+#define XL_FORM_LR  0x4C000020
+#define XL_FORM_CTR 0x4C000420
+#define XL_FORM_TAR 0x4C000460
+
+#define BO_ALWAYS    0x02800000
+#define BO_CTR       0x02000000
+#define BO_CRBI_OFF  0x00800000
+#define BO_CRBI_ON   0x01800000
+#define BO_CRBI_HINT 0x00400000
+
 unsigned int create_branch(const unsigned int *addr,
 			   unsigned long target, int flags);
 unsigned int create_cond_branch(const unsigned int *addr,
@@ -56,4 +66,10 @@ static inline unsigned long ppc_function_entry(void *func)
 #endif
 }
 
+/* Perf branch filters */
+bool instr_is_return_branch(unsigned int instr);
+bool instr_is_conditional_branch(unsigned int instr);
+bool instr_is_func_call(unsigned int instr);
+bool instr_is_indirect_func_call(unsigned int instr);
+
 #endif /* _ASM_POWERPC_CODE_PATCHING_H */
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index d5edbeb..a06f8b3 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -77,6 +77,7 @@ static unsigned int branch_opcode(unsigned int instr)
 	return (instr >> 26) & 0x3F;
 }
 
+/* Forms of branch instruction */
 static int instr_is_branch_iform(unsigned int instr)
 {
 	return branch_opcode(instr) == 18;
@@ -87,6 +88,85 @@ static int instr_is_branch_bform(unsigned int instr)
 	return branch_opcode(instr) == 16;
 }
 
+static int instr_is_branch_xlform(unsigned int instr)
+{
+	return branch_opcode(instr) == 19;
+}
+
+/* Classification of XL-form instruction */
+static int is_xlform_lr(unsigned int instr)
+{
+	return (instr & XL_FORM_LR) == XL_FORM_LR;
+}
+
+/* BO field analysis (B-form or XL-form) */
+static int is_bo_always(unsigned int instr)
+{
+	return (instr & BO_ALWAYS) == BO_ALWAYS;
+}
+
+/* Link bit is set */
+static int is_branch_link_set(unsigned int instr)
+{
+	return (instr & BRANCH_SET_LINK) == BRANCH_SET_LINK;
+}
+
+/* 
+ * Generic software implemented branch filters used
+ * by perf branch stack sampling when PMU does not
+ * process them for some reason.
+ */
+
+/* PERF_SAMPLE_BRANCH_ANY_RETURN */
+bool instr_is_return_branch(unsigned int instr)
+{
+	/*
+	 * Conditional and unconditional branch to LR register
+	 * without seting the link register.
+	 */
+	if (is_xlform_lr(instr) && !is_branch_link_set(instr))
+		return true;
+
+	return false;
+}
+
+/* PERF_SAMPLE_BRANCH_COND */
+bool instr_is_conditional_branch(unsigned int instr)
+{
+	/* I-form instruction - excluded */
+	if (instr_is_branch_iform(instr))
+		return false;
+
+	/* B-form or XL-form instruction */
+	if (instr_is_branch_bform(instr) || instr_is_branch_xlform(instr))  {
+
+		/* Not branch always */
+		if (!is_bo_always(instr))
+			return true;
+	}
+	return false;
+}
+
+/* PERF_SAMPLE_BRANCH_ANY_CALL */
+bool instr_is_func_call(unsigned int instr)
+{
+	/* LR should be set */
+	if (is_branch_link_set(instr))
+		return true;
+
+	return false;
+}
+
+/* PERF_SAMPLE_BRANCH_IND_CALL */
+bool instr_is_indirect_func_call(unsigned int instr)
+{
+	/* XL-form instruction with LR set */
+	if (instr_is_branch_xlform(instr) && is_branch_link_set(instr))
+		return true;
+
+	return false;
+}
+
 int instr_is_relative_branch(unsigned int instr)
 {
 	if (instr & BRANCH_ABSOLUTE)
-- 
1.7.11.7
