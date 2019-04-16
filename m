Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF1EC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 12:45:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90288205ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 12:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90288205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k4p56SLszDqLM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 22:45:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=vincenzo.frascino@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44k4lt1Dr6zDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 22:43:05 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77EEAEBD;
 Tue, 16 Apr 2019 05:43:02 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECF423F706;
 Tue, 16 Apr 2019 05:42:59 -0700 (PDT)
Subject: Re: [PATCH 1/5] arm64: Fix vDSO clock_getres()
To: Catalin Marinas <catalin.marinas@arm.com>
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
 <20190401115152.32751-2-vincenzo.frascino@arm.com>
 <20190415173521.GA901@arrakis.emea.arm.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <efaafc72-79da-b25a-78b7-36424d9350ad@arm.com>
Date: Tue, 16 Apr 2019 13:42:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415173521.GA901@arrakis.emea.arm.com>
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Catalin,

On 15/04/2019 18:35, Catalin Marinas wrote:
> On Mon, Apr 01, 2019 at 12:51:48PM +0100, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
>> index 2d419006ad43..47ba72345739 100644
>> --- a/arch/arm64/kernel/vdso.c
>> +++ b/arch/arm64/kernel/vdso.c
>> @@ -245,6 +245,8 @@ void update_vsyscall(struct timekeeper *tk)
>>  		vdso_data->cs_shift		= tk->tkr_mono.shift;
>>  	}
>>  
>> +	vdso_data->hrtimer_res			= hrtimer_resolution;
>> +
>>  	smp_wmb();
>>  	++vdso_data->tb_seq_count;
>>  }
>> diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
>> index c39872a7b03c..7a2cd2f8e13a 100644
>> --- a/arch/arm64/kernel/vdso/gettimeofday.S
>> +++ b/arch/arm64/kernel/vdso/gettimeofday.S
>> @@ -296,32 +296,35 @@ ENDPROC(__kernel_clock_gettime)
>>  /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
>>  ENTRY(__kernel_clock_getres)
>>  	.cfi_startproc
>> +	adr	vdso_data, _vdso_data
>>  	cmp	w0, #CLOCK_REALTIME
>>  	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
>>  	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
>> -	b.ne	1f
>> +	b.ne	2f
>>  
>> -	ldr	x2, 5f
>> -	b	2f
>> -1:
>> +1:	/* Get hrtimer_res */
>> +	seqcnt_acquire
>> +	syscall_check fail=5f
>> +	ldr	x2, [vdso_data, #CLOCK_REALTIME_RES]
>> +	seqcnt_check fail=1b
>> +	b	3f
>> +2:
> 
> We talked briefly but I'm still confused why we need the fallback to the
> syscall here if archdata.vdso_direct is false. Is it because if the
> timer driver code sets vdso_direct to false, we don't don't support
> highres timers? If my understanding is correct, you may want to move the
> hrtimer_res setting in update_vsyscall() to the !use_syscall block.
> 

Ok, so let me try to provide more details on what I mentioned yesterday:
- clock_getres syscall follows the rules of what defined in posix-timers.c
- based on the clock_id that, for this purpose, can be separated in coarse and
non-coarse calls either posix_get_coarse_res() or posix_get_hrtimer_res().
- if clock id is set to a coarse clock and posix_get_coarse_res() is invoked,
happens what follows:

static int posix_get_coarse_res(const clockid_t which_clock,
				struct timespec64 *tp)
{
	*tp = ktime_to_timespec64(KTIME_LOW_RES);
	return 0;
}

Note that since CONFIG_1HZ seems not supported (jiffies.h) by the kernel in this
case we do not need rounding in our vDSO implementation.

- if clock id is set to non-coarse and posix_get_hrtimer_res() is invoked,
happens the following:

static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
{
	tp->tv_sec = 0;
	tp->tv_nsec = hrtimer_resolution;
	return 0;
}

hrtimer_resolution can be high res or low res depending on the call of
hrtimer_switch_to_hres(). For us the only way to preserve the correct value is
to keep it in the vdso data page.

- The assembly code mimics exactly the same behaviour detailed above, with one
difference: the one related to the use_syscall parameter which is specific to arm64.
The use_syscall parameter is set by arm_arch_timer and consumed by
update_vsyscall(). To mirror what update_vsyscall does in update_vsyscall() I
check "syscall_check fail=5f" in clock_getres vdso function.

Said that, even if functionally it is the same thing, I think it is logically
more correct to have hrtimer_res setting inside the !use_syscall block, hence I
am going to change it in the next iteration.

Please let me know your thoughts.

-- 
Regards,
Vincenzo
