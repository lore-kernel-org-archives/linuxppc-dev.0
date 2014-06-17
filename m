Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE33F1A0168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:15:39 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/5] powerpc/ftrace: Fix typo in mask of opcode
Date: Tue, 17 Jun 2014 16:15:33 +1000
Message-Id: <1402985736-32180-2-git-send-email-mpe@ellerman.id.au>
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
changed the logic that checks for the expected code sequence when
patching a module.

We missed the typo in the mask, 0xffff00000 should be 0xffff0000, which
has the effect of making the test always true.

That makes it impossible to ftrace against modules, eg:

  Unexpected call sequence: 48000008 e8410018
  WARNING: at ../kernel/trace/ftrace.c:1638
  ftrace failed to modify [<d000000007cf001c>] rng_dev_open+0x1c/0x70 [rng_core]

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index f202d07..f5d1a34 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -307,7 +307,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	 * The load offset is different depending on the ABI. For simplicity
 	 * just mask it out when doing the compare.
 	 */
-	if ((op[0] != 0x48000008) || ((op[1] & 0xffff00000) != 0xe8410000)) {
+	if ((op[0] != 0x48000008) || ((op[1] & 0xffff0000) != 0xe8410000)) {
 		printk(KERN_ERR "Unexpected call sequence: %x %x\n",
 			op[0], op[1]);
 		return -EINVAL;
-- 
1.9.1
