Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E252A2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 00:22:51 +1000 (EST)
Subject: Re: [PATCH] powerpc/fsl-pci: use 'Header Type' to identify PCIE mode
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1348039419-17798-1-git-send-email-Minghuan.Lian@freescale.com>
Date: Wed, 19 Sep 2012 09:22:48 -0500
Message-Id: <4FA47D63-B0ED-42BF-A075-174B6338A0E8@kernel.crashing.org>
References: <1348039419-17798-1-git-send-email-Minghuan.Lian@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 19, 2012, at 2:23 AM, Minghuan Lian wrote:

> The original code uses 'Programming Interface' field to judge if PCIE =
is
> EP or RC mode, however, some latest silicons do not support this =
functionality.
> According to PCIE specification, 'Header Type' offset 0x0e is used to
> indicate header type, so change code to use 'Header Type' field to
> judge PCIE mode. Because FSL PCI controller does not support 'Header =
Type',
> patch still uses 'Programming Interface' to identify PCI mode.
>=20
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |   38 =
+++++++++++++++++++++++---------------
> 1 file changed, 23 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
> index c37f461..43d30df 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -38,15 +38,15 @@ static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
>=20
> static void __devinit quirk_fsl_pcie_header(struct pci_dev *dev)
> {
> -	u8 progif;
> +	u8 hdr_type;
>=20
> 	/* if we aren't a PCIe don't bother */
> 	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
> 		return;
>=20
> 	/* if we aren't in host mode don't bother */
> -	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
> -	if (progif & 0x1)
> +	pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type);
> +	if ((hdr_type & 0x7f) !=3D PCI_HEADER_TYPE_BRIDGE)
> 		return;
>=20
> 	dev->class =3D PCI_CLASS_BRIDGE_PCI << 8;
> @@ -425,7 +425,7 @@ int __init fsl_add_bridge(struct device_node *dev, =
int is_primary)
> 	struct pci_controller *hose;
> 	struct resource rsrc;
> 	const int *bus_range;
> -	u8 progif;
> +	u8 hdr_type, progif;
>=20
> 	if (!of_device_is_available(dev)) {
> 		pr_warning("%s: disabled\n", dev->full_name);
> @@ -457,25 +457,24 @@ int __init fsl_add_bridge(struct device_node =
*dev, int is_primary)
> 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
> 		PPC_INDIRECT_TYPE_BIG_ENDIAN);
>=20
> -	early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
> -	if ((progif & 1) =3D=3D 1) {
> -		/* unmap cfg_data & cfg_addr separately if not on same =
page */
> -		if (((unsigned long)hose->cfg_data & PAGE_MASK) !=3D
> -		    ((unsigned long)hose->cfg_addr & PAGE_MASK))
> -			iounmap(hose->cfg_data);
> -		iounmap(hose->cfg_addr);
> -		pcibios_free_controller(hose);
> -		return -ENODEV;
> -	}
> -
> 	setup_pci_cmd(hose);

I think we should be doing the check before we call setup_pci_cmd().  =
The old code didn't touch the controller registers if we where and =
end-point.  We should maintain that.

>=20
> 	/* check PCI express link status */
> 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
> +		/* For PCIE read HEADER_TYPE to identify controler mode =
*/
> +		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, =
&hdr_type);
> +		if ((hdr_type & 0x7f) !=3D PCI_HEADER_TYPE_BRIDGE)
> +			goto no_bridge;
> +
> 		hose->indirect_type |=3D PPC_INDIRECT_TYPE_EXT_REG |
> 			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
> 		if (fsl_pcie_check_link(hose))
> 			hose->indirect_type |=3D =
PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> +	} else {
> +		/* For PCI read PROG to identify controller mode */
> +		early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, =
&progif);
> +		if ((progif & 1) =3D=3D 1)
> +			goto no_bridge;
> 	}
>=20
> 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
> @@ -494,6 +493,15 @@ int __init fsl_add_bridge(struct device_node =
*dev, int is_primary)
> 	setup_pci_atmu(hose, &rsrc);
>=20
> 	return 0;
> +
> +no_bridge:
> +	/* unmap cfg_data & cfg_addr separately if not on same page */
> +	if (((unsigned long)hose->cfg_data & PAGE_MASK) !=3D
> +	    ((unsigned long)hose->cfg_addr & PAGE_MASK))
> +		iounmap(hose->cfg_data);
> +	iounmap(hose->cfg_addr);
> +	pcibios_free_controller(hose);
> +	return -ENODEV;
> }
> #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
>=20
> --=20
> 1.7.9.5
>=20
