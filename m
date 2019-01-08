Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A885C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 11:13:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B700B20850
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 11:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B700B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YqPH5GwyzDqSx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 22:13:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.214.193; helo=mail-pl1-f193.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YqMW0vkJzDqSW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 22:11:34 +1100 (AEDT)
Received: by mail-pl1-f193.google.com with SMTP id p8so1752412plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 03:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PnDwAcYEP7seDaF8teGPmXVEyo1ivYqMHaQFgG1aPZE=;
 b=JX1lJptGfkRiahVvaPkvlY/JCy/SBP8lrpaRPxZU6jj/yqVnyauMDdZQukuIit95gE
 9g1UjWhkVFpxIYxqbgif0AN413GqqOhePr8GmeX1p/BgBnF20OCtgk+Dp96g0DTKSRe2
 N6I+4l3yn/m1zp0fZJQoWwvIw7kuDZshlbyWU9SEw+VcyZDo0DdK5lNI+KcWMh2+wZy0
 jyaHGnzBI2HNVNw8U53VplntzEN9HZpD2oJMBDav0cKeBhlsG+Z/vfxAj+8ElME89AnQ
 OzJLFtaaudbxmVDI3+28TTP6AeuWJr8ahBYSXgAPgSPC9aD5TauJ902yngleAfZdXQ8u
 V0eg==
X-Gm-Message-State: AJcUukdXbbxLJljjcz79+DV+cwuhjli4hN/0CiQxTupKRX+bRA8MqcAl
 pBB2rJTfbBlvszbYfuWd8No=
X-Google-Smtp-Source: ALg8bN5udJj5tbqp/qzyn7YhAJllcTvONmYeSFwI94ER6NzysQWJQkzjyYQDDhSdS4QVK5VoBDILng==
X-Received: by 2002:a17:902:bb05:: with SMTP id
 l5mr1360032pls.230.1546945892963; 
 Tue, 08 Jan 2019 03:11:32 -0800 (PST)
Received: from [9.232.32.58] ([170.225.9.140])
 by smtp.gmail.com with ESMTPSA id e9sm89906857pff.5.2019.01.08.03.11.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 03:11:32 -0800 (PST)
Subject: Re: [PATCH v3 1/2] selftests/powerpc: Add MSR bits
To: Michael Ellerman <mpe@ellerman.id.au>,
 LEROY Christophe <christophe.leroy@c-s.fr>
References: <20190103181947.Horde.sGoDsMMUO3-VuetfCM1WTw7@messagerie.si.c-s.fr>
 <5af4e47a-f444-e259-1e09-1edf95d6595a@debian.org>
 <87k1jftshx.fsf@concordia.ellerman.id.au>
From: Breno Leitao <leitao@debian.org>
Message-ID: <1949511b-4918-876c-3fcc-431451dff39a@debian.org>
Date: Tue, 8 Jan 2019 09:11:28 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <87k1jftshx.fsf@concordia.ellerman.id.au>
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

Hi Michael,

On 1/8/19 7:20 AM, Michael Ellerman wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
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
>>    Problem: This might break the selftest independence of the kbuild system.
>>
>> 2) Generate a temporary header file inside selftests/include which contains
>> these macros at compilation time.
>>    Problem: The problem as above.
>>
>> 3) Define MSR fields at userspace headers (/usr/include).
>>    Problem: I am not sure userspace should have MSR bits information.
>>
>> Do you suggest me to investigate any other way?
> 
> In this case I think we can probably just copy the few #defines we need.

Cool. That is the very same thing as suggested by Christophe. I sent the v4
yesterday, with this change already.

Thanks for looking at it.
