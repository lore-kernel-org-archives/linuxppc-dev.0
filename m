Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4E26EDDFFC
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:21:10 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9DIL3Ro016990
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 14:21:03 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9DIL3LZ225916
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 14:21:03 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9DIL2Vp024275
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 14:21:03 -0400
Date: Mon, 13 Oct 2008 14:21:00 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH V2 4/4] POWERPC: Merge 32 and 64-bit dma code
Message-ID: <20081013142100.7efc2c81@zod.rchland.ibm.com>
In-Reply-To: <209E575D-DDE2-406A-82DE-2DD445046C02@kernel.crashing.org>
References: <1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<1221251686-5567-1-git-send-email-becky.bruce@freescale.com>
	<20081013144904.GB18363@yoda.jdub.homelinux.org>
	<20081013154127.GA27124@yoda.jdub.homelinux.org>
	<209E575D-DDE2-406A-82DE-2DD445046C02@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Oct 2008 13:06:36 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Oct 13, 2008, at 10:41 AM, Josh Boyer wrote:
> 
> > On Mon, Oct 13, 2008 at 10:49:04AM -0400, Josh Boyer wrote:
> >> On Fri, Sep 12, 2008 at 03:34:46PM -0500, Becky Bruce wrote:
> >>> We essentially adopt the 64-bit dma code, with some changes to  
> >>> support
> >>> 32-bit systems, including HIGHMEM.  dma functions on 32-bit are now
> >>> invoked via accessor functions which call the correct op for a  
> >>> device based
> >>> on archdata dma_ops.  If there is no archdata dma_ops, this defaults
> >>> to dma_direct_ops.
> >>>
> >>> In addition, the dma_map/unmap_page functions are added to dma_ops
> >>> because we can't just fall back on map/unmap_single when HIGHMEM is
> >>> enabled. In the case of dma_direct_*, we stop using map/unmap_single
> >>> and just use the page version - this saves a lot of ugly
> >>> ifdeffing.  We leave map/unmap_single in the dma_ops definition,
> >>> though, because they are needed by the iommu code, which does not
> >>> implement map/unmap_page.  Ideally, going forward, we will  
> >>> completely
> >>> eliminate map/unmap_single and just have map/unmap_page, if it's
> >>> workable for 64-bit.
> >>>
> >>> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> >>
> >> While doing a buildall this morning, I notice chrp32_defconfig fails
> >> to build with:
> >>
> >> drivers/built-in.o: In function `hard_dma_setup':
> >> floppy.c:(.text+0x6e40e): undefined reference to `isa_bridge_pcidev'
> >> floppy.c:(.text+0x6e412): undefined reference to `isa_bridge_pcidev'
> >> floppy.c:(.text+0x6e53e): undefined reference to `isa_bridge_pcidev'
> >> floppy.c:(.text+0x6e546): undefined reference to `isa_bridge_pcidev'
> >> floppy.c:(.text+0x6e54a): undefined reference to `isa_bridge_pcidev'
> >> make[1]: *** [.tmp_vmlinux1] Error 1
> >>
> >> (the hard_dma_setup thing is in arch/powerpc/include/asm/floppy.h).
> >>
> >> I did a git bisect and it pointed at this commit as causing the build
> >> to fail.  Why, I have no idea.
> >
> > Ok, I was annoyed enough to look at why.
> >
> > Basically, before this patch pci_map_single on 32-bit PPC seemed to
> > be compiled down to __dma_sync(ptr, size, direction); and the "dev"
> > parameter to the function was never actually used.  The compiler
> > seems to have optimized this out entirely, so we don't get the odd
> > link reference to isa_bridge_pcidev at all.  (Neither pci_map_single
> > or isa_bridge_pcidev are present in the vmlinux at all).
> >
> > With the patch, the compiler doesn't do this code elimination
> > because pci_map_single boils down to dma_map_page, which calls
> > get_dma_direct_offset with the "dev" parameter.  So since it is
> > still used, the compiler can't eliminate it and hence FAIL.
> >
> > I have no patch for this at the moment.  Someone should look at
> > it more closely, because this is causing the 5 chrp32_defconfig
> > users to weep.
> 
> Isn't this the type of regression we should fix post -rc1 :)

I don't think it matters much when it gets fixed, pre or post -rc1.  But
it should probably get fixed.  My hack was to pull isa_bridge_pcidev
into pci-common.c and export it from there.  The 64-bit PCI code can
initialized it, and the 32-bit can leave it NULL.  But I have no idea
if that is sane.  If so, I can probably submit a patch for it.

josh
