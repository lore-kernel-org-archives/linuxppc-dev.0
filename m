Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D362CDE04F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 01:47:36 +1000 (EST)
Message-Id: <6B1BFC35-0E39-41D9-A4A8-66415302155F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D260869@insardxms01.ap.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC] Kprobes for book-e
Date: Tue, 3 Jun 2008 10:46:28 -0500
References: <7B7EF7F090B9804A830ACC82F2CDE95D260869@insardxms01.ap.sony.com>
Cc: linuxppc-dev@ozlabs.org, rsmadhvesh@vsnl.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 3, 2008, at 3:23 AM, Sulibhavi, Madhvesh wrote:

> Kumar Gala wrote on Tuesday, June 03, 2008 11:01 AM
>> This is a patch that adds kprobes support for book-e style debug.   
>> Its
>> based on the patch posted by Madhvesh and assumes the
>> exception cleanup
>> that I've already posted.
>
> Thanks for your forward port of my previous kprobes patches.
> Few months back i did a port to 2.6.22.y but using ppc arch.
> As part of 2.6.22 port, i had to retain the debug exception handling
> fixes in DebugException and head_booke.h. I have to look into
> exception cleanup fixes posted by you.
>
> ....
>>
>
>> @@ -124,6 +147,10 @@ static void __kprobes
>> set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
>> 				struct kprobe_ctlblk *kcb)
>> {
>> 	__get_cpu_var(current_kprobe) = p;
>> +#ifdef CONFIG_BOOKE
>> +	regs->msr |= (MSR_EE); /* Turn on 'External Interrupt' bits */
>> +	regs->msr |= (MSR_CE); /* Turn on 'Critical Interrupt' bits */
>> +#endif
>> 	kcb->kprobe_saved_msr = regs->msr;
>> }
>
> I think the block code under CONFIG_BOOKE may not
> be required now if exception cleanup fixes address the stack
> problem which i had explained in my port. I have to look into
> exception fix patches and confirm about these changes. Can
> you please provide me the thread where exception cleanup
> is posted as i haven't tracked the list from long time.

http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056457.html

What was the original thinking about why you had to enable MSR_EE and  
MSR_CE?

>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -1030,10 +1030,34 @@ void SoftwareEmulation(struct pt_regs *regs)
>>
>> #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
>>
>> -void DebugException(struct pt_regs *regs, unsigned long  
>> debug_status)
>> +void __kprobes DebugException(struct pt_regs *regs, unsigned
>> long debug_status)
>> {
>> 	if (debug_status & DBSR_IC) {	/* instruction completion */
>> 		regs->msr &= ~MSR_DE;
>> +
>> +#ifdef CONFIG_KPROBES
>> +		/* Disable instruction completion */
>> +		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
>> +		/* Clear the instruction completion event */
>> +		mtspr(SPRN_DBSR, DBSR_IC);
>> +
>> +		/*
>> +		 * On Book E and perhaps other processsors,
>> singlestep is
>> +		 * handled on the critical exception stack.  This causes
>> +		 * current_thread_info() to fail, since it locates the
>> +		 * thread_info by masking off the low bits of
>> the current
>> +		 * stack pointer.  We work around this issue by copying
>> +		 * the thread_info from the kernel stack before calling
>> +		 * kprobe_post_handler, and copying it back afterwards.
>> +		 * On most processors the copy is avoided since
>> +		 * exception_thread_info == thread_info.
>> +		 */
>
> The above comment will not be valid now as stack copy is removed.

Agreed, I think I can simplify down the code here and remove the  
CONFIG_KPROBES.

> Below is the other change what i have in my kprobes ported code.
>
> @@ -180,9 +180,7 @@ void __kprobes arch_disarm_kprobe(struct
>
> void __kprobes arch_remove_kprobe(struct kprobe *p)
> {
> -       mutex_lock(&kprobe_mutex);
>        free_insn_slot(p->ainsn.insn,0);
> -       mutex_unlock(&kprobe_mutex);
> }
>
> This change is mainly to fix some build issues while working
> with lttng patches. I think this is coming from sched-devel git
> posted from here http://lkml.org/lkml/2008/4/9/159
> So the above changes are not required as mainline tree
> still uses global mutex. This needs to be addressed in future.
>
> Kumar, i would like to test the updated kprobes patches on my
> ebony target using latest kernel. But i am facing build issues using
> 2.6.26.rc3 for powerpc arch while using the ebony configuration.
> I tried it using paulus git tree, but could not succeed. If you have
> any ideas on any stable version of latest tree where ebony config
> can be built using powerpc arch, please let me know.

- k
