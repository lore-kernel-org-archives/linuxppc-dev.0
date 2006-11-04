Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B0DA67BD2
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 08:54:02 +1100 (EST)
Subject: Re: [PATCH/RFC] powerpc: Create PCI busses from of_platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <A9F3AC31-AB61-4E39-86D7-B14B96B50B4D@kernel.crashing.org>
References: <1162589327.10630.125.camel@localhost.localdomain>
	<A9F3AC31-AB61-4E39-86D7-B14B96B50B4D@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 08:53:56 +1100
Message-Id: <1162677236.28571.43.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-04 at 16:40 +0100, Segher Boessenkool wrote:
> > +static struct of_device_id of_pci_phb_ids[] = {
> > +	{ .type = "pci", },
> > +	{ .type = "pcix", },
> > +	{ .type = "pcie", },
> > +	{ .type = "pciex", },
> > +	{ .type = "ht", },
> > +	{}
> > +};
> > +
> > +static struct of_platform_driver of_pci_phb_driver = {
> > +       .name = "of-pci",
> > +       .match_table = of_pci_phb_ids,
> > +       .probe = of_pci_phb_probe,
> > +       .driver = {
> > +	       .multithread_probe = 1,
> > +       },
> > +};
> 
> Shouldn't you also/only check for compatible=pci?  Or maybe
> that would give too much fallout from all the broken device
> trees out there?

We can add things when we need them. This mecanism is to be used by
platforms who register of_device's for the PHBs. Currently, this will
only happen with Cell, so I only need to deal with what's there (I could
even remove 'ht' from the list :-)

As more platforms want to use it, they can fine-tune the list and probe
function.

Ben.
