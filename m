Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 893F72C0108
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 10:18:15 +1000 (EST)
Date: Fri, 26 Jul 2013 19:18:01 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 6/8] powerpc: introduce early_get_first_memblock_info
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <1372942454-25191-7-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Thu Jul  4 07:54:12 2013)
Message-ID: <1374884281.30721.40@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2013 07:54:12 AM, Kevin Hao wrote:
> For a relocatable kernel since it can be loaded at any place, there
> is no any relation between the kernel start addr and the =20
> memstart_addr.
> So we can't calculate the memstart_addr from kernel start addr. And
> also we can't wait to do the relocation after we get the real
> memstart_addr from device tree because it is so late. So introduce
> a new function we can use to get the first memblock address and size
> in a very early stage (before machine_init).
>=20
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> A new patch in v2.
>=20
>  arch/powerpc/kernel/prom.c | 24 ++++++++++++++++++++++++
>  include/linux/of_fdt.h     |  1 +
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index eb23ac9..9a69d2d 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -753,6 +753,30 @@ void __init early_init_devtree(void *params)
>  	DBG(" <- early_init_devtree()\n");
>  }
>=20
> +#ifdef CONFIG_RELOCATABLE
> +/*
> + * This function run before early_init_devtree, so we have to init
> + * initial_boot_params. Since early_init_dt_scan_memory_ppc will be
> + * executed again in early_init_devtree, we have to reinitialize the
> + * memblock data before return.
> + */
> +void __init early_get_first_memblock_info(void *params, phys_addr_t =20
> *size)
> +{
> +	/* Setup flat device-tree pointer */
> +	initial_boot_params =3D params;
> +
> +	/* Scan memory nodes and rebuild MEMBLOCKs */
> +	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> +	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> +
> +	if (size)
> +		*size =3D first_memblock_size;
> +
> +	/* Undo what early_init_dt_scan_memory_ppc does to memblock */
> +	memblock_reinit();
> +}
> +#endif

Wouldn't it be simpler to set a flag so that =20
early_init_dt_add_memory_arch() doesn't mess with memblocks on the =20
first pass?

-Scott=
