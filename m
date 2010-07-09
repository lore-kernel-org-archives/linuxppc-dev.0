Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 3A674B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 06:38:23 +1000 (EST)
Date: Fri, 9 Jul 2010 15:18:14 -0500
From: Milton Miller <miltonm@bga.com>
To: msm@freescale.com,
Subject: Re: [1/2] powerpc/crashdump: Fix issues with kexec and 36bit
	physical addr
Message-Id: <11278706694663348731.1957747793.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thu, 08 Jul 2010 around 09:27:15 -0500 Matthew McClintock wrote:
> On Thu, 2010-07-08 at 04:07 -0500, Milton Miller wrote:
> > On Wed, 07 Jul 2010 around 10:51:20 -0000 Matthew McClintock wrote:
...
> > > Fix sizes of variables so correct values are exported via /proc.
> > > Cast variable in comparison to avoid compiler error.
> > > 
> > > diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> > > index bb3d893..ec7f054 100644
> > > --- a/arch/powerpc/kernel/machine_kexec.c
> > > +++ b/arch/powerpc/kernel/machine_kexec.c
> > > @@ -145,6 +145,7 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
> > >  
> > >  /* Values we need to export to the second kernel via the device tree. */
> > >  static unsigned long kernel_end;
> > > +static unsigned long crashk_start;
> > >  static unsigned long crashk_size;
> > >  
> > >  static struct property kernel_end_prop = {
> > > @@ -156,7 +157,7 @@ static struct property kernel_end_prop = {
> > >  static struct property crashk_base_prop = {
> > >  	.name = "linux,crashkernel-base",
> > >  	.length = sizeof(unsigned long),
> > > -	.value = &crashk_res.start,
> > > +	.value = &crashk_start,
> > >  };
> > >  
> > 
> > This is wrong, its truncating the start and size.
> > 
> > Change the variables to be physaddr_t and the length to be sizeof(physaddr_t).
> > 
> > Since these properites only contain one variable, the number of cells
> > can be inferred from the property size like we do for reading the initrd-size.
> > 
> > Technically they should be an array of be32 but we can make that a comment.
> 
> I don't disagree but this can break kexec if phys_addr_t != unsigned
> long. Also, doesn't the crash kernel have to live below 2GB so unsigned
> long is always fine?


Its could only break kexec for the case of phys_addr_t != unsigned long
which you are fixing, and its the right way to fix it.  There is nothing
inherent in linux requiring the crash kernel to be below 2G, although
there may be limitations of the current kernel that require such a limit.

> 
> Will still change unless I hear otherwise.
>


> > 
> > By the way, why does 32 bit care about the running kernel's size? aka
> > linux,kernel-end?  64 bit book 3S needs it because we use mmu hooks
> > to copy the pages to their destination, but I thought ppc32 was using
> > a relocatable copy routine.  Are we missing the code to create
> > temp ref tlbs on the fly for book 3E?
> 
> This is not really in this patch or did I miss something? Kexec uses
> kernel-end just to add as a invalid region. Not crucial though for 32
> bit.

No its not in this patch, hence "By the way".  I figured you might have
some knowledge as you were working in this area.   If there is no reason
to have the kernel region blocked for 32 bit, then it should be removed.
Obviously from kexec-tools first, and then after some time we could move
its export to be only for 64-bit (or only 64 bit book-3S?)

It only causes additional time for traditional, and memory fragmentation
for book 3E, if you disallow memory below the current kernel end.   For
that matter, on 3E, does this limit creep as you repeatedly reboot?

milton
