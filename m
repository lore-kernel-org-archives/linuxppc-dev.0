Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A291EC10F00
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 09:04:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E9C207E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 09:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E9C207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YNYb2Tp5zDqMp
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=vincenzo.frascino@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44YNW35yyXzDqP0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 20:01:51 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 515C980D;
 Tue,  2 Apr 2019 02:01:50 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3E233F690;
 Tue,  2 Apr 2019 02:01:47 -0700 (PDT)
Subject: Re: [PATCH 2/5] powerpc: Fix vDSO clock_getres()
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
 <20190401115152.32751-3-vincenzo.frascino@arm.com>
 <5a76f55d-eb0d-fb49-8e59-f0e89e561f7b@c-s.fr>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f8206e04-79d2-87e7-0cf0-04d099b3ad40@arm.com>
Date: Tue, 2 Apr 2019 10:01:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5a76f55d-eb0d-fb49-8e59-f0e89e561f7b@c-s.fr>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 02/04/2019 07:14, Christophe Leroy wrote:
> 
> 
> On 04/01/2019 11:51 AM, Vincenzo Frascino wrote:
>> clock_getres in the vDSO library has to preserve the same behaviour
>> of posix_get_hrtimer_res().
>>
>> In particular, posix_get_hrtimer_res() does:
>>      sec = 0;
>>      ns = hrtimer_resolution;
>> and hrtimer_resolution depends on the enablement of the high
>> resolution timers that can happen either at compile or at run time.
>>
>> Fix the powerpc vdso implementation of clock_getres keeping a copy of
>> hrtimer_resolution in vdso data and using that directly.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>   arch/powerpc/include/asm/vdso_datapage.h  |  2 ++
>>   arch/powerpc/kernel/asm-offsets.c         |  2 +-
>>   arch/powerpc/kernel/time.c                |  1 +
>>   arch/powerpc/kernel/vdso32/gettimeofday.S | 22 +++++++++++++++-------
>>   arch/powerpc/kernel/vdso64/gettimeofday.S | 22 +++++++++++++++-------
>>   5 files changed, 34 insertions(+), 15 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
>> index 1e0bc5955a40..b21630079496 100644
>> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
>> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
>> @@ -160,14 +160,21 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
>>   	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
>>   	bne	cr0,99f
>>   
>> -	li	r3,0
>> -	cmpli	cr0,r4,0
>> +	mflr	r12
>> +  .cfi_register lr,r12
>> +	mr	r11,r4
>> +	bl	__get_datapage@local
>> +	lwz	r5,CLOCK_REALTIME_RES(r3)
>> +	li	r4,0
>> +	cmplwi	r11,0		/* check if res is NULL */
>> +	beq	1f
>> +
>> +	stw	r4,TSPC32_TV_SEC(r11)
>> +	stw	r5,TSPC32_TV_NSEC(r11)
>> +
>> +1:	mtlr	r12
>>   	crclr	cr0*4+so
>> -	beqlr
>> -	lis	r5,CLOCK_REALTIME_RES@h
>> -	ori	r5,r5,CLOCK_REALTIME_RES@l
>> -	stw	r3,TSPC32_TV_SEC(r4)
>> -	stw	r5,TSPC32_TV_NSEC(r4)
>> +	li	r3,0
>>   	blr
> 
> The above can be done simpler, see below
> 
> @@ -160,12 +160,15 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
>   	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
>   	bne	cr0,99f
> 
> +	mflr	r12
> +  .cfi_register lr,r12
> +	bl	__get_datapage@local
> +	lwz	r5,CLOCK_REALTIME_RES(r3)
> +	mtlr	r12
>   	li	r3,0
>   	cmpli	cr0,r4,0
>   	crclr	cr0*4+so
>   	beqlr
> -	lis	r5,CLOCK_REALTIME_RES@h
> -	ori	r5,r5,CLOCK_REALTIME_RES@l
>   	stw	r3,TSPC32_TV_SEC(r4)
>   	stw	r5,TSPC32_TV_NSEC(r4)
>   	blr
> 

Thank you for this, I will update my code accordingly before posting v2.

> Christophe
> 
>>   
>>   	/*
>> @@ -175,6 +182,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
>>   	 */
>>   99:
>>   	li	r0,__NR_clock_getres
>> +  .cfi_restore lr
>>   	sc
>>   	blr
>>     .cfi_endproc
>> diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
>> index a4ed9edfd5f0..a7e49bddd475 100644
>> --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
>> +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
>> @@ -190,14 +190,21 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
>>   	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
>>   	bne	cr0,99f
>>   
>> -	li	r3,0
>> -	cmpldi	cr0,r4,0
>> +	mflr	r12
>> +  .cfi_register lr,r12
>> +	mr	r11, r4
>> +	bl	V_LOCAL_FUNC(__get_datapage)
>> +	lwz	r5,CLOCK_REALTIME_RES(r3)
>> +	li	r4,0
>> +	cmpldi	r11,0		/* check if res is NULL */
>> +	beq	1f
>> +
>> +	std	r4,TSPC64_TV_SEC(r11)
>> +	std	r5,TSPC64_TV_NSEC(r11)
>> +
>> +1:	mtlr	r12
>>   	crclr	cr0*4+so
>> -	beqlr
>> -	lis	r5,CLOCK_REALTIME_RES@h
>> -	ori	r5,r5,CLOCK_REALTIME_RES@l
>> -	std	r3,TSPC64_TV_SEC(r4)
>> -	std	r5,TSPC64_TV_NSEC(r4)
>> +	li	r3,0
>>   	blr
> 
> The same type of simplification applies here too.
> 
> Christophe
> 
> 
>>   
>>   	/*
>> @@ -205,6 +212,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
>>   	 */
>>   99:
>>   	li	r0,__NR_clock_getres
>> +  .cfi_restore lr
>>   	sc
>>   	blr
>>     .cfi_endproc
>>

-- 
Regards,
Vincenzo
