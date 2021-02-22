Return-Path: <SRS0=5SgM=HY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F40C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Feb 2021 01:36:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5036564EC8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Feb 2021 01:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5036564EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DkPsn4Lrrz3cJ3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Feb 2021 12:36:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Qq4J4yH6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=Qq4J4yH6; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DkPsH71L5z30LH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2021 12:36:03 +1100 (AEDT)
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id D759320B57A0;
 Sun, 21 Feb 2021 17:35:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D759320B57A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1613957760;
 bh=ExCdsyPkQI85bgvWno/UIC3VrrC79Ve3YTXOyYnfvYU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Qq4J4yH6UugpeNQ3CD/H/jYSDYubKgYDrULJm5MSRGGMy4pVUF3ZhkkpFDiz4UKpC
 Fbe9plxzMLfQUkOqW20+R5R0Fp3HF31QA9jJO+T4Drq2NGRAd0AXMWGRuiHddmF4lc
 s/bgSL36U18cNAWtIPD4IoDQS7mWtllOclFbv2tE=
Subject: Re: [PATCH v18 03/11] of: Add a common kexec FDT setup function
To: Guenter Roeck <linux@roeck-us.net>
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
 <20210213161049.6190-4-nramas@linux.microsoft.com>
 <20210222013207.GA142216@roeck-us.net>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b4237414-24ec-f905-2561-6237081ea7ff@linux.microsoft.com>
Date: Sun, 21 Feb 2021 17:35:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222013207.GA142216@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: mark.rutland@arm.com, tao.li@vivo.com, zohar@linux.ibm.com,
 paulus@samba.org, vincenzo.frascino@arm.com, frowand.list@gmail.com,
 sashal@kernel.org, robh@kernel.org, masahiroy@kernel.org, jmorris@namei.org,
 takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, serge@hallyn.com, devicetree@vger.kernel.org,
 pasha.tatashin@soleen.com, will@kernel.org, prsriva@linux.microsoft.com,
 hsinyi@chromium.org, allison@lohutok.net, christophe.leroy@c-s.fr,
 mbrugger@suse.com, balajib@linux.microsoft.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, james.morse@arm.com, dmitry.kasatkin@gmail.com,
 joe@perches.com, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/21/21 5:32 PM, Guenter Roeck wrote:

Hi Guenter,

> On Sat, Feb 13, 2021 at 08:10:41AM -0800, Lakshmi Ramasubramanian wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> Both arm64 and powerpc do essentially the same FDT /chosen setup for
>> kexec.  The differences are either omissions that arm64 should have
>> or additional properties that will be ignored.  The setup code can be
>> combined and shared by both powerpc and arm64.
>>
>> The differences relative to the arm64 version:
>>   - If /chosen doesn't exist, it will be created (should never happen).
>>   - Any old dtb and initrd reserved memory will be released.
>>   - The new initrd and elfcorehdr are marked reserved.
>>   - "linux,booted-from-kexec" is set.
>>
>> The differences relative to the powerpc version:
>>   - "kaslr-seed" and "rng-seed" may be set.
>>   - "linux,elfcorehdr" is set.
>>   - Any existing "linux,usable-memory-range" is removed.
>>
>> Combine the code for setting up the /chosen node in the FDT and updating
>> the memory reservation for kexec, for powerpc and arm64, in
>> of_kexec_alloc_and_setup_fdt() and move it to "drivers/of/kexec.c".
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> s390:allmodconfig:
> 
> drivers/of/kexec.c: In function 'of_kexec_alloc_and_setup_fdt':
> drivers/of/kexec.c:378:10: error: 'const struct kimage' has no member named 'arch'
>    378 |     image->arch.elf_load_addr,
>        |          ^~
> drivers/of/kexec.c:379:10: error: 'const struct kimage' has no member named 'arch'
>    379 |     image->arch.elf_headers_sz);
>        |          ^~
> drivers/of/kexec.c:387:35: error: 'const struct kimage' has no member named 'arch'
>    387 |   ret = fdt_add_mem_rsv(fdt, image->arch.elf_load_addr,
>        |                                   ^~
> drivers/of/kexec.c:388:16: error: 'const struct kimage' has no member named 'arch'
>    388 |           image->arch.elf_headers_sz);
>        |                ^~
> 

I have posted a new patch set (link given below) that fixes the above 
build break. Could you please try that?

https://patchwork.kernel.org/project/linux-integrity/patch/20210221174930.27324-14-nramas@linux.microsoft.com/

thanks,
  -lakshmi

