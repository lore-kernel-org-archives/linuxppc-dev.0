Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 73CBCB6FBA
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2012 04:35:11 +1000 (EST)
Message-Id: <20120426183508.947595283@goodmis.org>
Date: Thu, 26 Apr 2012 14:31:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3][RFC] powerpc: Have patch_instruction detect faults
References: <20120426183116.857877522@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Steven Rostedt <srostedt@redhat.com>

For ftrace to use the patch_instruction code, it needs to check for
faults on write. Ftrace updates code all over the kernel, and we need to
know if code is updated or not due to protections that are placed on
some portions of the kernel. If ftrace does not detect a fault, it will
error later on, and it will be much more difficult to find the problem.

By changing patch_instruction() to detect faults, then ftrace will be
able to make use of it too.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/include/asm/code-patching.h |    4 ++--
 arch/powerpc/lib/code-patching.c         |   14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 37c32aba..a6f8c7a 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -26,8 +26,8 @@ unsigned int create_branch(const unsigned int *addr,
 			   unsigned long target, int flags);
 unsigned int create_cond_branch(const unsigned int *addr,
 				unsigned long target, int flags);
-void patch_branch(unsigned int *addr, unsigned long target, int flags);
-void patch_instruction(unsigned int *addr, unsigned int instr);
+int patch_branch(unsigned int *addr, unsigned long target, int flags);
+int patch_instruction(unsigned int *addr, unsigned int instr);
 
 int instr_is_relative_branch(unsigned int instr);
 int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 7c975d4..dd223b3 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -13,17 +13,23 @@
 #include <linux/mm.h>
 #include <asm/page.h>
 #include <asm/code-patching.h>
+#include <asm/uaccess.h>
 
 
-void patch_instruction(unsigned int *addr, unsigned int instr)
+int patch_instruction(unsigned int *addr, unsigned int instr)
 {
-	*addr = instr;
+	int err;
+
+	err = __put_user(instr, addr);
+	if (err)
+		return err;
 	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (addr));
+	return 0;
 }
 
-void patch_branch(unsigned int *addr, unsigned long target, int flags)
+int patch_branch(unsigned int *addr, unsigned long target, int flags)
 {
-	patch_instruction(addr, create_branch(addr, target, flags));
+	return patch_instruction(addr, create_branch(addr, target, flags));
 }
 
 unsigned int create_branch(const unsigned int *addr,
-- 
1.7.9.5
