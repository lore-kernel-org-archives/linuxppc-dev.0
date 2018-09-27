Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2140C43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 21:11:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FEC21571
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 21:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FEC21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LnYB4KlCzF380
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 07:11:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.195; helo=mail-qk1-f195.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ln5x44zNzF37t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 06:51:17 +1000 (AEST)
Received: by mail-qk1-f195.google.com with SMTP id a189-v6so2540928qkb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SdczOLlgD2I9v890RyFvwqTXXGP7YgA4wD0VUE++51A=;
 b=hosEtCRZcA7C11DRJ2HS0iwALpi04pZbR4Lvea1inQeW0i/nan5lSArI0H1SOB0srh
 QqHCj1qbm2ayJDSYrmy6Mn0a9alycArMK1lPriWqzUBK49AsWVGjIlEUtVCdSpbzA40V
 f4FjIGiFPncZnMAxbwiGR4OJUIZL7xkqbaL1ujp5AJpuG6YW226Pnw3uUcatSJTS9KQh
 bdGCuhAbqFxQ535LGJ4rOToAEv04E1JDgtwvJ1vq7bPXhzAq3fIykUIYPMQcllLpRTOd
 5Tc9v0WU2AZO5UhORmCs4Jv0vcJQRJWo9kOOL14ofc9ITB2c1e0bLQX1mS8tnPGL+Lcy
 5m0g==
X-Gm-Message-State: ABuFfohmprJkuwOk3MyobOXO1sylR4xPi7wOgqsyc8E/C2Eio68JadQ0
 szy/PQuOa1g2mntssL9LUZg=
X-Google-Smtp-Source: ACcGV63pfWZW6F2BRKfBhuBadi7TVmzLFKulOd08KFAaEijznDjrJMMK3mgbWI0tZiGqGMhWMq4tOQ==
X-Received: by 2002:a37:7b45:: with SMTP id
 w66-v6mr9614488qkc.39.1538081475192; 
 Thu, 27 Sep 2018 13:51:15 -0700 (PDT)
Received: from [10.0.0.9] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id b7-v6sm1725530qtt.24.2018.09.27.13.51.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Sep 2018 13:51:14 -0700 (PDT)
Subject: Re: [RFC PATCH 09/11] powerpc/tm: Do not restore default DSCR
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-10-git-send-email-leitao@debian.org>
 <10da0fdc641b05ea288890a23aa01ad33f2d6987.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <11f2155f-eff8-2aac-ab47-1ab343d52107@debian.org>
Date: Thu, 27 Sep 2018 17:51:10 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <10da0fdc641b05ea288890a23aa01ad33f2d6987.camel@neuling.org>
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

On 09/18/2018 02:41 AM, Michael Neuling wrote:
> On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
>> In the previous TM code, trecheckpoint was being executed in the middle of
>> an exception, thus, DSCR was being restored to default kernel DSCR value
>> after trecheckpoint was done.
>>
>> With this current patchset, trecheckpoint is executed just before getting
>> to userspace, at ret_from_except_lite, for example. Thus, we do not need to
>> set default kernel DSCR value anymore, as we are leaving kernel space.  It
>> is OK to keep the checkpointed DSCR value into the live SPR, mainly because
>> the transaction is doomed and it will fail soon (after RFID), 
> 
> What if we are going back to a suspended transaction?  It will remain live until
> userspace does a tresume

Hmm, I understand that once we get in kernel space, and call
treclaim/trecheckpoint, the transaction will be doomed and it will abort and
rollback when we leave kernel space. I.e., if we can treclaim/trecheckpointn
in kernel space, the transaction will *always* abort just after RFID, so, a
possible tresume will never be executed. Is my understanding wrong?

> 
>> so,
>> continuing with the pre-checkpointed DSCR value is what seems correct.
> 
> Reading this description suggests this patch isn't really needed. Right?

Maybe the description is not clear, but I understand this patch is required,
otherwise we will leave userspace with a default DSCR value.

By the way, do you know if there is a change in DSCR inside a transaction,
will it be reverted if the transaction is aborted?

Thank you
