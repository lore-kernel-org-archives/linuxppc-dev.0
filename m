Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2A7E42C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 04:06:11 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] powerpc/pci: Fix IMMRBAR address
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1389860091-32754-1-git-send-email-Minghuan.Lian@freescale.com>
Date: Fri, 17 Jan 2014 11:06:04 -0600
Message-Id: <4C7141D6-EB48-44DD-908C-6743894246C4@kernel.crashing.org>
References: <1389860091-32754-1-git-send-email-Minghuan.Lian@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 16, 2014, at 2:14 AM, Minghuan Lian <Minghuan.Lian@freescale.com> =
wrote:

> For PEXCSRBAR, bit 3-0 indicate prefetchable and address type.
> So when getting base address, these bits should be masked,
> otherwise we may get incorrect base address.
>=20
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
> index 4dfd61d..44eae39 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -868,6 +868,14 @@ u64 fsl_pci_immrbar_base(struct pci_controller =
*hose)
>=20
> 		pci_bus_read_config_dword(hose->bus,
> 			PCI_DEVFN(0, 0), PCI_BASE_ADDRESS_0, &base);
> +
> +		/*
> +		 * For PEXCSRBAR, bit 3-0 indicate prefetchable and
> +		 * address type. So when getting base address, these
> +		 * bits should be masked
> +		 */
> +		base &=3D 0xfffffff0;
> +

base & PCI_BASE_ADDRESS_MEM_MASK

> 		return base;
> 	}
> #endif
> --=20
> 1.8.1.2
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
