Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44F0A1A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:28:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 11/12] powerpc/ftrace: Rework __ftrace_make_nop()
Date: Thu, 25 Feb 2016 01:28:34 +1100
Message-Id: <1456324115-21144-11-git-send-email-mpe@ellerman.id.au>
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

__ftrace_make_nop() needs to detect either the two instruction or
the three instruction versions of the _mcount() sequence.

But if we're running a kernel with the two instruction sequence, we need
to be careful not to read from ip - 8, or we'll fault and (possibly)
incorrectly declare the sequence doesn't match.

To keep the code simpler just look at ip - 4, and if it is either of the
expected instructions declare it good. We've already passed a lot of
other checks.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

Squash.

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index f190528e3781..fe7486f9849e 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -174,28 +174,19 @@ __ftrace_make_nop(struct module *mod,
 		return -EFAULT;
 	}
 
-	if (op != PPC_INST_LD_TOC)
-	{
-		unsigned int op0, op1;
+	if (op != PPC_INST_LD_TOC) {
+		unsigned int inst;
 
-		if (probe_kernel_read(&op0, (void *)(ip-8), MCOUNT_INSN_SIZE)) {
-			pr_err("Fetching op0 failed.\n");
+		if (probe_kernel_read(&inst, (void *)(ip - 4), 4)) {
+			pr_err("Fetching instruction at %lx failed.\n", ip - 4);
 			return -EFAULT;
 		}
 
-		if (probe_kernel_read(&op1, (void *)(ip-4), MCOUNT_INSN_SIZE)) {
-			pr_err("Fetching op1 failed.\n");
-			return -EFAULT;
-		}
-
-		/* mflr r0 ; [ std r0,LRSAVE(r1) ]? */
-		if ( (op0 != PPC_INST_MFLR ||
-		      op1 != PPC_INST_STD_LR)
-		     && op1 != PPC_INST_MFLR )
-		{
+		/* We expect either a mlfr r0, or a std r0, LRSAVE(r1) */
+		if (inst != PPC_INST_MFLR && inst != PPC_INST_STD_LR) {
 			pr_err("Unexpected instructions around bl _mcount\n"
 			       "when enabling dynamic ftrace!\t"
-			       "(%08x,%08x,bl,%08x)\n", op0, op1, op);
+			       "(%08x,bl,%08x)\n", inst, op);
 			return -EINVAL;
 		}
 
-- 
2.5.0
