Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 8B70DB6F82
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 00:09:49 +1000 (EST)
Message-ID: <4E356221.6010302@redhat.com>
Date: Sun, 31 Jul 2011 17:09:37 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kvm PCI assignment & VFIO ramblings
References: <1311983933.8793.42.camel@pasglop>
In-Reply-To: <1311983933.8793.42.camel@pasglop>
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

On 07/30/2011 02:58 AM, Benjamin Herrenschmidt wrote:
> - Having a magic heuristic in libvirt to figure out those constraints is
> WRONG. This reeks of XFree 4 PCI layer trying to duplicate the kernel
> knowledge of PCI resource management and getting it wrong in many many
> cases, something that took years to fix essentially by ripping it all
> out. This is kernel knowledge and thus we need the kernel to expose in a
> way or another what those constraints are, what those "partitionable
> groups" are.

How about a sysfs entry partition=<partition-id>? then libvirt knows not 
to assign devices from the same partition to different guests (and not 
to let the host play with them, either).

> The interface currently proposed for VFIO (and associated uiommu)
> doesn't handle that problem at all. Instead, it is entirely centered
> around a specific "feature" of the VTd iommu's for creating arbitrary
> domains with arbitrary devices (tho those devices -do- have the same
> constraints exposed above, don't try to put 2 legacy PCI devices behind
> the same bridge into 2 different domains !), but the API totally ignores
> the problem, leaves it to libvirt "magic foo" and focuses on something
> that is both quite secondary in the grand scheme of things, and quite
> x86 VTd specific in the implementation and API definition.
>
> Now, I'm not saying these programmable iommu domains aren't a nice
> feature and that we shouldn't exploit them when available, but as it is,
> it is too much a central part of the API.

I have a feeling you'll be getting the same capabilities sooner or 
later, or you won't be able to make use of S/R IOV VFs.  While we should 
support the older hardware, the interfaces should be designed with the 
newer hardware in mind.

> My main point is that I don't want the "knowledge" here to be in libvirt
> or qemu. In fact, I want to be able to do something as simple as passing
> a reference to a PE to qemu (sysfs path ?) and have it just pickup all
> the devices in there and expose them to the guest.

Such magic is nice for a developer playing with qemu but in general less 
useful for a managed system where the various cards need to be exposed 
to the user interface anyway.

> * IOMMU
>
> Now more on iommu. I've described I think in enough details how ours
> work, there are others, I don't know what freescale or ARM are doing,
> sparc doesn't quite work like VTd either, etc...
>
> The main problem isn't that much the mechanics of the iommu but really
> how it's exposed (or not) to guests.
>
> VFIO here is basically designed for one and only one thing: expose the
> entire guest physical address space to the device more/less 1:1.

A single level iommu cannot be exposed to guests.  Well, it can be 
exposed as an iommu that does not provide per-device mapping.

A two level iommu can be emulated and exposed to the guest.  See 
http://support.amd.com/us/Processor_TechDocs/48882.pdf for an example.

> This means:
>
>    - It only works with iommu's that provide complete DMA address spaces
> to devices. Won't work with a single 'segmented' address space like we
> have on POWER.
>
>    - It requires the guest to be pinned. Pass-through ->  no more swap

Newer iommus (and devices, unfortunately) (will) support I/O page faults 
and then the requirement can be removed.

>    - The guest cannot make use of the iommu to deal with 32-bit DMA
> devices, thus a guest with more than a few G of RAM (I don't know the
> exact limit on x86, depends on your IO hole I suppose), and you end up
> back to swiotlb&  bounce buffering.

Is this a problem in practice?

>    - It doesn't work for POWER server anyways because of our need to
> provide a paravirt iommu interface to the guest since that's how pHyp
> works today and how existing OSes expect to operate.

Then you need to provide that same interface, and implement it using the 
real iommu.

> - Performance sucks of course, the vfio map ioctl wasn't mean for that
> and has quite a bit of overhead. However we'll want to do the paravirt
> call directly in the kernel eventually ...

Does the guest iomap each request?  Why?

Emulating the iommu in the kernel is of course the way to go if that's 
the case, still won't performance suck even then?

> The QEMU side VFIO code hard wires various constraints that are entirely
> based on various requirements you decided you have on x86 but don't
> necessarily apply to us :-)
>
> Due to our paravirt nature, we don't need to masquerade the MSI-X table
> for example. At all. If the guest configures crap into it, too bad, it
> can only shoot itself in the foot since the host bridge enforce
> validation anyways as I explained earlier. Because it's all paravirt, we
> don't need to "translate" the interrupt vectors&  addresses, the guest
> will call hyercalls to configure things anyways.

So, you have interrupt redirection?  That is, MSI-x table values encode 
the vcpu, not pcpu?

Alex, with interrupt redirection, we can skip this as well?  Perhaps 
only if the guest enables interrupt redirection?

If so, it's not arch specific, it's interrupt redirection specific.

> We don't need to prevent MMIO pass-through for small BARs at all. This
> should be some kind of capability or flag passed by the arch. Our
> segmentation of the MMIO domain means that we can give entire segments
> to the guest and let it access anything in there (those segments are a
> multiple of the page size always). Worst case it will access outside of
> a device BAR within a segment and will cause the PE to go into error
> state, shooting itself in the foot, there is no risk of side effect
> outside of the guest boundaries.

Does the BAR value contain the segment base address?  Or is that added 
later?


-- 
error compiling committee.c: too many arguments to function
