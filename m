Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 1316BDDEF3
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 13:56:18 +1000 (EST)
In-Reply-To: <1222291005.8277.86.camel@pasglop>
References: <200809231743.23828.ossthema@de.ibm.com>
	<20080915100406.342e027a@bull.net>
	<200809240958.m8O9wM7k010996@sullivan.realtime.net>
	<20080924143055.6102f317@bull.net>
	<0fa2693104ff3250114d82837911b9e8@bga.com>
	<1222291005.8277.86.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9eea138fe97eb1e63e5169a4d7647883@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH HACK] powerpc: quick hack to get a functional eHEA with
	hardirq preemption
Date: Wed, 24 Sep 2008 22:56:54 -0500
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Sebastien Dugue <sebastien.dugue@bull.net>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Christoph Raisch <RAISCH@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 24, 2008, at 4:16 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2008-09-24 at 11:42 -0500, Milton Miller wrote:
>>
>> I was trying to understand why the mask and early eoi, but I guess its
>> to handle other more limited interrupt controllers where the 
>> interrupts
>> stack in hardware instead of software.
>
> No Milton, we must do it that way, because the EOI must be done on the
> right CPU even on XICS, or we won't get the CPU priority back properly.

Ben and I had a online chat, and he pointed out I needed to be more 
specific in saying what I was thinking.

>> I think the flows we want on xics are:
>>
>> (non-threaded)
>> 	getirq (implicit source specific mask until eoi)
>> 	handle interrupt
>> 	eoi (implicit cpu priority restore)
>>
>> (threaded)
>> 	getirq (implicit source specific mask until eoi)
>> 	explicit cpu priority restore
>> 	handle interrupt
>> 	eoi (implicit cpu priority restore to same as explicit level)


cpu takes interrupt, checks soft disabled
if so,
	set hard disabled
else
	call get_irq
	if threaded
		write cppr to restore this cpu irq dispatch state to non-interrupt
		mark irq thread as irq pending
	else
		handle interrupt
		eoi (cppr = base)

irq thread will
	handle interrupt
	eoi
	wait for marked pending again

The part Ben did not follow was that the cppr write to base priority is 
done by the interrupted cpu (like the mask and eoi in the current flow) 
and only the final eoi (where the mask is in the existing flow) is done 
on which ever cpu happens to run the irq thread.


(optional) As I was discussing with Paul, when taking an irq when 
soft-disabled but still hard enabled, it is possible to write the cppr 
such that it would reject the pending irq and have it be considered for 
dispatch to another cpu.   But it would increase pathlength on both the 
go-to-hard-disabled and return-from-hard-disabled and the hardware will 
have some latency as it will likely send it back to the io source until 
it retrys, so we would only want to do this if the hard-disable period 
is sufficiently long.

milton
