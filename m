Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fDt33lFJzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 19:34:19 +1000 (AEST)
Date: Mon, 30 Jul 2018 02:34:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 mst@redhat.com, hch@infradead.org, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
 jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180730093414.GD26245@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180727095804.GA25592@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2018 at 10:58:05AM +0100, Will Deacon wrote:
> 
> I just wanted to say that this patch series provides a means for us to
> force the coherent DMA ops for legacy virtio devices on arm64, which in turn
> means that we can enable the SMMU with legacy devices in our fastmodel
> emulation platform (which is slowly being upgraded to virtio 1.0) without
> hanging during boot. Patch below.

Yikes, this is a nightmare.  That is exactly where I do not want things
to end up.  We really need to distinguish between legacy virtual crappy
virtio (and that includes v1) that totally ignores the bus it pretends
to be on, and sane virtio (to be defined) that sit on a real (or
properly emulated including iommu and details for dma mapping) bus.

Having a mumble jumble of arch specific undocumented magic as in
the powerpc patch replied to or this arm patch is a complete no-go.

Nacked-by: Christoph Hellwig <hch@lst.de>

for both.
