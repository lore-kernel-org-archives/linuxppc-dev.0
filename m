Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5ED2E1A09D3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 07:04:43 +1100 (AEDT)
Received: by mail-wi0-f169.google.com with SMTP id r20so5514527wiv.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 12:04:39 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] arch: powerpc: kernel: traps.c:  Remove unused function
Date: Sun,  7 Dec 2014 21:07:18 +0100
Message-Id: <1417982838-15588-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: Michael Neuling <mikey@neuling.org>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the function vsx_assist_exception() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/kernel/traps.c |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0dc43f9..857e5f7 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1707,21 +1707,6 @@ void altivec_assist_exception(struct pt_regs *regs)
 }
 #endif /* CONFIG_ALTIVEC */
 
-#ifdef CONFIG_VSX
-void vsx_assist_exception(struct pt_regs *regs)
-{
-	if (!user_mode(regs)) {
-		printk(KERN_EMERG "VSX assist exception in kernel mode"
-		       " at %lx\n", regs->nip);
-		die("Kernel VSX assist exception", regs, SIGILL);
-	}
-
-	flush_vsx_to_thread(current);
-	printk(KERN_INFO "VSX assist not supported at %lx\n", regs->nip);
-	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-}
-#endif /* CONFIG_VSX */
-
 #ifdef CONFIG_FSL_BOOKE
 void CacheLockingException(struct pt_regs *regs, unsigned long address,
 			   unsigned long error_code)
-- 
1.7.10.4
