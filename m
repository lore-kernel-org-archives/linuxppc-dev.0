Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3715C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 07:31:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C882086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 07:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="WgChJVEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C882086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YVVm2253zF3Bd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 18:31:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="WgChJVEG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="WgChJVEG"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YVS360d3zF0Vv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 18:29:07 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y15-v6so8848825plr.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zCpgQap9yJfHoZDx9whXGfsWad6eBfos032JLmZ0PYg=;
 b=WgChJVEGixmsnso6XPC+P7Vb2cyS/4KynqjmgiUnOgDdELE3HuKXBF6AgRbJR8iToL
 RJmUoGFwIWS4QhnldkCD8Cdap1CRgLBtp906XT89HDInWqjPcWJllodpGEEFnL9OrxBr
 Fq2zNeKxe/9i9hNJY7govWyJ/cvYsPUmWNzBVzmHAwP9PK7KQXmyrW4VDc2tEgGHIlQ7
 wzE/PTJ6zsru8PEPko0Y4KdK7xM7KgKwaCNhtHxhiZV+Pp3i8ld2a7S2hUm1vdy4BLl3
 M9RFSVSeYkRGvfpP+iguK7RG7Ju+98YDTcKQlmvRVbqu8Xj6p/jaB3ju9qzW6yQ+YnAX
 DGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zCpgQap9yJfHoZDx9whXGfsWad6eBfos032JLmZ0PYg=;
 b=D4jQeLxjP1/3va4rxNAU/qZAZ0plxHqL5EnG+FfjmhNzuEvdd4Dgif3x0zwbz0fIUa
 6DGnqWQrHSHmSvoUbsD5R4frdv5bs7k90YAaRZLiipGnSpHcm//1gBbHmnJb1fR+ROX5
 f6xnKhLUm8nvlx6yfoW5KRiLY9IWDDDtf9cV7LGzh7w1OgczkhmL+U14NBYI0ej2rUbZ
 WD3DIaq6y8LOT8/8VNOMWufyqzVE++5jDpMaxLHKN3mWO0aUSKr//+B6+ZIIGuAl8KZA
 G1BAqsT4C3aD8jb/Ny7ICo858GHZnf7Sb/2O8DrtQ1mAzW5vspaJ1xLyQbZ48YAQ3Ejg
 b5mA==
X-Gm-Message-State: ABuFfog9JbvpWbHdzFv+cvCFDYmlZeomEXyQLeVWQqpCbft+jzMuRwnj
 qpGY3ObXFipVuBxO+p5HivYmUQ==
X-Google-Smtp-Source: ACcGV60bMV1wIrXMLQSmK1EHedPMNsiTVhVHHVFh8UaUhTSwdAX8P3GcKAN8g34KZsohvAdcVQ5b/Q==
X-Received: by 2002:a17:902:b182:: with SMTP id
 s2-v6mr15893674plr.84.1539588545821; 
 Mon, 15 Oct 2018 00:29:05 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d2-v6sm14651032pfj.122.2018.10.15.00.29.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Oct 2018 00:29:04 -0700 (PDT)
Subject: Re: [PATCH kernel RFC 0/3] powerpc/pseries/iommu: GPU coherent memory
 pass through
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
References: <20180725095032.2196-1-aik@ozlabs.ru>
 <f5bb1df3-1b15-9c2b-8bb1-7733bb743926@ozlabs.ru>
 <a28c139e-deb6-cdb3-1eb5-b8d6e7378ce1@ozlabs.ru>
 <cc415da6-74e9-536c-9065-5b2f0a10f5a1@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <7a7dedb5-f852-3bc0-d379-edf35846e5aa@ozlabs.ru>
Date: Mon, 15 Oct 2018 18:29:00 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cc415da6-74e9-536c-9065-5b2f0a10f5a1@ozlabs.ru>
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
Cc: kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ping?


On 17/09/2018 17:05, Alexey Kardashevskiy wrote:
> Ping?
> 
> The problem is still there...
> 
> 
> On 24/08/2018 13:04, Alexey Kardashevskiy wrote:
>>
>>
>> On 09/08/2018 14:41, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 25/07/2018 19:50, Alexey Kardashevskiy wrote:
>>>> I am trying to pass through a 3D controller:
>>>> [0302]: NVIDIA Corporation GV100GL [Tesla V100 SXM2] [10de:1db1] (rev a1)
>>>>
>>>> which has a quite unique feature as coherent memory directly accessible
>>>> from a POWER9 CPU via an NVLink2 transport.
>>>>
>>>> So in addition to passing a PCI device + accompanying NPU devices,
>>>> we will also be passing the host physical address range as it is done
>>>> on the bare metal system.
>>>>
>>>> The memory on the host is presented as:
>>>>
>>>> ===
>>>> [aik@yc02goos ~]$ lsprop /proc/device-tree/memory@42000000000
>>>> ibm,chip-id      000000fe (254)
>>>> device_type      "memory"
>>>> compatible       "ibm,coherent-device-memory"
>>>> reg              00000420 00000000 00000020 00000000
>>>> linux,usable-memory
>>>>                  00000420 00000000 00000000 00000000
>>>> phandle          00000726 (1830)
>>>> name             "memory"
>>>> ibm,associativity
>>>>                  00000004 000000fe 000000fe 000000fe 000000fe
>>>> ===
>>>>
>>>> and the host does not touch it as the second 64bit value of
>>>> "linux,usable-memory" - the size - is null. Later on the NVIDIA driver
>>>> trains the NVLink2 and probes this memory and this is how it becomes
>>>> onlined.
>>>>
>>>> In the virtual environment I am planning on doing the same thing,
>>>> however there is a difference in 64bit DMA handling. The powernv
>>>> platform uses a PHB3 bypass mode and that just works but
>>>> the pseries platform uses DDW RTAS API to achieve the same
>>>> result and the problem with this is that we need a huge DMA
>>>> window to start from zero (because this GPU supports less than
>>>> 50bits for DMA address space) and cover not just present memory
>>>> but also this new coherent memory.
>>>>
>>>>
>>>> This is based on sha1
>>>> d72e90f3 Linus Torvalds "Linux 4.18-rc6".
>>>>
>>>> Please comment. Thanks.
>>>
>>>
>>> Ping?
>>
>>
>> Ping?
>>
>>>
>>>
>>>>
>>>>
>>>>
>>>> Alexey Kardashevskiy (3):
>>>>   powerpc/pseries/iommu: Allow dynamic window to start from zero
>>>>   powerpc/pseries/iommu: Force default DMA window removal
>>>>   powerpc/pseries/iommu: Use memory@ nodes in max RAM address
>>>>     calculation
>>>>
>>>>  arch/powerpc/platforms/pseries/iommu.c | 77 ++++++++++++++++++++++++++++++----
>>>>  1 file changed, 70 insertions(+), 7 deletions(-)
>>>>
>>>
>>
> 

-- 
Alexey
