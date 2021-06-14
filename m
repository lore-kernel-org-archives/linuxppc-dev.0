Return-Path: <SRS0=LJle=LI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73166C48BE6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 07:23:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA10061370
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 07:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA10061370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3NG55YwCz3brs
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 17:23:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3NFk23RRz2xYk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jun 2021 17:22:46 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4G3NFZ6JhFzBDPc;
 Mon, 14 Jun 2021 09:22:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zx1WoupozuEn; Mon, 14 Jun 2021 09:22:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4G3NFX5MGzzBDGV;
 Mon, 14 Jun 2021 09:22:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AAA618B78A;
 Mon, 14 Jun 2021 09:22:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5oePj3xza3NU; Mon, 14 Jun 2021 09:22:40 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D92C8B763;
 Mon, 14 Jun 2021 09:22:40 +0200 (CEST)
Subject: Re: [PATCH] powerpc/signal64: Copy siginfo before changing regs->nip
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20210608134605.2783677-1-mpe@ellerman.id.au>
 <1623631623.jvh0hlk56m.astroid@bobo.none>
 <1623633868.lnyugcilh9.astroid@bobo.none>
 <759f715b-df1f-847d-d836-2d202c8a7dc4@csgroup.eu>
 <1623649799.9s42wcnyya.astroid@bobo.none>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a7739358-6dd3-2f5d-50c4-f6b908ab2718@csgroup.eu>
Date: Mon, 14 Jun 2021 09:22:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623649799.9s42wcnyya.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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



Le 14/06/2021 à 07:55, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of June 14, 2021 3:31 pm:
>>
>>
>> Le 14/06/2021 à 03:29, Nicholas Piggin a écrit :
>>> Excerpts from Nicholas Piggin's message of June 14, 2021 10:47 am:
>>>> Excerpts from Michael Ellerman's message of June 8, 2021 11:46 pm:
>>>>> In commit 96d7a4e06fab ("powerpc/signal64: Rewrite handle_rt_signal64()
>>>>> to minimise uaccess switches") the 64-bit signal code was rearranged to
>>>>> use user_write_access_begin/end().
>>>>>
>>>>> As part of that change the call to copy_siginfo_to_user() was moved
>>>>> later in the function, so that it could be done after the
>>>>> user_write_access_end().
>>>>>
>>>>> In particular it was moved after we modify regs->nip to point to the
>>>>> signal trampoline. That means if copy_siginfo_to_user() fails we exit
>>>>> handle_rt_signal64() with an error but with regs->nip modified, whereas
>>>>> previously we would not modify regs->nip until the copy succeeded.
>>>>>
>>>>> Returning an error from signal delivery but with regs->nip updated
>>>>> leaves the process in a sort of half-delivered state. We do immediately
>>>>> force a SEGV in signal_setup_done(), called from do_signal(), so the
>>>>> process should never run in the half-delivered state.
>>>>>
>>>>> However that SEGV is not delivered until we've gone around to
>>>>> do_notify_resume() again, so it's possible some tracing could observe
>>>>> the half-delivered state.
>>>>>
>>>>> There are other cases where we fail signal delivery with regs partly
>>>>> updated, eg. the write to newsp and SA_SIGINFO, but the latter at least
>>>>> is very unlikely to fail as it reads back from the frame we just wrote
>>>>> to.
>>>>>
>>>>> Looking at other arches they seem to be more careful about leaving regs
>>>>> unchanged until the copy operations have succeeded, and in general that
>>>>> seems like good hygenie.
>>>>>
>>>>> So although the current behaviour is not cleary buggy, it's also not
>>>>> clearly correct. So move the call to copy_siginfo_to_user() up prior to
>>>>> the modification of regs->nip, which is closer to the old behaviour, and
>>>>> easier to reason about.
>>>>
>>>> Good catch, should it still have a Fixes: tag though? Even if it's not
>>>> clearly buggy we want it to be patched.
>>>
>>> Also...
>>>
>>>>>
>>>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>>> ---
>>>>>    arch/powerpc/kernel/signal_64.c | 9 ++++-----
>>>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
>>>>> index dca66481d0c2..f9e1f5428b9e 100644
>>>>> --- a/arch/powerpc/kernel/signal_64.c
>>>>> +++ b/arch/powerpc/kernel/signal_64.c
>>>>> @@ -902,6 +902,10 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>>>>>    	unsafe_copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set), badframe_block);
>>>>>    	user_write_access_end();
>>>>>    
>>>>> +	/* Save the siginfo outside of the unsafe block. */
>>>>> +	if (copy_siginfo_to_user(&frame->info, &ksig->info))
>>>>> +		goto badframe;
>>>>> +
>>>>>    	/* Make sure signal handler doesn't get spurious FP exceptions */
>>>>>    	tsk->thread.fp_state.fpscr = 0;
>>>>>    
>>>>> @@ -915,11 +919,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>>>>>    		regs->nip = (unsigned long) &frame->tramp[0];
>>>>>    	}
>>>>>    
>>>>> -
>>>>> -	/* Save the siginfo outside of the unsafe block. */
>>>>> -	if (copy_siginfo_to_user(&frame->info, &ksig->info))
>>>>> -		goto badframe;
>>>>> -
>>>>>    	/* Allocate a dummy caller frame for the signal handler. */
>>>>>    	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
>>>>>    	err |= put_user(regs->gpr[1], (unsigned long __user *)newsp);
>>>
>>> Does the same reasoning apply to this one and the ELF V1 function
>>> descriptor thing? It seems like you could move all of that block
>>> up instead. With your other SA_SIGINFO get_user patch, there would
>>> then be no possibility of error after you start modifying regs.
>>>
>>
>> To move the above in the user access block, we need to open a larger window. At the time being the
>> window opened only contains the 'frame'. 'newsp' points before the 'frame'.
>>
> 
> Only by 64/128 bytes though. Is that a problem? Not for 64s. Could it
> cause more overhead than it saves on other platforms?

No it is not a problem at all, just need to not be forgotten, on ppc64 it may go unnoticed, on 32s 
it will blew up if we forget to enlarge the access window and the access involves a different 256M 
segment (Very unlikely for sure but ...)

> 
> For protection, it looks like all the important control data is in the
> signal frame anyway, this frame is just for stack unwinding?

That's my understanding as well.

Christophe
