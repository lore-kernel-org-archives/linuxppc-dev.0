Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BBE61A003C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 19:16:50 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 239F41401D0
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2014 19:16:49 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 27 Nov 2014 18:16:48 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C25F22BB006D
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2014 19:16:44 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAR8Gi6i39780510
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2014 19:16:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAR8GiMH016937
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2014 19:16:44 +1100
Message-ID: <5476DDE3.10705@linux.vnet.ibm.com>
Date: Thu, 27 Nov 2014 13:46:35 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [RESEND, V3] powerpc, xmon: Enable HW instruction breakpoint
 on POWER8
References: <20141126082548.34D5114017D@ozlabs.org>
In-Reply-To: <20141126082548.34D5114017D@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/26/2014 01:55 PM, Michael Ellerman wrote:
> On Tue, 2014-25-11 at 10:08:48 UTC, Anshuman Khandual wrote:
>> This patch enables support for hardware instruction breakpoints
>> on POWER8 with the help of a new register CIABR (Completed
>> Instruction Address Breakpoint Register). With this patch, single
>> hardware instruction breakpoint can be added and cleared during
>> any active xmon debug session. This hardware based instruction
>> breakpoint mechanism works correctly along with the existing TRAP
>> based instruction breakpoints available on xmon.
> 
> 
> Hi Anshuman,
> 
>> diff --git a/arch/powerpc/include/asm/xmon.h b/arch/powerpc/include/asm/xmon.h
>> index 5eb8e59..5d17aec 100644
>> --- a/arch/powerpc/include/asm/xmon.h
>> +++ b/arch/powerpc/include/asm/xmon.h
>> @@ -29,5 +29,11 @@ static inline void xmon_register_spus(struct list_head *list) { };
>>  extern int cpus_are_in_xmon(void);
>>  #endif
> 
> This file is the exported interface *of xmon*, it's not the place to put things
> that xmon needs internally.
> 
> For now just put it in xmon.c

Okay.

> 
>> +#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_SPLPAR)
>> +#include <asm/plpar_wrappers.h>
>> +#else
>> +static inline long plapr_set_ciabr(unsigned long ciabr) {return 0; };
>> +#endif
> 
> Also the ifdef is overly verbose, CONFIG_PPC_SPLPAR essentially depends on
> CONFIG_PPC_BOOK3S_64. So you can just use #ifdef CONFIG_PPC_SPLPAR.

Yeah, thats correct.

> 
>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> index b988b5a..c2f601a 100644
>> --- a/arch/powerpc/xmon/xmon.c
>> +++ b/arch/powerpc/xmon/xmon.c
>> @@ -271,6 +273,55 @@ static inline void cinval(void *p)
>>  }
>>  
>>  /*
>> + * write_ciabr
>> + *
>> + * This function writes a value to the
>> + * CIARB register either directly through
>> + * mtspr instruction if the kernel is in HV
>> + * privilege mode or call a hypervisor function
>> + * to achieve the same in case the kernel is in
>> + * supervisor privilege mode.
>> + */
> 
> I'm not really sure a function this small needs a documentation block.
> 
> But if you're going to add one, PLEASE make sure it's an actual kernel-doc
> style comment.
> 
> You can check with:
> 
> $ ./scripts/kernel-doc -text arch/powerpc/xmon/xmon.c
> 
> Which you'll notice prints:
> 
> Warning(arch/powerpc/xmon/xmon.c): no structured comments found
> 
> You need something like:
> 
> /**
>  * write_ciabr() - write the CIABR SPR
>  * @ciabr: The value to write.
>  *
>  * This function writes a value to the CIABR register either directly through
>  * mtspr instruction if the kernel is in HV privilege mode or calls a
>  * hypervisor function to achieve the same in case the kernel is in supervisor
>  * privilege mode.
>  */

Sure.

> 
> 
> 
> The rest of the patch is OK. But I was hoping you'd notice that we no longer
> support any cpus that implement CPU_FTR_IABR. And so you can just repurpose all
> the iabr logic for ciabr.

Okay.

> 
> Something like this, untested:

Yeah it is working on LPAR and also on bare metal platform as well. The new patch
will use some of your suggested code, so can I add your signed-off-by to the patch
as well ?
