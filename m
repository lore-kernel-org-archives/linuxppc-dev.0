Return-Path: <haokexin@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75E4B1A0CC2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 22:26:18 +1100 (AEDT)
Received: from mail-qg0-x231.google.com (mail-qg0-x231.google.com
 [IPv6:2607:f8b0:400d:c04::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D8F9914017F
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2015 22:26:17 +1100 (AEDT)
Received: by mail-qg0-f49.google.com with SMTP id q107so18006842qgd.8
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2015 03:26:16 -0800 (PST)
Date: Sat, 21 Feb 2015 19:26:07 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/dma: Always configure ZONE_DMA32 correctly
Message-ID: <20150221112607.GA5321@pek-khao-d1.corp.ad.wrs.com>
References: <1424421325.27448.41.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <1424421325.27448.41.camel@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@au1.ibm.com>, Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 07:35:25PM +1100, Benjamin Herrenschmidt wrote:
> We do this for consistency and also in order to support the use of a
> consistent mask smaller than the dma mask in subsequent patches.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/dma-swiotlb.c | 3 ---
>  arch/powerpc/mm/mem.c             | 6 ++++++
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-=
swiotlb.c
> index 7359797..cb92f94 100644
> --- a/arch/powerpc/kernel/dma-swiotlb.c
> +++ b/arch/powerpc/kernel/dma-swiotlb.c
> @@ -110,9 +110,6 @@ void __init swiotlb_detect_4g(void)
>  {
>  	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
>  		ppc_swiotlb_enable =3D 1;
> -#ifdef CONFIG_ZONE_DMA32
> -		limit_zone_pfn(ZONE_DMA32, (1ULL << 32) >> PAGE_SHIFT);
> -#endif
>  	}
>  }
> =20
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index b7285a5..f146ef0 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -307,6 +307,12 @@ void __init paging_init(void)
>  	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
>  	       (long int)((top_of_ram - total_ram) >> 20));
> =20
> +#ifdef CONFIG_ZONE_DMA32
> +	/* Default limit for ZONE_DMA32, platform might limit it
> +	 * further due to PCI bridge addressing limitations
> +	 */
> +	limit_zone_pfn(ZONE_DMA32, (1ULL << 32) >> PAGE_SHIFT);
> +#endif
>  #ifdef CONFIG_HIGHMEM

Hmm, won't this break the PCI on the fsl SoCs? The ZONE_DMA32 is set to
2GB due to the PCI inbound window limitation on fsl SoCs. This will override
that unconditionally. Please see the commit 84f44cc56c09 ("powerpc/fsl-pci:
Limit ZONE_DMA32 to 2GiB on 64-bit platforms") for more detail.

Thanks,
Kevin

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU6GtPAAoJEJNY7TDerrFxPgkH/RKUpc6iR6HJte05sj3ejMz5
hAierSXSR+OcwqYReMQ3MNyvJYGjAO4DY93QquOiePO+0I6YkFRocd4rwhXcwwEl
YoYuSqhDLq31Cc5EfLCs8Xkd5fbEjWIsPaz9LgGY8GeTuuQNnRREWwnf7Bx5Xdss
ygYin0dzwn+kJH/Ou0tenCqiyX9lFl1NMBhumibT6ULJLRHgnDDmo0jU1X/NhVxH
orDFV+6xzCCYW1+wstw3QhaW8b62AH44b0vuoq8JEcvdUSrQ1uHYEdrfY0th4yVn
KOff8hXIg7GYdp/tPEoro8IDU3ZuJPnGJlwViADpK0TubcPPsaiw4Q2gf1PfXv4=
=wv2J
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
