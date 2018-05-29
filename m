Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wSh30PsmzDr6Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 08:14:42 +1000 (AEST)
Message-ID: <230075a7760a9cf878355e2b8abe4cdb967a482a.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, luto@kernel.org
Date: Wed, 30 May 2018 08:13:54 +1000
In-Reply-To: <20180529140319.GA19972@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
 <20180525202300-mutt-send-email-mst@kernel.org>
 <6fff9f5d67361653e6072570a857cf0d1009a123.camel@kernel.crashing.org>
 <2f1d48cf029c1f0903f3cffea946ae5b85f60ec0.camel@kernel.crashing.org>
 <20180529140319.GA19972@infradead.org>
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

On Tue, 2018-05-29 at 07:03 -0700, Christoph Hellwig wrote:
> On Tue, May 29, 2018 at 09:56:24AM +1000, Benjamin Herrenschmidt wrote:
> > I don't think forcing the addition of an emulated iommu in the middle
> > just to work around the fact that virtio "cheats" and doesn't use the
> > dma API unless there is one, is the right "fix".
> 
> Agreed.
> 
> > The right long term fix is to always use the DMA API, reducing code
> > path etc... and just have a single point where virtio can "chose"
> > alternate DMA ops (via an arch hook to deal with our case).
> 
> Also agreed.
> 
> When Andi added vring_use_dma_api it was marked as temporary.
> 
> So I'd much rather move to blacklisting platforms that needs this
> hack now than adding another exception.
> 
> And then once we have the blacklist move it to a quirk in the arch
> code that just forces dma_direct_ops as the per-device dma ops.
> 
> I don't really think this is crazy long term, but something we could
> do relatively quickly.  Interestingly enough the original commit
> mentions PPC64 as a case where this quirk is needed.

Not sure why, it's not so much a platform issue today. It's qemu itself
who by defaults bypasses any iommu. I suppose ppc64 stood out because
unlike x86 we always have an iommu by default.

Anyway, Anshuman, I think that's the right approach, first make virtio
always use the DMA API with a quirk early to override the ops.

Christoph: the overriding of the ops isn't a platform thing. It's a
qemu thing, ie, from a Linux perspective, it's a feature of the
"device". So it should be done in virtio itself, not the platform code.

However, we do want the ability in platform code to force the bounce
buffering to solve our secure VM issue.

Cheers,
Ben.
