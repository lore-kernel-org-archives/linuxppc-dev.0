Return-Path: <linuxppc-dev+bounces-23581-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0767AC43602
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 02:41:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtpXD17nqz3bps;
	Mon, 06 Jul 2026 12:41:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783305692;
	cv=none; b=IKpP9jFPiioHeSY4D7k/5NMhwXV1bJJlxp6+I8c5p8pNpctC4Tmqn+am1+6Z4vKseLfq2H2kg0zxNMvdzMSKmaFYGppSBwidjR/9bqsabcNy9khOZUHfa8Gxq0A3QoJjodrL2kIyvhSmTItjWcFFXyvYkpHxhj03KY4B+6Y2ojM3Bqy18rPKtSf7CG8d2DbZpkQMaDbZUIgM9qqYqyJwdVpkOqceqmjyHJrmX6mbHHOBPLiYP/nWNdHzc2H8uc8F1q2D7WAUPfkbhvgcnjmgxmINH/TuTV8PxbdvzyKeUA6nufNghSsm0n3o9+oFsYNgAFp1OkeY1kELIA7a51G6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783305692; c=relaxed/relaxed;
	bh=tLzU64zcWCpCqtKqdJfi72+8jOLqHwm6rAX9TlEnpBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iWIJEJP27PlVYpF8xHfuEjRvheTrUk8kG+n66ImafGzbzlFNzH/Mkd71QRBHy08ZJ16CmMxqEkAX0mdFCqtTzPR4oThToNhodD83srd/skzxb3lSTLgRSAsVV6o/bKvX/1804RtIreq0iILqjgqtyrEuagzIWAtxNG1050QqjBOsOFW0/bYz6p2s91JKG88z/exLia9d9nq70ka9X0TAYGT3m16YU0TwNZuy5cMFVNJpm81eYOkP0BkwF9VvIcyEY16wjrj9yJh5XD+cXoDkWdsyTMeG9+jz8T13EaCzVZAfS3Niz/fpMw99eyQ/sBaF/jZyLnEPMNQWbSqornJ+9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6kW0tTks; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6kW0tTks;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtpX93GRsz3bp7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 12:41:28 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tLzU64zcWCpCqtKqdJfi72+8jOLqHwm6rAX9TlEnpBE=;
	b=6kW0tTks7I4JJHDfBVjF8dEaDL2J766PtNvpdA6LbQQFpMfTqMznvyBNQeh9wxbc/IYSzn3ZU
	f2djYQecToR3moTosPPfqQapkuoiHKQieMFK0sbmqWZPM62GXgOZ9REO2UonKr5TBLANxucel3h
	3onSIAA/PUlP2PaW4QIuLbU=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gtpL20K7Pz12LHv;
	Mon,  6 Jul 2026 10:32:42 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 836134057A;
	Mon,  6 Jul 2026 10:41:22 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jul 2026 10:41:17 +0800
Message-ID: <e53b3d1f-c9fe-428c-bf1c-6505b3bcb894@huawei.com>
Date: Mon, 6 Jul 2026 10:41:16 +0800
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to return
 boolean
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>
CC: <oleg@redhat.com>, <richard.henderson@linaro.org>, <mattst88@gmail.com>,
	<linmag7@gmail.com>, <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kees@kernel.org>, <guoren@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <geert@linux-m68k.org>,
	<tsbogend@alpha.franken.de>, <James.Bottomley@HansenPartnership.com>,
	<deller@gmx.de>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<luto@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <chris@zankel.net>,
	<jcmvbkbc@gmail.com>, <peterz@infradead.org>, <wad@chromium.org>,
	<thuth@redhat.com>, <mark.rutland@arm.com>, <kevin.brodsky@arm.com>,
	<linusw@kernel.org>, <yeoreum.yun@arm.com>, <song@kernel.org>,
	<james.morse@arm.com>, <anshuman.khandual@arm.com>, <broonie@kernel.org>,
	<liqiang01@kylinos.cn>, <pengcan@kylinos.cn>, <ryan.roberts@arm.com>,
	<yangtiezhu@loongson.cn>, <sshegde@linux.ibm.com>, <mchauras@linux.ibm.com>,
	<austin.kim@lge.com>, <jchrist@linux.ibm.com>, <arnd@arndb.de>,
	<thomas.weissschuh@linutronix.de>, <sohil.mehta@intel.com>,
	<andrew.cooper3@citrix.com>, <jgross@suse.com>, <kas@kernel.org>,
	<x86@kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-csky@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-um@lists.infradead.org>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
 <b8f3b5cd-8d8a-4396-ba0c-011a83234dd9@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <b8f3b5cd-8d8a-4396-ba0c-011a83234dd9@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/1/2026 12:37 AM, Ada Couprie Diaz wrote:
