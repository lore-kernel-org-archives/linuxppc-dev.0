Return-Path: <B38951@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
 [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6E6FDB6F77
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2011 17:59:57 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/2] powerpc/fsl-pci: Only scan PCI bus if configured as
 a host
Date: Mon, 31 Oct 2011 06:58:56 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5DFC83DB@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1319789023-8924-1-git-send-email-B38951@freescale.com>
 <1319789023-8924-2-git-send-email-B38951@freescale.com>
 <A40D3EA1-8172-4267-A509-2409CF32310D@kernel.crashing.org>
In-Reply-To: <A40D3EA1-8172-4267-A509-2409CF32310D@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: linuxppc-dev-bounces+b38951=3Dfreescale.com@lists.ozlabs.org [mailto:=
linuxppc-dev-bounces+b38951=3Dfreescale.com@lists.ozlabs.org] On Behalf Of =
Kumar Gala
Sent: Friday, October 28, 2011 9:10 PM
To: Jia Hongtao-B38951
Cc: Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/fsl-pci: Only scan PCI bus if configured a=
s a host


On Oct 28, 2011, at 3:03 AM, Jia Hongtao wrote:

> If we're an agent/end-point or fsl_add_bridge doesn't succeed due to=20
> some resource failure we should not scan the PCI bus. We change=20
> fsl_add_bridge() to return -ENODEV in the case we're an agent/end-point.
>=20
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |   17 ++++++++++-------
> 1 files changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.c=20
> b/arch/powerpc/sysdev/fsl_pci.c index 4d4536f..caa7801 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -370,7 +370,7 @@ int __init fsl_add_bridge(struct device_node *dev, in=
t is_primary)
> 			iounmap(hose->cfg_data);
> 		iounmap(hose->cfg_addr);
> 		pcibios_free_controller(hose);
> -		return 0;
> +		return -ENODEV;
> 	}
>=20
> 	setup_pci_cmd(hose);
> @@ -418,6 +418,7 @@ void fsl_pci_setup(int primary_phb_addr) {
> 	struct device_node *np;
> 	struct pci_controller *hose;
> +	int ret;
> 	dma_addr_t min_dma_addr =3D 0xffffffff;
>=20
> 	for_each_node_by_type(np, "pci") {
> @@ -425,14 +426,16 @@ void fsl_pci_setup(int primary_phb_addr)
> 			struct resource rsrc;
> 			of_address_to_resource(np, 0, &rsrc);
> 			if ((rsrc.start & 0xfffff) =3D=3D primary_phb_addr)
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
> +				hose =3D pci_find_hose_for_OF_device(np);
> +				min_dma_addr =3D min(min_dma_addr,
> +						hose->dma_window_base_cur
> +						+ hose->dma_window_size);
> +			}
>=20
> 		}
> 	}

In the failure case (i.e. when ret !=3D 0), what about the following code:

+#ifdef CONFIG_SWIOTLB
+	/*
+	 * if we couldn't map all of DRAM via the dma windows we need SWIOTLB
+	 * to handle buffers located outside of dma capable memory region
+	 */
+	if (memblock_end_of_DRAM() > min_dma_addr) {
+		ppc_swiotlb_enable =3D 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
+	}
+#endif

This should get updated to be:
	if ((ret =3D=3D 0) && (memblock_end_of_DRAM() > min_dma_arr)) {
[Jia Hongtao-B38951] A board could have more than one pci controllers, so t=
his update is not right for it only checked the last one. I will submit ano=
ther patch to solve this issue.

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
