Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB3AA1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 May 2011 10:50:32 +1000 (EST)
Subject: Re: [PATCH 3/3] [repost] powerpc/eeh: Display eeh error location
	for bus and device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard A Lary <rlary@linux.vnet.ibm.com>
In-Reply-To: <1304642771.2513.487.camel@pasglop>
References: <4DC1D9CE.4050104@linux.vnet.ibm.com>
	<1304642771.2513.487.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 May 2011 10:50:09 +1000
Message-ID: <1304643009.2513.488.camel@pasglop>
Mime-Version: 1.0
Cc: antonb@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-05-06 at 10:46 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2011-05-04 at 15:57 -0700, Richard A Lary wrote:
> > From: Richard A Lary <rlary@linux.vnet.ibm.com>
> > 
> >   For adapters which have devices under a PCIe switch/bridge it is informative
> >   to display information for both the PCIe switch/bridge and the device on
> >   which the bus error was detected.
> > 
> >   rebased to powerpc-next
> > 
> > Signed-off-by: Richard A Lary <rlary@linux.vnet.ibm.com>
> > ---
> 
> Not sure what you're doing but it still doesn't apply for me. I think
> the patch is whitespace damaged. IE. Some spaces have been added at
> the beginning of each line. IE. "context" lines (nor patch lines
> that start with - or +) seem to have -two- spaces at the beginning
> of each line for some reason.
> 
> I suspect whatever you're using for email is corrupting patches.

BTW. I've hand applied it this time.

Cheers,
Ben.

> Cheers,
> Ben.
> 
> > ---
> >   arch/powerpc/platforms/pseries/eeh_driver.c |   22 	13 +	9 -	0 !
> >   1 file changed, 13 insertions(+), 9 deletions(-)
> > 
> > Index: b/arch/powerpc/platforms/pseries/eeh_driver.c
> > ===================================================================
> > --- a/arch/powerpc/platforms/pseries/eeh_driver.c
> > +++ b/arch/powerpc/platforms/pseries/eeh_driver.c
> > @@ -328,7 +328,7 @@ struct pci_dn * handle_eeh_events (struc
> >   	struct pci_bus *frozen_bus;
> >   	int rc = 0;
> >   	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
> > -	const char *location, *pci_str, *drv_str;
> > +	const char *location, *pci_str, *drv_str, *bus_pci_str, *bus_drv_str;
> > 
> >   	frozen_dn = find_device_pe(event->dn);
> >   	if (!frozen_dn) {
> > @@ -364,13 +364,8 @@ struct pci_dn * handle_eeh_events (struc
> >   	frozen_pdn = PCI_DN(frozen_dn);
> >   	frozen_pdn->eeh_freeze_count++;
> > 
> > -	if (frozen_pdn->pcidev) {
> > -		pci_str = pci_name (frozen_pdn->pcidev);
> > -		drv_str = pcid_name (frozen_pdn->pcidev);
> > -	} else {
> > -		pci_str = eeh_pci_name(event->dev);
> > -		drv_str = pcid_name (event->dev);
> > -	}
> > +	pci_str = eeh_pci_name(event->dev);
> > +	drv_str = pcid_name(event->dev);
> >   	
> >   	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
> >   		goto excess_failures;
> > @@ -378,8 +373,17 @@ struct pci_dn * handle_eeh_events (struc
> >   	printk(KERN_WARNING
> >   	   "EEH: This PCI device has failed %d times in the last hour:\n",
> >   		frozen_pdn->eeh_freeze_count);
> > +
> > +	if (frozen_pdn->pcidev) {
> > +		bus_pci_str = pci_name(frozen_pdn->pcidev);
> > +		bus_drv_str = pcid_name(frozen_pdn->pcidev);
> > +		printk(KERN_WARNING
> > +			"EEH: Bus location=%s driver=%s pci addr=%s\n",
> > +			location, bus_drv_str, bus_pci_str);
> > +	}
> > +
> >   	printk(KERN_WARNING
> > -		"EEH: location=%s driver=%s pci addr=%s\n",
> > +		"EEH: Device location=%s driver=%s pci addr=%s\n",
> >   		location, drv_str, pci_str);
> > 
> >   	/* Walk the various device drivers attached to this slot through
> 
