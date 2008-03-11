Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
From: Michael Ellerman <michael@ellerman.id.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
In-Reply-To: <47C750CE.7050202@austin.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com>  <47C750CE.7050202@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ROiIv7LT4QVEnENUPbMg"
Date: Tue, 11 Mar 2008 12:02:21 +1100
Message-Id: <1205197341.8656.5.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ROiIv7LT4QVEnENUPbMg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-02-28 at 18:24 -0600, Manish Ahuja wrote:
> Initial patch for reserving memory in early boot, and freeing it later.
> If the previous boot had ended with a crash, the reserved memory would co=
ntain
> a copy of the crashed kernel data.
>=20
> Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
> Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>

Hi Manish,

A few comments inline ..

> Index: 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ 2.6.25-rc1/arch/powerpc/platforms/pseries/phyp_dump.c	2008-02-28 21:5=
7:52.000000000 -0600
> @@ -0,0 +1,105 @@
> +/*
> + * Hypervisor-assisted dump
> + *
> + * Linas Vepstas, Manish Ahuja 2008
> + * Copyright 2008 IBM Corp.
> + *
> + *      This program is free software; you can redistribute it and/or
> + *      modify it under the terms of the GNU General Public License
> + *      as published by the Free Software Foundation; either version
> + *      2 of the License, or (at your option) any later version.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/pfn.h>
> +#include <linux/swap.h>
> +
> +#include <asm/page.h>
> +#include <asm/phyp_dump.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +
> +/* Global, used to communicate data between early boot and late boot */
> +static struct phyp_dump phyp_dump_global;
> +struct phyp_dump *phyp_dump_info =3D &phyp_dump_global;

I don't see the point of this. You have a static (ie. non-global) struct
called phyp_dump_global, then you create a pointer to it and pass that
around. It could just be:

phyp_dump.h:
extern struct phyp_dump phyp_dump_info;=20

phyp_dump.c:
struct phyp_dump phyp_dump_info;

phyp_dump_info.foo =3D bar;

I also think the struct should be called phyp_dump_info, not phyp_dump -
it contains info about phyp_dump, not the dump itself.

