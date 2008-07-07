Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD1D4DDF00
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:27:14 +1000 (EST)
Subject: Re: [PATCH] Power5,Power6 BSR driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sonny Rao <sonnyrao@us.ibm.com>
In-Reply-To: <20080707211740.GA15821@us.ibm.com>
References: <20080616185344.GB16192@gamma> <20080617223952.GA9594@localdomain>
	<20080617224443.GD7552@localhost.localdomain>
	<20080618065123.GB13318@localhost.localdomain>
	<1215406775.8970.57.camel@pasglop> <20080707211740.GA15821@us.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:26:57 +1000
Message-Id: <1215469617.8970.146.camel@pasglop>
Mime-Version: 1.0
Cc: sonnyrao@linux.vnet.ibm.com, paulus@samba.org, Nathan Lynch <ntl@pobox.com>,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 16:17 -0500, Sonny Rao wrote:
> On Mon, Jul 07, 2008 at 02:59:35PM +1000, Benjamin Herrenschmidt wrote:
> > 
> > > +		cur->bsr_addr   = reg[i * 2];
> > > +		cur->bsr_len    = reg[i * 2 + 1];
> > 
> > That's fishy... hand-reading of "reg" property without taking
> > into account the parent's #size-cells/#address-cells... can't you
> > use of_address_to_resource or something similar and carry a struct
> > resource around instead ?
> 
> So, with this suggestion I looked at the resource API... not very well
> documented, and I get the feeling like it's more for carving up a PCI
> memory address range.  In the case of the BSR, everything is already
> partitioned (by hardware) so I don't see the point of using this API
> here.  Or am I missing something about it?

It's about properly parsing a "reg" property in OF. The format of the
reg property depends on the parent #address-cells and #size-cells, and
the addresses in there may need remapping (or not) depending on parent
"ranges" properties. The special cases in prom_parse.c for PCI and ISA
are purely to deal with the additional address space flags those add to
addresses, but you shouldn't hit that with BSR.

> > In fact, same goes with the way you do num_bsr_devs = reg_len / 16.
> > 
> > You should rather use -another- property of well known lenght, or
> > get the #address/#size-cells of the parent and use those appropriately.
> 
> Well, I check to make sure the lengths are consistent with each other
> right above there so we shouldn't walk off the end of anything, but I
> will take a look at using #size-cells / #address-cells instead.

The code in prom_parse.c will do it for you :-)

Cheers,
Ben.
