Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fDhM1pf5zF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 19:25:55 +1000 (AEST)
Date: Mon, 30 Jul 2018 02:25:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
 hch@infradead.org, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
 paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
Message-ID: <20180730092551.GB26245@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +const struct dma_map_ops virtio_direct_dma_ops;

This belongs into a header if it is non-static.  If you only
use it in this file anyway please mark it static and avoid a forward
declaration.

> +
>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (virtio_has_iommu_quirk(dev))
> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);

This needs a big fat comment explaining what is going on here.

Also not new, but I find the existance of virtio_has_iommu_quirk and its
name horribly confusing.  It might be better to open code it here once
only a single caller is left.
