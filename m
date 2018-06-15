Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416pfk4t3yzF13F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 04:19:26 +1000 (AEST)
Date: Fri, 15 Jun 2018 02:16:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ram Pai <linuxram@us.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, robh@kernel.org,
 pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>,
 aik@ozlabs.ru, jasowang@redhat.com, cohuck@redhat.com,
 linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 "Rustad, Mark D" <mark.d.rustad@intel.com>,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180615091624.GA1064@infradead.org>
References: <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
 <20180611023909.GA5726@ram.oc3035372033.ibm.com>
 <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
 <20180613074141.GA12033@infradead.org>
 <5dbcafa73b065bc619fd6adc9ef47eb6367b8378.camel@kernel.crashing.org>
 <10bbd7122aaa67f51de7a8328df8154212a13f23.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10bbd7122aaa67f51de7a8328df8154212a13f23.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2018 at 11:11:01PM +1000, Benjamin Herrenschmidt wrote:
> Actually ... the stuff in lib/dma-direct.c seems to be just it, no ?
> 
> There's no cache flushing and there's no architecture hooks that I can
> see other than the AMD security stuff which is probably fine.
> 
> Or am I missing something ?

You are missing the __phys_to_dma arch hook that allows architectures
to adjust the dma address.  Various systems have offsets, or even
multiple banks with different offsets there.  Most of them don't
use the dma-direct code yet (working on it), but there are a few
examples in the tree already.
