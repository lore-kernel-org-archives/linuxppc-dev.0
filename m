Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id D3572B71D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 23:39:46 +1000 (EST)
Message-ID: <4E37FE18.6080503@redhat.com>
Date: Tue, 02 Aug 2011 16:39:36 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kvm PCI assignment & VFIO ramblings
References: <1311983933.8793.42.camel@pasglop> <4E356221.6010302@redhat.com>	
	<1312248479.8793.827.camel@pasglop> <4E37BF62.2060809@redhat.com>
	<1312289929.8793.890.camel@pasglop>
In-Reply-To: <1312289929.8793.890.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/2011 03:58 PM, Benjamin Herrenschmidt wrote:
> >  >
> >  >  What you mean 2-level is two passes through two trees (ie 6 or 8 levels
> >  >  right ?).
> >
> >  (16 or 25)
>
> 25 levels ? You mean 25 loads to get to a translation ? And you get any
> kind of performance out of that ? :-)
>

Aggressive partial translation caching.  Even then, performance does 
suffer on memory intensive workloads.  The fix was transparent 
hugepages; that makes the page table walks much faster since they're 
fully cached, the partial translation caches become more effective, and 
the tlb itself becomes more effective.  On some workloads, THP on both 
guest and host was faster than no-THP on bare metal.

> >  >
> >  >  Not sure what you mean... the guest calls h-calls for every iommu page
> >  >  mapping/unmapping, yes. So the performance of these is critical. So yes,
> >  >  we'll eventually do it in kernel. We just haven't yet.
> >
> >  I see.  x86 traditionally doesn't do it for every request.  We had some
> >  proposals to do a pviommu that does map every request, but none reached
> >  maturity.
>
> It's quite performance critical, you don't want to go anywhere near a
> full exit. On POWER we plan to handle that in "real mode" (ie MMU off)
> straight off the interrupt handlers, with the CPU still basically
> operating in guest context with HV permission. That is basically do the
> permission check, translation and whack the HW iommu immediately. If for
> some reason one step fails (!present PTE or something like that), we'd
> then fallback to an exit to Linux to handle it in a more "common"
> environment where we can handle page faults etc...

I guess we can hack some kind of private interface, though I'd hoped to 
avoid it (and so far we succeeded - we can even get vfio to inject 
interrupts into kvm from the kernel without either knowing anything 
about the other).

> >  >  >   Does the BAR value contain the segment base address?  Or is that added
> >  >  >   later?
> >  >
> >  >  It's a shared address space. With a basic configuration on p7ioc for
> >  >  example we have MMIO going from 3G to 4G (PCI side addresses). BARs
> >  >  contain the normal PCI address there. But that 1G is divided in 128
> >  >  segments of equal size which can separately be assigned to PE#'s.
> >  >
> >  >  So BARs are allocated by firmware or the kernel PCI code so that devices
> >  >  in different PEs don't share segments.
> >
> >  Okay, and config space virtualization ensures that the guest can't remap?
>
> Well, so it depends :-)
>
> With KVM we currently use whatever config space virtualization you do
> and so we somewhat rely on this but it's not very fool proof.
>
> I believe pHyp doesn't even bother filtering config space. As I said in
> another note, you can't trust adapters anyway. Plenty of them (video
> cards come to mind) have ways to get to their own config space via MMIO
> registers for example.

Yes, we've seen that.

> So what pHyp does is that it always create PE's (aka groups) that are
> below a bridge. With PCIe, everything mostly is below a bridge so that's
> easy, but that does mean that you always have all functions of a device
> in the same PE (and thus in the same partition). SR-IOV is an exception
> to this rule since in that case the HW is designed to be trusted.
>
> That way, being behind a bridge, the bridge windows are going to define
> what can be forwarded to the device, and thus the system is immune to
> the guest putting crap into the BARs. It can't be remapped to overlap a
> neighbouring device.
>
> Note that the bridge itself isn't visible to the guest, so yes, config
> space is -somewhat- virtualized, typically pHyp make every pass-through
> PE look like a separate PCI host bridge with the devices below it.

I think I see, yes.

-- 
error compiling committee.c: too many arguments to function
