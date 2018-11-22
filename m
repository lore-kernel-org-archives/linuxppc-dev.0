Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7011C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 12:49:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F28A206B2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 12:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F28A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430zm23D3wzDqNt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 23:49:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.196; helo=mail-qt1-f196.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430zhF1RrWzDqP5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 23:46:04 +1100 (AEDT)
Received: by mail-qt1-f196.google.com with SMTP id l11so7320789qtp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 04:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4wT5myvTEsdmnJkd0PGW5dfdRd0PA7d+cVl5ri1lL/4=;
 b=aUWj9zCm2tpFESxJGlNe7KYZCK9NnbxJmYqsyea4lNdYWcMLb6wf4EHEbDST9uTLsP
 LBCND9yJWx5ny8f5kGD00vLQr27Mz+xWcSVzNYP0SJmRYmLN4b6bdqlWTiNARIuG5Kiq
 AU8hLcGST+ZYcZxZfyrb1LK1zSStqWlZ+G77i+bTlQXudn25pcOuATJaTEyxVHx1bb5u
 UkJXqTCnAIiPmef2B1f1X2T7u+FKev0oB6URGpqtvMyq/u5Kk8wiakZvCevgg7WSRXcn
 ae07RA4fdxo00kRvwdPZ2M4dnqJZ8Hqm2Q1jZCaoM9ocCgJovJZVB48+oRKB39UHYfwo
 nuZQ==
X-Gm-Message-State: AA+aEWY4E45zx4v/sQ/QOzg3c8wRYpBtHpT5ieBp9wQr5UqBFlHHbrgr
 1kAUBpDcEbJDOgB8LjXhY6M/2lfWhmM=
X-Google-Smtp-Source: AFSGD/X6VlFGXZ4BwEk0OlQ+XPY2IY+NcU0Kczn/WAmARSKyQOI05PVaoy0aMA1uhI8SZjuRc6TexA==
X-Received: by 2002:ac8:3b42:: with SMTP id r2mr10031319qtf.364.1542890762837; 
 Thu, 22 Nov 2018 04:46:02 -0800 (PST)
Received: from [9.18.239.97] ([32.104.18.203])
 by smtp.gmail.com with ESMTPSA id v186sm9733947qkd.13.2018.11.22.04.46.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Nov 2018 04:46:02 -0800 (PST)
Subject: Re: [PATCH] powerpc/tm: Set MSR[TS] just prior to recheckpoint
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1542631494-10344-1-git-send-email-leitao@debian.org>
 <9cdf12d1eaa5350e130d3cfb15ecb060323b6788.camel@neuling.org>
 <5ead16d3-2ada-d5b2-5481-0326a3c920af@debian.org>
 <c4edf2ad99edb1c932f7367819e11d19e3a3bb75.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <8d793baf-3288-c392-0cb5-7b6fa06ea4d2@debian.org>
Date: Thu, 22 Nov 2018 10:46:05 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <c4edf2ad99edb1c932f7367819e11d19e3a3bb75.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Gustavo Romero <gromero@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mikey,

On 11/21/18 8:42 PM, Michael Neuling wrote:
>> Do you mean in this part of code?
>>
>>   SYSCALL_DEFINE0(rt_sigreturn)
>>   {
>> 	....
>>         if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
>>                 goto badframe;
>>
>> 	...
>>         if (MSR_TM_SUSPENDED(mfmsr()))
>>                 tm_reclaim_current(0);
> 
> I'm actually thinking after the reclaim, not before.
> 
> If I follow your original email properly, you have a problem because you end up
> in this senario:
> 1) Current MSR is not TM suspended
> 2) regs->msr[TS] set
> 3) get_user() (which may fault)

In fact you need another case, where TEXASR register (the live register) does
not contain FS bit set. So, the current flow is:

 1) Current MSR is not TM suspended
 2) regs->msr[TS] set
 2a) TEXASR[FS] = 0
3) get_user() (which may fault)

In this case, the page fault will call SCHEDULE, which will call
__switch_to_tm().

__switch_to_tm() will call tm_reclaim_task(), which does:

	static inline void tm_reclaim_task(struct task_struct *tsk)
	{
		...
	        tm_reclaim_thread(thr, TM_CAUSE_RESCHED);
		...
	        tm_save_sprs(thr);
	}

So, the code above is executed at page fault with the scenario you described
(current MSR is not suspended, regs->msr[TS] set and current TEXASR = 0).

That said, tm_reclaim_task() will invoke tm_reclaim_thread() which will
return due to:

	        if (!MSR_TM_SUSPENDED(mfmsr()))
	                return;

Calling tm_save_sprs(thread), which does:

	_GLOBAL(tm_save_sprs)
     		mfspr   r0, SPRN_TEXASR		 <- TEXASR is 0 here
      		std     r0, THREAD_TM_TEXASR(r3) <- thr->texasr will be 0


In this case, we have a process that was de-schedule properly but has
regs->msr[TS] set and Thread->texasr[FS] = 0. (If current MSR[TS] was set,
then the reclaim process would set the live TEXASR[FS] for us, but it didn't
happen, since MSR_TM_SUSPENDED(mfmsr()) was false.)

When this process is scheduled back, then it breaks. It will do call the
following chain:

__switch_to_tm() -> tm_recheckpoint_new_task() -> tm_recheckpoint() which does:

	void tm_recheckpoint(struct thread_struct *thread)
	{
		...
	        tm_restore_sprs(thread); 	
        	__tm_recheckpoint(thread);
	}

In this case, __tm-recheckpoint() is called with current TEXASR[FS] = 0,
hitting that bug.


> After the tm_reclaim there are cases in restore_tm_sigcontexts() where the
> above
> is also the case. Hence why I think we have a problem there too

Right, but in order to meet the criteria, you need to *fully* execute
tm_reclaim() (i.e execute the TRECLAIM instruction), so, thread->texasr[FS]
will be set.

So, at the entrance level, you either have current MSR[TS] set and fully
reclaim, thus setting texasr[FS], or, you will not have the regs->msr[TS] set
*and* current MSR[TS] disabled (until later where this patch fixes the problem).

Anyway, I might be missing something. So, the root of the problem seem to be
related to creating a case where current MSR[TS] is not set but regs->msr[TS]
is set.



