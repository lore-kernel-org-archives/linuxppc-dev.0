Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A808B2C01AE
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Feb 2014 19:08:00 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 18:08:00 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8A7CE2CE8054
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Feb 2014 19:07:57 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1587iXo2032072
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Feb 2014 19:07:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1587ujU010912
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Feb 2014 19:07:57 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V5 08/11] powerpc, lib: Add new branch analysis support functions
Date: Wed,  5 Feb 2014 13:36:19 +0530
Message-Id: <1391587582-32028-9-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1391587582-32028-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1391587582-32028-1-git-send-email-khandual@linux.vnet.ibm.com>
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
