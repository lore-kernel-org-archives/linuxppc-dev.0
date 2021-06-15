Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5127DC48BDF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 06:41:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9426128C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 06:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9426128C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3zHn30h5z3c1N
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 16:41:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3zH85FdHz3093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 16:41:08 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4G3zGz6YgjzB9CM;
 Tue, 15 Jun 2021 08:40:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4LSHGgtLUzVC; Tue, 15 Jun 2021 08:40:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4G3zGy5lp4zB9BM;
 Tue, 15 Jun 2021 08:40:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BB4848B7A3;
 Tue, 15 Jun 2021 08:40:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id iSE_0BqpddPX; Tue, 15 Jun 2021 08:40:58 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 79B488B7A2;
 Tue, 15 Jun 2021 08:40:58 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 51AE26627B; Tue, 15 Jun 2021 06:40:58 +0000 (UTC)
Message-Id: <a2134d0ed504f5ccdd4449487e731a4e244fd13f.1623739212.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/7] powerpc/signal64: Don't read sigaction arguments back
 from user memory
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 15 Jun 2021 06:40:58 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michael Ellerman <mpe@ellerman.id.au>

When delivering a signal to a sigaction style handler (SA_SIGINFO), we
pass pointers to the siginfo and ucontext via r4 and r5.

Currently we populate the values in those registers by reading the
pointers out of the sigframe in user memory, even though the values in
user memory were written by the kernel just prior:

  unsafe_put_user(&frame->info, &frame->pinfo, badframe_block);
  unsafe_put_user(&frame->uc, &frame->puc, badframe_block);
  ...
  if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
  	err |= get_user(regs->gpr[4], (unsigned long __user *)&frame->pinfo);
  	err |= get_user(regs->gpr[5], (unsigned long __user *)&frame->puc);

ie. we write &frame->info into frame->pinfo, and then read frame->pinfo
back into r4, and similarly for &frame->uc.

The code has always been like this, since linux-fullhistory commit
d4f2d95eca2c ("Forward port of 2.4 ppc64 signal changes.").

There's no reason for us to read the values back from user memory,
rather than just setting the value in the gpr[4/5] directly. In fact
reading the value back from user memory opens up the possibility of
another user thread changing the values before we read them back.
Although any process doing that would be racing against the kernel
delivering the signal, and would risk corrupting the stack, so that
would be a userspace bug.

Note that this is 64-bit only code, so there's no subtlety with the size
of pointers differing between kernel and user. Also the frame variable
is not modified to point elsewhere during the function.

In the past reading the values back from user memory was not costly, but
now that we have KUAP on some CPUs it is, so we'd rather avoid it for
that reason too.

So change the code to just set the values directly, using the same
values we have written to the sigframe previously in the function.

Note also that this matches what our 32-bit signal code does.

Using a version of will-it-scale's signal1_threads that sets SA_SIGINFO,
this results in a ~4% increase in signals per second on a Power9, from
229,777 to 239,766.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index f9e1f5428b9e..8b2eb758131c 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -947,8 +947,8 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	regs->gpr[3] = ksig->sig;
 	regs->result = 0;
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		err |= get_user(regs->gpr[4], (unsigned long __user *)&frame->pinfo);
-		err |= get_user(regs->gpr[5], (unsigned long __user *)&frame->puc);
+		regs->gpr[4] = (unsigned long)&frame->info;
+		regs->gpr[5] = (unsigned long)&frame->uc;
 		regs->gpr[6] = (unsigned long) frame;
 	} else {
 		regs->gpr[4] = (unsigned long)&frame->uc.uc_mcontext;
-- 
2.25.0

