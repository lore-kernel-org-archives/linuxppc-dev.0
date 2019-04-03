Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1628C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 14:28:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD5C2082C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 14:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD5C2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z7jQ0c11zDqP0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 01:28:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=vincenzo.frascino@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44Z7Y81hbjzDqLx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 01:21:15 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7956AA78;
 Wed,  3 Apr 2019 07:21:14 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2033F68F;
 Wed,  3 Apr 2019 07:21:11 -0700 (PDT)
Subject: Re: [PATCH 3/5] s390: Fix vDSO clock_getres()
To: Thomas Gleixner <tglx@linutronix.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
 <20190401115152.32751-4-vincenzo.frascino@arm.com>
 <20190403113844.334a32d9@mschwideX1>
 <alpine.DEB.2.21.1904031205460.1967@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9121e8d2-65d2-2b96-1b69-0047d62dc308@arm.com>
Date: Wed, 3 Apr 2019 15:21:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904031205460.1967@nanos.tec.linutronix.de>
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
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, Vincent Chen <deanbo422@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Greentime Hu <green.hu@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 03/04/2019 11:06, Thomas Gleixner wrote:
> On Wed, 3 Apr 2019, Martin Schwidefsky wrote:
> 
>> On Mon,  1 Apr 2019 12:51:50 +0100
>> Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
>>
>>> clock_getres in the vDSO library has to preserve the same behaviour
>>> of posix_get_hrtimer_res().
>>>
>>> In particular, posix_get_hrtimer_res() does:
>>>     sec = 0;
>>>     ns = hrtimer_resolution;
>>> and hrtimer_resolution depends on the enablement of the high
>>> resolution timers that can happen either at compile or at run time.
>>>
>>> Fix the s390 vdso implementation of clock_getres keeping a copy of
>>> hrtimer_resolution in vdso data and using that directly.
>>>
>>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>> ---
>>>  arch/s390/include/asm/vdso.h           |  1 +
>>>  arch/s390/kernel/asm-offsets.c         |  2 +-
>>>  arch/s390/kernel/time.c                |  1 +
>>>  arch/s390/kernel/vdso32/clock_getres.S | 17 ++++++++++++-----
>>>  arch/s390/kernel/vdso64/clock_getres.S | 15 ++++++++++-----
>>>  5 files changed, 25 insertions(+), 11 deletions(-)
>>
>> I tried this patch and in principle this works. In that regard
>> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>
>> But I wonder if the loop to check the update counter is really
>> necessary. The hrtimer_resolution value can only changes once with
>> the first call to hrtimer_switch_to_hres(). With the TOD clock
>> as the only clock available on s390 we always have the ability
>> to do hrtimer. It then all depends on the highres=[on|off] kernel
>> parameter what value we get with clock_getres().
> 
> Yes, it's not changing after boot anymore.
> 
> Thanks,
> 
> 	tglx
> 

Ok, I will remove the loop from both the implementations and post it with v2.

-- 
Regards,
Vincenzo
