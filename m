Return-Path: <Tony.Li@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1665DDE30
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 17:54:37 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m036sMfp005795
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jan 2008 23:54:22 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m036sLAc012366
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jan 2008 00:54:21 -0600 (CST)
Subject: Re: [PATCH] powerpc: Add MPC837x PCIE controller RC mode support
From: Li Li <r64360@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200801021253.08280.arnd@arndb.de>
References: <1199272605.22416.8.camel@Guyver>
	<200801021253.08280.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 03 Jan 2008 14:40:40 +0800
Message-Id: <1199342440.7375.29.camel@Guyver>
Mime-Version: 1.0
Cc: Wood Scott <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Phillips Kim <Kim.Phillips@freescale.com>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-01-02 at 19:53 +0800, Arnd Bergmann wrote:
> On Wednesday 02 January 2008, Li Li wrote: 
> >  #ifdef CONFIG_PCI 
> > -       for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") 
> > -               mpc83xx_add_bridge(np); 
> > +       for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") { 
> > +               if (primary_pci_bus) { 
> > +                       mpc83xx_add_bridge(np, PPC_83XX_PCI |
> PPC_83XX_PCI_PRIMARY); 
> > +                       primary_pci_bus = 0; 
> > +               } else 
> > +                       mpc83xx_add_bridge(np, PPC_83XX_PCI); 
> > +       } 
> > + 
> > +       for_each_compatible_node(np, "pci", "fsl,mpc8377-pcie") { 
> > +               if (primary_pci_bus) { 
> > +                       mpc83xx_add_bridge(np, PPC_83XX_PCIE |
> PPC_83XX_PCI_PRIMARY); 
> > +                       primary_pci_bus = 0; 
> > +               } else 
> > +                       mpc83xx_add_bridge(np, PPC_83XX_PCIE); 
> > +       } 
> > + 
> > +       ppc_md.pci_exclude_device = mpc837x_exclude_device; 
> >  #endif
> 
> A few comments on how I think this can be improved:
> 
> * Instead of duplicating this code across all platforms, make a
> single 
> function that does the probing in one place (including the #ifdef 
> CONFIG_PCI).
> 

This code appears in 834x board in first and then copied from one board
to another. It is a legacy issue. :(
Yes. it is the time to remove this duplicates.

> * Better yet, get rid of mpc83xx_add_bridge and make it possible for
> the 
> mpc83xx code to use the of_pci_phb_driver from 
> arch/powerpc/kernel/of_platform.c. This used to be impossible because 
> of the differences  between 32 and 64 bit code for PCI probing, but 
> I think with the work than benh put into unifying the two, we should 
> be pretty close now.
> 

This is really a huge task and almost affects all exist boards. We need
more opinions in here. 


> * The detection method for the primary bus is somewhat fragile,
> because 
> we depend on the order of the nodes in the device tree, which is not 
> specified to have a meaning. /Maybe/ there could be a property in 
> (at most) one of the PCI host bridge nodes saying that this specific
> bus 
> is the primary one.
> 

Put this primary in code is more save than in dts.
The dts lacks error checking function. If provide error dts such as two
pci hosts both has primary property will occur chaos.

> * Since you are using exactly the same probing code for pci and pcie, 
> you may want to check for a more generic "compatible" property than 
> the specific model, so you can use the same code for both.
> 
>         Arnd <><
> 
