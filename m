Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtncN3tvwzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 14:48:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, Anton Blanchard <anton@samba.org>,
 duwe@lst.de
Subject: [PATCH 1/2] powerpc/ftrace: Separate the heuristics for checking call
 sites
Date: Tue, 19 Jul 2016 14:48:30 +1000
Message-Id: <1468903711-5869-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In __ftrace_make_nop() (the 64-bit version), we have code to deal with
two ftrace ABIs. There is the original ABI, which looks mostly like a
function call, and then the mprofile-kernel ABI which is just a branch.

The code tries to handle both cases, by looking for the presence of a
load to restore the TOC pointer (PPC_INST_LD_TOC). If we detect the TOC
load, we assume the call site is for an mcount() call using the old ABI.
That means we patch the mcount() call with a b +8, to branch over the
TOC load.

However if the kernel was built with mprofile-kernel, then there will
never be a call site using the original ftrace ABI. If for some reason
we do see a TOC load, then it's there for a good reason, and we should
not jump over it.

So split the code, using the existing CC_USING_MPROFILE_KERNEL. Kernels
built with mprofile-kernel will only look for, and expect, the new ABI,
and similarly for the original ABI.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 7af6c4de044b..438442dac44c 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -144,6 +144,21 @@ __ftrace_make_nop(struct module *mod,
 		return -EINVAL;
 	}
 
+#ifdef CC_USING_MPROFILE_KERNEL
+	/* When using -mkernel_profile there is no load to jump over */
+	pop = PPC_INST_NOP;
+
+	if (probe_kernel_read(&op, (void *)(ip - 4), 4)) {
+		pr_err("Fetching instruction at %lx failed.\n", ip - 4);
+		return -EFAULT;
+	}
+
+	/* We expect either a mlfr r0, or a std r0, LRSAVE(r1) */
+	if (op != PPC_INST_MFLR && op != PPC_INST_STD_LR) {
+		pr_err("Unexpected instruction %08x around bl _mcount\n", op);
+		return -EINVAL;
+	}
+#else
 	/*
 	 * Our original call site looks like:
 	 *
@@ -170,24 +185,10 @@ __ftrace_make_nop(struct module *mod,
 	}
 
 	if (op != PPC_INST_LD_TOC) {
-		unsigned int inst;
-
-		if (probe_kernel_read(&inst, (void *)(ip - 4), 4)) {
-			pr_err("Fetching instruction at %lx failed.\n", ip - 4);
-			return -EFAULT;
-		}
-
-		/* We expect either a mlfr r0, or a std r0, LRSAVE(r1) */
-		if (inst != PPC_INST_MFLR && inst != PPC_INST_STD_LR) {
-			pr_err("Unexpected instructions around bl _mcount\n"
-			       "when enabling dynamic ftrace!\t"
-			       "(%08x,bl,%08x)\n", inst, op);
-			return -EINVAL;
-		}
-
-		/* When using -mkernel_profile there is no load to jump over */
-		pop = PPC_INST_NOP;
+		pr_err("Expected %08x found %08x\n", PPC_INST_LD_TOC, op);
+		return -EINVAL;
 	}
+#endif /* CC_USING_MPROFILE_KERNEL */
 
 	if (patch_instruction((unsigned int *)ip, pop)) {
 		pr_err("Patching NOP failed.\n");
-- 
2.7.4
