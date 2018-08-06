Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ktpj6BGRzDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 09:17:33 +1000 (AEST)
Message-ID: <8e00f0310fa78882d3d32270c03b0b6257f35f83.camel@kernel.crashing.org>
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
Date: Tue, 07 Aug 2018 09:16:43 +1000
In-Reply-To: <93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
References: <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
 <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
 <20180806233024-mutt-send-email-mst@kernel.org>
 <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
 <20180807002857-mutt-send-email-mst@kernel.org>
 <93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
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

On Tue, 2018-08-07 at 08:13 +1000, Benjamin Herrenschmidt wrote:
> 
> OK well, assuming Christoph can solve the direct case in a way that
> also work for the virtio !iommu case, we still want some bit of logic
> somewhere that will "switch" to swiotlb based ops if the DMA mask is
> limited.
> 
> You mentioned an RFC for that ? Do you happen to have a link ?
> 
> It would be indeed ideal if all we had to do was setup some kind of
> bus_dma_mask on all PCI devices and have virtio automagically insert
> swiotlb when necessary.

Actually... I can think of a simpler option (Anshuman, didn't you
prototype this earlier ?):

Since that limitaiton of requiring bounce buffering via swiotlb is true
of any device in a secure VM, whether it goes through the iommu or not,
the iommu remapping is essentially pointless.

Thus, we could ensure that the iommu maps 1:1 the swiotlb bounce buffer
(either that or we configure it as "disabled" which is equivalent in
this case).

That way, we can now use the basic swiotlb ops everywhere, the same
dma_ops (swiotlb) will work whether a device uses the iommu or not.

Which boils down now to only making virtio use dma ops, there is no
need to override the dma_ops.

Which means all we have to do is either make xen_domain() return true
(yuck) or replace that one test with arch_virtio_force_dma_api() which
resolves to xen_domain() on x86 and can do something else for us.

As to using a virtio feature flag for that, which is what Christoph
proposes, I'm not too fan of it because this means effectively exposing
this to the peer, ie the interface. I don't think it belong there. The
interface, from the hypervisor perspective, whether it's qemu, vmware,
hyperz etc... have no business knowing how the guest manages its dma
operations, and may not even be aware of the access limitations (in our
case they are somewhat guest self-imposed).

Now, if this flag really is what we have to do, then we'd probably need
a qemu hack which will go set that flag on all virtio devices when it
detects that the VM is going secure.

But I don't think that's where that information "need to use the dma
API even for direct mode" belongs.

Cheers,
Ben.
