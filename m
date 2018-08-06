Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kpN5562lzF3HK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 05:57:41 +1000 (AEST)
Message-ID: <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
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
Date: Tue, 07 Aug 2018 05:56:59 +1000
In-Reply-To: <20180806164106-mutt-send-email-mst@kernel.org>
References: <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
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

On Mon, 2018-08-06 at 16:46 +0300, Michael S. Tsirkin wrote:
> 
> > Right, we'll need some quirk to disable balloons  in the guest I
> > suppose.
> > 
> > Passing something from libvirt is cumbersome because the end user may
> > not even need to know about secure VMs. There are use cases where the
> > security is a contract down to some special application running inside
> > the secure VM, the sysadmin knows nothing about.
> > 
> > Also there's repercussions all the way to admin tools, web UIs etc...
> > so it's fairly wide ranging.
> > 
> > So as long as we only need to quirk a couple of devices, it's much
> > better contained that way.
> 
> So just the balloon thing already means that yes management and all the
> way to the user tools must know this is going on. Otherwise
> user will try to inflate the balloon and wonder why this does not work.

There is *dozens* of management systems out there, not even all open
source, we won't ever be able to see the end of the tunnel if we need
to teach every single of them, including end users, about platform
specific new VM flags like that.

.../...

> Here's another example: you can't migrate a secure vm to hypervisor
> which doesn't support this feature. Again management tools above libvirt
> need to know otherwise they will try.

There will have to be a new machine type for that I suppose, yes,
though it's not just the hypervisor that needs to know about the
modified migration stream, it's also the need to have a compatible
ultravisor with the right keys on the other side.

So migration is going to be special and require extra admin work in all
cases yes. But not all secure VMs are meant to be migratable.

In any case, back to the problem at hand. What a qemu flag gives us is
just a way to force iommu at VM creation time.

This is rather sub-optimal, we don't really want the iommu in the way,
so it's at best a "workaround", and it's not really solving the real
problem.

As I said replying to Christoph, we are "leaking" into the interface
something here that is really what's the VM is doing to itself, which
is to stash its memory away in an inaccessible place.

Cheers,
Ben.
