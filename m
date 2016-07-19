Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtncQ69gxzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 14:48:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, Anton Blanchard <anton@samba.org>,
 duwe@lst.de
Subject: [PATCH 2/2] powerpc/modules: Never restore r2 for a mprofile-kernel
 style mcount() call
Date: Tue, 19 Jul 2016 14:48:31 +1000
Message-Id: <1468903711-5869-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1468903711-5869-1-git-send-email-mpe@ellerman.id.au>
References: <1468903711-5869-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the module loader we process relocations, and for long jumps we
generate trampolines (aka stubs). At the call site for one of these
trampolines we usually need to generate a load instruction to restore
the TOC pointer into r2.

There is one exception however, which is calls to mcount() using the
mprofile-kernel ABI, they handle the TOC inside the stub, and so for
them we do not generate a TOC load.

The bug is in how the code in restore_r2() decides if it needs to
generate the TOC load. It does so by looking for a nop following the
branch, and if it sees a nop, it replaces it with the load. In general
the compiler has no reason to generate a nop following the mcount()
call and so that check works OK.

However if we combine a jump label at the start of a function, with an
early return, such that GCC applies the shrink-wrapping optimisation, we
can then end up with an mcount call followed immediately by a nop.
However the nop is not there for a TOC load, it is for the jump label.

That confuses restore_r2() into replacing the jump label nop with a TOC
load, which in turn confuses ftrace into replacing the mcount call with
a b +8 (fixed in the previous commit). The end result is we jump over
the jump label, which if it was supposed to return means we incorrectly
run the body of the function.

We have seen this in practice with some yet-to-be-merged patches that
use jump labels more extensively.

The fix is relatively simple, in restore_r2() we check for an
mprofile-kernel style mcount() call first, before looking for the
presence of a nop.

Fixes: 153086644fd1 ("powerpc/ftrace: Add support for -mprofile-kernel ftrace ABI")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/module_64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index f703f343358e..183368e008cf 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -494,9 +494,10 @@ static bool is_early_mcount_callsite(u32 *instruction)
    restore r2. */
 static int restore_r2(u32 *instruction, struct module *me)
 {
+	if (is_early_mcount_callsite(instruction - 1))
+		return 1;
+
 	if (*instruction != PPC_INST_NOP) {
-		if (is_early_mcount_callsite(instruction - 1))
-			return 1;
 		pr_err("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
 		return 0;
-- 
2.7.4
