Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C169EC46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 14:02:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DD12075D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 14:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DD12075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datacom.com.br
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gpht1Sd9zF37j
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 01:02:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=datacom.com.br
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=datacom.com.br
 (client-ip=177.66.5.10; helo=mail.datacom.com.br;
 envelope-from=felipe.rechia@datacom.com.br; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=datacom.com.br
X-Greylist: delayed 415 seconds by postgrey-1.36 at bilbo;
 Thu, 25 Oct 2018 23:14:41 AEDT
Received: from mail.datacom.com.br (mx.datacom.ind.br [177.66.5.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gmJx4rgTzF2Ds
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 23:14:41 +1100 (AEDT)
Received: from mail.datacom.com.br (localhost [127.0.0.1])
 by mail.datacom.com.br (Postfix) with ESMTPS id 1C58E1BA35BC;
 Thu, 25 Oct 2018 09:07:55 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
 by mail.datacom.com.br (Postfix) with ESMTP id 091291BA35A2;
 Thu, 25 Oct 2018 09:07:55 -0300 (-03)
Received: from mail.datacom.com.br ([127.0.0.1])
 by localhost (mail.datacom.com.br [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id AoI1Yr0fNSEO; Thu, 25 Oct 2018 09:07:54 -0300 (-03)
Received: from mail.datacom.com.br (mail.datacom.com.br [172.25.4.13])
 by mail.datacom.com.br (Postfix) with ESMTP id E3C241BA34DF;
 Thu, 25 Oct 2018 09:07:54 -0300 (-03)
Date: Thu, 25 Oct 2018 10:07:54 -0200 (BRST)
From: "DATACOM - Felipe.Rechia" <felipe.rechia@datacom.com.br>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <344813002.4841437.1540469274858.JavaMail.zimbra@datacom.com.br>
Subject: [PATCH] powerpc/process: Fix flush_all_to_thread for SPE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [177.19.224.224]
X-Mailer: Zimbra 8.8.8_GA_2026 (ZimbraWebClient - GC61 (Linux)/8.8.8_GA_2031)
Thread-Index: DE8zwwRWMMU6om5tVT/rDLYCRhieLg==
Thread-Topic: powerpc/process: Fix flush_all_to_thread for SPE
X-Mailman-Approved-At: Fri, 26 Oct 2018 00:50:26 +1100
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
Cc: Zaneti <paulo.zaneti@datacom.com.br>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Felipe Rechia" <felipe.rechia@datacom.com.br>
Date: Wed, 24 Oct 2018 10:57:22 -0300
Subject: [PATCH] powerpc/process: Fix flush_all_to_thread for SPE

Fix a bug introduced by the creation of flush_all_to_thread() for
processors that have SPE (Signal Processing Engine) and use it to
compute floating-point operations.

From userspace perspective, the problem was seen in attempts of
computing floating-point operations which should generate exceptions.
For example:

  fork();
  float x = 0.0 / 0.0;
  isnan(x);           // forked process returns False (should be True)

The operation above also should always cause the SPEFSCR FINV bit to
be set. However, the SPE floating-point exceptions were turned off
after a fork().

Kernel versions prior to the bug used flush_spe_to_thread(), which
first saves SPEFSCR register values in tsk->thread and then calls
giveup_spe(tsk).

After commit 579e633e764e, the save_all() function was called first
to giveup_spe(), and then the SPEFSCR register values were saved in
tsk->thread. This would save the SPEFSCR register values after
disabling SPE for that thread, causing the bug described above.

Fixes 579e633e764e ("powerpc: create flush_all_to_thread()")
Signed-off-by: felipe.rechia <felipe.rechia@datacom.com.br>
---
 arch/powerpc/kernel/process.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a0c74bb..16eb428 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -566,12 +566,11 @@ void flush_all_to_thread(struct task_struct *tsk)
 	if (tsk->thread.regs) {
 		preempt_disable();
 		BUG_ON(tsk != current);
-		save_all(tsk);
-
 #ifdef CONFIG_SPE
 		if (tsk->thread.regs->msr & MSR_SPE)
 			tsk->thread.spefscr = mfspr(SPRN_SPEFSCR);
 #endif
+		save_all(tsk);
 
 		preempt_enable();
 	}
-- 
2.7.4
