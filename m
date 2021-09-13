Return-Path: <SRS0=+bYb=OD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E2FC433EF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Sep 2021 16:22:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226E860295
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Sep 2021 16:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 226E860295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7WwC4pzVz2yyh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 02:22:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.233;
 helo=out03.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7Wvj5x2lz2xg3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Sep 2021 02:21:53 +1000 (AEST)
Received: from in02.mta.xmission.com ([166.70.13.52]:36934)
 by out03.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mPoiL-003rDB-KW; Mon, 13 Sep 2021 10:21:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47520
 helo=email.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mPoiJ-00GFz6-JY; Mon, 13 Sep 2021 10:21:48 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christophe Leroy <christophe.leroy@csgroup.eu>
References: <1718f38859d5366f82d5bef531f255cedf537b5d.1631537060.git.christophe.leroy@csgroup.eu>
 <2b179deba4fd4ec0868cdc48a0230dfa3aa5a22f.1631537060.git.christophe.leroy@csgroup.eu>
 <87h7eopixa.fsf@disp2133>
Date: Mon, 13 Sep 2021 11:21:41 -0500
In-Reply-To: <87h7eopixa.fsf@disp2133> (Eric W. Biederman's message of "Mon,
 13 Sep 2021 10:57:37 -0500")
Message-ID: <87y280o38q.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mPoiJ-00GFz6-JY; ; ; mid=<87y280o38q.fsf@disp2133>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.227.160.95; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX19YOxK9unwbVjxKnnW7IzmHNswDYE8PXPw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH RESEND v3 6/6] powerpc/signal: Use
 unsafe_copy_siginfo_to_user()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
Cc: linux-kernel@vger.kernel.org, hch@infradead.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>
>> Use unsafe_copy_siginfo_to_user() in order to do the copy
>> within the user access block.
>>
>> On an mpc 8321 (book3s/32) the improvment is about 5% on a process
>> sending a signal to itself.

If you can't make function calls from an unsafe macro there is another
way to handle this that doesn't require everything to be inline.

From a safety perspective it is probably even a better approach.

Eric

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 0608581967f0..1b30bb78b863 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -205,6 +205,12 @@ struct sigframe {
 	int			abigap[56];
 };
 
+#ifdef CONFIG_PPC64
+# define user_siginfo_t		compat_siginfo_t
+#else
+# define user_siginfo_t		siginfo_t
+#endif
+
 /*
  *  When we have rt signals to deliver, we set up on the
  *  user stack, going down from the original stack pointer:
@@ -217,11 +223,7 @@ struct sigframe {
  *
  */
 struct rt_sigframe {
-#ifdef CONFIG_PPC64
-	compat_siginfo_t info;
-#else
-	struct siginfo info;
-#endif
+	user_siginfo_t info;
 	struct ucontext	uc;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	struct ucontext	uc_transact;
@@ -712,7 +714,7 @@ static long restore_tm_user_regs(struct pt_regs *regs, struct mcontext __user *s
 
 #ifdef CONFIG_PPC64
 
-#define copy_siginfo_to_user	copy_siginfo_to_user32
+#define copy_siginfo_to_external	copy_siginfo_to_external32
 
 #endif /* CONFIG_PPC64 */
 
@@ -731,6 +733,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	struct pt_regs *regs = tsk->thread.regs;
 	/* Save the thread's msr before get_tm_stackpointer() changes it */
 	unsigned long msr = regs->msr;
+	user_siginfo_t uinfo;
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
@@ -743,6 +746,8 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	else
 		prepare_save_user_regs(1);
 
+	copy_siginfo_to_external(&uinfo, &ksig->info);
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		goto badframe;
 
@@ -778,12 +783,10 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 		asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
 	}
 	unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
+	unsafe_copy_to_user(&frame->info, &uinfo, failed);
 
 	user_access_end();
 
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
-		goto badframe;
-
 	regs->link = tramp;
 
 #ifdef CONFIG_PPC_FPU_REGS

Eric
