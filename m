Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6TH63Y6HzDqm8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 19:15:30 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v948EYBY059230
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Oct 2017 04:15:27 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dcmvmbf6e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Oct 2017 04:15:27 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 4 Oct 2017 18:15:22 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v948FKvF51773448
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Oct 2017 19:15:20 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v948FNqP013887
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Oct 2017 19:15:23 +1100
Subject: Re: [PATCH] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
To: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <1507008978-10145-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171003093029.x6hwls7qwyyjihkg@naverao1-tp.localdomain>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Wed, 4 Oct 2017 13:45:15 +0530
MIME-Version: 1.0
In-Reply-To: <20171003093029.x6hwls7qwyyjihkg@naverao1-tp.localdomain>
Content-Type: text/plain; charset=windows-1252
Message-Id: <f9b11e6e-2785-7a6b-8d2d-41a702506e86@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 03 October 2017 03:00 PM, Naveen N . Rao wrote:

Hi Naveen,

[snip]
> 
> A few small nits focusing on just the trampoline...
> 
>> diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
>> index c98e90b..708a96d 100644
>> --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
>> +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
>> @@ -249,6 +249,83 @@ livepatch_handler:
>>
>>  	/* Return to original caller of live patched function */
>>  	blr
>> +
>> +	/*
>> +	 * This livepatch stub code, called from livepatch module to jump into
>> +	 * kernel or other modules. It replicates the livepatch_handler code,
>> +	 * with an expection of jumping to the trampoline instead of patched
>> +	 * function.
>> +	 */
>> +	.global klp_stub_insn
>> +klp_stub_insn:
>> +	CURRENT_THREAD_INFO(r12, r1)
>> +
>> +	/* Allocate 3 x 8 bytes */
>> +	ld      r11, TI_livepatch_sp(r12)
>> +	addi    r11, r11, 24
>> +	std     r11, TI_livepatch_sp(r12)
>> +
>> +	/* Save toc & real LR on livepatch stack */
>> +	std     r2,  -24(r11)
>> +	mflr    r12
>> +	std     r12, -16(r11)
>> +
>> +	/* Store stack end marker */
>> +	lis     r12, STACK_END_MAGIC@h
>> +	ori     r12, r12, STACK_END_MAGIC@l
>> +	std     r12, -8(r11)
> 
> Seeing as this is the same as livepatch_handler() except for this part 
> in the middle, does it make sense to reuse livepatch_handler() with 
> appropriate labels added for your use?  You could patch in the below 5 
> instructions using the macros from ppc-opcode.h...

Thanks for the review. The current upstream livepatch_handler code
is a bit different. I have posted a bug fix to 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-September/163824.html
which alters the livepatch_handler to have similar code. It's
a good idea to re-use the livepatch_handler code. I will re-spin
v2 with based on top of bug fix posted earlier.

> 
>> +
>> +	/*
>> +	 * Stub memory is allocated dynamically, during the module load.
>> +	 * Load TOC relative address into r11. module_64.c::klp_stub_for_addr()
>> +	 * identifies the available free stub slot and loads the address into
>> +	 * r11 with two instructions.
>> +	 *
>> +	 * addis r11, r2, stub_address@ha
>> +	 * addi  r11, r11, stub_address@l
>> +	 */
>> +	.global klp_stub_entry
>> +klp_stub_entry:
>> +	addis   r11, r2, 0
>> +	addi    r11, r11, 0
>> +
>> +	/* Load the r12 with called function address from entry->funcdata */
>> +	ld      r12, 128(r11)
>> +
>> +	/* Move r12 into ctr for global entry and branch there */
>> +	mtctr   r12
>> +	bctrl
>> +
>> +	/*
>> +	 * Now we are returning to the patched function. We are free to
>> +	 * use r11, r12 and we can use r2 until we restore it.
>> +	 */
>> +	CURRENT_THREAD_INFO(r12, r1)
>> +
>> +	ld      r11, TI_livepatch_sp(r12)
>> +
>> +	/* Check stack marker hasn't been trashed */
>> +	lis     r2,  STACK_END_MAGIC@h
>> +	ori     r2,  r2, STACK_END_MAGIC@l
>> +	ld      r12, -8(r11)
>> +2:	tdne    r12, r2
>> +	EMIT_BUG_ENTRY 2b, __FILE__, __LINE__ - 1, 0
> 
> If you plan to keep this trampoline separate from livepatch_handler(), 
> note that the above bug entry is not required since you copy only the 
> text of this trampoline elsewhere and you won't have an associated bug 
> entry for that new stub address.
> 

Agree, klp_stub_entry trampoline will go away in v2. 

-- 
cheers,
Kamalesh.
