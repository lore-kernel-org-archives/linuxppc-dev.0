Return-Path: <linuxppc-dev+bounces-21396-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EECCD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 12:45:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMQ3S2qllz3brr;
	Fri, 22 May 2026 22:45:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779453908;
	cv=none; b=Kbjxa9Jm6jd0jMgAIDFBZQKdDPJYqtW6QDkrCTWbQy3TlrD9FamENdhJ5X4H+Bp4HiJy+2Q78T0KovpoR5augp1UhqFbo9Pjz7Z23Eq36EvkD710iFf+p/tJHSEgGDsQd1bzdye8uK+AVWHyI93YuIlifUhPU6+wMYQrh5un09OSSq+eg4lk8XABr49evFcgq3u1gMMcynohi0mZmyklo8fiFbrdVw/I4gCnJggkFcrOhhW+s3YUaWmLVgeOIKnwPzaZWi74NffE7wzfCWzwXug7RkFYcBsth1g/KNYYgmF4+clMapDBvBaQlxFHZyHQZC7XYUG6IhgHyT6DirjnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779453908; c=relaxed/relaxed;
	bh=kc80LGaAlPljAg7ILWOq2bbeI+elbTjRGpAnUDTXRts=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W2AHIidI7Z7y8fDu+NsgJYzV9qI3kmEkFCi1hfz3s/kCSQlpw3eKaLv/CUvqCJ9pyG+Kxj78TQB/7rJ5yrkVGhIw727C4dEEFOuOKBojmR1reSR/EYfpbeFhWt+UJjiRuub69+n42oIRa0zwbOBHCIiOsxWW0pKkuCwqge5gOI+osJLTDfzDtpdxIiShJCzcvek3oZfExdscT9dq+jSZaT4pKsmRSFQbfjkk0k0DtVMzafOY3uD6aa2vyvWWxMUn24xmZSLwgBXnaCrg+LEgcEnaRSVGfZzpy/zfYR4elj84X4MrGBHVCGBGatwjoSD7V5PoiVGUOUMFrhSDB0BJ0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRldLOCn; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRldLOCn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMQ3K2k0Vz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 22:45:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 47754600BB;
	Fri, 22 May 2026 12:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1991F000E9;
	Fri, 22 May 2026 12:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453899;
	bh=kc80LGaAlPljAg7ILWOq2bbeI+elbTjRGpAnUDTXRts=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=lRldLOCn4Yiy3236MudQVu/AwN8Wqlzq1ZYWUa4taX0yZtdXIj5OnjwbBldGuMG4f
	 CGgXzeuT437aQEF6weLjAO3Wf0rg8tPOG4MjN1IY/F64Rx27helR2UjTklyLi05v6M
	 rbVFHKAWQGm3Ufbs7LjNmGKN2g2erF//eWiuxA0fquukjWkHAIlnXfdR+unv0iJSo/
	 pv0JQNnzYUXYma+/A6Q7zt9JENM/7Jxd8rkf00M+CdVnI4xW86ky+rNXzHRi9bj86Q
	 3LQPuQiMxwrLVeoS08NQ2zylbQPRdZ3VumnC9wkDFzXiWtHZRQhQJ3mrfwWcIvYxQc
	 BJmOHpLQR9kCw==
Message-ID: <28a7b0b9-3c17-4f76-af80-f17f4869f854@kernel.org>
Date: Fri, 22 May 2026 14:44:55 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] powerpc/signal64: Untangle setup_tm_sigcontexts()
 and user_access_begin()
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1779441786.git.chleroy@kernel.org>
 <7c83fe5a596514a02fde37da987a48d638d0d097.1779441786.git.chleroy@kernel.org>
 <20260522121237.3089276f@pumpkin>
 <69bd69b1-97f7-41e2-934b-bed28dc2fef7@kernel.org>
