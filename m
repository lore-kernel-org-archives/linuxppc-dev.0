Return-Path: <aik@ozlabs.ru>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41JzXq6yHZzF1MY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 17:34:35 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id i23-v6so13866916iog.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 00:34:35 -0700 (PDT)
Date: Mon, 2 Jul 2018 17:34:26 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 alistair@popple.id.au, tpearson@raptorengineering.com
Subject: Re: [PATCH 1/3] powerpc/powernv/pci: Track largest available TCE
 order per PHB
Message-ID: <20180702173426.1254ecd0@aik.ozlabs.ibm.com>
In-Reply-To: <20180702173256.67254e00@aik.ozlabs.ibm.com>
References: <20180629073437.4060-1-ruscur@russell.cc>
 <20180629073437.4060-2-ruscur@russell.cc>
 <20180702173256.67254e00@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2 Jul 2018 17:32:56 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On Fri, 29 Jun 2018 17:34:35 +1000
> Russell Currey <ruscur@russell.cc> wrote:
> 
> > Knowing the largest possible TCE size of a PHB is useful, so get it
> > out of the device tree.  This relies on the property being added in
> > OPAL.
> > 
> > It is assumed that any PHB4 or later machine would be running
> > firmware that implemented this property, and otherwise assumed to
> > be PHB3, which has a maximum TCE order of 28 bits or 256MB TCEs.
> > 
> > This is used later in the series.
> > 
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > ---
> >  arch/powerpc/platforms/powernv/pci-ioda.c | 16 ++++++++++++++++
> >  arch/powerpc/platforms/powernv/pci.h      |  3 +++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> > b/arch/powerpc/platforms/powernv/pci-ioda.c index
> > 5bd0eb6681bc..17c590087279 100644 ---
> > a/arch/powerpc/platforms/powernv/pci-ioda.c +++
> > b/arch/powerpc/platforms/powernv/pci-ioda.c @@ -3873,11 +3873,13 @@
> > static void __init pnv_pci_init_ioda_phb(struct device_node *np,
> > struct resource r; const __be64 *prop64;
> >  	const __be32 *prop32;
> > +	struct property *prop;
> >  	int len;
> >  	unsigned int segno;
> >  	u64 phb_id;
> >  	void *aux;
> >  	long rc;
> > +	u32 val;
> >  
> >  	if (!of_device_is_available(np))
> >  		return;
> > @@ -4016,6 +4018,20 @@ static void __init
> > pnv_pci_init_ioda_phb(struct device_node *np, }
> >  	phb->ioda.pe_array = aux + pemap_off;
> >  
> > +	phb->ioda.max_tce_order = 0;
> > +	/* Get TCE order from the DT.  If it's not present, assume
> > P8 */
> > +	if (!of_get_property(np, "ibm,supported-tce-sizes", NULL))
> > {
> > +		phb->ioda.max_tce_order = 28; /* assume P8 256mb
> > TCEs */
> > +	} else {
> > +		of_property_for_each_u32(np,
> > "ibm,supported-tce-sizes", prop,
> > +					 prop32, val) {
> > +			if (val > phb->ioda.max_tce_order)
> > +				phb->ioda.max_tce_order = val;
> > +		}
> > +		pr_debug("PHB%llx Found max TCE order of %d
> > bits\n",
> > +			 phb->opal_id, phb->ioda.max_tce_order);
> > +	}  
> 
> 
> pnv_ioda_parse_tce_sizes() does this, use it. It even reports 256MB
> pages for P8 as in v4.18-rc3.


ah, not, not in rc3, my bad. I'll post it soon.


--
Alexey
