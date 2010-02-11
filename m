Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2545B7CB8
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 11:06:31 +1100 (EST)
Message-ID: <4B7349F2.8030802@freescale.com>
Date: Wed, 10 Feb 2010 18:06:10 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] perf_event: e500 support
References: <20100115214351.GA2869@loki.buserror.net>
	<20100210222932.GA9844@brick.ozlabs.ibm.com>
In-Reply-To: <20100210222932.GA9844@brick.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
>> Some limitations:
>> - No threshold support -- need to figure out how to represent it in
>>   the event struct from userspace.
> 
> What does "threshold support" mean in this context?  Does it mean
> something different from getting an interrupt after N events have been
> counted?  Or does it mean counting instances where something takes
> longer than a specific number of cycles?

The latter.

>> - When trying to schedule multiple event groups at once, and using
>>   restricted events, situations could arise where scheduling fails even
>>   though it would be possible.  Consider three groups, each with two events.
>>   One group has restricted events, the others don't.  The two non-restricted
>>   groups are scheduled, then one is removed, which happens to occupy the two
>>   counters that can't do restricted events.  The remaining non-restricted
>>   group will not be moved to the non-restricted-capable counters to make
>>   room if the restricted group tries to be scheduled.  Since thresholds are
>>   not yet supported (though you can use the events with a threshold of
>>   zero), and threshold events are the only restricted events, this seems
>>   like a low priority issue.
> 
> Which way around are the restrictions?  That some events can only be
> counted on certain counters, or that some counters can only count a
> subset of the available events?

You could look at it either way -- threshold-capable events can only go on 
counters 0-1, or counters 2-3 can only count non-threshold-capable events.

> Did you look at the constraint satisfaction code in the existing
> perf_event.c and p*-pmu.c?  That lets you express both sorts of
> restrictions and automatically find the best solution (including
> moving events from one counter to another like you describe).

I did look at it -- but I had a hard time understanding it, and went with the 
simpler approach for now since the constraints are minimal on these chips.  I'm 
open to converting with a little help, if it doesn't add too much complexity or 
if future chips need it.

>> +#ifdef CONFIG_FSL_EMB_PERFMON
>> +#define MAX_HWEVENTS 4
>> +
>> +/* event flags */
>> +#define FSL_EMB_EVENT_VALID 1
>> +#define FSL_EMB_EVENT_RESTRICTED 2
>> +
>> +struct power_pmu {
> 
> I wonder if we should have just the stuff exported to the core in
> asm/perf_event.h and move MAX_HWEVENTS, struct power_pmu etc. to
> separate headers for fsl_embedded, classic, etc.?

Maybe.  We may also want to consider making it runtime selectable, as later 
revisions of e300 have an e500-style performance counter.  There's also a 
separate platform-level performance counter on some of our chips; having arch 
infrastructure that can delegate to multiple counter types would help there as well.

>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -98,7 +98,10 @@ obj64-$(CONFIG_AUDIT)		+= compat_audit.o
>>  
>>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
>>  obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
>> -obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o perf_callchain.o
>> +obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o
>> +obj-$(CONFIG_FSL_EMB_PERF_EVENT) += perf_event_fsl_emb.o
>> +obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o
>> +obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
> 
> This is because we want perf_callchain.o even if we don't have
> hardware PMU support, is it?  If so this is a separate fix that
> deserves its own patch.

OK.

-Scott
