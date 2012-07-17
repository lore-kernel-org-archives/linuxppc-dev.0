Return-Path: <linuxram@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2EF882C0180
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 15:57:25 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 16 Jul 2012 23:57:23 -0600
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 02D34C90052
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 01:57:21 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6H5vKVU422934
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 01:57:20 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6HBSDrJ013541
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 07:28:13 -0400
Date: Tue, 17 Jul 2012 13:57:15 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
Message-ID: <20120717055715.GF2369@ram-ThinkPad-T61>
References: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
 <20120717050547.GD2369@ram-ThinkPad-T61>
 <20120717052333.GE2369@ram-ThinkPad-T61>
 <20120717053648.GA18497@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120717053648.GA18497@shangw>
Cc: linux-pci@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
 linuxppc-dev@ozlabs.org, bhelgaas@google.com, yinghai@kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2012 at 01:36:49PM +0800, Gavin Shan wrote:
> On Tue, Jul 17, 2012 at 01:23:33PM +0800, Ram Pai wrote:
> >On Tue, Jul 17, 2012 at 01:05:47PM +0800, Ram Pai wrote:
> >> On Tue, Jul 17, 2012 at 10:23:17AM +0800, Gavin Shan wrote:
> >> > The patch changes function pbus_size_io() and pbus_size_mem() to
> >> > do resource (I/O, memory and prefetchable memory) reassignment
> >> > based on the minimal alignments for the p2p bridge, which was
> >> > retrieved by function window_alignment().
> >> > 
> >> > Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> 
> [snip]
> 
> >> > @@ -772,11 +775,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> >> >  		return;
> >> >  	}
> >> >  	/* Alignment of the IO window is always 4K */
> >> > -	b_res->start = 4096;
> >> > +	b_res->start = io_align;
> >> >  	b_res->end = b_res->start + size0 - 1;
> >> >  	b_res->flags |= IORESOURCE_STARTALIGN;
> >> >  	if (size1 > size0 && realloc_head) {
> >> > -		add_to_list(realloc_head, bus->self, b_res, size1-size0, 4096);
> >> > +		add_to_list(realloc_head, bus->self, b_res, size1-size0, io_align);
> >> >  		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
> >> >  				 "%pR to [bus %02x-%02x] add_size %lx\n", b_res,
> >> >  				 bus->secondary, bus->subordinate, size1-size0);
> >> > @@ -875,6 +878,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >> >  			min_align = align1 >> 1;
> >> >  		align += aligns[order];
> >> >  	}
> >> > +
> >> > +	min_align = max(min_align, window_alignment(bus, type));
> >> 
> >>   'type' can sometimes be (IORESOURCE_MEM | IORESOURCE_PREFETCH), which
> >>   can lead to unpredictable results depending on how window_alignment()
> >>   is implemented... Hence to be on the safer side I suggest
> >> 
> >> 	min_align = max(min_align, window_alignment(bus, b_res->flags & mask));
> 
> Sorry, Ram. I didn't see your concern in last reply. So I have to
> cover your conver in this reply.
> 
> I think it'd better to pass "type" directly because platform (e.g. powernv)
> expects both IORESOURCE_MEM as well as IORESOURCE_PREFETCH. 
> In future, powernv platform will return M32 segment size for IORESOURCE_MEM, but
> might return M64 segment size for (IORESOURCE_MEM | IORESOURCE_PREFETCH).

Hmm.. this code is not about determining what kind of segment the
platform is returning. This code is about using the right alignment
constraints for the type of segment from which resource will be
allocated. right?

b_res is the resource that is being sized. b_res already knows
what kind of resource it is, i.e IORESOURCE_MEM or IORESOURCE_PREFETCH.
Hence we should be exactly using the same alignment constraints as
that dictated by the type of b_res. no?

RP
