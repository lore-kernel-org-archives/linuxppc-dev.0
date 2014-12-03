Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A60741A05CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 17:49:13 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 307C41400E2
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 17:49:11 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 3 Dec 2014 12:19:07 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4BA70E0045
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 12:19:30 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB36mnhE51708030
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2014 12:18:51 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB36mpNG022302
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2014 12:18:53 +0530
Message-ID: <547EB253.5050307@linux.vnet.ibm.com>
Date: Wed, 03 Dec 2014 12:18:51 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
References: <20141203052204.9DA8F1400DD@ozlabs.org>
In-Reply-To: <20141203052204.9DA8F1400DD@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 shuahkh@osg.samsung.com, oleg@redhat.com, dhowells@redhat.com,
 kirjanov@gmail.com, tglx@linutronix.de, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, davem@davemloft.net,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/03/2014 10:52 AM, Michael Ellerman wrote:
> On Tue, 2014-02-12 at 07:56:45 UTC, Anshuman Khandual wrote:
>> This patch adds four new ELF core note sections for powerpc
>> transactional memory and one new ELF core note section for
>> powerpc general miscellaneous debug registers. These addition
>> of new ELF core note sections extends the existing ELF ABI
>> without affecting it in any manner.
>>
>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  include/uapi/linux/elf.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
>> index ea9bf25..2260fc0 100644
>> --- a/include/uapi/linux/elf.h
>> +++ b/include/uapi/linux/elf.h
>> @@ -379,6 +379,11 @@ typedef struct elf64_shdr {
>>  #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
>>  #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
>>  #define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
>> +#define NT_PPC_TM_SPR	0x103		/* PowerPC TM special registers */
>> +#define NT_PPC_TM_CGPR	0x104		/* PowerpC TM checkpointed GPR */
>> +#define NT_PPC_TM_CFPR	0x105		/* PowerPC TM checkpointed FPR */
>> +#define NT_PPC_TM_CVMX	0x106		/* PowerPC TM checkpointed VMX */
>> +#define NT_PPC_MISC	0x107		/* PowerPC miscellaneous registers */
> 
> This is a really terrible name, "MISC".
> 
> Having said that, I guess it's accurate. We have a whole bunch of regs that
> have accrued over recent years that aren't accessible via ptrace.
> 
> It seems to me if we're adding a misc regset we should be adding everything we
> might want to it that is currenty architected.

But I believe they also need to be part of the thread_struct structure to be
accessible from ptrace.
 
> 
> But currently you only include the PPR, TAR & DSCR.

Yeah, thats what we started with.

> 
> Looking at Power ISA v2.07, I see the following that could be included:
> 
>   MMCR2
>   MMCRA
>   PMC1
>   PMC2
>   PMC3
>   PMC4
>   PMC5
>   PMC6
>   MMCR0
>   EBBHR
>   EBBRR
>   BESCR
>   SIAR
>   SDAR
>   CFAR?

MMCRA, PMC[1..6], EBBHR, BESCR, EBBRR, CFAR are not part of the thread struct.

> 
> Those are all new in 2.07 except for CFAR.
> 
> There might be more I missed, that was just a quick scan.
> 
> Some are only accessible when EBB is in use, maybe those could be a separate
> regset.

Yeah we can have one more regset for EBB specific registers.
