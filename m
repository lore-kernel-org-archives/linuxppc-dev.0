Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id C53ECDDE05
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2008 22:54:18 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Add MPC837x PCIE controller RC mode support
Date: Wed, 2 Jan 2008 12:53:07 +0100
References: <1199272605.22416.8.camel@Guyver>
In-Reply-To: <1199272605.22416.8.camel@Guyver>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801021253.08280.arnd@arndb.de>
Cc: Wood Scott <scottwood@freescale.com>,
	kim phillips <Kim.Phillips@freescale.com>, Li Li <r64360@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 02 January 2008, Li Li wrote:
> =A0#ifdef CONFIG_PCI
> -=A0=A0=A0=A0=A0=A0=A0for_each_compatible_node(np, "pci", "fsl,mpc8349-pc=
i")
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mpc83xx_add_bridge(np);
> +=A0=A0=A0=A0=A0=A0=A0for_each_compatible_node(np, "pci", "fsl,mpc8349-pc=
i") {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (primary_pci_bus) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mpc=
83xx_add_bridge(np, PPC_83XX_PCI | PPC_83XX_PCI_PRIMARY);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pri=
mary_pci_bus =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mpc=
83xx_add_bridge(np, PPC_83XX_PCI);
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> +=A0=A0=A0=A0=A0=A0=A0for_each_compatible_node(np, "pci", "fsl,mpc8377-pc=
ie") {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (primary_pci_bus) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mpc=
83xx_add_bridge(np, PPC_83XX_PCIE | PPC_83XX_PCI_PRIMARY);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pri=
mary_pci_bus =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mpc=
83xx_add_bridge(np, PPC_83XX_PCIE);
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> +=A0=A0=A0=A0=A0=A0=A0ppc_md.pci_exclude_device =3D mpc837x_exclude_devic=
e;
> =A0#endif

A few comments on how I think this can be improved:

* Instead of duplicating this code across all platforms, make a single
function that does the probing in one place (including the #ifdef
CONFIG_PCI).

* Better yet, get rid of mpc83xx_add_bridge and make it possible for the
mpc83xx code to use the of_pci_phb_driver from
arch/powerpc/kernel/of_platform.c. This used to be impossible because
of the differences  between 32 and 64 bit code for PCI probing, but
I think with the work than benh put into unifying the two, we should
be pretty close now.

* The detection method for the primary bus is somewhat fragile, because
we depend on the order of the nodes in the device tree, which is not
specified to have a meaning. /Maybe/ there could be a property in
(at most) one of the PCI host bridge nodes saying that this specific bus
is the primary one.

* Since you are using exactly the same probing code for pci and pcie,
you may want to check for a more generic "compatible" property than
the specific model, so you can use the same code for both.

	Arnd <><
