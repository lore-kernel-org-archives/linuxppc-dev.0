Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0705C43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 20:57:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E442159D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 20:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E442159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LnDj1twmzF380
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 06:57:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.177; helo=mail-qt1-f177.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ln3B1P4hzF37t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 06:48:54 +1000 (AEST)
Received: by mail-qt1-f177.google.com with SMTP id z13-v6so4351047qts.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VGNx84LlKvYQokOGTIPioIZVlzbGoswie6CgGctqQOY=;
 b=IdepfNN35iZ7DAnSYG2X07RyAoQxQEKZ/Y3QfDPurEJnkEtsIFgEsCtummt9EUfRaA
 NjMcxoHgaXxfMGkQ+dP1qDSxVGSf0qSV3ob+LJ1NvmGOHMj7EkqGZdjpRDJkgY2Js9/q
 ESDQhYVl3suK7FVNz1iq9KAR4Obfv/DETdySjzNHW3pqjSxJjj5jQid9Ryjgz4H+D7yI
 pAmTjyBKPfus9muCEJgQI4torDD6KMQdWd+XsAe07xQHG1mAFphuI+sMrIITugWB2s/5
 ECKk7lwJR26kD/cjX4twDjQ8d1JCe2tdJjmROFPbyoEOiCZqitBBBq2yPB0CRqVW1Wk5
 r+eg==
X-Gm-Message-State: ABuFfojqN42LtbSaHMkC6tnxs70pRWY0vn5ZsMimbwNJB0YGCbMuEfHV
 jyVCZ470F01giyLUo9N2vrk=
X-Google-Smtp-Source: ACcGV624xFE/A5hJws5OKGrz/DsHL4ceBAgmeIgmR8Lwz93+wgg66DhzXpPNpXRm8tdlAx64corNTw==
X-Received: by 2002:ac8:190e:: with SMTP id
 t14-v6mr9939715qtj.327.1538081331822; 
 Thu, 27 Sep 2018 13:48:51 -0700 (PDT)
Received: from [10.0.0.9] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id e195-v6sm1823444qka.2.2018.09.27.13.48.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Sep 2018 13:48:51 -0700 (PDT)
Subject: Re: [RFC PATCH 06/11] powerpc/tm: Refactor the __switch_to_tm code
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-7-git-send-email-leitao@debian.org>
 <d06021833414dcfa5c9e04b4d83dfc475d1f1cbd.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <8c286819-a41b-5c07-2857-09618181000f@debian.org>
Date: Thu, 27 Sep 2018 17:48:46 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d06021833414dcfa5c9e04b4d83dfc475d1f1cbd.camel@neuling.org>
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

hi Mikey

On 09/18/2018 01:04 AM, Michael Neuling wrote:
>> On top of that, both tm_reclaim_task() and tm_recheckpoint_new_task()
>> functions are not used anymore, removing them.
> 
> What about tm_reclaim_current().  This is being used in places like signals
> which I would have thought we could avoid with this series

In fact tm_reclaim_current() is the default function to reclaim. It is the
function that is being called by TM_KERNEL_ENTRY, other than that, it should
never be called on the sane path.

>> +		 * If we got here with an active transaction, then, it was
>> +		 * aborted by TM_KERNEL_ENTRY and the fix the failure case
>> +		 * needs to be fixed, so, indepedently how we arrived here, the
>> +		 * new TM abort case will be TM_CAUSE_RESCHED now.
> 
> What does "fix the failure case needs to be fixed" mean?
> 
> also s/indepedently/independently/

In fact, I rewrote this paragraph. I try to say that the "TEXASR Failure
code" needs to be updated/fixed, but it became that messy and crazy
paragraph. :-(

> 
>> +		 */
>> +		if (MSR_TM_ACTIVE(prev->thread.regs->msr)) {
>> +			/*
>> +			 * If there was an IRQ during trecheckpoint, it will
>> +			 * cause an IRQ to be replayed. This replayed IRQ can
>> +			 * invoke SCHEDULE_USER, thus, we arrive here with a TM
>> +			 * active transaction.
> 
> I don't think this can happen. trecheckpoint (and treclaim) are called with IRQs
> hard off (since they change r1).

There will be an IRQ check and replay later. An IRQ being replayed can cause
a process to be reschedule and arrive here after a trecheckpoint.

> I think something else is going on here. I think this code and comment needs to
> go but I assume it's here because you are seeing something.

Right, and it was my major concern about this whole review.

The tm_recheckpoint() was being called with IRQ hard off, as you said, but
the IRQ is being re-enabled later, after "trecheckpoint", when it calls
local_irq_restore().

Since the IRQ was re-enabled, there is a mechanism to check for IRQs that
were pending and execute them (after recheckpoint - hence with MSR[TS]
active). Some of these pending IRQ might cause a task reschedule, bringing us
to __switch_to with MSR[TS] active.

I also checked that there were cases where a pending IRQ was waiting to be
replayed even before  tm_recheckpoint() is called. I suspect we were reaching
tm_recheckpoint soft-disabled.

On the v2 patchset, I am following your suggestion, which is calling
restore_tm_state() much later (at the beginning of fast_exception_return),
after the _TIF_USER_WORK_MASK section, and after the IRQ replay section also.
So, after this point, there is no way to rollback the exit to userspace after
trecheckpoint. Therefore, if there is a recheckpoint, a rfid will always come
directly.

In order to do so, I need to remove _TIF_RESTORE_TM as part of
_TIF_USER_WORK_MASK and handle _TIF_RESTORE_TM individually later.

This seems to solve this problem, and I can remove this reclaim in the middle
of __switch_to_tm().

Thank you
