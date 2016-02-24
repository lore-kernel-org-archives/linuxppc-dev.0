Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 758701A03F9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:28:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 06/12] powerpc/module: Rework is_early_mcount_callsite()
Date: Thu, 25 Feb 2016 01:28:29 +1100
Message-Id: <1456324115-21144-6-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

is_early_mcount_callsite() needs to detect either the two instruction or
the three instruction versions of the _mcount() sequence.

But if we're running a kernel with the two instruction sequence, we need
to be careful not to read instruction - 2, otherwise we might fall off
the front of a page and cause an oops.

While we're here convert to bool to make the return semantics clear.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/module_64.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

Squash.

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 32c10e0d2aa5..495df4340623 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -449,27 +449,25 @@ static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
 }
 
 #ifdef CC_USING_MPROFILE_KERNEL
-static int is_early_mcount_callsite(u32 *instruction)
+static bool is_early_mcount_callsite(u32 *instruction)
 {
-	/* -mprofile-kernel sequence starting with
-	 * mflr r0 and maybe std r0, LRSAVE(r1).
+	/*
+	 * Check if this is one of the -mprofile-kernel sequences.
 	 */
-	if ((instruction[-3] == PPC_INST_MFLR &&
-	     instruction[-2] == PPC_INST_STD_LR) ||
-	    instruction[-2] == PPC_INST_MFLR) {
-		/* Nothing to be done here, it's an _mcount
-		 * call location and r2 will have to be
-		 * restored in the _mcount function.
-		 */
-		return 1;
-	}
-	return 0;
+	if (instruction[-1] == PPC_INST_STD_LR &&
+	    instruction[-2] == PPC_INST_MFLR)
+		return true;
+
+	if (instruction[-1] == PPC_INST_MFLR)
+		return true;
+
+	return false;
 }
 #else
 /* without -mprofile-kernel, mcount calls are never early */
-static int is_early_mcount_callsite(u32 *instruction)
+static bool is_early_mcount_callsite(u32 *instruction)
 {
-	return 0;
+	return false;
 }
 #endif
 
@@ -478,7 +476,7 @@ static int is_early_mcount_callsite(u32 *instruction)
 static int restore_r2(u32 *instruction, struct module *me)
 {
 	if (*instruction != PPC_INST_NOP) {
-		if (is_early_mcount_callsite(instruction))
+		if (is_early_mcount_callsite(instruction - 1))
 			return 1;
 		pr_err("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
-- 
2.5.0
