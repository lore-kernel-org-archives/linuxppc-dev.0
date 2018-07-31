Return-Path: <BATV+736af7e55a6f7db1fe82+5455+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41g48x0TYjzF14h
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 04:05:02 +1000 (AEST)
Date: Tue, 31 Jul 2018 10:30:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
 jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180731173052.GA17153@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730155633-mutt-send-email-mst@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2018 at 04:26:32PM +0300, Michael S. Tsirkin wrote:
> Real hardware would reuse parts of the interface but by necessity it
> needs to behave slightly differently on some platforms.  However for
> some platforms (such as x86) a PV virtio driver will by luck work with a
> PCI device backend without changes. As these platforms and drivers are
> widely deployed, some people will deploy hardware like that.  Should be
> a non issue as by definition it's transparent to guests.

On some x86.  As soon as you have an iommu or strange PCI root ports
things are going to start breaking apart.

> > And that very much excludes arch-specific (or
> > Xen-specific) overrides.
> 
> We already committed to a xen specific hack but generally I prefer
> devices that describe how they work instead of platforms magically
> guessing, yes.

For legacy reasons I guess we'll have to keep it, but we really need
to avoid adding more junk than this.

> However the question people raise is that DMA API is already full of
> arch-specific tricks the likes of which are outlined in your post linked
> above. How is this one much worse?

None of these warts is visible to the driver, they are all handled in
the architecture (possibly on a per-bus basis).

So for virtio we really need to decide if it has one set of behavior
as specified in the virtio spec, or if it behaves exactly as if it
was on a PCI bus, or in fact probably both as you lined up.  But no
magic arch specific behavior inbetween.
