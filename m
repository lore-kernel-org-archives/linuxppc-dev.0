Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0F742DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 04:21:10 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4b6790c7a989dce8c200000687275224@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
Date: Fri, 14 Nov 2008 11:25:38 -0600
To: Ben Herrenschmidt <benh@kernel.crashing.org>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In-Reply-To: <1226606055.5339.31.camel@localhost.localdomain>


On Fri Nov 14 at 06:54:15 EST in 2008, Hollis Blanchard wrote:
> On Thu, 2008-11-13 at 07:44 +1100, Benjamin Herrenschmidt wrote:
>> Again, why can't we just stick something in the kernel code that
>> reserves the last page ? It could be in prom.c or it could be called 
>> by
>> affected 4xx platforms by the platform code, whatever, but the reserve
>> map isn't really meant for that and will not be passed over from 
>> kernel
>> to kernel by kexec.
>
> Reserving a page is overkill; only the last 256 bytes are affected. We
> need to intercept at the LMB level, because allocations are already 
> done
> there, so by the time we hit bootmem it's way too late.

I agree with Ben we need to have something in the tree to tell kexec 
and or the kernel of this errata, unless we adapt the kernel to not 
require the memory node be page size aligned.

I instigated a discussion with Josh and Hollis on irc.

> I simply don't see a good place to do this in the kernel. It would have
> to be before the first lmb_alloc() call, which for safety would put it
> inside early_init_devtree() -- along with the other lmb_reserve()
> calls.[1]
>
> [1] This is exactly where flat device tree reservations are done, and
> that's why the patch I submitted works.


> However, ppc_md.probe() hasn't even been called yet, so there's no way
> of knowing if we're on an affected system, unless you want to add a
> special of_scan_flat_dt() call here.

I think we decided a property is the right way to go, but am not sure 
we decided if it should be a specific property in the /cpus/cpu@* nodes 
or a general property that describes a base and length ... in which 
case it is either a property in /memory (cpus nodes are not part of the 
system address space, with an independent size 0 address space).   It 
was also noted if we go the property route. that kexec tools would need 
to know about it since it allocates destination pages based on reading 
/memory reg ranges, although it also has a hardcoded 768M limit which 
might hide this.

> I'm open to suggestions, but I don't see a better way than what I
> already sent. I think the important part is to call lmb_add() for all
> memory, but lmb_reserve() the last 256 bytes before lmb_alloc() 
> happens.
>
> It sounds like kexec must have some knowledge of the platform and 
> device
> tree already, so is this really a big deal? At any rate, this
> conversation is somewhat academic, since there is no kexec on 44x... so
> maybe this can be re-addressed when that becomes a real issue.

As discussed, kexec userspace has some ideas of platforms, but its very 
general and should not have lists of which cpus have an errata but 
should base all its decisions off the device tree.

Alternatives to adding a property include just trimming the memory node 
(and fixing the kernel to handle memory size not being page aligned), 
and adding an additional node that says this memory is in use.  We 
should handle the memory size not some big power of 2 anyways, and if 
we just create a new node it should not overlap the memory node 
anyways.  Although we did note that due to current kexec implementation 
we can name a node starting with /rtas and use linux,rtas-base and 
rtas-size to reserve any 32 bit chunk of memory even to kexec, although 
that is considered beyond acceptable for this errata fix (some else 
might want to join me in using that to reserve memory for log buffers 
across boot).

It has been described to me that the bug affects any access to the 256 
bytes, so it would be accurate to describe the memory as not existing 
or as this cpu has an errata tnd the dram is really here.  I just say 
it needs to be described in the device tree.  Trimming the memory node 
has the advantage that kexec userspace will not need a patch, adding 
the cpu has errata property would only require a patch for platofrms 
with <768MB (or manual override of the usable memory size via the 
command line).


milton
