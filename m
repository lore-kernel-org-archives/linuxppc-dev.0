Return-Path: <dkirjanov@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 423EDB70BC
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 18:04:46 +1000 (EST)
Date: Fri, 30 Jul 2010 08:04:39 +0000
From: Denis Kirjanov <dkirjanov@kernel.org>
To: benh@kernel.crashing.org
Subject: [PATCH] Use is_32bit_task() helper to test 32 bit binary
Message-ID: <20100730080439.GA31219@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: shaggy@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use is_32bit_task() helper to test 32 bit binary.

Signed-off-by: Denis Kirjanov <dkirjanov@kernel.org>
---
 arch/powerpc/kernel/process.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 43855c9..e7dffbf 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -692,7 +692,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		p->thread.regs = childregs;
 		if (clone_flags & CLONE_SETTLS) {
 #ifdef CONFIG_PPC64
-			if (!test_thread_flag(TIF_32BIT))
+			if (!is_32bit_task())
 				childregs->gpr[13] = childregs->gpr[6];
 			else
 #endif
@@ -787,7 +787,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	regs->nip = start;
 	regs->msr = MSR_USER;
 #else
-	if (!test_thread_flag(TIF_32BIT)) {
+	if (!is_32bit_task()) {
 		unsigned long entry, toc;
 
 		/* start is a relocated pointer to the function descriptor for
@@ -959,7 +959,7 @@ int sys_clone(unsigned long clone_flags, unsigned long usp,
 	if (usp == 0)
 		usp = regs->gpr[1];	/* stack pointer for child */
 #ifdef CONFIG_PPC64
-	if (test_thread_flag(TIF_32BIT)) {
+	if (is_32bit_task()) {
 		parent_tidp = TRUNC_PTR(parent_tidp);
 		child_tidp = TRUNC_PTR(child_tidp);
 	}
-- 
1.6.4.4
