Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 857E4B6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 08:17:41 +1000 (EST)
Subject: Re: [1/2] powerpc/crashdump: Fix issues with kexec and 36bit
	physical addr
From: Matthew McClintock <msm@freescale.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <11278706694663348731.1957747793.miltonm@bga.com>
References: <11278706694663348731.1957747793.miltonm@bga.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 17:17:07 -0500
Message-ID: <1278627427.16683.21.camel@localhost>
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

On Fri, 2010-07-09 at 15:18 -0500, Milton Miller wrote:
> > I don't disagree but this can break kexec if phys_addr_t != unsigned
> > long. Also, doesn't the crash kernel have to live below 2GB so
> unsigned
> > long is always fine?
> 
> 
> Its could only break kexec for the case of phys_addr_t != unsigned
> long
> which you are fixing, and its the right way to fix it.  There is
> nothing
> inherent in linux requiring the crash kernel to be below 2G, although
> there may be limitations of the current kernel that require such a
> limit.

Fair enough. This will be updated in the next patch.

> 
> > 
> > Will still change unless I hear otherwise.
> >
> 
> 
> > > 
> > > By the way, why does 32 bit care about the running kernel's size?
> aka
> > > linux,kernel-end?  64 bit book 3S needs it because we use mmu
> hooks
> > > to copy the pages to their destination, but I thought ppc32 was
> using
> > > a relocatable copy routine.  Are we missing the code to create
> > > temp ref tlbs on the fly for book 3E?
> > 
> > This is not really in this patch or did I miss something? Kexec uses
> > kernel-end just to add as a invalid region. Not crucial though for
> 32
> > bit.
> 
> No its not in this patch, hence "By the way".  I figured you might
> have
> some knowledge as you were working in this area.   If there is no
> reason
> to have the kernel region blocked for 32 bit, then it should be
> removed.
> Obviously from kexec-tools first, and then after some time we could
> move
> its export to be only for 64-bit (or only 64 bit book-3S?)
> 

As far as I can tell it's just used as an exclusion range. It's only
applicable for a crash kernel to make sure your crashkernel=XXM@XXM does
not overlap with the current kernel. Seems like it might not be needed.

> It only causes additional time for traditional, and memory
> fragmentation
> for book 3E, if you disallow memory below the current kernel end.
> For
> that matter, on 3E, does this limit creep as you repeatedly reboot?
> 

For a crash kernel it does not matter as you stick with the reserved
region. For kexec proper the current kexec HEAD disallows loading from
0x0-kernelend but I think that is wrong and needs to be modified for at
least some platforms. So, basically you can't load too the currently
running kernel address, and you can't even restart but I have not tried
a different address. 

I submitted a patch a while back to change that behavior for
kexec-uImage targets and have more working coming soon which will need
to be reviewed as well for kexec-elf targets.

-Matthew