> +
> +/**
> + * release_memory_range -- release memory previously lmb_reserved
> + * @start_pfn: starting physical frame number
> + * @nr_pages: number of pages to free.
> + *
> + * This routine will release memory that had been previously
> + * lmb_reserved in early boot. The released memory becomes
> + * available for genreal use.
> + */
> +static void
> +release_memory_range(unsigned long start_pfn, unsigned long nr_pages)
> +{
> +	struct page *rpage;
> +	unsigned long end_pfn;
> +	long i;
> +
> +	end_pfn =3D start_pfn + nr_pages;
> +
> +	for (i =3D start_pfn; i <=3D end_pfn; i++) {
> +		rpage =3D pfn_to_page(i);
> +		if (PageReserved(rpage)) {
> +			ClearPageReserved(rpage);
> +			init_page_count(rpage);
> +			__free_page(rpage);
> +			totalram_pages++;
> +		}
> +	}
> +}
> +
> +static int __init phyp_dump_setup(void)
> +{
> +	unsigned long start_pfn, nr_pages;
> +
> +	/* If no memory was reserved in early boot, there is nothing to do */
> +	if (phyp_dump_info->init_reserve_size =3D=3D 0)
> +		return 0;
> +
> +	/* Release memory that was reserved in early boot */
> +	start_pfn =3D PFN_DOWN(phyp_dump_info->init_reserve_start);
> +	nr_pages =3D PFN_DOWN(phyp_dump_info->init_reserve_size);
> +	release_memory_range(start_pfn, nr_pages);
> +
> +	return 0;
> +}
> +machine_subsys_initcall(pseries, phyp_dump_setup);
> +
> +int __init early_init_dt_scan_phyp_dump(unsigned long node,
> +		const char *uname, int depth, void *data)
> +{
> +#ifdef CONFIG_PHYP_DUMP
> +	const unsigned int *sizes;
> +
> +	phyp_dump_info->phyp_dump_configured =3D 0;
> +	phyp_dump_info->phyp_dump_is_active =3D 0;
> +
> +	if (depth !=3D 1 || strcmp(uname, "rtas") !=3D 0)
> +		return 0;
> +
> +	if (of_get_flat_dt_prop(node, "ibm,configure-kernel-dump", NULL))
> +		phyp_dump_info->phyp_dump_configured++;
> +
> +	if (of_get_flat_dt_prop(node, "ibm,dump-kernel", NULL))
> +		phyp_dump_info->phyp_dump_is_active++;
> +
> +	sizes =3D of_get_flat_dt_prop(node, "ibm,configure-kernel-dump-sizes",
> +									NULL);
> +	if (!sizes)
> +		return 0;
> +
> +	if (sizes[0] =3D=3D 1)
> +		phyp_dump_info->cpu_state_size =3D *((unsigned long *)&sizes[1]);
> +
> +	if (sizes[3] =3D=3D 2)
> +		phyp_dump_info->hpte_region_size =3D
> +						*((unsigned long *)&sizes[4]);
> +#endif

This doesn't need to be inside #ifdef, you have a dummy version already
defined in the header file.

> Index: 2.6.25-rc1/arch/powerpc/kernel/prom.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- 2.6.25-rc1.orig/arch/powerpc/kernel/prom.c	2008-02-28 21:54:57.000000=
000 -0600
> +++ 2.6.25-rc1/arch/powerpc/kernel/prom.c	2008-02-28 21:55:27.000000000 -=
0600
> @@ -1039,6 +1040,51 @@ static void __init early_reserve_mem(voi
>  #endif
>  }
> =20
> +#ifdef CONFIG_PHYP_DUMP
> +/**
> + * reserve_crashed_mem() - reserve all not-yet-dumped mmemory
> + *
> + * This routine may reserve memory regions in the kernel only
> + * if the system is supported and a dump was taken in last
> + * boot instance or if the hardware is supported and the
> + * scratch area needs to be setup. In other instances it returns
> + * without reserving anything. The memory in case of dump being
> + * active is freed when the dump is collected (by userland tools).
> + */
> +static void __init reserve_crashed_mem(void)

This could do with a name change IMO, eg. phyp_dump_reserve_mem() or
something.

> +{
> +	unsigned long base, size;
> +	if (!phyp_dump_info->phyp_dump_configured) {
> +		printk(KERN_ERR "Phyp-dump not supported on this hardware\n");
> +		return;
> +	}
> +
> +	if (phyp_dump_info->phyp_dump_is_active) {
> +		/* Reserve *everything* above RMR.Area freed by userland tools*/
> +		base =3D PHYP_DUMP_RMR_END;
> +		size =3D lmb_end_of_DRAM() - base;
> +
> +		/* XXX crashed_ram_end is wrong, since it may be beyond
> +		 * the memory_limit, it will need to be adjusted. */
> +		lmb_reserve(base, size);
> +
> +		phyp_dump_info->init_reserve_start =3D base;
> +		phyp_dump_info->init_reserve_size =3D size;
> +	} else {
> +		size =3D phyp_dump_info->cpu_state_size +
> +			phyp_dump_info->hpte_region_size +
> +			PHYP_DUMP_RMR_END;
> +		base =3D lmb_end_of_DRAM() - size;
> +		lmb_reserve(base, size);
> +		phyp_dump_info->init_reserve_start =3D base;
> +		phyp_dump_info->init_reserve_size =3D size;
> +	}
> +}
> +#else
> +static inline void __init reserve_crashed_mem(void) {}
> +#endif /* CONFIG_PHYP_DUMP  && CONFIG_PPC_RTAS */


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ROiIv7LT4QVEnENUPbMg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH1doddSjSd0sB4dIRAgFNAKC7b8g64uyvb0d8Xa9xBK9hzjf9pwCZAYdw
ivTzXZaE+mqIRt+e3QmEUkM=
=mvay
-----END PGP SIGNATURE-----

--=-ROiIv7LT4QVEnENUPbMg--
