Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fDng5YmSzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 19:30:31 +1000 (AEST)
Date: Mon, 30 Jul 2018 02:30:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 hch@infradead.org, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
 paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
Message-ID: <20180730093027.GC26245@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
 <c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
 <20180729001344-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180729001344-mutt-send-email-mst@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +
> > +	if (xen_domain())
> > +		goto skip_override;
> > +
> > +	if (virtio_has_iommu_quirk(dev))
> > +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
> > +
> > + skip_override:
> > +
> 
> I prefer normal if scoping as opposed to goto spaghetti pls.
> Better yet move vring_use_dma_api here and use it.
> Less of a chance something will break.

I agree about avoid pointless gotos here, but we can do things
perfectly well without either gotos or a confusing helper here
if we structure it right. E.g.:

	// suitably detailed comment here
	if (!xen_domain() &&
	    !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);

and while we're at it - modifying dma ops for the parent looks very
dangerous.  I don't think we can do that, as it could break iommu
setup interactions.  IFF we set a specific dma map ops it has to be
on the virtio device itself, of which we have full control.
