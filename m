Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A94B2B6F6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 02:18:37 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4BGFVhX007745
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 10:15:31 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4BGJHEq127198
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 10:19:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4BAHsCk022186
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2011 04:17:55 -0600
Message-ID: <4DCAB6B0.8020904@linux.vnet.ibm.com>
Date: Wed, 11 May 2011 11:17:52 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins>
	<1299675674.2308.2924.camel@twins>
	<1299766211.2308.4468.camel@twins>
	<1303294056.8345.122.camel@twins>
	<1303336869.2513.26.camel@pasglop>
	<4DC85BFE.7060900@linux.vnet.ibm.com>
	<1305036563.2914.80.camel@laptop>
In-Reply-To: <1305036563.2914.80.camel@laptop>
Content-Type: text/plain; charset=UTF-8
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2011 09:09 AM, Peter Zijlstra wrote:
> On Mon, 2011-05-09 at 16:26 -0500, Jesse Larrew wrote:
>>
>> According the the Power firmware folks, updating the home node of a
>> virtual cpu happens rather infrequently. The VPHN code currently
>> checks for topology updates every 60 seconds, but we can poll less
>> frequently if it helps. I chose 60 second intervals simply because
>> that's how often they check the topology on s390. ;-)
> 
> This just makes me shudder, so you poll the state? Meaning that the vcpu
> can actually run 99% of the time on another node?
> 
> What's the point of this if the vcpu scheduler can move the vcpu around
> much faster?
> 

Based on my discussion with the firmware folks, it sounds like the hypervisor will never automatically move vcpus around on its own. The firmware is designed to set the cpu home node at partition boot, then wait for the customer to run a tool to rebalance the affinity. Moving vcpus around costs performance, so they want to let the customer decide when to shuffle the vcpus. 

>From the kernel's perspective, we can expect to see occasional batches of vcpus updating at once, after which the topology should remain fixed until the tool is run again.

>> As for updating the memory topology, there are cases where changing
>> the home node of a virtual cpu doesn't affect the memory topology. If
>> it does, there is a separate notification system for memory topology
>> updates that is independent from the cpu updates. I plan to start
>> working on a patch set to enable memory topology updates in the kernel
>> in the coming weeks, but I wanted to get the cpu patches out on the
>> list so we could start having these debates. :) 
> 
> Well, they weren't put out on a list (well maybe on the ppc list but
> that's the same as not posting them from my pov), they were merged (and
> thus declared done) that's not how you normally start a debate.
> 

That's a fair point. At the time, I didn't expect anyone outside of the PPC community to care much about a PPC-specific patch set, but I see now why it's important to keep everyone in the loop. Sorry about that. I'll be sure to send any future patches to LKML as well.

> I would really like to see both patch-sets together. Also, I'm not at
> all convinced its a sane thing to do. Pretty much all NUMA aware
> software I know of assumes that CPU<->NODE relations are static,
> breaking that in kernel renders all existing software broken.
> 

I suspect that's true. Then again, shouldn't it be the capabilities of the hardware that dictates what the software does, rather than the other way around?

-- 

Jesse Larrew
Software Engineer, Linux on Power Kernel Team
IBM Linux Technology Center
Phone: (512) 973-2052 (T/L: 363-2052)
jlarrew@linux.vnet.ibm.com
