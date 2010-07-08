Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19FFAB6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 00:28:05 +1000 (EST)
Subject: Re: [1/2] powerpc/crashdump: Fix issues with kexec and 36bit
	physical addr
From: Matthew McClintock <msm@freescale.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <20100708-mitltonm-msm-reply@mdm.bga.com>
References: <1278535881-6463-1-git-send-email-msm@freescale.com>
	<20100708-mitltonm-msm-reply@mdm.bga.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 09:27:15 -0500
Message-ID: <1278599235.9343.7.camel@localhost>
Mime-Version: 1.0
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-08 at 04:07 -0500, Milton Miller wrote:
> On Wed, 07 Jul 2010 around 10:51:20 -0000 Matthew McClintock wrote:
> > 
> > Fix sizes of variables so correct values are exported via /proc.
> > Cast variable in comparison to avoid compiler error.
> > 
> > Signed-off-by: Matthew McClintock <msm@freescale.com>
> > 
> >  
> > -	csize = min(csize, PAGE_SIZE);
> > +	csize = min(csize, (size_t)PAGE_SIZE);
> 
> no use min_t

Ok

> 
> >  
> > -	if (pfn < max_pfn) {
> > +	if ((min_low_pfn < pfn) && (pfn < max_pfn)) {
> >  		vaddr = __va(pfn << PAGE_SHIFT);
> >  		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
> >  	} else {
> > diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> > index bb3d893..ec7f054 100644
> > --- a/arch/powerpc/kernel/machine_kexec.c
> > +++ b/arch/powerpc/kernel/machine_kexec.c
> > @@ -145,6 +145,7 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
> >  
> >  /* Values we need to export to the second kernel via the device tree. */
> >  static unsigned long kernel_end;
> > +static unsigned long crashk_start;
> >  static unsigned long crashk_size;
> >  
> >  static struct property kernel_end_prop = {
> > @@ -156,7 +157,7 @@ static struct property kernel_end_prop = {
> >  static struct property crashk_base_prop = {
> >  	.name = "linux,crashkernel-base",
> >  	.length = sizeof(unsigned long),
> > -	.value = &crashk_res.start,
> > +	.value = &crashk_start,
> >  };
> >  
> 
> This is wrong, its truncating the start and size.
> 
> Change the variables to be physaddr_t and the length to be sizeof(physaddr_t).
> 
> Since these properites only contain one variable, the number of cells
> can be inferred from the property size like we do for reading the initrd-size.
> 
> Technically they should be an array of be32 but we can make that a comment.

I don't disagree but this can break kexec if phys_addr_t != unsigned
long. Also, doesn't the crash kernel have to live below 2GB so unsigned
long is always fine?

Will still change unless I hear otherwise.

> 
> By the way, why does 32 bit care about the running kernel's size? aka
> linux,kernel-end?  64 bit book 3S needs it because we use mmu hooks
> to copy the pages to their destination, but I thought ppc32 was using
> a relocatable copy routine.  Are we missing the code to create
> temp ref tlbs on the fly for book 3E?

This is not really in this patch or did I miss something? Kexec uses
kernel-end just to add as a invalid region. Not crucial though for 32
bit.

> 
> >  static struct property crashk_size_prop = {
> > @@ -180,6 +181,7 @@ static void __init export_crashk_values(struct device_node *node)
> >  		prom_remove_property(node, prop);
> >  
> >  	if (crashk_res.start != 0) {
> > +		crashk_start = crashk_res.start;
> >  		prom_add_property(node, &crashk_base_prop);
> >  		crashk_size = crashk_res.end - crashk_res.start + 1;
> >  		prom_add_property(node, &crashk_size_prop);
> 
> I guess we use the reuse of the resources varables, but such is
> common code vs userspace.
> 
> milton
