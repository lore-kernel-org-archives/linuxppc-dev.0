Return-Path: <brking@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 60C27B7D0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 23:50:26 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3LDjKFH026639
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2010 09:45:20 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3LDoL2A147190
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2010 09:50:21 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3LDoLe9010729
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2010 09:50:21 -0400
Message-ID: <4BCF029B.1020805@linux.vnet.ibm.com>
Date: Wed, 21 Apr 2010 08:50:19 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/1] powerpc: Ignore IPIs to offline CPUs
References: <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com>
	<12054.1271815478@neuling.org>
	<4BCE6DDC.4020902@linux.vnet.ibm.com>
	<1271856929.3832.46.camel@concordia>
In-Reply-To: <1271856929.3832.46.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/21/2010 08:35 AM, Michael Ellerman wrote:
> On Tue, 2010-04-20 at 22:15 -0500, Brian King wrote:
>> On 04/20/2010 09:04 PM, Michael Neuling wrote:
>>> In message <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com> you wrote:
>>>>
>>>> Since there is nothing to stop an IPI from occurring to an
>>>> offline CPU, rather than printing a warning to the logs,
>>>> just ignore the IPI. This was seen while stress testing
>>>> SMT enable/disable.
>>>
>>> This seems like a recipe for disaster.  Do we at least need a
>>> WARN_ON_ONCE?
>>
>> Actually we are only seeing it once per offlining of a CPU,
>> and only once in a while.
>>  
>> My guess is that once the CPU is marked offline fewer IPIs
>> get sent to it since its no longer in the online mask.
> 
> Hmm, right. Once it's offline it shouldn't get _any_ IPIs, AFAICS.
> 
>> Perhaps we should be disabling IPIs to offline CPUs instead?
> 
> You mean not sending them? We do:
> 
> void smp_xics_message_pass(int target, int msg)
> {
>         unsigned int i;
> 
>         if (target < NR_CPUS) {
>                 smp_xics_do_message(target, msg);
>         } else {
>                 for_each_online_cpu(i) {
>                         if (target == MSG_ALL_BUT_SELF
>                             && i == smp_processor_id())
>                                 continue;
>                         smp_xics_do_message(i, msg);
>                 }
>         }
> }      
> 
> So it does sound like the IPI was sent while the cpu was online (ie.
> before pseries_cpu_disable(), but xics_migrate_irqs_away() has not
> caused the IPI to be cancelled.
> 
> Problem is I don't think we can just ignore the IPI. The IPI might have
> been sent for a smp_call_function() which is waiting for the result, in
> which case if we ignore it the caller will block for ever.
> 
> I don't see how to fix it :/

Any objections to just removing the warning?

Thanks,

Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
