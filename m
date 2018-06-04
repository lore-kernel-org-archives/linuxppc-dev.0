Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zy940dppzF0mR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:33:27 +1000 (AEST)
Message-ID: <acdfef1327f73f6ac67645d9f1a8e9204a0f22fb.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au
Date: Mon, 04 Jun 2018 23:14:36 +1000
In-Reply-To: <20180604125530.GA16378@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
 <20180604153558-mutt-send-email-mst@kernel.org>
 <20180604125530.GA16378@infradead.org>
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

On Mon, 2018-06-04 at 05:55 -0700, Christoph Hellwig wrote:
> On Mon, Jun 04, 2018 at 03:43:09PM +0300, Michael S. Tsirkin wrote:
> > Another is that given the basic functionality is in there, optimizations
> > can possibly wait until per-device quirks in DMA API are supported.
> 
> We have had per-device dma_ops for quite a while.

I've asked Ansuman to start with a patch that converts virtio to use
DMA ops always, along with an init quirk to hookup "direct" ops when
the IOMMU flag isn't set.

This will at least remove that horrid duplication of code path we have
in there.

Then we can just involve the arch in that init quirk so we can chose an
alternate set of ops when running a secure VM.

This is completely orthogonal to whether an iommu exist qemu side or
not, and should be entirely solved on the Linux side.

Cheers,
Ben.
