Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E4542C0368
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 17:58:06 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 16 Oct 2013 12:28:00 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 52052E0055
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:29:22 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G6vtbt38797342
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:27:55 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G6vu3X029067
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:27:57 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V3 07/10] powerpc,
 lib: Add new branch instruction analysis support functions
Date: Wed, 16 Oct 2013 12:26:54 +0530
Message-Id: <1381906617-11392-8-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1381906617-11392-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1381906617-11392-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, michaele@au1.ibm.com,
 eranian@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Generic powerpc branch instruction analysis support added in the code
patching library which will help the subsequent patch on SW based
filtering of branch records in perf. This patch also converts and
exports some of the existing local static functions through the header
file to be used else where.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/code-patching.h | 30 ++++++++++++++++++
 arch/powerpc/lib/code-patching.c         | 54 ++++++++++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index a6f8c7a..8bab417 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -22,6 +22,36 @@
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
+/* Forms of branch instruction */
+int instr_is_branch_iform(unsigned int instr);
+int instr_is_branch_bform(unsigned int instr);
+int instr_is_branch_xlform(unsigned int instr);
+
+/* Classification of XL-form instruction */
+int is_xlform_lr(unsigned int instr);
+int is_xlform_ctr(unsigned int instr);
+int is_xlform_tar(unsigned int instr);
+
+/* Branch instruction is a call */
+int is_branch_link_set(unsigned int instr);
+
+/* BO field analysis (B-form or XL-form) */
+int is_bo_always(unsigned int instr);
+int is_bo_ctr(unsigned int instr);
+int is_bo_crbi_off(unsigned int instr);
+int is_bo_crbi_on(unsigned int instr);
+int is_bo_crbi_hint(unsigned int instr);
+
 unsigned int create_branch(const unsigned int *addr,
 			   unsigned long target, int flags);
 unsigned int create_cond_branch(const unsigned int *addr,
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 17e5b23..cb62bd8 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -77,16 +77,66 @@ static unsigned int branch_opcode(unsigned int instr)
 	return (instr >> 26) & 0x3F;
 }
 
-static int instr_is_branch_iform(unsigned int instr)
+int instr_is_branch_iform(unsigned int instr)
 {
 	return branch_opcode(instr) == 18;
 }
 
-static int instr_is_branch_bform(unsigned int instr)
+int instr_is_branch_bform(unsigned int instr)
 {
 	return branch_opcode(instr) == 16;
 }
 
+int instr_is_branch_xlform(unsigned int instr)
+{
+	return branch_opcode(instr) == 19;
+}
+
+int is_xlform_lr(unsigned int instr)
+{
+	return (instr & XL_FORM_LR) == XL_FORM_LR;
+}
+
+int is_xlform_ctr(unsigned int instr)
+{
+	return (instr & XL_FORM_CTR) == XL_FORM_CTR;
+}
+
+int is_xlform_tar(unsigned int instr)
+{
+	return (instr & XL_FORM_TAR) == XL_FORM_TAR;
+}
+
+int is_branch_link_set(unsigned int instr)
+{
+	return (instr & BRANCH_SET_LINK) == BRANCH_SET_LINK;
+}
+
+int is_bo_always(unsigned int instr)
+{
+	return (instr & BO_ALWAYS) == BO_ALWAYS;
+}
+
+int is_bo_ctr(unsigned int instr)
+{
+	return (instr & BO_CTR) == BO_CTR;
+}
+
+int is_bo_crbi_off(unsigned int instr)
+{
+	return (instr & BO_CRBI_OFF) == BO_CRBI_OFF;
+}
+
+int is_bo_crbi_on(unsigned int instr)
+{
+	return (instr & BO_CRBI_ON) == BO_CRBI_ON;
+}
+
+int is_bo_crbi_hint(unsigned int instr)
+{
+	return (instr & BO_CRBI_HINT) == BO_CRBI_HINT;
+}
+
 int instr_is_relative_branch(unsigned int instr)
 {
 	if (instr & BRANCH_ABSOLUTE)
-- 
1.7.11.7
