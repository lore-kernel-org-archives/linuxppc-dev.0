Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF53C43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 21:18:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361FD216FA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 21:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361FD216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Lnjj1XghzF397
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 07:18:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.196; helo=mail-qk1-f196.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LnG82qzwzF38T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 06:58:24 +1000 (AEST)
Received: by mail-qk1-f196.google.com with SMTP id 80-v6so2568206qkj.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nNyRwZtkV//CFi7CNkaMqkG07m6uruMLulbf9vN5yf4=;
 b=IEPPpgSgW4Newjjd7ej+Oe4+wp5upJZyFX5u0Je3FDJJylLXAT15oE7Bt2zgL7omV4
 51TmK2hVDerjLZ5NYsnXZRlPJAA0KfK3jnkEWp+CrmA4OQAx7nYrtO8pWcGOrInrQKN/
 3QDUMKvWFuI07k9JAF3m7vsB6G3j99nNZ5TZyrq8Ck/1OldH5uugd9efqP66B8Sx7Opu
 IaVWxBXq3h2OIeL9xZWBDLR/Fh73zs4V1wMFaC3kII9VrTEDQQM0gL1uU7Mb7iFAi7Xy
 nQCNaogZIp+QGWDUvqDOW9oIO1dVjfPqXkbBBZzwAkb5zJur/HHCMEA+w+K9vh1CmH3H
 CIKg==
X-Gm-Message-State: ABuFfogLFizq8SGwhclPfQJdgguqEQK5bRtT8Ius6FqmVPvEDI4kwZU0
 AWRkeIrEHv1Rtnqq2vhVeqM=
X-Google-Smtp-Source: ACcGV612vRoW7GaZIDocxoDP3+yDeVuzMAYn7QAPABiLFR2yVk/yNxSHtGM1mtwGcCjqC+X3+AZQ1w==
X-Received: by 2002:a37:9442:: with SMTP id
 w63-v6mr9480743qkd.304.1538081902252; 
 Thu, 27 Sep 2018 13:58:22 -0700 (PDT)
Received: from [10.0.0.9] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id m64-v6sm1831778qkf.18.2018.09.27.13.58.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Sep 2018 13:58:21 -0700 (PDT)
Subject: Re: [RFC PATCH 05/11] powerpc/tm: Function that updates the failure
 code
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-6-git-send-email-leitao@debian.org>
 <53c7daa6af9a502827e877d04b4a45b7eea5efbe.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <205eceb0-1f6f-340c-fea4-97b31297272d@debian.org>
Date: Thu, 27 Sep 2018 17:58:18 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <53c7daa6af9a502827e877d04b4a45b7eea5efbe.camel@neuling.org>
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

On 09/17/2018 10:29 PM, Michael Neuling wrote:
> On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
>> Now the transaction reclaims happens very earlier in the trap handler, and
>> it is impossible to know precisely, at that early time, what should be set
>> as the failure cause for some specific cases, as, if the task will be
>> rescheduled, thus, the transaction abort case should be updated from
>> TM_CAUSE_MISC to TM_CAUSE_RESCHED, for example.
> 
> Please add comments to where this is used (in EXCEPTION_COMMON macro I think)
> that say this might happen.

Is it OK if I comment it in TM_KERNEL_ENTRY macro, since the failure cause
could be updated independently of the exception being execute, so, every call
to TM_KERNEL_ENTRY can have the cause overwritten.

I.e. it does not matter if  the exception is a systemcall or a page fault,
the failure cause will be updated if there is a process reschedule after the
exception/syscall is handled.

Thank you
