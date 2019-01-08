Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BDDC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 11:35:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79157206C0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 11:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79157206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Yqth6l80zDqTQ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 22:35:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.194; helo=mail-qk1-f194.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Yqpc4gsdzDqTL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 22:31:36 +1100 (AEDT)
Received: by mail-qk1-f194.google.com with SMTP id 189so2072559qkj.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 03:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ofx0GsVn3HPOvdWNa9jIyCp+AsVk4LmMJrygxYazaI8=;
 b=G0D3F54Bkv8hJzcT6m3/Sjv4A46P7r80t0V9xe/UJHQGUCsZC/VA88pbm/BeKLnzfZ
 DwicK+kciTYiONP/w3UtJpQ79pa+UjgIhQY4Ahmu/QmIxuVgrAWI0GrM4+L27EooRna1
 FKQ/T6K2mTQnLJLoQ3C4yG3RfHKOAXhXTEwHuRiAP1Xq1UWnUiTSoyw0eYe/hgn3oq/V
 /jM9m6AUt3wn2yKOIesNEDWwdjfX1di2mgj7YJTntEZcXI8yyA8+0sw22jN47KXIRtNm
 muVrLRLouZW3fvP5/AJLyTNXkiDSmZhOAFn+tcy4ZLXG6wWzajZYB8mKY9ivNBvarhmW
 Zrcg==
X-Gm-Message-State: AJcUukfOlkj22r4fGvL5MRJzfCn1oHQRY8Kw6LlCf/dv2au4qQhWk7iv
 nvOve/DCm25RZfpm0yYl1hQ=
X-Google-Smtp-Source: ALg8bN4QFJtJ/VnL/v/cM/oBYOH8CKYNUY2Xep4OU92w2B74MFStitB3OnWpPRmYr0qLrjRhaPDrsQ==
X-Received: by 2002:a37:660f:: with SMTP id a15mr1137952qkc.328.1546947094295; 
 Tue, 08 Jan 2019 03:31:34 -0800 (PST)
Received: from [9.18.239.29] ([32.104.18.202])
 by smtp.gmail.com with ESMTPSA id r24sm38496898qtr.2.2019.01.08.03.31.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 03:31:33 -0800 (PST)
Subject: Re: [PATCH v3 1/2] selftests/powerpc: Add MSR bits
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20190103181947.Horde.sGoDsMMUO3-VuetfCM1WTw7@messagerie.si.c-s.fr>
 <5af4e47a-f444-e259-1e09-1edf95d6595a@debian.org>
 <87k1jftshx.fsf@concordia.ellerman.id.au>
 <1949511b-4918-876c-3fcc-431451dff39a@debian.org>
 <1ce6a6b8-58ea-8e63-acb2-f2c4a8770c5c@c-s.fr>
From: Breno Leitao <leitao@debian.org>
Message-ID: <436ac339-e9fa-c7b3-3791-990a65f9b87f@debian.org>
Date: Tue, 8 Jan 2019 09:31:30 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1ce6a6b8-58ea-8e63-acb2-f2c4a8770c5c@c-s.fr>
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

On 1/8/19 9:14 AM, Christophe Leroy wrote:
> Le 08/01/2019 à 12:11, Breno Leitao a écrit :
>> Hi Michael,
>>
>> On 1/8/19 7:20 AM, Michael Ellerman wrote:
>>> Breno Leitao <leitao@debian.org> writes:
>>>
>>>> hi Christophe,
>>>>
>>>> On 1/3/19 3:19 PM, LEROY Christophe wrote:
>>>>> Breno Leitao <leitao@debian.org> a écrit :
>>>>>
>>>>>> This patch simply adds definitions for the MSR bits and some macros to
>>>>>> test for MSR TM bits.
>>>>>>
>>>>>> This was copied from arch/powerpc/include/asm/reg.h generic MSR part.
>>>>>
>>>>> Can't we find a way to avoid duplicating such defines ?
>>>>
>>>> I think there are three possible ways, but none of them respect the premises
>>>> we are used too. These are the possible ways I can think of:
>>>>
>>>> 1) Including arch/powerpc/include/asm as part of the selftest compilation
>>>> process.
>>>>     Problem: This might break the selftest independence of the kbuild
>>>> system.
>>>>
>>>> 2) Generate a temporary header file inside selftests/include which contains
>>>> these macros at compilation time.
>>>>     Problem: The problem as above.
>>>>
>>>> 3) Define MSR fields at userspace headers (/usr/include).
>>>>     Problem: I am not sure userspace should have MSR bits information.
>>>>
>>>> Do you suggest me to investigate any other way?
>>>
>>> In this case I think we can probably just copy the few #defines we need.
>>
>> Cool. That is the very same thing as suggested by Christophe. I sent the v4
>> yesterday, with this change already.
> 
> It didn't get through. Latest is still v3 it seems, look
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=71262

Weird, I am not finding it as well, although I've just confirmed that I have,
in fact, sent it. Anyway, let me send it again.

Thanks!
