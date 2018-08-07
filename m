Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41l4rQ71bjzDqZm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 16:49:42 +1000 (AEST)
Message-ID: <7622efcbb499919616f165266968565b1d329a91.camel@kernel.crashing.org>
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
Date: Tue, 07 Aug 2018 16:44:01 +1000
In-Reply-To: <20180807062731.GA23159@infradead.org>
References: <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
 <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
 <20180806233024-mutt-send-email-mst@kernel.org>
 <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
 <20180807002857-mutt-send-email-mst@kernel.org>
 <93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
 <20180807062731.GA23159@infradead.org>
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

On Mon, 2018-08-06 at 23:27 -0700, Christoph Hellwig wrote:
> On Tue, Aug 07, 2018 at 08:13:56AM +1000, Benjamin Herrenschmidt wrote:
> > It would be indeed ideal if all we had to do was setup some kind of
> > bus_dma_mask on all PCI devices and have virtio automagically insert
> > swiotlb when necessary.
> 
> For 4.20 I plan to remove the swiotlb ops and instead do the bounce
> buffering in the common code, including a direct call to the direct
> ops to avoid retpoline overhead.  For that you still need a flag
> in virtio that instead of blindly working physical addresses it needs
> to be treated like a real device in terms of DMA.

But you will still call the swiotlb infrastructure, right ? IE, I sitll
need to control where/how the swiotlb "pool" is allocated.
> 
> And for powerpc to make use of that I need to get the dma series I
> posted last week reviewed and included, otherwise powerpc will have
> to be excepted (like arm, where rmk didn't like the way the code
> was factored, everything else has already been taken care of).
> 
> https://lists.linuxfoundation.org/pipermail/iommu/2018-July/028989.html

Yes, I saw your series. I'm just back from a week of travel, I plan to
start reviewing it this week if Michael doesn't beat me to it.

Cheers,
Ben.