> Hi Jinjie,
> 
> On 29/06/2026 14:05, Jinjie Ruan wrote:
>> The return value of __secure_computing() currently uses 0 to indicate
>> that a system call should be allowed, and -1 to indicate that it should
>> be blocked/killed. This 0/-1 pattern is non-intuitive for a security
>> check function and makes the control flow at the call sites less
>> readable.
>>
>> Furthermore, any potential future changes to these return values would
>> require a high-risk, error-prone audit of all its users across different
>> architectures.
>>
>> Sanitize this logic by converting the return type of __secure_computing()
>> to a proper boolean, where 'true' explicitly means 'allow' and 'false'
>> means 'fail/deny'.
>>
>> Update all the two dozen or so call sites across the tree to align with
>> this new boolean semantic. No functional changes are intended, as the
>> callers still return -1 to the lower-level assembly entry code upon
>> seccomp denial.
> Would it be relevant to mention that this fixes the unsound return value of
> `syscall_trace_enter()` in generic entry, which motivated the patch
> initially[0] ?

That's a very good point. It's definitely worth mentioning

>> Suggested-by: Thomas Gleixner <tglx@kernel.org>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   arch/alpha/kernel/ptrace.c            |  2 +-
>>   arch/arm/kernel/ptrace.c              |  2 +-
>>   arch/arm64/kernel/ptrace.c            |  2 +-
>>   arch/csky/kernel/ptrace.c             |  2 +-
>>   arch/m68k/kernel/ptrace.c             |  2 +-
>>   arch/mips/kernel/ptrace.c             |  2 +-
>>   arch/parisc/kernel/ptrace.c           |  2 +-
>>   arch/sh/kernel/ptrace_32.c            |  2 +-
>>   arch/um/kernel/skas/syscall.c         |  2 +-
>>   arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
>>   arch/xtensa/kernel/ptrace.c           |  3 +--
>>   include/linux/entry-common.h          |  7 +++---
>>   include/linux/seccomp.h               | 10 ++++----
>>   kernel/seccomp.c                      | 34 +++++++++++++--------------
>>   14 files changed, 36 insertions(+), 38 deletions(-)
> 
> This is missing an update to the Kconfig documentation, a possible
> suggestion :

Will update it.

> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index fa7507ac8e13..9e3d40088afb 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -637,7 +637,7 @@ config HAVE_ARCH_SECCOMP_FILTER
>           - syscall_set_return_value()
>           - SIGSYS siginfo_t support
>           - secure_computing is called from a ptrace_event()-safe context
> -         - secure_computing return value is checked and a return value
> of -1
> +         - secure_computing return value is checked and if false
>             results in the system call being skipped immediately.
>           - seccomp syscall wired up
>           - if !HAVE_SPARSE_SYSCALL_NR, have SECCOMP_ARCH_NATIVE,
> 
>> [...]
>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>> index 416a3352261f..3f66320e46d3 100644
>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -100,9 +100,8 @@ static __always_inline long
>> syscall_trace_enter(struct pt_regs *regs, unsigned l
>>         /* Do seccomp after ptrace, to catch any tracer changes. */
>>       if (work & SYSCALL_WORK_SECCOMP) {
>> -        ret = __secure_computing();
>> -        if (ret == -1L)
>> -            return ret;
>> +        if (!__secure_computing())
>> +            return -1L;
>>       }
>>         /* Either of the above might have changed the syscall number */
>> @@ -113,7 +112,7 @@ static __always_inline long
>> syscall_trace_enter(struct pt_regs *regs, unsigned l
>>         syscall_enter_audit(regs, syscall);
>>   -    return ret ? : syscall;
>> +    return syscall;
>>   }
>> [...]
> 
> Otherwise this feels like a more appropriate change with regards to
> "safeguarding against new `secure_computing()` return value" !
> 
> With the updated Kconfig :
> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> 
> Thanks,
> Ada
> 
> [0]: https://lore.kernel.org/r/20260511092103.1974980-2-
> ruanjinjie@huawei.com
> 
> 


