Return-Path: <B32579@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7FC70B6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 21:40:49 +1000 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/85xx: add host-pci(e) bridge only for RC
Date: Thu, 19 May 2011 11:25:31 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F8741D5C9C@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1303882532-25615-1-git-send-email-prabhakar@freescale.com>
	<7E57A9FF-9BB3-4C5A-9965-E56A4E35B1B8@kernel.crashing.org>
In-Reply-To: <7E57A9FF-9BB3-4C5A-9965-E56A4E35B1B8@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "meet2prabhu@gmail.com" <meet2prabhu@gmail.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kumar,
  Please find my answer in-lined

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, May 19, 2011 11:55 AM
> To: Kushwaha Prabhakar-B32579
> Cc: linuxppc-dev@lists.ozlabs.org; meet2prabhu@gmail.com; Vivek Mahajan
> Subject: Re: [PATCH] powerpc/85xx: add host-pci(e) bridge only for RC
>=20
>=20
> On Apr 27, 2011, at 12:35 AM, Prabhakar Kushwaha wrote:
>=20
> > FSL PCIe controller can act as agent(EP) or host(RC).
> > Under Agent(EP) mode they are configured via Host. So it is not
> > required to add with the PCI(e) sub-system.
> >
> > Add and configure PCIe controller only for RC mode.
> >
> > Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
> > Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> > ---
> > Based upon
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(b
> > ranch master)
> >
> > arch/powerpc/sysdev/fsl_pci.c |   14 ++++++++++++++
> > 1 files changed, 14 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> > b/arch/powerpc/sysdev/fsl_pci.c index 68ca929..87ac11b 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -323,6 +323,7 @@ int __init fsl_add_bridge(struct device_node *dev,
> int is_primary)
> > 	struct pci_controller *hose;
> > 	struct resource rsrc;
> > 	const int *bus_range;
> > +	u8 is_agent;
> >
> > 	if (!of_device_is_available(dev)) {
> > 		pr_warning("%s: disabled\n", dev->full_name); @@ -353,6
> +354,19 @@
> > int __init fsl_add_bridge(struct device_node *dev, int is_primary)
> >
> > 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
> > 		PPC_INDIRECT_TYPE_BIG_ENDIAN);
> > +
> > +	early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &is_agent);
>=20
> Why are we looking at PCI_HEADER_TYPE?  We should look at PCI_CLASS_PROG.

I think both are OK. We can check for any one.=20
Is there any problem with PCI_HEADER_TYPE?


> > +	if ((is_agent & 0x7f) =3D=3D PCI_HEADER_TYPE_NORMAL) {
> > +		u32 temp;
> > +
> > +		temp =3D (u32)hose->cfg_data & ~PAGE_MASK;
> > +		if (((u32)hose->cfg_data & PAGE_MASK) !=3D (u32)hose->cfg_addr)
> > +			iounmap(hose->cfg_data - temp);
> > +		iounmap(hose->cfg_addr);
> > +		pcibios_free_controller(hose);
> > +		return 0;
> > +	}
> > +
> > 	setup_pci_cmd(hose);
> >
> > 	/* check PCI express link status */
> > --
> > 1.7.3
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
