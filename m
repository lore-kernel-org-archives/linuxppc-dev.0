Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KY9h1WWRzF1LM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 15:49:58 +1000 (AEST)
Message-ID: <8e6ab216ef609df96087d01e9e0dd69906e6e9ee.camel@russell.cc>
Subject: Re: [PATCH 1/3] powerpc/powernv/pci: Track largest available TCE
 order per PHB
From: Russell Currey <ruscur@russell.cc>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 alistair@popple.id.au, tpearson@raptorengineering.com
Date: Tue, 03 Jul 2018 15:49:47 +1000
In-Reply-To: <20180702173426.1254ecd0@aik.ozlabs.ibm.com>
References: <20180629073437.4060-1-ruscur@russell.cc>
 <20180629073437.4060-2-ruscur@russell.cc>
 <20180702173256.67254e00@aik.ozlabs.ibm.com>
 <20180702173426.1254ecd0@aik.ozlabs.ibm.com>
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

On Mon, 2018-07-02 at 17:34 +1000, Alexey Kardashevskiy wrote:
> On Mon, 2 Jul 2018 17:32:56 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
> > On Fri, 29 Jun 2018 17:34:35 +1000
> > Russell Currey <ruscur@russell.cc> wrote:
> > 
> > > Knowing the largest possible TCE size of a PHB is useful, so get
> > > it
> > > out of the device tree.  This relies on the property being added
> > > in
> > > OPAL.
> > > 
> > > It is assumed that any PHB4 or later machine would be running
> > > firmware that implemented this property, and otherwise assumed to
> > > be PHB3, which has a maximum TCE order of 28 bits or 256MB TCEs.
> > > 
> > > This is used later in the series.
> > > 
> > > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > > ---
> > >  arch/powerpc/platforms/powernv/pci-ioda.c | 16 ++++++++++++++++
> > >  arch/powerpc/platforms/powernv/pci.h      |  3 +++
> > >  2 files changed, 19 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> > > b/arch/powerpc/platforms/powernv/pci-ioda.c index
> > > 5bd0eb6681bc..17c590087279 100644 ---
> > > a/arch/powerpc/platforms/powernv/pci-ioda.c +++
> > > b/arch/powerpc/platforms/powernv/pci-ioda.c @@ -3873,11 +3873,13
> > > @@
> > > static void __init pnv_pci_init_ioda_phb(struct device_node *np,
> > > struct resource r; const __be64 *prop64;
> > >  	const __be32 *prop32;
> > > +	struct property *prop;
> > >  	int len;
> > >  	unsigned int segno;
> > >  	u64 phb_id;
> > >  	void *aux;
> > >  	long rc;
> > > +	u32 val;
> > >  
> > >  	if (!of_device_is_available(np))
> > >  		return;
> > > @@ -4016,6 +4018,20 @@ static void __init
> > > pnv_pci_init_ioda_phb(struct device_node *np, }
> > >  	phb->ioda.pe_array = aux + pemap_off;
> > >  
> > > +	phb->ioda.max_tce_order = 0;
> > > +	/* Get TCE order from the DT.  If it's not present,
> > > assume
> > > P8 */
> > > +	if (!of_get_property(np, "ibm,supported-tce-sizes",
> > > NULL))
> > > {
> > > +		phb->ioda.max_tce_order = 28; /* assume P8 256mb
> > > TCEs */
> > > +	} else {
> > > +		of_property_for_each_u32(np,
> > > "ibm,supported-tce-sizes", prop,
> > > +					 prop32, val) {
> > > +			if (val > phb->ioda.max_tce_order)
> > > +				phb->ioda.max_tce_order = val;
> > > +		}
> > > +		pr_debug("PHB%llx Found max TCE order of %d
> > > bits\n",
> > > +			 phb->opal_id, phb->ioda.max_tce_order);
> > > +	}  
> > 
> > 
> > pnv_ioda_parse_tce_sizes() does this, use it. It even reports 256MB
> > pages for P8 as in v4.18-rc3.
> 
> 
> ah, not, not in rc3, my bad. I'll post it soon.

Sure, whatever works, no need for duplication

> 
> 
> --
> Alexey
