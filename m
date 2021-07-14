Return-Path: <SRS0=lYaZ=MG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2452C07E9A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Jul 2021 08:33:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888CD613AB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Jul 2021 08:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888CD613AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GPrNz6QDDz3062
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Jul 2021 18:33:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=0zJnH4Zy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=2607:f8b0:4864:20::436;
 helo=mail-pf1-x436.google.com; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=0zJnH4Zy; dkim-atps=neutral
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GPrNN6jT7z2yYJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jul 2021 18:32:34 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id 17so1374569pfz.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jul 2021 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=dX1snp8Zkg1yewGw7VfUJfTAWh+xT6mywa/1czjEeQA=;
 b=0zJnH4Zyt7DWULsNgwhWY9gCJlGQkLo1Ovz83E+FpkILCFpER32q1+2Fg+FOrGrNYg
 awADz0RVRI1V7iRBiwZ7X3DWXvgkHITcH8+lx7EvsnLtYknQUlKtABh3Ro5QpmyMxO57
 y2Ic3fEsYvSibPdcs4Odroe2/K+rmDQ4MzrLqHL3jErQAc8h1skozyDTWkQwNEki4yam
 jxKT1MkwCXPs4eP6xp06BJzKj87bDvVooC3YcuBtTL/VeKZkid3Nw2z2kYN/KaWaOLm3
 8wAt+ppvNjyKbUeasIUSYxLEpeXCCks5AD39+WnJl8ER/wkx7ZeEKDT9/FyoDvXEmD0A
 P5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dX1snp8Zkg1yewGw7VfUJfTAWh+xT6mywa/1czjEeQA=;
 b=Qtl86KWE/iV+22bxtPTY7Qvss6iUx3Xnhzi3+AWx9/bfKeqGoOFMmsdfMlDJdhE5Fa
 IxAFJtKV7o17HWcdTrBONRWJ3kLKKAtgc5mApecbDKGsOhaf07AxyFy0iKH4UzZVkTWN
 7SIqY7vfkLA4+8Z71INN7zhhN4JAeTXrx3F5N6qVoxNEA/2uxgzOGEuG+V+WHd7Spzbq
 PfTW0EzQhqpsptSX+gxyi2XSJyPM9VBfB1Th068JoG1KhbPpZy0BNzBQYBZ7ucZhi6nG
 fxOIvkrjNwKgn7l+AmYxeALdvfVSvnoQ8Uf0B12R5WlAgr3lTgXQIz3hYcg4RYfG+drV
 sZzA==
X-Gm-Message-State: AOAM532kcFfjPDKchbv6MRPLJnxt9ehksRgikGm7euuJ4OZNkAwRdBYn
 bT78Om1tZMCLfekh6gR1csXw2w==
X-Google-Smtp-Source: ABdhPJwXiSa8hgrN6WGQ+H85kKC0acFWBcHlebTwNvpvrBehSoFoXD+F27Xzsi1qYrUPDyb1bUcsdA==
X-Received: by 2002:a65:6145:: with SMTP id o5mr8474989pgv.410.1626251549586; 
 Wed, 14 Jul 2021 01:32:29 -0700 (PDT)
Received: from [192.168.10.23] (219-90-184-65.ip.adam.com.au. [219.90.184.65])
 by smtp.gmail.com with UTF8SMTPSA id
 a23sm1820095pfn.117.2021.07.14.01.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jul 2021 01:32:28 -0700 (PDT)
Message-ID: <88e3b97e-201d-0782-0e95-8e3d2d850a38@ozlabs.ru>
Date: Wed, 14 Jul 2021 18:32:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Subject: Re: [PATCH v4 07/11] powerpc/pseries/iommu: Reorganize
 iommu_table_setparms*() with new helper
Content-Language: en-US
To: =?UTF-8?Q?Leonardo_Br=c3=a1s?= <leobras.c@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>
References: <20210430163145.146984-1-leobras.c@gmail.com>
 <20210430163145.146984-8-leobras.c@gmail.com>
 <e4984fa0-2afe-a987-4fb8-61b878431b1f@ozlabs.ru>
 <97626d3883ed207b818760a8239babb08a6b5c59.camel@gmail.com>
 <b25dff0f130b9ab721b8b524e55a3cd4c244a8f3.camel@gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <b25dff0f130b9ab721b8b524e55a3cd4c244a8f3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 13/07/2021 14:47, Leonardo Brás wrote:
> Hello Alexey,
> 
> On Fri, 2021-06-18 at 19:26 -0300, Leonardo Brás wrote:
>>>
>>>> +                                        unsigned long liobn,
>>>> unsigned long win_addr,
>>>> +                                        unsigned long
>>>> window_size,
>>>> unsigned long page_shift,
>>>> +                                        unsigned long base,
>>>> struct
>>>> iommu_table_ops *table_ops)
>>>
>>>
>>> iommu_table_setparms() rather than passing 0 around.
>>>
>>> The same comment about "liobn" - set it in
>>> iommu_table_setparms_lpar().
>>> The reviewer will see what field atters in what situation imho.
>>>
>>
>> The idea here was to keep all tbl parameters setting in
>> _iommu_table_setparms (or iommu_table_setparms_common).
>>
>> I understand the idea that each one of those is optional in the other
>> case, but should we keep whatever value is present in the other
>> variable (not zeroing the other variable), or do someting like:
>>
>> tbl->it_index = 0;
>> tbl->it_base = basep;
>> (in iommu_table_setparms)
>>
>> tbl->it_index = liobn;
>> tbl->it_base = 0;
>> (in iommu_table_setparms_lpar)
>>
> 
> This one is supposed to be a question, but I missed the question mark.
> Sorry about that.

Ah ok :)

> I would like to get your opinion in this :)

Besides making the "base" parameter a pointer, I really do not have 
strong preference, just make it not hurting eyes of a reader, that's all :)

imho in general, rather than answering 5 weeks later, it is more 
productive to address whatever comments were made, add comments (in the 
code or commit logs) why you are sticking to your initial approach, 
rebase and repost the whole thing. Thanks,



-- 
Alexey
