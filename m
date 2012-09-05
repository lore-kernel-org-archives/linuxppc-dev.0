Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 42D2B2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 14:58:01 +1000 (EST)
Message-ID: <1346821074.2225.65.camel@ul30vt.home>
Subject: Re: [PATCH] powerpc-powernv: align BARs to PAGE_SIZE on powernv
 platform
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 04 Sep 2012 22:57:54 -0600
In-Reply-To: <1346807803.2257.19.camel@pasglop>
References: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1346744201-31262-1-git-send-email-aik@ozlabs.ru>
 <1346787940.3025.11.camel@pasglop> <5046A2F1.1020004@ozlabs.ru>
 <1346807803.2257.19.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-09-05 at 11:16 +1000, Benjamin Herrenschmidt wrote:
> > > It's still bad in more ways that I care to explain...
> > 
> > Well it is right before pci_reassigndev_resource_alignment() which is 
> > common and does the same thing.
> > 
> > > The main one is that you do the "fixup" in a very wrong place anyway and
> > > it might cause cases of overlapping BARs.
> > 
> > As far as I can tell it may only happen if someone tries to align resource 
> > via kernel command line.
> > 
> > But ok. I trust you :)
> 
> I have reasons to believe that this realignment crap is wrong too :-)
> 
> > > In any case this is wrong. It's a VFIO design bug and needs to be fixed
> > > there (CC'ing Alex).
> > 
> > It can be fixed in VFIO only if VFIO will stop treating functions 
> > separately and start mapping group's MMIO space as a whole thing. But this 
> > is not going to happen.
> 
> It still can be fixed without that...
> 
> > The example of the problem is NEC USB PCI which has 3 functions, each has 
> > one BAR, these BARs are 4K aligned and I cannot see how it can be fixed 
> > with 64K page size and VFIO creating memory regions per BAR (not per PHB).
> 
> VFIO can perfectly well realize it's the same MR or even map the same
> area 3 times and create 3 MRs, both options work. All it needs is to
> know the offset of the BAR inside the page.

Yep, I think I agree...

> > > IE. We need a way to know where the BAR is within a page at which point
> > > VFIO can still map the page, but can also properly take into account the
> > > offset.
> > 
> > It is not about VFIO, it is about KVM. I cannot put non-aligned page to 
> > kvm_set_phys_mem(). Cannot understand how we would solve this.
> 
> No, VFIO still maps the whole page and creates an MR for the whole page,
> that's fine. But you still need to know the offset within the page.

Do we need an extra region info field, or is it sufficient that we
define a region to be mmap'able with getpagesize() pages when the MMAP
flag is set and simply offset the region within the device fd?  ex.

BAR0: 0x10000 /* no offset */
BAR1: 0x21000 /* 4k offset */
BAR2: 0x32000 /* 8k offset */

A second level optimization might make these 0x10000, 0x11000, 0x12000.

This will obviously require some arch hooks w/in vfio as we can't do
this on x86 since we can't guarantee that whatever lives in the
overflow/gaps is in the same group and power is going to need to make
sure we don't accidentally allow msix table mapping... in fact hiding
the msix table might be a lot more troublesome on 64k page hosts.

> Now the main problem here is going to be that the guest itself might
> reallocate the BAR and move it around (well, it's version of the BAR
> which isn't the real thing), and so we cannot create a direct MMU
> mapping between -that- and the real BAR.
> 
> IE. We can only allow that direct mapping if the guest BAR mapping has
> the same "offset within page" as the host BAR mapping. 

Euw...

> Our guests don't mess with BARs but SLOF does ... it's really tempting
> to look into bringing the whole BAR allocation back into qemu and out of
> SLOF :-( (We might have to if we ever do hotplug anyway). That way qemu
> could set offsets that match appropriately.

BTW, as I mentioned elsewhere, I'm on vacation this week, but I'll try
to keep up as much as I have time for.

Thanks,

Alex
