Return-Path: <BATV+f549808562659eaf3d0e+5464+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mHk86BgYzDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 16:03:28 +1000 (AEST)
Date: Wed, 8 Aug 2018 22:40:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
 jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180809054013.GA20507@infradead.org>
References: <20180807062117.GD32709@infradead.org>
 <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
 <20180807135505.GA29034@infradead.org>
 <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
 <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
 <20180808123036.GA2525@infradead.org>
 <b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
 <20180808232210-mutt-send-email-mst@kernel.org>
 <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2018 at 08:13:32AM +1000, Benjamin Herrenschmidt wrote:
> > > -	if (xen_domain())
> > > +	if (xen_domain() || pseries_secure_vm())
> > > 		return true;
> > 
> > I don't think it's pseries specific actually. E.g. I suspect AMD SEV
> > might benefit from the same kind of hack.
> 
> As long as they can provide the same guarantee that the DMA ops are
> completely equivalent between virtio and other PCI devices, at least on
> the same bus, ie, we don't have to go hack special DMA ops.
> 
> I think the latter is really what Christoph wants to avoid for good
> reasons.

Yes.  I also generally want to avoid too much arch specific magic.

FYI, I'm off to a week-long vacation today, don't expect quick replies.
