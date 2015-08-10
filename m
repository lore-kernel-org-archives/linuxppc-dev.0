Return-Path: <Yuanjie.Huang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFEA01A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 13:03:58 +1000 (AEST)
Subject: Re: powerpc/fsl_book3e: fix the relocatable bug in debug interrupt
 handler
To: Scott Wood <scottwood@freescale.com>
References: <1438930690-28046-1-git-send-email-Yuanjie.Huang@windriver.com>
 <20150808022913.GA29133@home.buserror.net>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>
From: "Huang, Yuanjie" <yuanjie.huang@windriver.com>
Message-ID: <55C80B29.7050308@windriver.com>
Date: Mon, 10 Aug 2015 10:23:37 +0800
MIME-Version: 1.0
In-Reply-To: <20150808022913.GA29133@home.buserror.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

On 08/08/2015 10:29 AM, Scott Wood wrote:
> [Please wrap commit messages at around 74 columns]
Ok, I will when sending a new version.
>
> On Fri, Aug 07, 2015 at 02:58:10PM +0800, Yuanjie Huang wrote:
>> PowerPC Book3E processor features hardware-supported single instruction
>> execution, and it is used for ptrace(PTRACE_SINGLESTEP, ...).  When a
>> debugger loads a debuggee, it typically sets the CPU to yield debug
>> interrupt on first instruction complete or branch taken.  However, the
>> newly-forked child process could run into instruction TLB miss
>> exception handler when switched to, and causes a debug interrupt in the
>> exception entry sequence.  This is not expected by caller of
>> ptrace(PTRACE_SINGLESTEP, ...), so the next instruction address saved
>> in DSRR0 is checked against the boundary of exception entry sequence,
>> to ensure the kernel only process the interrupt as a normal exception
>> if the address does not fall in the exception entry sequence.  Failure
>> in obtaining the correct boundary leads to such debug exception handled
>> as from privileged mode, and causes kernel oops.
>>
>> The LOAD_REG_IMMEDIATE can't be used to load the boundary addresses
>> when relocatable enabled, so this patch replace them with
>> LOAD_REG_ADDR_PIC.  LR is backed up and restored before and after
>> calling LOAD_REG_ADDR_PIC, because LOAD_REG_ADDR_PIC clobbers it.
>>
>> Signed-off-by: Yuanjie Huang <Yuanjie.Huang@windriver.com>
>> ---
>>   arch/powerpc/kernel/exceptions-64e.S | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
>> index 3e68d1c..c475f569 100644
>> --- a/arch/powerpc/kernel/exceptions-64e.S
>> +++ b/arch/powerpc/kernel/exceptions-64e.S
>> @@ -735,12 +735,24 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>>   	andis.	r15,r14,(DBSR_IC|DBSR_BT)@h
>>   	beq+	1f
>>   
>> +#ifdef CONFIG_RELOCATABLE
>> +	mflr	r14
>> +	LOAD_REG_ADDR_PIC(r15,interrupt_base_book3e)
>> +	mtlr	r14
>> +	cmpld	cr0,r10,r15
>> +	blt+	cr0,1f
>> +	LOAD_REG_ADDR_PIC(r15,interrupt_end_book3e)
>> +	mtlr	r14
>> +	cmpld	cr0,r10,r15
>> +	bge+	cr0,1f
>> +#else
> CONFIG_RELOCATABLE is not supported on 64-bit book3e without applying
> additional patches, such as the RFC patchset I posted recently that
> contained the patch "powerpc/book3e-64: rename interrupt_end_book3e with
> __end_interrupts".  But if you've applied that patchset, then you
> wouldn't be working with the name interrupt_base_book3e, so how are you
> seeing this?

Actually I have merged additional patches submitted but not merged to 
make CONFIG_RELOCATABLE work with 64-bit book3e. I am happy to delay 
this until those patches are merged, and sent an adjusted version. Shall 
I wait until they are merged?

> Also, why not use the RELOCATABLE version unconditionally?  I don't think
> this is a performance-critical path.

The difference is 15 instructions against 14, if it's not important we 
can surely use only RELOCATABLE version.

Best,
Yuanjie

> -Scott
