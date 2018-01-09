Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGH6L1LXhzF0gG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 03:05:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 peterz@infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 npiggin@gmail.com, Oliver O'Halloran <oohall@gmail.com>,
 Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 07/11] powerpc/64s: Add support for RFI flush of L1-D cache
In-Reply-To: <CACPK8XfOyB8t+d9ALr38=akc9BKuxeA-b4jU5FqYPGPzGX4qjw@mail.gmail.com>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-7-mpe@ellerman.id.au>
 <CACPK8XfOyB8t+d9ALr38=akc9BKuxeA-b4jU5FqYPGPzGX4qjw@mail.gmail.com>
Date: Wed, 10 Jan 2018 03:05:11 +1100
Message-ID: <87efmzkog8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joel Stanley <joel@jms.id.au> writes:

> On Mon, Jan 8, 2018 at 8:54 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> On some CPUs we can prevent the Meltdown vulnerability by flushing the
>> L1-D cache on exit from kernel to user mode, and from hypervisor to
>> guest.
>
> Super minor nitpicks below. Don't let this hold up your work.
>
>> --- a/arch/powerpc/kernel/exceptions-64s.S
>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>> @@ -1449,6 +1449,88 @@ masked_##_H##interrupt:                                  \
>>         b       .;                                      \
>>         MASKED_DEC_HANDLER(_H)
>>
>> +TRAMP_REAL_BEGIN(rfi_flush_fallback)
>> +       SET_SCRATCH0(r13);
>> +       GET_PACA(r13);
>> +       std     r9,PACA_EXRFI+EX_R9(r13)
>> +       std     r10,PACA_EXRFI+EX_R10(r13)
>> +       std     r11,PACA_EXRFI+EX_R11(r13)
>> +       std     r12,PACA_EXRFI+EX_R12(r13)
>> +       std     r8,PACA_EXRFI+EX_R13(r13)
>> +       mfctr   r9
>> +       ld      r10,PACA_RFI_FLUSH_FALLBACK_AREA(r13)
>> +       ld      r11,PACA_L1D_FLUSH_SETS(r13)
>> +       ld      r12,PACA_L1D_FLUSH_CONGRUENCE(r13)
>> +       /*
>> +        * The load adresses are at staggered offsets within cachelines,
>> +        * which suits some pipelines better (on others it should not
>> +        * hurt.
>
> Nit: missing ) on the last line.

Thanks.

>> --- a/arch/powerpc/lib/feature-fixups.c
>> +++ b/arch/powerpc/lib/feature-fixups.c
>> @@ -116,6 +116,47 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
>>         }
>>  }
>>
>> +#ifdef CONFIG_PPC_BOOK3S_64
>> +void do_rfi_flush_fixups(enum l1d_flush_type types)
>> +{
>> +       unsigned int instrs[3], *dest;
>> +       long *start, *end;
>> +       int i;
>> +
>> +       start = PTRRELOC(&__start___rfi_flush_fixup),
>> +       end = PTRRELOC(&__stop___rfi_flush_fixup);
>> +
>> +       instrs[0] = 0x60000000; /* nop */
>> +       instrs[1] = 0x60000000; /* nop */
>> +       instrs[2] = 0x60000000; /* nop */
>> +
>> +       if (types & L1D_FLUSH_FALLBACK)
>
> This looked a bit confusing on first read. Do we ever get
> L1D_FLUSH_FALLBACK and the other types? If not, could it be made
> clearer?
>
>   if ( types & L1D_FLUSH_FALLBACK)
>       /* stuff */
>   else
>     /* other types */

Yeah that would make more sense.

I'm going to merge it as-is because that's whats been tested, and given
the time of day I'm likely to break it if I try and refactor it. So we
can clean it up once it's merged.

cheers
