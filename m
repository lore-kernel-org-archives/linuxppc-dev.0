Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B77B1A0175
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 22:59:28 +1100 (AEDT)
Date: Thu, 3 Dec 2015 19:27:21 +0800
From: Chenhui Zhao <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v3 1/6] powerpc/mm: any thread in one core can be the
 first to setup TLB1
To: Denis Kirjanov <kda@linux-powerpc.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Message-ID: <1449142041.11289.0@remotesmtp.freescale.net>
In-Reply-To: <CAOJe8K1_S1EwfjO1qW6mBKA+ighFBKbuKCW6-Q5B_og4-NuzFg@mail.gmail.com>
References: <1448010842-22345-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOJe8K1_S1EwfjO1qW6mBKA+ighFBKbuKCW6-Q5B_og4-NuzFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wed, Dec 2, 2015 at 8:12 PM, Denis Kirjanov <kda@linux-powerpc.org> 
wrote:
> On 11/20/15, Chenhui Zhao <chenhui.zhao@freescale.com> wrote:
>>  On e6500, in the case of cpu hotplug, either thread in one core
>>  may be the first thread initilzing the TLB1. The subsequent threads
>>  must not setup it again.
>> 
>>  The code is derived from the comment of Scott Wood.
>> 
>>  Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
>>  ---
>>   arch/powerpc/include/asm/cputhreads.h | 7 +++++++
>>   arch/powerpc/mm/tlb_nohash.c          | 4 +---
>>   2 files changed, 8 insertions(+), 3 deletions(-)
>> 
>>  diff --git a/arch/powerpc/include/asm/cputhreads.h
>>  b/arch/powerpc/include/asm/cputhreads.h
>>  index ba42e46..b56cece 100644
>>  --- a/arch/powerpc/include/asm/cputhreads.h
>>  +++ b/arch/powerpc/include/asm/cputhreads.h
>>  @@ -94,6 +94,13 @@ static inline int cpu_last_thread_sibling(int 
>> cpu)
>>   	return cpu | (threads_per_core - 1);
>>   }
>> 
>>  +static inline u32 get_tensr(void)
>>  +{
>>  +	if (cpu_has_feature(CPU_FTR_SMT))
>>  +		return mfspr(SPRN_TENSR);
>>  +	else
>>  +		return 1;
>>  +}
> If i get it right, SPRN_TENSR used in the code only if CONFIG_PPC64
> is defined. Then we can make it noop on ppc32.
> 
> Thanks!

Yeah, SPRN_TENSR is defined when CONFIG_BOOKE or CONFIG_40x is enabled. 
I'd like to change the code like:

static inline u32 get_tensr(void)
{
#ifdef CONFIG_BOOKE
        if (cpu_has_feature(CPU_FTR_SMT))
                return mfspr(SPRN_TENSR);
#endif
        return 1;
}

Thanks,
Chenhui
