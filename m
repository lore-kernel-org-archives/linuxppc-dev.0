Return-Path: <hollisb@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F914DDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 09:09:49 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAEM5nw5020457
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 17:05:49 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAEM9lJZ133524
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 17:09:47 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAEM9U8M022514
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 17:09:31 -0500
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
Date: Fri, 14 Nov 2008 16:09:44 -0600
References: <4b6790c7a989dce8c200000687275224@bga.com>
	<84e16946c1ed4b782568f6492931512a@bga.com>
In-Reply-To: <84e16946c1ed4b782568f6492931512a@bga.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811141609.44161.hollisb@us.ibm.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 14 November 2008 11:29:35 Milton Miller wrote:
> > I simply don't see a good place to do this in the kernel. It would have
> > to be before the first lmb_alloc() call, which for safety would put it
> > inside early_init_devtree() -- along with the other lmb_reserve()
> > calls.[1]
> >
> > [1] This is exactly where flat device tree reservations are done, and
> > that's why the patch I submitted works.
> 
> 
> > However, ppc_md.probe() hasn't even been called yet, so there's no way
> > of knowing if we're on an affected system, unless you want to add a
> > special of_scan_flat_dt() call here.
> 
> I think we decided a property is the right way to go, but am not sure 
> we decided if it should be a specific property in the /cpus/cpu@* nodes 
> or a general property that describes a base and length ... in which 
> case it is either a property in /memory (cpus nodes are not part of the 
> system address space, with an independent size 0 address space).   It 
> was also noted if we go the property route. that kexec tools would need 
> to know about it since it allocates destination pages based on reading 
> /memory reg ranges, although it also has a hardcoded 768M limit which 
> might hide this.
> 
> > I'm open to suggestions, but I don't see a better way than what I
> > already sent. I think the important part is to call lmb_add() for all
> > memory, but lmb_reserve() the last 256 bytes before lmb_alloc() 
> > happens.
> >
> > It sounds like kexec must have some knowledge of the platform and 
> > device
> > tree already, so is this really a big deal? At any rate, this
> > conversation is somewhat academic, since there is no kexec on 44x... so
> > maybe this can be re-addressed when that becomes a real issue.
> 
> As discussed, kexec userspace has some ideas of platforms, but its very 
> general and should not have lists of which cpus have an errata but 
> should base all its decisions off the device tree.
> 
> Alternatives to adding a property include just trimming the memory node 
> (and fixing the kernel to handle memory size not being page aligned),
> and adding an additional node that says this memory is in use.  We 
> should handle the memory size not some big power of 2 anyways, and if 
> we just create a new node it should not overlap the memory node 
> anyways.  Although we did note that due to current kexec implementation 
> we can name a node starting with /rtas and use linux,rtas-base and 
> rtas-size to reserve any 32 bit chunk of memory even to kexec, although 
> that is considered beyond acceptable for this errata fix (some else 
> might want to join me in using that to reserve memory for log buffers 
> across boot).
> 
> It has been described to me that the bug affects any access to the 256 
> bytes, so it would be accurate to describe the memory as not existing 
> or as this cpu has an errata tnd the dram is really here.  I just say 
> it needs to be described in the device tree.  Trimming the memory node 
> has the advantage that kexec userspace will not need a patch, adding 
> the cpu has errata property would only require a patch for platofrms 
> with <768MB (or manual override of the usable memory size via the 
> command line).

I don't think patching kexec userspace is too onerous, especially if it's done 
now long before kexec exists on 440. That would also allow you to drop your 
rtas hack...

Basically my revised proposal is to add explicit memory reservation properties 
to the device tree. Currently, "/memreserve" properties in .dts files are not 
present in the device tree itself, only in the FDT header. I think these 
reservations should be duplicated in the tree itself, so that they become 
visible to post-boot tools like kexec.

In summary, all memory reservations will then exist both in the device tree 
and in the FDT header. Comments?

Impact to uboot: revert memory node truncation; create reservation 
and /memreserve property.

Impact to cuboot wrapper: revert memory node truncation; create reservation 
and /memreserve property.

Impact to kernel: none. /memreserve will be ignored, since memory reservations 
are already handled properly.

Impact to kexec-tools: Must take /memreserve into account when placing data 
at "the end of memory".

If this is all too much, then I'm close to giving up and burning a 64KB page, 
which requires only ALIGN_DOWN() in the kernel.

-- 
Hollis Blanchard
IBM Linux Technology Center
