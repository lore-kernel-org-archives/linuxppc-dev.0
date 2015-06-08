Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6136D1A0C12
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jun 2015 21:38:45 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ACFDB140283
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2015 21:38:44 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 8 Jun 2015 17:08:42 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0B6AD125804F
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2015 17:11:09 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t58BcX3K49020956
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2015 17:08:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t58BcWOP022038
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2015 17:08:32 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, mikey@neuling.org
Subject: [PATCH V8 06/10] powerpc,
 lib: Add new branch analysis support functions
Date: Mon,  8 Jun 2015 17:08:27 +0530
Message-Id: <1433763511-5270-6-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/code-patching.h | 15 ++++++++
 arch/powerpc/lib/code-patching.c         | 66 ++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 840a550..0a6f0d8 100644
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
@@ -99,4 +109,9 @@ static inline unsigned long ppc_global_function_entry(void *func)
 #endif
 }
 
+bool instr_is_return_branch(unsigned int instr);
+bool instr_is_conditional_branch(unsigned int instr);
+bool instr_is_func_call(unsigned int instr);
+bool instr_is_indirect_func_call(unsigned int instr);
+
 #endif /* _ASM_POWERPC_CODE_PATCHING_H */
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index d5edbeb..15b7b88 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -87,6 +87,72 @@ static int instr_is_branch_bform(unsigned int instr)
 	return branch_opcode(instr) == 16;
 }
 
+static int instr_is_branch_xlform(unsigned int instr)
+{
+	return branch_opcode(instr) == 19;
+}
+
+static int is_xlform_lr(unsigned int instr)
+{
+	return (instr & XL_FORM_LR) == XL_FORM_LR;
+}
+
+static int is_bo_always(unsigned int instr)
+{
+	return (instr & BO_ALWAYS) == BO_ALWAYS;
+}
+
+static int is_branch_link_set(unsigned int instr)
+{
+	return (instr & BRANCH_SET_LINK) == BRANCH_SET_LINK;
+}
+
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
+bool instr_is_func_call(unsigned int instr)
+{
+	/* LR should be set */
+	if (is_branch_link_set(instr))
+		return true;
+
+	return false;
+}
+
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
2.1.0
