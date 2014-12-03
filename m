Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 995791A09D5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 01:50:03 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 00:50:03 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E7C1D2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 01:50:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB3Eo0jG31850656
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 01:50:00 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB3Enxeq003201
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 01:50:00 +1100
Message-ID: <547F230A.3030303@linux.vnet.ibm.com>
Date: Wed, 03 Dec 2014 20:19:46 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 1/2]powerpc: foundation code to handle CR5 for local_t
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
 <1417485890.15957.205.camel@freescale.com>
In-Reply-To: <1417485890.15957.205.camel@freescale.com>
Content-Type: text/plain; charset=utf-8
Cc: rusty@rustcorp.com.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 02 December 2014 07:34 AM, Scott Wood wrote:
> On Thu, 2014-11-27 at 17:48 +0530, Madhavan Srinivasan wrote:
>> - I really appreciate feedback on the patchset.
>> - Kindly comment if I should try with any other benchmark or
>>     workload to check the numbers.
>> - Also, kindly recommand any know stress test for CR
>>
>>  Makefile                                 |   6 ++
>>  arch/powerpc/include/asm/exception-64s.h |  21 +++++-
>>  arch/powerpc/kernel/entry_64.S           | 106 ++++++++++++++++++++++++++++++-
>>  arch/powerpc/kernel/exceptions-64s.S     |   2 +-
>>  arch/powerpc/kernel/head_64.S            |   8 +++
>>  5 files changed, 138 insertions(+), 5 deletions(-)
> 
> Patch 2/2 enables this for all PPC64, not just book3s -- so please don't
> forget about the book3e exception paths (also MSR[GS] for KVM, but
> aren't most if not all the places you're checking for HV mode after KVM
> would have taken control?  Or am I missing something about how book3s
> KVM works?).
> 
> Or, if you don't want to do that, change patch 2/2 to be book3s only and
> ifdef-protect the changes to common exception code.
> 

Still learning the interrupt path and various configs. Was assuming
PPC64 is for server side. My bad. Will change the it to book3s and also
to common code.

>> @@ -224,8 +243,26 @@ syscall_exit:
>>  BEGIN_FTR_SECTION
>>  	stdcx.	r0,0,r1			/* to clear the reservation */
>>  END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
>> +BEGIN_FTR_SECTION
>> +	lis	r4,4096
>> +	rldicr	r4,r4,32,31
>> +	mr	r6,r4
>> +	ori	r4,r4,16384
>> +	and	r4,r8,r4
>> +	cmpd	cr3,r6,r4
>> +	beq	cr3,65f
>> +	mtcr	r5
>> +FTR_SECTION_ELSE
>>  	andi.	r6,r8,MSR_PR
>> -	ld	r4,_LINK(r1)
>> +	beq	65f
>> +	mtcr	r5
>> +	nop
>> +	nop
>> +	nop
>> +	nop
>> +	nop
>> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
>> +65:	ld	r4,_LINK(r1)
>>  
>>  	beq-	1f
>>  	ACCOUNT_CPU_USER_EXIT(r11, r12)
>> @@ -234,7 +271,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
>>  1:	ld	r2,GPR2(r1)
>>  	ld	r1,GPR1(r1)
>>  	mtlr	r4
>> +#ifdef	CONFIG_PPC64
>> +	mtcrf	0xFB,r5
>> +#else
>>  	mtcr	r5
>> +#endif
> 
> mtcrf with more than one CRn being updated is expensive on Freescale
> chips (and this isn't a book3s-only code path).  Why do you need to do
> it twice?  I don't see where either r5 or cr5 are messed with between
> the two places...
> 
Incase of returning to userspace, will be updating it twice. Which can
be avoid. Will redo this.

Regards
Maddy

> -Scott
> 
> 
