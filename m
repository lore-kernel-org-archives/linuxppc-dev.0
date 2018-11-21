Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66255C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 18:29:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7333214C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 18:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7333214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430WM64v1szF3gt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 05:29:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.194; helo=mail-qt1-f194.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430WK42sx3zF3c7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 05:27:52 +1100 (AEDT)
Received: by mail-qt1-f194.google.com with SMTP id y20so4883726qtm.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 10:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cSIdAUKetZPHejOsr247eNRYyKvUgZQJUiwuZW0hXlU=;
 b=W4S0kNulvboo7HtHxJc+67fZu5xf/Aw6NJialLyxbbMyY61u1gwva+7yBTyTLiIKOM
 SsVaoYax46f7PcRr8Ql/as1HC5nQztDtSm0bLX1UZ+7C43WeUH4Tf9oBERdA7kwCEzCc
 EHgLSlMvOXyx7jsl930aqfu4cBT1DF3RYRsA+s4bnTaS1ryrYwX8uFBxlxgQEjeCyfKE
 RrxlxVIsENCzLhPLpwnkp46CmUIg/DikqHNPW8HhcKxNwv6FU4DUVgJ9Ko2/deKSSym8
 KEwHtv2xyn28yETuhZJ9AoI3DMEu1nYi4bFISKELpY0WfXA76n/6zKeggtPt6OgALjEq
 tc0w==
X-Gm-Message-State: AA+aEWYNY2FvdOLKa42PJZu2tdkviamFmP2I8+vw5y2lNNnBFusqtP41
 1z29iDbXhCKYndzrWT4mmZA=
X-Google-Smtp-Source: AFSGD/XTIgaZ7sSCx+Z/7+IQko/3RzO4biZLai/nd/vHcBzKCtAuODn3MWszVKfHvk2Mm//6vgtKiA==
X-Received: by 2002:a0c:d065:: with SMTP id d34mr6981338qvh.209.1542824869805; 
 Wed, 21 Nov 2018 10:27:49 -0800 (PST)
Received: from [9.18.239.97] ([32.104.18.243])
 by smtp.gmail.com with ESMTPSA id p48sm31223824qtp.62.2018.11.21.10.27.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Nov 2018 10:27:48 -0800 (PST)
Subject: Re: [PATCH] powerpc/tm: Set MSR[TS] just prior to recheckpoint
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1542631494-10344-1-git-send-email-leitao@debian.org>
 <9cdf12d1eaa5350e130d3cfb15ecb060323b6788.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <5ead16d3-2ada-d5b2-5481-0326a3c920af@debian.org>
Date: Wed, 21 Nov 2018 16:27:51 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <9cdf12d1eaa5350e130d3cfb15ecb060323b6788.camel@neuling.org>
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

hi Mikey,

On 11/19/18 9:30 PM, Michael Neuling wrote:
> On Mon, 2018-11-19 at 10:44 -0200, Breno Leitao wrote:
>> On a signal handler return, the user could set a context with MSR[TS] bits
>> set, and these bits would be copied to task regs->msr.
>>
>> At restore_tm_sigcontexts(), after current task regs->msr[TS] bits are set,
>> several __get_user() are called and then a recheckpoint is executed.
> 
> Do we have the same problem on the entry side?  There are a bunch of
> copy_from_user() before we do a tm_reclaim() (ie when still transactional). Is
> there some chance of the same problem there?

Do you mean in this part of code?

  SYSCALL_DEFINE0(rt_sigreturn)
  {
	....
        if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
                goto badframe;

	...
        if (MSR_TM_SUSPENDED(mfmsr()))
                tm_reclaim_current(0);

I suspect it is not a problem, since a page fault here will cause the process
to be reschedule, and tm-reclaim and tm_recheckpoint will happen, and save
and restore the checkpointed/live registers before this tm_reclaim_current(0).

I also forced a process reschedule (calling schedule()) just after
copy_from_user() and I didn't see it breaking anything. I might spent more
timing thinking about this whole get_user() at signal handlers and I will
double check it.

>> This is a problem since a page fault (in kernel space) could happen when
>> calling __get_user(). If it happens, the process MSR[TS] bits were
>> already set, but recheckpoint was not executed, and SPRs are still invalid.
>>
>> The page fault can cause the current process to be de-scheduled, with
>> MSR[TS] active and without tm_recheckpoint() being called.  More
>> importantly, without TEXAR[FS] bit set also.
> 
> This patch is great and should go in ASAP 
> 
>> Since TEXASR might not have the FS bit set, and when the process is
>> scheduled back, it will try to reclaim, which will be aborted because of
>> the CPU is not in the suspended state, and, then, recheckpoint. This
>> recheckpoint will restore thread->texasr into TEXASR SPR, which might be
>> zero, hitting a BUG_ON().
>>
>> 	[ 2181.457997] kernel BUG at arch/powerpc/kernel/tm.S:446!
> 
> Can you put more of the backtrace here?  Can be useful for people searching for
> a similar problem.

Ack!

> 
>> This patch simply delays the MSR[TS] set, so, if there is any page fault in
>> the __get_user() section, it does not have regs->msr[TS] set, since the TM
>> structures are still invalid, thus avoiding doing TM operations for
>> in-kernel exceptions and possible process reschedule.
> 
> Can you put a comment in the code what says after the MSR[TS] setting, there can
> be no get/put_user before the recheckpoint?

Sure. I will circle this code with a preempt_disable/enable() and put a
comment there as well.

> Also, it looks like the 32bit signals case is safe, but please add a comment in
> there too.

Yes, 32-bits seems to be safe, but, I will do the same as above, adding
preempt disable/enable and warn about possible interrupts in-between.

Thank you!
Breno
