Return-Path: <SRS0=itdR=HZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE5CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Feb 2021 05:14:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F24A64E31
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Feb 2021 05:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F24A64E31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dl6fn3Kb9z3cNd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Feb 2021 16:14:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=vUn3khT6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=vUn3khT6; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dl6fH2FjCz30MV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2021 16:13:56 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id ds5so1099608pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2021 21:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4SffRHLtG7nt3Ltmt3Tr3+tyegiAH2nuFv/zbGJURFw=;
 b=vUn3khT6E1bYKUjq2DtR3Tutqszv2qikitpA+XiBjOiC9bp75bv3W+Ieswo7noGPFb
 x2iUzyJHoXmbBeG5L9uF5hcPZ8H9E2EYT7c23w7w0k/wC4ORarSdhOFlYhacomihrBL8
 JFZjo1eiJ99YKzT1FGpnfZr/MKniT+dmtxXBUxQgIJmB3KT7e1HUrOKiwRzOXqWGolGE
 SNgqalz79NB0aFx/Zuj3Z3YqH5ILodY0NMGSiPu9RsJe5qWBwUkB0LHuHhUSjBjS81LZ
 SCjLeUlfcQaT8EkM885b/tK2yPNcGl6L3kvNJVORr2KJUwHQs4O1cjoPXfkh6BObzS85
 XLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4SffRHLtG7nt3Ltmt3Tr3+tyegiAH2nuFv/zbGJURFw=;
 b=fdNnwtvCSd1J8XYGiszvj+C09OLFAIK820K/OfOfD6KPwPTpsTGIZX6cB2EX1qbins
 OBBlGBC4TS21eWErXNrEhcd+q5OxShML4dW2TssMEXQCSZWU2ikFEUm3XUiFPasxWRa9
 qQmJ99J7VvPaqnST55uw1mXlAI/DUQoqywSfzaEFWVmbiex9PtOQhv+5pqE36EzuhTig
 N1/G95ZN17cjNzaR3dBBkja2mYmTlC4YC0YJKEsGdDZiKWJPxDxoejIIUrprNZgvY5Rg
 avQSb4dTPYbfeUlobh9+EJ+qygqWG8SrThVvyhQnshs6WhquKiU8pMIF6KVK+ySrs/S8
 NYJw==
X-Gm-Message-State: AOAM532rw8g7guRKqRUtg5vJbGwa1RwRML69RRexWxXeugmKlGPrm5ua
 dgN7jSHJy1Kyt+BaK6y6XpQW2Q==
X-Google-Smtp-Source: ABdhPJxEC2GMFlE4kvJhqEFeUTcumwzH4cEMd7lfXdWcOZ3dBmoKOivRTt617cE9HIcam10fwOLeJg==
X-Received: by 2002:a17:90a:eac4:: with SMTP id
 ev4mr13946489pjb.146.1614057232966; 
 Mon, 22 Feb 2021 21:13:52 -0800 (PST)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au.
 [124.171.107.241])
 by smtp.gmail.com with UTF8SMTPSA id a19sm20218956pff.186.2021.02.22.21.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Feb 2021 21:13:52 -0800 (PST)
Subject: Re: [PATCH kernel] powerpc/iommu: Annotate nested lock for lockdep
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20210216032000.21642-1-aik@ozlabs.ru>
 <49b1f5cb-107c-296f-c339-13e627a73d6d@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0804cbd0-7acc-3c9b-3626-4149dcd03f8b@ozlabs.ru>
Date: Tue, 23 Feb 2021 16:13:49 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <49b1f5cb-107c-296f-c339-13e627a73d6d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 18/02/2021 23:59, Frederic Barrat wrote:
> 
> 
> On 16/02/2021 04:20, Alexey Kardashevskiy wrote:
>> The IOMMU table is divided into pools for concurrent mappings and each
>> pool has a separate spinlock. When taking the ownership of an IOMMU group
>> to pass through a device to a VM, we lock these spinlocks which triggers
>> a false negative warning in lockdep (below).
>>
>> This fixes it by annotating the large pool's spinlock as a nest lock.
>>
>> ===
>> WARNING: possible recursive locking detected
>> 5.11.0-le_syzkaller_a+fstn1 #100 Not tainted
>> --------------------------------------------
>> qemu-system-ppc/4129 is trying to acquire lock:
>> c0000000119bddb0 (&(p->lock)/1){....}-{2:2}, at: 
>> iommu_take_ownership+0xac/0x1e0
>>
>> but task is already holding lock:
>> c0000000119bdd30 (&(p->lock)/1){....}-{2:2}, at: 
>> iommu_take_ownership+0xac/0x1e0
>>
>> other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(&(p->lock)/1);
>>    lock(&(p->lock)/1);
>> ===
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/kernel/iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index 557a09dd5b2f..2ee642a6731a 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -1089,7 +1089,7 @@ int iommu_take_ownership(struct iommu_table *tbl)
>>       spin_lock_irqsave(&tbl->large_pool.lock, flags);
>>       for (i = 0; i < tbl->nr_pools; i++)
>> -        spin_lock(&tbl->pools[i].lock);
>> +        spin_lock_nest_lock(&tbl->pools[i].lock, &tbl->large_pool.lock);
> 
> 
> We have the same pattern and therefore should have the same problem in 
> iommu_release_ownership().
> 
> But as I understand, we're hacking our way around lockdep here, since 
> conceptually, those locks are independent. I was wondering why it seems 
> to fix it by worrying only about the large pool lock.

This is the other way around - we telling the lockdep not to worry about 
small pool locks if the nest lock (==large pool lock) is locked. The 
warning is printed when a nested lock is detected and the lockdep checks 
if there is a nest for this nested lock at check_deadlock().


> That loop can take 
> many locks (up to 4 with current config). However, if the dma window is 
> less than 1GB, we would only have one, so it would make sense for 
> lockdep to stop complaining.

Why would it stop if the large pool is always there?

> Is it what happened? In which case, this 
> patch doesn't really fix it. Or I'm missing something :-)

I tried with 1 or 2 small pools, no difference at all. I might also be 
missing something here too :)


> 
>    Fred
> 
> 
> 
>>       iommu_table_release_pages(tbl);
>>

-- 
Alexey
