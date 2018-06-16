Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416zlF0Pk0zDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 11:08:56 +1000 (AEST)
Message-ID: <1b4732c5015ee4377fef1de0270065174cde397a.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ram Pai <linuxram@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 robh@kernel.org, pawel.moll@arm.com, Tom Lendacky
 <thomas.lendacky@amd.com>, aik@ozlabs.ru,
 jasowang@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com, "Rustad, Mark
 D" <mark.d.rustad@intel.com>,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Sat, 16 Jun 2018 11:07:24 +1000
In-Reply-To: <20180615091624.GA1064@infradead.org>
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
 <20180615091624.GA1064@infradead.org>
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

On Fri, 2018-06-15 at 02:16 -0700, Christoph Hellwig wrote:
> On Wed, Jun 13, 2018 at 11:11:01PM +1000, Benjamin Herrenschmidt wrote:
> > Actually ... the stuff in lib/dma-direct.c seems to be just it, no ?
> > 
> > There's no cache flushing and there's no architecture hooks that I can
> > see other than the AMD security stuff which is probably fine.
> > 
> > Or am I missing something ?
> 
> You are missing the __phys_to_dma arch hook that allows architectures
> to adjust the dma address.  Various systems have offsets, or even
> multiple banks with different offsets there.  Most of them don't
> use the dma-direct code yet (working on it), but there are a few
> examples in the tree already.

Ok and on those systems, qemu will bypass said offset ? Maybe we could
just create a device DMA "flag" or (or use the attributes) to instruct
dma-direct to not use that for legacy virtio ?

Cheers,
Ben.
