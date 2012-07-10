Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 011A62C0357
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 18:26:42 +1000 (EST)
Message-ID: <4FFBE659.10804@windriver.com>
Date: Tue, 10 Jul 2012 16:22:49 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] powerpc: add "memory" attribute for mfmsr()
References: <1341907153-20516-1-git-send-email-tiejun.chen@windriver.com>
 <1341908398.2561.15.camel@pasglop>
In-Reply-To: <1341908398.2561.15.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2012 04:19 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2012-07-10 at 15:59 +0800, Tiejun Chen wrote:
>> Add "memory" attribute in inline assembly language as a compiler
>> barrier to make sure 4.6.x GCC don't reorder mfmsr().
> 
> Out of curiosity, did you see a case where it was re-ordered
> improperly ?

Yes.

In my scenario, there's one simple wrapper from local_irq_save().
------
uint32_t XX_DisableAllIntr(void)
{
    unsigned long flags;

    local_irq_save(flags);

    return (uint32_t)flags;
}

When CONFIG_TRACE_IRQFLAGS_SUPPORT is enabled, kernel would expand
local_irq_save(). Firstly, please refer to the follows:

#define local_irq_save(flags)               \
    do {                        \
        raw_local_irq_save(flags);      \
        trace_hardirqs_off();           \
    } while (0)

#define raw_local_irq_save(flags)           \
    do {                        \
        typecheck(unsigned long, flags);    \
        flags = arch_local_irq_save();      \
    } while (0)

static inline unsigned long arch_local_irq_save(void)
{
    unsigned long flags = arch_local_save_flags();
#ifdef CONFIG_BOOKE
    asm volatile("wrteei 0" : : : "memory");
#else
    SET_MSR_EE(flags & ~MSR_EE);
#endif
    return flags;
}

static inline unsigned long arch_local_save_flags(void)
{
    return mfmsr();
}

So local_irq_save(flags) is extended as something like:

{
	#1 flags = mfmsr();
	#2 asm volatile("wrteei 0" : : : "memory");
	#3 trace_hardirqs_off();
}

But build kernel with our 5.0 toolchain (with/without
--with-toolchain-dir=wr-toolchain),

(gdb) disassemble XX_DisableAllIntr
Dump of assembler code for function XX_DisableAllIntr:
   0xc04550c0 <+0>:	mflr    r0
   0xc04550c4 <+4>:	stw     r0,4(r1)
   0xc04550c8 <+8>:	bl      0xc000f060 <mcount>
   0xc04550cc <+12>:	stwu    r1,-16(r1)
   0xc04550d0 <+16>:	mflr    r0
   0xc04550d4 <+20>:	stw     r0,20(r1)
   0xc04550d8 <+24>:	wrteei  0
   0xc04550dc <+28>:	bl      0xc00c6c10 <trace_hardirqs_off>
   0xc04550e0 <+32>:	mfmsr   r3
   0xc04550e4 <+36>:	lwz     r0,20(r1)
   0xc04550e8 <+40>:	mtlr    r0
   0xc04550ec <+44>:	addi    r1,r1,16
   0xc04550f0 <+48>:	blr
End of assembler dump.

You should notice #2 and #3 is reorganized before #1. This means irq is always
disabled before we check irq status via reading msr. Then kernel would work as
abnormal sometimes.

But with old toolchain (4.5.x) for this same kernel, everything is fine.

Tiejun

> 
> Cheers,
> Ben.
> 
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>  arch/powerpc/include/asm/reg.h |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> index 559da19..578e5a0 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -1016,7 +1016,8 @@
>>  /* Macros for setting and retrieving special purpose registers */
>>  #ifndef __ASSEMBLY__
>>  #define mfmsr()		({unsigned long rval; \
>> -			asm volatile("mfmsr %0" : "=r" (rval)); rval;})
>> +			asm volatile("mfmsr %0" : "=r" (rval) : \
>> +						: "memory"); rval;})
>>  #ifdef CONFIG_PPC_BOOK3S_64
>>  #define __mtmsrd(v, l)	asm volatile("mtmsrd %0," __stringify(l) \
>>  				     : : "r" (v) : "memory")
> 
> 
> 
> 
