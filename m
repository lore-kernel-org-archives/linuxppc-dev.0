Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFMPK5BD8zDr5Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 20:13:25 +1000 (AEST)
Subject: Re: [PATCH] powerpc/8xx: fix single_step debug
To: Gabriel Paubert <paubert@iram.es>
References: <20160818094420.8E0991A2459@localhost.localdomain>
 <20160818095807.GA14832@visitor2.iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d371d987-aa4b-20bb-e751-6ced387d5575@c-s.fr>
Date: Thu, 18 Aug 2016 12:13:21 +0200
MIME-Version: 1.0
In-Reply-To: <20160818095807.GA14832@visitor2.iram.es>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 18/08/2016 à 11:58, Gabriel Paubert a écrit :
> On Thu, Aug 18, 2016 at 11:44:20AM +0200, Christophe Leroy wrote:
>> SPRN_ICR must be read for clearing the internal freeze signal which
>> is asserted by the single step exception, otherwise the timebase and
>> decrementer remain freezed
>
> Minor nit: s/freezed/frozen/
>
> If the timebase and decrementer are frozen even for a few cycles, this
> probably upsets timekeeping. I consider this a completely stupid design
> decision, and maybe I'm not alone.
>
>     Gabriel

We could also unset TBF bit (TimeBase Freeze enable) in TBSCR register 
(today it is set in arch/powerpc/platforms/8xx/m8xx_setup.c) but then it 
would impact debug done with an external BDM system which expects the 
decrementer and TB frozen when it freezes the execution.

Christophe


>
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/include/asm/reg_8xx.h | 1 +
>>  arch/powerpc/kernel/traps.c        | 8 ++++++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
>> index feaf641..6dae71f 100644
>> --- a/arch/powerpc/include/asm/reg_8xx.h
>> +++ b/arch/powerpc/include/asm/reg_8xx.h
>> @@ -17,6 +17,7 @@
>>  #define SPRN_DC_DAT	570	/* Read-only data register */
>>
>>  /* Misc Debug */
>> +#define SPRN_ICR	148
>>  #define SPRN_DPDR	630
>>  #define SPRN_MI_CAM	816
>>  #define SPRN_MI_RAM0	817
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index 2cb5892..0f1f0ce 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -400,8 +400,16 @@ static inline int check_io_access(struct pt_regs *regs)
>>  #define REASON_TRAP		0x20000
>>
>>  #define single_stepping(regs)	((regs)->msr & MSR_SE)
>> +#ifdef CONFIG_PPC_8xx
>> +static inline void clear_single_step(struct pt_regs *regs)
>> +{
>> +	regs->msr &= ~MSR_SE;
>> +	mfspr(SPRN_ICR);
>> +}
>> +#else
>>  #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
>>  #endif
>> +#endif
>>
>>  #if defined(CONFIG_4xx)
>>  int machine_check_4xx(struct pt_regs *regs)
>> --
>> 2.1.0
