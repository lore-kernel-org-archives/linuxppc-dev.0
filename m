Return-Path: <sam.mj@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A21C91A1803
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 11:09:46 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.mj@au1.ibm.com>;
 Thu, 21 Jan 2016 10:09:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BD7502BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 11:09:39 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0L09V1Z52953110
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 11:09:39 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0L09670031612
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 11:09:07 +1100
Date: Thu, 21 Jan 2016 11:08:42 +1100
From: Sam Mendoza-Jonas <sam@mendozajonas.com>
To: Russell Currey <ruscur@russell.cc>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh: Fix PE location code
Message-ID: <20160121000842.GB10361@localhost.localdomain>
References: <1449033932-27307-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1453262173.1201.2.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1453262173.1201.2.camel@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 20, 2016 at 02:56:13PM +1100, Russell Currey wrote:
> On Wed, 2015-12-02 at 16:25 +1100, Gavin Shan wrote:
> > In eeh_pe_loc_get(), the PE location code is retrieved from the
> > "ibm,loc-code" property of the device node for the bridge of the
> > PE's primary bus. It's not correct because the property indicates
> > the parent PE's location code.
> > 
> > This reads the correct PE location code from "ibm,io-base-loc-code"
> > or "ibm,slot-location-code" property of PE parent bus's device node.
> > 
> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > ---
> 
> Tested-by: Russell Currey <ruscur@russell.cc>

Thanks Russell!

W.R.T including this in stable, I don't believe anything actively breaks
without the patch, but in the event of an EEH freeze the wrong slot for
the device will be identified, making troubleshooting more difficult.
> >  arch/powerpc/kernel/eeh_pe.c | 33 +++++++++++++++------------------
> >  1 file changed, 15 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> > index 8654cb1..ca9e537 100644
> > --- a/arch/powerpc/kernel/eeh_pe.c
> > +++ b/arch/powerpc/kernel/eeh_pe.c
> > @@ -883,32 +883,29 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
> >  const char *eeh_pe_loc_get(struct eeh_pe *pe)
> >  {
> >  	struct pci_bus *bus = eeh_pe_bus_get(pe);
> > -	struct device_node *dn = pci_bus_to_OF_node(bus);
> > +	struct device_node *dn;
> >  	const char *loc = NULL;
> >  
> > -	if (!dn)
> > -		goto out;
> > +	while (bus) {
> > +		dn = pci_bus_to_OF_node(bus);
> > +		if (!dn) {
> > +			bus = bus->parent;
> > +			continue;
> > +		}
> >  
> > -	/* PHB PE or root PE ? */
> > -	if (pci_is_root_bus(bus)) {
> > -		loc = of_get_property(dn, "ibm,loc-code", NULL);
> > -		if (!loc)
> > +		if (pci_is_root_bus(bus))
> >  			loc = of_get_property(dn, "ibm,io-base-loc-
> > code", NULL);
> > +		else
> > +			loc = of_get_property(dn, "ibm,slot-location-
> > code",
> > +					      NULL);
> > +
> >  		if (loc)
> > -			goto out;
> > +			return loc;
> >  
> > -		/* Check the root port */
> > -		dn = dn->child;
> > -		if (!dn)
> > -			goto out;
> > +		bus = bus->parent;
> >  	}
> >  
> > -	loc = of_get_property(dn, "ibm,loc-code", NULL);
> > -	if (!loc)
> > -		loc = of_get_property(dn, "ibm,slot-location-code",
> > NULL);
> > -
> > -out:
> > -	return loc ? loc : "N/A";
> > +	return "N/A";
> >  }
> >  
> >  /**
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
