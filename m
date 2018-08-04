Return-Path: <benh@kernel.crashing.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41j5fb64vhzF2FR
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2018 11:19:19 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w741JGCf101660
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Aug 2018 21:19:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kmyde4m1n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Aug 2018 21:19:16 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@kernel.crashing.org>;
 Sat, 4 Aug 2018 02:19:14 +0100
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 robin.murphy@arm.com, jean-philippe.brucker@arm.com, marc.zyngier@arm.com
In-Reply-To: <20180803220443-mutt-send-email-mst@kernel.org>
References: <20180801083639.GF26378@infradead.org>
 <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
 <20180802182959-mutt-send-email-mst@kernel.org>
 <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
 <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803220443-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Date: Fri, 03 Aug 2018 20:16:21 -0500
Message-Id: <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-03 at 22:07 +0300, Michael S. Tsirkin wrote:
> On Fri, Aug 03, 2018 at 10:58:36AM -0500, Benjamin Herrenschmidt wrote:
> > On Fri, 2018-08-03 at 00:05 -0700, Christoph Hellwig wrote:
> > > >   2- Make virtio use the DMA API with our custom platform-provided
> > > > swiotlb callbacks when needed, that is when not using IOMMU *and*
> > > > running on a secure VM in our case.
> > > 
> > > And total NAK the customer platform-provided part of this.  We need
> > > a flag passed in from the hypervisor that the device needs all bus
> > > specific dma api treatment, and then just use the normal plaform
> > > dma mapping setup. 
> > 
> > Christoph, as I have explained already, we do NOT have a way to provide
> > such a flag as neither the hypervisor nor qemu knows anything about
> > this when the VM is created.
> 
> I think the fact you can't add flags from the hypervisor is
> a sign of a problematic architecture, you should look at
> adding that down the road - you will likely need it at some point.

Well, we can later in the boot process. At VM creation time, it's just
a normal VM. The VM firmware, bootloader etc... are just operating
normally etc...

Later on, (we may have even already run Linux at that point,
unsecurely, as we can use Linux as a bootloader under some
circumstances), we start a "secure image".

This is a kernel zImage that includes a "ticket" that has the
appropriate signature etc... so that when that kernel starts, it can
authenticate with the ultravisor, be verified (along with its ramdisk)
etc... and copied (by the UV) into secure memory & run from there.

At that point, the hypervisor is informed that the VM has become
secure.

So at that point, we could exit to qemu to inform it of the change, and
have it walk the qtree and "Switch" all the virtio devices to use the
IOMMU I suppose, but it feels a lot grosser to me.

That's the only other option I can think of.

> However in this specific case, the flag does not need to come from the
> hypervisor, it can be set by arch boot code I think.
> Christoph do you see a problem with that?

The above could do that yes. Another approach would be to do it from a
small virtio "quirk" that pokes a bit in the device to force it to
iommu mode when it detects that we are running in a secure VM. That's a
bit warty on the virito side but probably not as much as having a qemu
one that walks of the virtio devices to change how they behave.

What do you reckon ?

What we want to avoid is to expose any of this to the *end user* or
libvirt or any other higher level of the management stack. We really
want that stuff to remain contained between the VM itself, KVM and
maybe qemu.

We will need some other qemu changes for migration so that's ok. But
the minute you start touching libvirt and the higher levels it becomes
a nightmare.

Cheers,
Ben.

> > >  To get swiotlb you'll need to then use the DT/ACPI
> > > dma-range property to limit the addressable range, and a swiotlb
> > > capable plaform will use swiotlb automatically.
> > 
> > This cannot be done as you describe it.
> > 
> > The VM is created as a *normal* VM. The DT stuff is generated by qemu
> > at a point where it has *no idea* that the VM will later become secure
> > and thus will have to restrict which pages can be used for "DMA".
> > 
> > The VM will *at runtime* turn itself into a secure VM via interactions
> > with the security HW and the Ultravisor layer (which sits below the
> > HV). This happens way after the DT has been created and consumed, the
> > qemu devices instanciated etc...
> > 
> > Only the guest kernel knows because it initates the transition. When
> > that happens, the virtio devices have already been used by the guest
> > firmware, bootloader, possibly another kernel that kexeced the "secure"
> > one, etc... 
> > 
> > So instead of running around saying NAK NAK NAK, please explain how we
> > can solve that differently.
> > 
> > Ben.
> > 
