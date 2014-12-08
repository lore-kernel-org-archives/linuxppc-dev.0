Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A7781A05DA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 21:08:54 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BD0FA1400A0
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 21:08:53 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 8 Dec 2014 15:38:50 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 23E0CE0058
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 15:39:20 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB8AArne62456024
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2014 15:40:54 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB8A8ggv032411
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2014 15:38:44 +0530
Message-ID: <548578A8.5020901@linux.vnet.ibm.com>
Date: Mon, 08 Dec 2014 15:38:40 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <547EB253.5050307@linux.vnet.ibm.com>
In-Reply-To: <547EB253.5050307@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, shuahkh@osg.samsung.com, oleg@redhat.com,
 dhowells@redhat.com, kirjanov@gmail.com, davej@redhat.com, tglx@linutronix.de,
 sukadev@linux.vnet.ibm.com, akpm@linux-foundation.org, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/03/2014 12:18 PM, Anshuman Khandual wrote:
> On 12/03/2014 10:52 AM, Michael Ellerman wrote:
>> On Tue, 2014-02-12 at 07:56:45 UTC, Anshuman Khandual wrote:
>>> This patch adds four new ELF core note sections for powerpc
>>> transactional memory and one new ELF core note section for
>>> powerpc general miscellaneous debug registers. These addition
>>> of new ELF core note sections extends the existing ELF ABI
>>> without affecting it in any manner.
>>>
>>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>> ---
>>>  include/uapi/linux/elf.h | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
>>> index ea9bf25..2260fc0 100644
>>> --- a/include/uapi/linux/elf.h
>>> +++ b/include/uapi/linux/elf.h
>>> @@ -379,6 +379,11 @@ typedef struct elf64_shdr {
>>>  #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
>>>  #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
>>>  #define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
>>> +#define NT_PPC_TM_SPR	0x103		/* PowerPC TM special registers */
>>> +#define NT_PPC_TM_CGPR	0x104		/* PowerpC TM checkpointed GPR */
>>> +#define NT_PPC_TM_CFPR	0x105		/* PowerPC TM checkpointed FPR */
>>> +#define NT_PPC_TM_CVMX	0x106		/* PowerPC TM checkpointed VMX */
>>> +#define NT_PPC_MISC	0x107		/* PowerPC miscellaneous registers */
>>
>> This is a really terrible name, "MISC".
>>
>> Having said that, I guess it's accurate. We have a whole bunch of regs that
>> have accrued over recent years that aren't accessible via ptrace.
>>
>> It seems to me if we're adding a misc regset we should be adding everything we
>> might want to it that is currenty architected.
> 
> But I believe they also need to be part of the thread_struct structure to be
> accessible from ptrace.

Currently we dont context save/restore the PMC count registers (PMC1-PMC6)
during the process context switch. So the values of PMC1..PMC6 are not
thread specific in the structure. To be able to access them in ptrace
when the tracee has stopped, we need to context save these counters
in the thread struct. Shall we do that ? Then we can add them to the
MISC regset bucket irrespective of whats the value we get in there when
we probe through ptrace.

The same goes for MMCRA, CFAR registers as well.

>  
>>
>> But currently you only include the PPR, TAR & DSCR.
> 
> Yeah, thats what we started with.
> 
>>
>> Looking at Power ISA v2.07, I see the following that could be included:
>>
>>   MMCR2
>>   MMCRA
>>   PMC1
>>   PMC2
>>   PMC3
>>   PMC4
>>   PMC5
>>   PMC6
>>   MMCR0
>>   EBBHR
>>   EBBRR
>>   BESCR
>>   SIAR
>>   SDAR
>>   CFAR?
> 
> MMCRA, PMC[1..6], EBBHR, BESCR, EBBRR, CFAR are not part of the thread struct.

Sorry. EBBRR, EBBHR, BESCR registers are part of the thread struct.

> 
>>
>> Those are all new in 2.07 except for CFAR.
>>
>> There might be more I missed, that was just a quick scan.
>>
>> Some are only accessible when EBB is in use, maybe those could be a separate
>> regset.
> 
> Yeah we can have one more regset for EBB specific registers.

Should the new EBB specific regset include only EBBRR, EBBHR, BESCR registers
or should it also include SIAR, SDAR, SIER, MMCR0, MMCR2 registers as well. I
was thinking about putting these five registers into the MISC bucket instead.
But from the perf code, it looks like these five registers are also related to
the EBB context as well.

Some clarity on these points would really help.
