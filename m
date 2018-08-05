Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41jkcc6pbyzF1Tw
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Aug 2018 12:04:48 +1000 (AEST)
Message-ID: <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 robin.murphy@arm.com, jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date: Sun, 05 Aug 2018 11:10:15 +1000
In-Reply-To: <20180804082120.GB4421@infradead.org>
References: <20180802182959-mutt-send-email-mst@kernel.org>
 <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
 <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803160246.GA13794@infradead.org>
 <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
 <20180804082120.GB4421@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-08-04 at 01:21 -0700, Christoph Hellwig wrote:
> No matter if you like it or not (I don't!) virtio is defined to bypass
> dma translations, it is very clearly stated in the spec.  It has some
> ill-defined bits to bypass it, so if you want the dma mapping API
> to be used you'll have to set that bit (in its original form, a refined
> form, or an entirely newly defined sane form) and make sure your
> hypersivors always sets it.  It's not rocket science, just a little bit
> for work to make sure your setup is actually going to work reliably
> and portably.

I think you are conflating completely different things, let me try to
clarify, we might actually be talking past each other.

> > We aren't going to cancel years of HW and SW development for our
> 
> Maybe you should have actually read the specs you are claiming to
> implemented before spending all that effort.

Anyway, let's cool our respective jets and sort that out, there are
indeed other approaches than overriding the DMA ops with special ones,
though I find them less tasty ... but here's my attempt at a (simpler)
description.

Bear with me for the long-ish email, this tries to describe the system
so you get an idea where we come from, and options we can use to get
out of this.

So we *are* implementing the spec, since qemu is currently unmodified:

Default virtio will bypass the iommu emulated by qemu as per spec etc..

On the Linux side, thus, virtio "sees" a normal iommu-bypassing device
and will treat it as such.

The problem is the assumption in the middle that qemu can access all
guest pages directly, which holds true for traditional VMs, but breaks
when the VM in our case turns itself into a secure VM. This isn't under
the action (or due to changes in) the hypervisor. KVM operates (almost)
normally here.

But there's this (very thin and open source btw) layer underneath
called ultravisor, which exploits some HW facilities to maintain a
separate pool of "secure" memory, which cannot be physically accessed
by a non-secure entity.

So in our scenario, qemu and KVM create a VM totally normally, there is
no changes required to the VM firmware, bootloader(s), etc... in fact
we support Linux based bootloaders, and those will work as normal linux
would in a VM, virtio works normally, etc...

Until that VM (via grub or kexec for example) loads a "secure image".

That secure image is a Linux kernel which has been "wrapped" (to simply
imagine a modified zImage wrapper though that's not entirely exact).

When that is run, before it modifies it's .data, it will interact with
the ultravisor using a specific HW facility to make itself secure. What
happens then is that the UV cryptographically verifies the kernel and
ramdisk, and copies them to the secure memory where execution returns.

The Ultravisor is then involved as a small shim for hypercalls between
the secure VM and KVM to prevent leakage of information (sanitize
registers etc...).

Now at this point, qemu can no longer access the secure VM pages
(there's more to this, such as using HMM to allow migration/encryption
accross etc... but let's not get bogged down).

So virtio can no longer access any page in the VM.

Now the VM *can* request from the Ultravisor some selected pages to be
made "insecure" and thus shared with qemu. This is how we handle some
of the pages used in our paravirt stuff, and that's how we want to deal
with virtio, by creating an insecure swiotlb pool.

At this point, thus, there are two options.

 - One you have rejected, which is to have a way for "no-iommu" virtio
(which still doesn't use an iommu on the qemu side and doesn't need
to), to be forced to use some custom DMA ops on the VM side.

 - One, which sadly has more overhead and will require modifying more
pieces of the puzzle, which is to make qemu uses an emulated iommu.
Once we make qemu do that, we can then layer swiotlb on top of the
emulated iommu on the guest side, and pass that as dma_ops to virtio.

Now, assuming you still absolutely want us to go down the second
option, there are several ways to get there. We would prefer to avoid
requiring the user to pass some special option to qemu. That has an
impact up the food chain (libvirt, management tools etc...) and users
probably won't understand what it's about. In fact the *end user* might
not even need to know a VM is secure, though applications inside might.

There's the additional annoyance that currently our guest FW (SLOF)
cannot deal with virtio in IOMMU mode, but that's fixable.

>From there, refer to the email chain between Michael and I where we are
discussing options to "switch" virtio at runtime on the qemu side.

Any comment or suggestion ?

Cheers,
Ben.
