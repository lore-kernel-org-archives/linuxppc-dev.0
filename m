Return-Path: <BATV+a01a3e67072ae75c0352+5392+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wGM35w30zDr61
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 00:29:19 +1000 (AEST)
Date: Tue, 29 May 2018 07:03:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, hch@infradead.org, luto@kernel.org
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180529140319.GA19972@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
 <20180525202300-mutt-send-email-mst@kernel.org>
 <6fff9f5d67361653e6072570a857cf0d1009a123.camel@kernel.crashing.org>
 <2f1d48cf029c1f0903f3cffea946ae5b85f60ec0.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2f1d48cf029c1f0903f3cffea946ae5b85f60ec0.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 29, 2018 at 09:56:24AM +1000, Benjamin Herrenschmidt wrote:
> I don't think forcing the addition of an emulated iommu in the middle
> just to work around the fact that virtio "cheats" and doesn't use the
> dma API unless there is one, is the right "fix".

Agreed.

> The right long term fix is to always use the DMA API, reducing code
> path etc... and just have a single point where virtio can "chose"
> alternate DMA ops (via an arch hook to deal with our case).

Also agreed.

When Andi added vring_use_dma_api it was marked as temporary.

So I'd much rather move to blacklisting platforms that needs this
hack now than adding another exception.

And then once we have the blacklist move it to a quirk in the arch
code that just forces dma_direct_ops as the per-device dma ops.

I don't really think this is crazy long term, but something we could
do relatively quickly.  Interestingly enough the original commit
mentions PPC64 as a case where this quirk is needed.
