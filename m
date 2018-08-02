Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hDjT0pQbzF21L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 01:33:48 +1000 (AEST)
Message-ID: <7779442d7889ee943b3e4ff6c63ec90b4a58b79d.camel@kernel.crashing.org>
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
Date: Thu, 02 Aug 2018 10:33:05 -0500
In-Reply-To: <20180802003823-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com> <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180802003823-mutt-send-email-mst@kernel.org>
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

On Thu, 2018-08-02 at 00:56 +0300, Michael S. Tsirkin wrote:
> > but it's not, VMs are
> > created in "legacy" mode all the times and we don't know at VM creation
> > time whether it will become a secure VM or not. The way our secure VMs
> > work is that they start as a normal VM, load a secure "payload" and
> > call the Ultravisor to "become" secure.
> > 
> > So we're in a bit of a bind here. We need that one-liner optional arch
> > hook to make virtio use swiotlb in that "IOMMU bypass" case.
> > 
> > Ben.
> 
> And just to make sure I understand, on your platform DMA APIs do include
> some of the cache flushing tricks and this is why you don't want to
> declare iommu support in the hypervisor?

I'm not sure I parse what you mean.

We don't need cache flushing tricks. The problem we have with our
"secure" VMs is that:

 - At VM creation time we have no idea it's going to become a secure
VM, qemu doesn't know anything about it, and thus qemu (or other
management tools, libvirt etc...) are going to create "legacy" (ie
iommu bypass) virtio devices.

 - Once the VM goes secure (early during boot but too late for qemu),
it will need to make virtio do bounce-buffering via swiotlb because
qemu cannot physically access most VM pages (blocked by HW security
features), we need to bounce buffer using some unsecure pages that are
accessible to qemu.

That said, I wouldn't object for us to more generally switch long run
to changing qemu so that virtio on powerpc starts using the IOMMU as a
default provided we fix our guest firmware to understand it (it
currently doesn't), and provided we verify that the performance impact
on things like vhost is negligible.

Cheers,
Ben.
