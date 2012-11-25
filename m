Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 530CC2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2012 23:41:11 +1100 (EST)
Subject: Re: [PATCH] powerpc/pci-hotplug: fix the rescanned pci device's
 dma_set_mask issue
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1353644968-29469-1-git-send-email-B41889@freescale.com>
Date: Sun, 25 Nov 2012 06:41:01 -0600
Message-Id: <455E76A9-ABB3-4FF6-A19E-612E43223C4A@kernel.crashing.org>
References: <1353644968-29469-1-git-send-email-B41889@freescale.com>
To: Yuanquan Chen <B41889@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, r61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 22, 2012, at 10:29 PM, Yuanquan Chen wrote:

> On powerpc arch, dma_ops of rescanned pci device after system's =
booting up won't be
> initialized by system, so it will fail to execute the dma_set_mask in =
the device's
> driver. Initialize it to solve this issue.
>=20
> Signed-off-by: Yuanquan Chen <B41889@freescale.com>
> ---
> arch/powerpc/include/asm/dma-mapping.h |    7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

This is not the right way to get the dma_ops setup.  You need to find =
some other point for the hotplug scenario to get the dma_ops setup.

- k

>=20
> diff --git a/arch/powerpc/include/asm/dma-mapping.h =
b/arch/powerpc/include/asm/dma-mapping.h
> index 7816087..22eae53 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -126,8 +126,11 @@ static inline int dma_supported(struct device =
*dev, u64 mask)
> {
> 	struct dma_map_ops *dma_ops =3D get_dma_ops(dev);
>=20
> -	if (unlikely(dma_ops =3D=3D NULL))
> -		return 0;
> +	if (unlikely(dma_ops =3D=3D NULL)) {
> +		set_dma_ops(dev, &dma_direct_ops);
> +		set_dma_offset(dev, PCI_DRAM_OFFSET);
> +		dma_ops =3D &dma_direct_ops;
> +	}
> 	if (dma_ops->dma_supported =3D=3D NULL)
> 		return 1;
> 	return dma_ops->dma_supported(dev, mask);
> --=20
> 1.7.9.5
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
