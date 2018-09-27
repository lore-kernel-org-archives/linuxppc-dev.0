Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB37AC43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 21:21:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395E5216FA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 21:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395E5216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Lnmb15MDzF39C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 07:21:19 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LnMz3HDvzF38V
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 07:03:27 +1000 (AEST)
Received: by mail-qt1-f196.google.com with SMTP id i10-v6so4437018qtp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 14:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fMuiGNIhLVfXcjnfaIs9bxfJ7nDKry3/26kExqHB2co=;
 b=Wj7rAt87uz6hkWZYHEwNaQ8R69ckfOnzAGOYwpzRBx5dGUDUqbsM6MZSUR5UN2m/dH
 FSLU6rPbRFjSagSw5FH9JQZFsCtzBR+z+Ti26GlmmmfvbPkCS2tNr12q7TSOiRgWmIIJ
 aBPkVGGvofHr46b16RrQdInAuEDCLp8UQSIoStkp7trmSalVIJMPnRDe80JsFtEnhadB
 6RNng48BkL1JmqNZAuzFqTPVxb4qmz4IRaD+km/kA3mRqm8F6+hiOjUNmh4RQiP1b/4U
 hobcaVokh5Y7uIAHJJqwYGO5K/uNDw0hhU5GQL4PxpJ9P0O+Yx0FNfHh3MBG9XKtFQpI
 HPQg==
X-Gm-Message-State: ABuFfogsUG5w8zwIabyngNaFAQC1k+lTAgDajDTvIzOlEWzqVP6lKLei
 s2Xf6PeWG62uwS/OnwUQ3Hc=
X-Google-Smtp-Source: ACcGV63FkZN8E0hPn2RRVqUDq7B0NPN7YG5AtOBDegSi6m3vpGCE0E6LywfIxsxktnimFgHL2DW5jw==
X-Received: by 2002:ac8:33da:: with SMTP id
 d26-v6mr9945658qtb.313.1538082205396; 
 Thu, 27 Sep 2018 14:03:25 -0700 (PDT)
Received: from [10.0.0.9] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id f184-v6sm1773934qkc.23.2018.09.27.14.03.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Sep 2018 14:03:24 -0700 (PDT)
Subject: Re: [RFC PATCH 08/11] powerpc/tm: Do not reclaim on ptrace
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-9-git-send-email-leitao@debian.org>
 <743b29dab736700c1b284fabb8fccf7c83ddb3c2.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <18dcf8b7-1001-d6cc-1847-af9c679f9435@debian.org>
Date: Thu, 27 Sep 2018 18:03:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <743b29dab736700c1b284fabb8fccf7c83ddb3c2.camel@neuling.org>
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
Cc: ldufour@linux.vnet.ibm.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mikey,

On 09/18/2018 02:36 AM, Michael Neuling wrote:
> On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
>> Make sure that we are not suspended on ptrace and that the registers were
>> already reclaimed.
>>
>> Since the data was already reclaimed, there is nothing to be done here
>> except to restore the SPRs.
>>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>  arch/powerpc/kernel/ptrace.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
>> index 9667666eb18e..cf6ee9154b11 100644
>> --- a/arch/powerpc/kernel/ptrace.c
>> +++ b/arch/powerpc/kernel/ptrace.c
>> @@ -136,12 +136,10 @@ static void flush_tmregs_to_thread(struct task_struct
>> *tsk)
>>  	if ((!cpu_has_feature(CPU_FTR_TM)) || (tsk != current))
>>  		return;
>>  
>> -	if (MSR_TM_SUSPENDED(mfmsr())) {
>> -		tm_reclaim_current(TM_CAUSE_SIGNAL);
>> -	} else {
>> -		tm_enable();
>> -		tm_save_sprs(&(tsk->thread));
>> -	}
>> +	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
>> +
>> +	tm_enable();
>> +	tm_save_sprs(&(tsk->thread));
> 
> Do we need to check if TM was enabled in the task before saving the TM SPRs?
> 
> What happens if TM was lazily off and hence we had someone else's TM SPRs in the
> CPU currently?  Wouldn't this flush the wrong values to the task_struct?
> 
> I think we need to check the processes MSR before doing this.

Yes, it is a *very* good point, and I think we are vulnerable even before
this patch (in the current kernel). Take a look above, we are calling
tm_save_sprs() if MSR is not TM suspended independently if TM is lazily off.

It shouldn't be hard to create a test case for it. I can try to call
ptrace(PTRACE_GETVRREGS) on a task that sleeps until TM is lazily disabled,
compare if the TM SPR changed in this mean time. (while doing HTM in parallel
to keep HTM SPR changing). Let's see if I can read others task TM SPRs.

Thank you.
