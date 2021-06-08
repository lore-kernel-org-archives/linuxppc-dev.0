Return-Path: <SRS0=nRCD=LC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6CFC47082
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 13:46:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2EC61040
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 13:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2EC61040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fzs3W07p8z3bsT
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 23:46:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=GIcrF631;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=GIcrF631; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fzs336Fnlz2yyM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jun 2021 23:46:23 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Fzs2z3Fwkz9sW8; Tue,  8 Jun 2021 23:46:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1623159979;
 bh=RVNb0VDmSOTPB+jr0KhjqcrOvxuyNKzTYQSeBHV0B/0=;
 h=From:To:Cc:Subject:Date:From;
 b=GIcrF631wGG10z1GIhava2NNG0pkClIUNtrLP71Ab+FpJiFiEmhA5vcJmnYxCZBc2
 BZz6i0RCmKaQC/eikvVacIgCEnKFQPNCT0TmcCVHyb0NSoLeGgg5xZbzb9rX4EqB4w
 LOgbZmwM4N/GcEO0krJVeqHzzFoPc9MPJXH9Y/V41BbtNwDA8f7MTFdO10OqQUwYBJ
 IptWQq/eDjmupCYsIht4Rnvxo8mZ5PCv8ZhLTSnbMKoXXhNmYY3FXXY+MESa8LnYnr
 HoyN96Um4JPPJcYrYTPmzAH+aD/ZS1Gfqvacwpx9QvikGBHjsoCLROeDRAF3BI+xqy
 4pk0rQNjTqrgQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/signal64: Copy siginfo before changing regs->nip
Date: Tue,  8 Jun 2021 23:46:05 +1000
Message-Id: <20210608134605.2783677-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: dja@axtens.net, cmr@codefail.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit 96d7a4e06fab ("powerpc/signal64: Rewrite handle_rt_signal64()
to minimise uaccess switches") the 64-bit signal code was rearranged to
use user_write_access_begin/end().

As part of that change the call to copy_siginfo_to_user() was moved
later in the function, so that it could be done after the
user_write_access_end().

In particular it was moved after we modify regs->nip to point to the
signal trampoline. That means if copy_siginfo_to_user() fails we exit
handle_rt_signal64() with an error but with regs->nip modified, whereas
previously we would not modify regs->nip until the copy succeeded.

Returning an error from signal delivery but with regs->nip updated
leaves the process in a sort of half-delivered state. We do immediately
force a SEGV in signal_setup_done(), called from do_signal(), so the
process should never run in the half-delivered state.

However that SEGV is not delivered until we've gone around to
do_notify_resume() again, so it's possible some tracing could observe
the half-delivered state.

There are other cases where we fail signal delivery with regs partly
updated, eg. the write to newsp and SA_SIGINFO, but the latter at least
is very unlikely to fail as it reads back from the frame we just wrote
to.

Looking at other arches they seem to be more careful about leaving regs
unchanged until the copy operations have succeeded, and in general that
seems like good hygenie.

So although the current behaviour is not cleary buggy, it's also not
clearly correct. So move the call to copy_siginfo_to_user() up prior to
the modification of regs->nip, which is closer to the old behaviour, and
easier to reason about.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/signal_64.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index dca66481d0c2..f9e1f5428b9e 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -902,6 +902,10 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	unsafe_copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set), badframe_block);
 	user_write_access_end();
 
+	/* Save the siginfo outside of the unsafe block. */
+	if (copy_siginfo_to_user(&frame->info, &ksig->info))
+		goto badframe;
+
 	/* Make sure signal handler doesn't get spurious FP exceptions */
 	tsk->thread.fp_state.fpscr = 0;
 
@@ -915,11 +919,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		regs->nip = (unsigned long) &frame->tramp[0];
 	}
 
-
-	/* Save the siginfo outside of the unsafe block. */
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
-		goto badframe;
-
 	/* Allocate a dummy caller frame for the signal handler. */
 	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
 	err |= put_user(regs->gpr[1], (unsigned long __user *)newsp);
-- 
2.25.1