Content-Language: fr-FR
In-Reply-To: <69bd69b1-97f7-41e2-934b-bed28dc2fef7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/05/2026 à 14:06, Christophe Leroy (CS GROUP) a écrit :
> 
> 
> Le 22/05/2026 à 13:12, David Laight a écrit :
>> On Fri, 22 May 2026 11:56:02 +0200
>> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
>>
>>> Call setup_tm_sigcontexts() before opening user access to avoid
>>> having to close and open again.
>>>
>>> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>>> ---
>>>   arch/powerpc/kernel/signal_64.c | 22 +++++++++-------------
>>>   1 file changed, 9 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/ 
>>> signal_64.c
>>> index 86bb5bb4c143..3849af21e1d8 100644
>>> --- a/arch/powerpc/kernel/signal_64.c
>>> +++ b/arch/powerpc/kernel/signal_64.c
>>> @@ -873,6 +873,15 @@ int handle_rt_signal64(struct ksignal *ksig, 
>>> sigset_t *set,
>>>       if (!MSR_TM_ACTIVE(msr))
>>>           prepare_setup_sigcontext(tsk);
>>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>>> +    if (MSR_TM_ACTIVE(msr))
>>
>> Can't that be done without the ugly #ifdef?
>> I assume MSR_TM_ACTIVE() will be zero - so it will all get optimised 
>> away.
> 
> Yes but struct rt_sigframe field uc_transact only exists when 
> CONFIG_PPC_TRANSACTIONAL_MEM is defined.
> 
> And that would also require a stub setup_tm_sigcontexts()

After thinking once more, I think we can do the following, is it better 
for you ?

diff --git a/arch/powerpc/kernel/signal_64.c 
b/arch/powerpc/kernel/signal_64.c
index 86bb5bb4c143..c70732e8002d 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -203,8 +203,7 @@ static long notrace __unsafe_setup_sigcontext(struct 
sigcontext __user *sc,
   * examine the transactional registers in the 2nd sigcontext to 
determine the
   * real origin of the signal.
   */
-static long setup_tm_sigcontexts(struct sigcontext __user *sc,
-				 struct sigcontext __user *tm_sc,
+static long setup_tm_sigcontexts(struct rt_sigframe __user *frame,
  				 struct task_struct *tsk,
  				 int signr, sigset_t *set, unsigned long handler,
  				 unsigned long msr)
@@ -217,6 +216,8 @@ static long setup_tm_sigcontexts(struct sigcontext 
__user *sc,
  	 * Userland shall check AT_HWCAP to know wether it can rely on the
  	 * v_regs pointer or not.
  	 */
+	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
+	struct sigcontext __user *tm_sc = &frame->uc_transact.uc_mcontext;
  #ifdef CONFIG_ALTIVEC
  	elf_vrreg_t __user *v_regs = sigcontext_vmx_regs(sc);
  	elf_vrreg_t __user *tm_v_regs = sigcontext_vmx_regs(tm_sc);
@@ -325,6 +326,14 @@ static long setup_tm_sigcontexts(struct sigcontext 
__user *sc,

  	return err;
  }
+#else
+static long setup_tm_sigcontexts(struct rt_sigframe __user *frame,
+				 struct task_struct *tsk,
+				 int signr, sigset_t *set, unsigned long handler,
+				 unsigned long msr)
+{
+	return -EINVAL;
+}
  #endif

  /*
@@ -872,6 +881,9 @@ int handle_rt_signal64(struct ksignal *ksig, 
sigset_t *set,
  	 */
  	if (!MSR_TM_ACTIVE(msr))
  		prepare_setup_sigcontext(tsk);
+	else
+		err |= setup_tm_sigcontexts(frame, tsk, ksig->sig, NULL,
+					    (unsigned long)ksig->ka.sa.sa_handler, msr);

  	if (!user_write_access_begin(frame, sizeof(*frame)))
  		goto badframe;
@@ -889,19 +901,6 @@ int handle_rt_signal64(struct ksignal *ksig, 
sigset_t *set,
  		 * ucontext_t (for transactional state) with its uc_link ptr.
  		 */
  		unsafe_put_user(&frame->uc_transact, &frame->uc.uc_link, 
badframe_block);
-
-		user_write_access_end();
-
-		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
-					    &frame->uc_transact.uc_mcontext,
-					    tsk, ksig->sig, NULL,
-					    (unsigned long)ksig->ka.sa.sa_handler,
-					    msr);
-
-		if (!user_write_access_begin(&frame->uc.uc_sigmask,
-					     sizeof(frame->uc.uc_sigmask)))
-			goto badframe;
-
  #endif
  	} else {
  		unsafe_put_user(0, &frame->uc.uc_link, badframe_block);


Christophe

