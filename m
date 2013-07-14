Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 165A52C00F3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 19:07:31 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/4] powerpc: remove the redundant flush_fp_to_thread() in
 setup_sigcontext()
Date: Sun, 14 Jul 2013 17:02:04 +0800
Message-ID: <1373792526-16241-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1373792526-16241-1-git-send-email-haokexin@gmail.com>
References: <1373792526-16241-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit c6e6771b(powerpc: Introduce VSX thread_struct and CONFIG_VSX)
we add a invocation of flush_fp_to_thread() before copying the FPR or
VSR to users. But we already invoke the flush_fp_to_thread() in this
function. So remove one of them.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/signal_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 887e99d..cb833bf 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -96,8 +96,6 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	unsigned long msr = regs->msr;
 	long err = 0;
 
-	flush_fp_to_thread(current);
-
 #ifdef CONFIG_ALTIVEC
 	err |= __put_user(v_regs, &sc->v_regs);
 
-- 
1.8.1.4
