Return-Path: <brking@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85462B7D06
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 09:33:55 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3LNQvtn013692
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2010 17:26:57 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3LNXokt134008
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2010 17:33:50 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3LNaW84004419
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2010 17:36:32 -0600
Message-ID: <4BCF8B5B.8040607@linux.vnet.ibm.com>
Date: Wed, 21 Apr 2010 18:33:47 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/1] powerpc: Ignore IPIs to offline CPUs
References: <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com>
	<12054.1271815478@neuling.org>
	<4BCE6DDC.4020902@linux.vnet.ibm.com>
	<1271856929.3832.46.camel@concordia>
	<4BCF029B.1020805@linux.vnet.ibm.com>
	<16434.1271883816@neuling.org>
	<4BCF78E5.9020502@linux.vnet.ibm.com> <2902.1271890145@neuling.org>
In-Reply-To: <2902.1271890145@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/21/2010 05:49 PM, Michael Neuling wrote:
> In message <4BCF78E5.9020502@linux.vnet.ibm.com> you wrote:
>> On 04/21/2010 04:03 PM, Michael Neuling wrote:
>>> In message <4BCF029B.1020805@linux.vnet.ibm.com> you wrote:
>>>> On 04/21/2010 08:35 AM, Michael Ellerman wrote:
>>>>> On Tue, 2010-04-20 at 22:15 -0500, Brian King wrote:
>>>>>> On 04/20/2010 09:04 PM, Michael Neuling wrote:
>>>>>>> In message <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com> you wrote:
>>>>>>>>
>>>>>>>> Since there is nothing to stop an IPI from occurring to an
>>>>>>>> offline CPU, rather than printing a warning to the logs,
>>>>>>>> just ignore the IPI. This was seen while stress testing
>>>>>>>> SMT enable/disable.
>>>>>>>
>>>>>>> This seems like a recipe for disaster.  Do we at least need a
>>>>>>> WARN_ON_ONCE?
>>>>>>
>>>>>> Actually we are only seeing it once per offlining of a CPU,
>>>>>> and only once in a while.
>>>>>>  
>>>>>> My guess is that once the CPU is marked offline fewer IPIs
>>>>>> get sent to it since its no longer in the online mask.
>>>>>
>>>>> Hmm, right. Once it's offline it shouldn't get _any_ IPIs, AFAICS.
>>>>>
>>>>>> Perhaps we should be disabling IPIs to offline CPUs instead?
>>>>>
>>>>> You mean not sending them? We do:
>>>>>
>>>>> void smp_xics_message_pass(int target, int msg)
>>>>> {
>>>>>         unsigned int i;
>>>>>
>>>>>         if (target < NR_CPUS) {
>>>>>                 smp_xics_do_message(target, msg);
>>>>>         } else {
>>>>>                 for_each_online_cpu(i) {
>>>>>                         if (target == MSG_ALL_BUT_SELF
>>>>>                             && i == smp_processor_id())
>>>>>                                 continue;
>>>>>                         smp_xics_do_message(i, msg);
>>>>>                 }
>>>>>         }
>>>>> }      
>>>>>
>>>>> So it does sound like the IPI was sent while the cpu was online (ie.
>>>>> before pseries_cpu_disable(), but xics_migrate_irqs_away() has not
>>>>> caused the IPI to be cancelled.
>>>>>
>>>>> Problem is I don't think we can just ignore the IPI. The IPI might have
>>>>> been sent for a smp_call_function() which is waiting for the result, in
>>>>> which case if we ignore it the caller will block for ever.
>>>>>
>>>>> I don't see how to fix it :/
>>>>
>>>> Any objections to just removing the warning?
>>>
>>> Well someone could be waiting for the result, so it could be a real
>>> problem.  
>>>
>>> IMHO the warning should stay.
>>
>> Looking in arch/powerpc/kernel/smp.c, there are four possible IPIs:
>>
>> void smp_message_recv(int msg)
>> {
>> 	switch(msg) {
>> 	case PPC_MSG_CALL_FUNCTION:
>> 		generic_smp_call_function_interrupt();
>> 		break;
>> 	case PPC_MSG_RESCHEDULE:
>> 		/* we notice need_resched on exit */
>> 		break;
>> 	case PPC_MSG_CALL_FUNC_SINGLE:
>> 		generic_smp_call_function_single_interrupt();
>> 		break;
>> 	case PPC_MSG_DEBUGGER_BREAK:
>> 		if (crash_ipi_function_ptr) {
>> 			crash_ipi_function_ptr(get_irq_regs());
>> 			break;
>> 		}
>> #ifdef CONFIG_DEBUGGER
>> 		debugger_ipi(get_irq_regs());
>> 		break;
>> #endif /* CONFIG_DEBUGGER */
>> 		/* FALLTHROUGH */
>>
>>
>> Both generic_smp_call_function_interrupt and
>> generic_smp_call_function_single_interrupt have
>> WARN_ON(!cpu_online(cpu)); in them. The debugger IPI, appears to
>> ignore the IPI if the cpu is offline, which leaves the reschedule
>> IPI. This is likely the one I am seeing in test, since I'm not seeing
>> the other WARN_ON's.
> 
> I'm not sure what you are suggesting?
> 
> If the other methods produce the warning when a CPU is offline, surely
> we should keep the warning?  Maybe we need to add one to the debugger
> case too if we want to be consistent.  

I guess my point was that perhaps the warning in xics_ipi_dispatch is redundant.
I'm not sure if there are issues with not having a warning in the reschedule path,
which is really the one I care about. Am I correct in assuming that for the reschedule
IPI we wouldn't have to worry about someone waiting on that? There shouldn't be
anything running on the cpu we are disabling, or should we be scheduling anything on it...

Thanks,

Brian


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
