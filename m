Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6172AC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66A521736
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66A521736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YFsC5LlFzDqGQ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 00:01:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YFmy1s2MzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 23:58:10 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id e5so244842qtr.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jan 2019 04:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6QPHfsRkJHIrwGypSmYC4a+u8Egm/C21rokZAUb3bmM=;
 b=AKxQA6AXIDraxwGBovCFpqe9LRFBGgXW28uYHNgSuhgscLID6IHFtOZJkFt/7eTuZZ
 y8eifvZLy+Q2HzhY3l56N2IwWYD+nP6s3PH5jGsCQ5kW+MDtPheHs2N4Y+E5MXkQtO46
 XlOeymQZsvXEdxbLVPQncYwVzGKWrevmtVqvZRfGBbfOLEP+HCcr8EvyW/z7mQ9Y70h6
 k+naPyqWvjN1GbAaZHLEOi/J6GmjU1ewPCW/P9ovsXIF3In8VBcoya3KMfCNzhr+0fNB
 +O1ZMoA3V4YCtrlLw7c+b+lDJ7L5ofJV/929fI35it/t2Tx8fqooYHXwsTdfdH8wwmAg
 eVFQ==
X-Gm-Message-State: AA+aEWaq9ryLsd4uvEw+dgTdQXj7FLsuVQlgJlKQy4FlnM0lwOU/Cm+n
 3ZvezkYDXArnLYsN4Ci9pnXUk43F
X-Google-Smtp-Source: AFSGD/XWqP5JUUlxjIWrscqbBR2uLfTHkeuJs6igc3lCLHdric20wBO7aSAVH3indQg8ymm/f2bzfQ==
X-Received: by 2002:ac8:674b:: with SMTP id n11mr58378622qtp.104.1546865887858; 
 Mon, 07 Jan 2019 04:58:07 -0800 (PST)
Received: from [10.0.0.8] ([189.29.25.55])
 by smtp.gmail.com with ESMTPSA id a17sm30833417qth.93.2019.01.07.04.58.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 04:58:07 -0800 (PST)
Subject: Re: [PATCH v3 1/2] selftests/powerpc: Add MSR bits
To: Christophe Leroy <christophe.leroy@c-s.fr>
References: <20190103181947.Horde.sGoDsMMUO3-VuetfCM1WTw7@messagerie.si.c-s.fr>
 <5af4e47a-f444-e259-1e09-1edf95d6595a@debian.org>
 <13f835f8-8c6c-9b94-9e27-c23ce3df8253@c-s.fr>
From: Breno Leitao <leitao@debian.org>
Message-ID: <3b767228-badb-6e93-3da4-8d5e003da9ce@debian.org>
Date: Mon, 7 Jan 2019 10:58:03 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <13f835f8-8c6c-9b94-9e27-c23ce3df8253@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

hi Christophe,

On 1/7/19 10:47 AM, Christophe Leroy wrote:
> Hi Breno,
> 
> Le 07/01/2019 à 13:44, Breno Leitao a écrit :
>> hi Christophe,
>>
>> On 1/3/19 3:19 PM, LEROY Christophe wrote:
>>> Breno Leitao <leitao@debian.org> a écrit :
>>>
>>>> This patch simply adds definitions for the MSR bits and some macros to
>>>> test for MSR TM bits.
>>>>
>>>> This was copied from arch/powerpc/include/asm/reg.h generic MSR part.
>>>
>>> Can't we find a way to avoid duplicating such defines ?
>>
>> I think there are three possible ways, but none of them respect the premises
>> we are used too. These are the possible ways I can think of:
>>
>> 1) Including arch/powerpc/include/asm as part of the selftest compilation
>> process.
>>     Problem: This might break the selftest independence of the kbuild system.
>>
>> 2) Generate a temporary header file inside selftests/include which contains
>> these macros at compilation time.
>>     Problem: The problem as above.
>>
>> 3) Define MSR fields at userspace headers (/usr/include).
>>     Problem: I am not sure userspace should have MSR bits information.
>>
>> Do you suggest me to investigate any other way?
> 
> Looking it other .h in selftests, it looks like they are limited to the only
> strictly necessary values.
> 
> Are all the values you have listed used ? If not, could you only include in
> the file the necessary ones ?

Sure. That works also.  Let send a v4 patch.
