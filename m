Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413z6l2qP4zF1dT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 13:30:23 +1000 (AEST)
Message-ID: <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, robh@kernel.org, pawel.moll@arm.com,
 Tom Lendacky <thomas.lendacky@amd.com>, aik@ozlabs.ru,
 jasowang@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com, "Rustad, Mark
 D" <mark.d.rustad@intel.com>,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 11 Jun 2018 13:29:18 +1000
In-Reply-To: <20180611023909.GA5726@ram.oc3035372033.ibm.com>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
 <20180611023909.GA5726@ram.oc3035372033.ibm.com>
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

On Sun, 2018-06-10 at 19:39 -0700, Ram Pai wrote:
> 
> However if the administrator
> ignores/forgets/deliberatey-decides/is-constrained to NOT enable the
> flag, virtio will not be able to pass control to the DMA ops associated
> with the virtio devices. Which means, we have no opportunity to share
> the I/O buffers with the hypervisor/qemu.
> 
> How do you suggest, we handle this case?

At the risk of repeating myself, let's just do the first pass which is
to switch virtio over to always using the DMA API in the actual data
flow code, with a hook at initialization time that replaces the DMA ops
with some home cooked "direct" ops in the case where the IOMMU flag
isn't set.

This will be equivalent to what we have today but avoids having 2
separate code path all over the driver.

Then a second stage, I think, is to replace this "hook" so that the
architecture gets a say in the matter.

Basically, something like:

	arch_virtio_update_dma_ops(pci_dev, qemu_direct_mode).

IE, virtio would tell the arch whether the "other side" is in fact QEMU
in a mode that bypasses the IOMMU and is cache coherent with the guest.
This is our legacy "qemu special" mode. If the performance is
sufficient we may want to deprecate it over time and have qemu enable
the iommu by default but we still need it.

A weak implementation of the above will be provied that just puts in
the direct ops when qemu_direct_mode is set, and thus provides today's
behaviour on any arch that doesn't override it. If the flag is not set,
the ops are left to whatever the arch PCI layer already set.

This will provide the opportunity for architectures that want to do
something special, such as in our case, when we want to force even the
"qemu_direct_mode" to go via bounce buffers, to put our own ops in
there, while retaining the legacy behaviour otherwise.

It also means that the "gunk" is entirely localized in that one
function, the rest of virtio just uses the DMA API normally.

Christoph, are you actually hacking "stage 1" above already or should
we produce patches ?

Cheers,
Ben.
