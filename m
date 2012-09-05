Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C660A2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 15:18:03 +1000 (EST)
Message-ID: <1346822276.2257.46.camel@pasglop>
Subject: Re: [PATCH] powerpc-powernv: align BARs to PAGE_SIZE on powernv
 platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 05 Sep 2012 15:17:56 +1000
In-Reply-To: <1346821074.2225.65.camel@ul30vt.home>
References: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1346744201-31262-1-git-send-email-aik@ozlabs.ru>
 <1346787940.3025.11.camel@pasglop> <5046A2F1.1020004@ozlabs.ru>
 <1346807803.2257.19.camel@pasglop> <1346821074.2225.65.camel@ul30vt.home>
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

On Tue, 2012-09-04 at 22:57 -0600, Alex Williamson wrote:

> Do we need an extra region info field, or is it sufficient that we
> define a region to be mmap'able with getpagesize() pages when the MMAP
> flag is set and simply offset the region within the device fd?  ex.

Alexey ? You mentioned you had ways to get at the offset with the
existing interfaces ?

> BAR0: 0x10000 /* no offset */
> BAR1: 0x21000 /* 4k offset */
> BAR2: 0x32000 /* 8k offset */
> 
> A second level optimization might make these 0x10000, 0x11000, 0x12000.
> 
> This will obviously require some arch hooks w/in vfio as we can't do
> this on x86 since we can't guarantee that whatever lives in the
> overflow/gaps is in the same group and power is going to need to make
> sure we don't accidentally allow msix table mapping... in fact hiding
> the msix table might be a lot more troublesome on 64k page hosts.

Fortunately, our guests don't access the msix table directly anyway, at
least most of the time :-) There's a paravirt API for it, and our iommu
makes sure that if for some reason the guest still accesses it and does
the wrong thing to it, the side effects will be contained to the guest.

> > Now the main problem here is going to be that the guest itself might
> > reallocate the BAR and move it around (well, it's version of the BAR
> > which isn't the real thing), and so we cannot create a direct MMU
> > mapping between -that- and the real BAR.
> > 
> > IE. We can only allow that direct mapping if the guest BAR mapping has
> > the same "offset within page" as the host BAR mapping. 
> 
> Euw...

Yeah sucks :-) Basically, let's say page size is 64K. Host side BAR
(real BAR) is at 0xf0001000.

qemu maps 0xf0000000..0xf000ffff to a virtual address inside QEMU,
itself 64k aligned, let's say 0x80000000 and knows that the BAR is at
offset 0x1000 in there.

However, the KVM "MR" API is such that we can only map PAGE_SIZE regions
into the guest as well, so if the guest assigns a value ADDR to the
guest BAR, let's say 0x40002000, all KVM can do is an MR that maps
0x40000000 (guest physical) to 0x80000000 (qemu). Any access within that
64K page will have the low bits transferred directly from guest to HW.

So the guest will end up having that 0x2000 offset instead of the 0x1000
needed to actually access the BAR. FAIL.

There are ways to fix that but all are nasty.

 - In theory, we have the capability (and use it today) to restrict IO
mappings in the guest to 4K HW pages, so knowing that, KVM could use a
"special" MR that plays tricks here... but that would break all sort of
generic code both in qemu and kvm and generally be very nasty.

 - The best approach is to rely on the fact that our guest kernels don't
do BAR assignment, they rely on FW to do it (ie not at all, unlike x86,
we can't even fixup because in the general case, the hypervisor won't
let us anyway). So we could move our guest BAR allocation code out of
our guest firmware (SLOF) back into qemu (where we had it very early
on), which allows us to make sure that the guest BAR values we assign
have the same "offset within the page" as the host side values. This
would also allow us to avoid messing up too many MRs (this can have a
performance impact with KVM) and eventually handle our "group" regions
instead of individual BARs for mappings. We might need to do that anyway
in the long run for hotplug as our hotplug hypervisor APIs also rely on
the "new" hotplugged devices to have the BARs pre-assigned when they get
handed out to the guest. 

> > Our guests don't mess with BARs but SLOF does ... it's really tempting
> > to look into bringing the whole BAR allocation back into qemu and out of
> > SLOF :-( (We might have to if we ever do hotplug anyway). That way qemu
> > could set offsets that match appropriately.
> 
> BTW, as I mentioned elsewhere, I'm on vacation this week, but I'll try
> to keep up as much as I have time for.

No worries,

Cheers,
Ben.
