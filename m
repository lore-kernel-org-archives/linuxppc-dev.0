Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E8D82C011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 09:51:17 +1000 (EST)
Date: Mon, 6 May 2013 18:50:57 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
To: tiejun.chen <tiejun.chen@windriver.com>
In-Reply-To: <51871FCD.9070900@windriver.com> (from
 tiejun.chen@windriver.com on Sun May  5 22:13:17 2013)
Message-ID: <1367884257.3398.9@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/05/2013 10:13:17 PM, tiejun.chen wrote:
> On 05/06/2013 11:10 AM, Tiejun Chen wrote:
>> For the external interrupt, the decrementer exception and the =20
>> doorbell
>> excpetion, we also need to soft-disable interrupts while doing as =20
>> host
>> interrupt handlers since the DO_KVM hook is always performed to skip
>> EXCEPTION_COMMON then miss this original chance with the 'ints' =20
>> (INTS_DISABLE).

http://patchwork.ozlabs.org/patch/241344/
http://patchwork.ozlabs.org/patch/241412/

:-)

>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>   arch/powerpc/kvm/bookehv_interrupts.S |    9 +++++++++
>>   1 file changed, 9 insertions(+)
>>=20
>> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S =20
>> b/arch/powerpc/kvm/bookehv_interrupts.S
>> index e8ed7d6..2fd62bf 100644
>> --- a/arch/powerpc/kvm/bookehv_interrupts.S
>> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
>> @@ -33,6 +33,8 @@
>>=20
>>   #ifdef CONFIG_64BIT
>>   #include <asm/exception-64e.h>
>> +#include <asm/hw_irq.h>
>> +#include <asm/irqflags.h>
>>   #else
>>   #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
>>   #endif
>> @@ -469,6 +471,13 @@ _GLOBAL(kvmppc_resume_host)
>>   	PPC_LL	r3, HOST_RUN(r1)
>>   	mr	r5, r14 /* intno */
>>   	mr	r14, r4 /* Save vcpu pointer. */
>> +#ifdef CONFIG_64BIT
>> +	/* Should we soft-disable interrupts? */
>> +	andi.	r6, r5, BOOKE_INTERRUPT_EXTERNAL | =20
>> BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL
>> +	beq	skip_soft_dis
>> +	SOFT_DISABLE_INTS(r7,r8)
>> +skip_soft_dis:
>> +#endif

Why wouldn't we always disable them?  kvmppc_handle_exit() will enable =20
interrupts when it's ready.

-Scott=
