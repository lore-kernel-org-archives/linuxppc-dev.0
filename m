Return-Path: <SRS0+1a4aa88343b650159535+823+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEEB4687FB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 23:51:47 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Thu, 24 Nov 2005 12:51:40 +0000
Message-Id: <1132836700.11921.58.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] Save NVGPRS in 32-bit signal frame
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Somehow this one slipped through the cracks; when we ended up in
do_signal() on a 32-bit kernel but without having the caller-saved
registers into the regs, we didn't set the TIF_SAVE_NVGPRS flag to
ensure they got saved later.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -219,6 +218,15 @@ static inline int get_old_sigaction(stru
 static inline int save_general_regs(struct pt_regs *regs,
 		struct mcontext __user *frame)
 {
+	if (!FULL_REGS(regs)) {
+		/* Zero out the unsaved GPRs to avoid information
+		   leak, and set TIF_SAVE_NVGPRS to ensure that the
+		   registers do actually get saved later. */
+		memset(&regs->gpr[14], 0, 18 * sizeof(unsigned long));
+		current_thread_info()->nvgprs_frame = &frame->mc_gregs;
+		set_thread_flag(TIF_SAVE_NVGPRS);
+	}
+
 	return __copy_to_user(&frame->mc_gregs, regs, GP_REGS_SIZE);
 }
 

-- 
dwmw2
