Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70B8CDDE34
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 03:07:12 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48H79T2018266
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 13:07:09 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48H78Hh501806
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 13:07:08 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48H78KR005640
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 13:07:08 -0400
Subject: Re: [PATCH v4 4/7] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20070508164513.GD19780@localdomain>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com>
	<1178573318.2990.206.camel@zod.rchland.ibm.com>
	<20070508164513.GD19780@localdomain>
Content-Type: text/plain
Date: Tue, 08 May 2007 12:01:26 -0500
Message-Id: <1178643686.3453.37.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-08 at 11:45 -0500, Nathan Lynch wrote:
> Hi Josh-
> 
> I see this has been picked up by Paul already, but there are a couple
> minor things I noticed as I was reading the patch.

That's fine.  Comments are still welcome since I do plan on adding a bit
more a bit down the road.  I'll make sure to note them and fix them up.

> > +int holly_exclude_device(u_char bus, u_char devfn)
> > +{
> > +	if (bus == 0 && PCI_SLOT(devfn) == 0)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +	else
> > +		return PCIBIOS_SUCCESSFUL;
> > +}
> 
> This function could be static, I think?  Looks like it's assigned to
> ppc_md.pci_exclude_device and called through that.

Yes, could be I think.

> > +static void __init holly_init_IRQ(void)
> > +{
> > +	struct mpic *mpic;
> > +	phys_addr_t mpic_paddr = 0;
> > +	struct device_node *tsi_pic;
> > +#ifdef CONFIG_PCI
> > +	unsigned int cascade_pci_irq;
> > +	struct device_node *tsi_pci;
> > +	struct device_node *cascade_node = NULL;
> > +#endif
> > +
> > +	tsi_pic = of_find_node_by_type(NULL, "open-pic");
> > +	if (tsi_pic) {
> > +		unsigned int size;
> > +		const void *prop = of_get_property(tsi_pic, "reg", &size);
> > +		mpic_paddr = of_translate_address(tsi_pic, prop);
> > +	}
> 
> You don't actually need 'size' there; it's legal to pass NULL to
> of_get_property.

Yep.

josh
