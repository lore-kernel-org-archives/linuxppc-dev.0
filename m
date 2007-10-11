Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 975C6DE0B8
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:36:07 +1000 (EST)
Date: Thu, 11 Oct 2007 16:35:49 -0500 (CDT)
Message-Id: <200710112135.l9BLZnaf030827@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Subject: Re: Hard hang in hypervisor!?
References: <18189.26776.326248.278431@cargo.ozlabs.ibm.com>
In-Reply-To: <18189.26776.326248.278431@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu Oct 11 10:04:40 EST 2007, Paul Mackerras wrote:
> Linas Vepstas writes:
>> Err ..  it was cpu 0 that was spinlocked.  Are interrupts not
>> distributed?
> 
> We have some bogosities in the xics code that I noticed a couple of
> days ago.  Basically we only set the xics to distribute interrupts to
> all cpus if (a) the affinity mask is equal to CPU_MASK_ALL (which has
> ones in every bit position from 0 to NR_CPUS-1) and (b) all present
> cpus are online (cpu_online_map == cpu_present_map).  Otherwise we
> direct interrupts to the first cpu in the affinity map.  So you can
> easily have the affinity mask containing all the online cpus and still
> not get distributed interrupts.


The second condition was just added to try fix some issues where a 
vendor wants to always run the kdump kernel with maxcpus=1 on all
architectures, and the emulated xics on js20 was not working.
For a true xics, this should work because we (1) remove all but 1
cpu from the global server list and (2) raise the prioirity of the
cpu to disabled and the hardware will deliver to another cpu in the
parition.

http://ozlabs.org/pipermail/linuxppc-dev/2006-December/028941.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-January/029607.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-March/032621.html

However, my experience the other day on a js21 was that firmware
delivered either to all cpus (if we bound to the global server) or
the first online cpu in the partition, regardless of to which cpu
we bound the interrupt, so I don't know that the change will fix
the original problem.

It does mean that taking a cpu offline but not dlpar removing it from the
kernel will result in the inability to actually distribute interrupts
to all cpus.

I'd be happy to say remove the extra check and work with firmware to
property distribute the interrupts.

milton
