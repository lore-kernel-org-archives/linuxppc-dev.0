Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B7887B6F83
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2011 00:09:53 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc/fsl-pci: Only scan PCI bus if configured as a
 host
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1319789023-8924-2-git-send-email-B38951@freescale.com>
Date: Fri, 28 Oct 2011 08:09:45 -0500
Message-Id: <A40D3EA1-8172-4267-A509-2409CF32310D@kernel.crashing.org>
References: <1319789023-8924-1-git-send-email-B38951@freescale.com>
 <1319789023-8924-2-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B11780@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 28, 2011, at 3:03 AM, Jia Hongtao wrote:

> If we're an agent/end-point or fsl_add_bridge doesn't succeed due to =
some
> resource failure we should not scan the PCI bus. We change =
fsl_add_bridge()
> to return -ENODEV in the case we're an agent/end-point.
>=20
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |   17 ++++++++++-------
> 1 files changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
> index 4d4536f..caa7801 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -370,7 +370,7 @@ int __init fsl_add_bridge(struct device_node *dev, =
int is_primary)
> 			iounmap(hose->cfg_data);
> 		iounmap(hose->cfg_addr);
> 		pcibios_free_controller(hose);
> -		return 0;
> +		return -ENODEV;
> 	}
>=20
> 	setup_pci_cmd(hose);
> @@ -418,6 +418,7 @@ void fsl_pci_setup(int primary_phb_addr)
> {
> 	struct device_node *np;
> 	struct pci_controller *hose;
> +	int ret;
> 	dma_addr_t min_dma_addr =3D 0xffffffff;
>=20
> 	for_each_node_by_type(np, "pci") {
> @@ -425,14 +426,16 @@ void fsl_pci_setup(int primary_phb_addr)
> 			struct resource rsrc;
> 			of_address_to_resource(np, 0, &rsrc);
> 			if ((rsrc.start & 0xfffff) =3D=3D =
primary_phb_addr)
> -				fsl_add_bridge(np, 1);
> +				ret =3D fsl_add_bridge(np, 1);
> 			else
> -				fsl_add_bridge(np, 0);
> +				ret =3D fsl_add_bridge(np, 0);
>=20
> -			hose =3D pci_find_hose_for_OF_device(np);
> -			min_dma_addr =3D min(min_dma_addr,
> -					hose->dma_window_base_cur
> -					+ hose->dma_window_size);
> +			if (ret =3D=3D 0) {
> +				hose =3D =
pci_find_hose_for_OF_device(np);
> +				min_dma_addr =3D min(min_dma_addr,
> +						=
hose->dma_window_base_cur
> +						+ =
hose->dma_window_size);
> +			}
>=20
> 		}
> 	}

In the failure case (i.e. when ret !=3D 0), what about the following =
code:

+#ifdef CONFIG_SWIOTLB
+	/*
+	 * if we couldn't map all of DRAM via the dma windows we need =
SWIOTLB
+	 * to handle buffers located outside of dma capable memory =
region
+	 */
+	if (memblock_end_of_DRAM() > min_dma_addr) {
+		ppc_swiotlb_enable =3D 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
+	}
+#endif

This should get updated to be:
	if ((ret =3D=3D 0) && (memblock_end_of_DRAM() > min_dma_arr)) {
