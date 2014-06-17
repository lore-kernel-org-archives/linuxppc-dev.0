Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 357B11A0168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:15:40 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/5] powerpc/ftrace: Fix inverted check of create_branch()
Date: Tue, 17 Jun 2014 16:15:34 +1000
Message-Id: <1402985736-32180-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1402985736-32180-1-git-send-email-mpe@ellerman.id.au>
References: <1402985736-32180-1-git-send-email-mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, dcb314@hotmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 24a1bdc35, "Fix ABIv2 issues with __ftrace_make_call", Anton
changed the logic that creates and patches the branch, and added a
thinko in the check of create_branch(). create_branch() returns the
instruction that was generated, so if we get zero then it succeeded.

The result is we can't ftrace modules:

  Branch out of range
  WARNING: at ../kernel/trace/ftrace.c:1638
  ftrace failed to modify [<d000000004ba001c>] fuse_req_init_context+0x1c/0x90 [fuse]

We should probably fix patch_instruction() to do that check and make the
API saner, but that's a separate patch. For now just invert the test.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index f5d1a34..8fc0c17 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -320,7 +320,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	}
 
 	/* Ensure branch is within 24 bits */
-	if (create_branch(ip, rec->arch.mod->arch.tramp, BRANCH_SET_LINK)) {
+	if (!create_branch(ip, rec->arch.mod->arch.tramp, BRANCH_SET_LINK)) {
 		printk(KERN_ERR "Branch out of range");
 		return -EINVAL;
 	}
-- 
1.9.1
