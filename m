Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A27DB6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 16:25:22 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: add host-pci(e) bridge only for RC
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1303882532-25615-1-git-send-email-prabhakar@freescale.com>
Date: Thu, 19 May 2011 01:25:12 -0500
Message-Id: <7E57A9FF-9BB3-4C5A-9965-E56A4E35B1B8@kernel.crashing.org>
References: <1303882532-25615-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: meet2prabhu@gmail.com, linuxppc-dev@lists.ozlabs.org,
	Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 27, 2011, at 12:35 AM, Prabhakar Kushwaha wrote:

> FSL PCIe controller can act as agent(EP) or host(RC).
> Under Agent(EP) mode they are configured via Host. So it is not =
required to add
> with the PCI(e) sub-system.
>=20
> Add and configure PCIe controller only for RC mode.
>=20
> Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branc=
h master)
>=20
> arch/powerpc/sysdev/fsl_pci.c |   14 ++++++++++++++
> 1 files changed, 14 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
> index 68ca929..87ac11b 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -323,6 +323,7 @@ int __init fsl_add_bridge(struct device_node *dev, =
int is_primary)
> 	struct pci_controller *hose;
> 	struct resource rsrc;
> 	const int *bus_range;
> +	u8 is_agent;
>=20
> 	if (!of_device_is_available(dev)) {
> 		pr_warning("%s: disabled\n", dev->full_name);
> @@ -353,6 +354,19 @@ int __init fsl_add_bridge(struct device_node =
*dev, int is_primary)
>=20
> 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
> 		PPC_INDIRECT_TYPE_BIG_ENDIAN);
> +
> +	early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &is_agent);

Why are we looking at PCI_HEADER_TYPE?  We should look at =
PCI_CLASS_PROG.

> +	if ((is_agent & 0x7f) =3D=3D PCI_HEADER_TYPE_NORMAL) {
> +		u32 temp;
> +
> +		temp =3D (u32)hose->cfg_data & ~PAGE_MASK;
> +		if (((u32)hose->cfg_data & PAGE_MASK) !=3D =
(u32)hose->cfg_addr)
> +			iounmap(hose->cfg_data - temp);
> +		iounmap(hose->cfg_addr);
> +		pcibios_free_controller(hose);
> +		return 0;
> +	}
> +
> 	setup_pci_cmd(hose);
>=20
> 	/* check PCI express link status */
> --=20
> 1.7.3
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
