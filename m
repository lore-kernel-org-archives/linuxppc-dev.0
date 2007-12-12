Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2] [POWERPC] pasemi: Implement MSI support
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071212064446.GB786@lixom.net>
References: <20071212063406.GA786@lixom.net> <20071212064446.GB786@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-EuWI5Gc+uY+3jM1VKk6i"
Date: Wed, 12 Dec 2007 17:49:39 +1100
Message-Id: <1197442179.24356.3.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-EuWI5Gc+uY+3jM1VKk6i
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-12-12 at 00:44 -0600, Olof Johansson wrote:
> [POWERPC] pasemi: Implement MSI support
>=20
> Implement MSI support for PA Semi PWRficient platforms. MSI is done
> through a special range of sources on the openpic controller, and they're
> unfortunately breaking the usual concepts of how sources are programmed:
>=20
> * The source is calculated as 512 + the value written into the MSI
>   register
> * The vector for this source is added to the source and reported
>   through IACK
>=20
> This means that for simplicity, it makes much more sense to just set the
> vector to 0 for the source, since that's really the vector we expect to
> see from IACK.
>=20
> Also, the affinity/priority registers will affect 16 sources at a
> time. To avoid most (simple) users from being limited by this, allocate
> 16 sources per device but use only one. This means that there's a total
> of 32 sources.
>=20
> If we get usage scenarions that need more sources, the allocator should
> probably be revised to take an alignment argument and size, not just do
> natural alignment.
>=20
> Finally, since I'm already touching the MPIC names on pasemi, rename
> the base one from the somewhat odd " PAS-OPIC  " to "PASEMI-OPIC".
>=20
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
>=20
> ---
>=20
> Oops, fixed the CONFIG_PCI_MSI=3Dn prototype to be static inline instead
> of extern.
>=20
>  arch/powerpc/platforms/pasemi/setup.c |    2=20
>  arch/powerpc/sysdev/Makefile          |    2=20
>  arch/powerpc/sysdev/mpic.c            |   20 +++
>  arch/powerpc/sysdev/mpic.h            |    7 +
>  arch/powerpc/sysdev/mpic_pasemi_msi.c |  172 +++++++++++++++++++++++++++=
+++++++
>  5 files changed, 201 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platfor=
ms/pasemi/setup.c
> index 6d7d068..b5dfd42 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -223,7 +223,7 @@ static __init void pas_init_IRQ(void)
> =20
>  	mpic =3D mpic_alloc(mpic_node, openpic_addr,
>  			  MPIC_PRIMARY|MPIC_LARGE_VECTORS,
> -			  0, 0, " PAS-OPIC  ");
> +			  0, 0, "PASEMI-OPIC");
>  	BUG_ON(!mpic);
> =20
>  	mpic_assign_isu(mpic, 0, openpic_addr + 0x10000);
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index 99a77d7..85cf8c6 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -2,7 +2,7 @@ ifeq ($(CONFIG_PPC64),y)
>  EXTRA_CFLAGS			+=3D -mno-minimal-toc
>  endif
> =20
> -mpic-msi-obj-$(CONFIG_PCI_MSI)	+=3D mpic_msi.o mpic_u3msi.o
> +mpic-msi-obj-$(CONFIG_PCI_MSI)	+=3D mpic_msi.o mpic_u3msi.o mpic_pasemi_=
msi.o
>  obj-$(CONFIG_MPIC)		+=3D mpic.o $(mpic-msi-obj-y)
> =20
>  obj-$(CONFIG_PPC_MPC106)	+=3D grackle.o
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index e479388..aebf025 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -842,6 +842,24 @@ int mpic_set_irq_type(unsigned int virq, unsigned in=
t flow_type)
>  	return 0;
>  }
> =20
> +void mpic_set_vector(unsigned int virq, unsigned int vector)
> +{
> +	struct mpic *mpic =3D mpic_from_irq(virq);
> +	unsigned int src =3D mpic_irq_to_hw(virq);
> +	unsigned int vecpri;
> +
> +	DBG("mpic: set_vector(mpic:@%p,virq:%d,src:%d,vector:0x%x)\n",
> +	    mpic, virq, src, vector);
> +
> +	if (src >=3D mpic->irq_count)
> +		return;
> +
> +	vecpri =3D mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
> +	vecpri =3D vecpri & ~MPIC_INFO(VECPRI_VECTOR_MASK);
> +	vecpri |=3D vector;
> +	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
> +}
> +
>  static struct irq_chip mpic_irq_chip =3D {
>  	.mask		=3D mpic_mask_irq,
>  	.unmask		=3D mpic_unmask_irq,
> @@ -1230,6 +1248,8 @@ void __init mpic_init(struct mpic *mpic)
>  		mpic_u3msi_init(mpic);
>  	}
> =20
> +	mpic_pasemi_msi_init(mpic);
> +
>  	for (i =3D 0; i < mpic->num_sources; i++) {
>  		/* start with vector =3D source number, and masked */
>  		u32 vecpri =3D MPIC_VECPRI_MASK | i |
> diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
> index 1cb6bd8..4783c6e 100644
> --- a/arch/powerpc/sysdev/mpic.h
> +++ b/arch/powerpc/sysdev/mpic.h
> @@ -17,6 +17,7 @@ extern int mpic_msi_init_allocator(struct mpic *mpic);
>  extern irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num)=
;
>  extern void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int num)=
;
>  extern int mpic_u3msi_init(struct mpic *mpic);
> +extern int mpic_pasemi_msi_init(struct mpic *mpic);
>  #else
>  static inline void mpic_msi_reserve_hwirq(struct mpic *mpic,
>  					  irq_hw_number_t hwirq)
> @@ -28,9 +29,15 @@ static inline int mpic_u3msi_init(struct mpic *mpic)
>  {
>  	return -1;
>  }
> +
> +static inline int mpic_pasemi_msi_init(struct mpic *mpic)
> +{
> +	return -1;
> +}
>  #endif
> =20
>  extern int mpic_set_irq_type(unsigned int virq, unsigned int flow_type);
> +extern void mpic_set_vector(unsigned int virq, unsigned int vector);
>  extern void mpic_end_irq(unsigned int irq);
>  extern void mpic_mask_irq(unsigned int irq);
>  extern void mpic_unmask_irq(unsigned int irq);
> diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/=
mpic_pasemi_msi.c
> new file mode 100644
> index 0000000..d6bfda3
> --- /dev/null
> +++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
> @@ -0,0 +1,172 @@
> +/*
> + * Copyright 2007, Olof Johansson, PA Semi
> + *
> + * Based on arch/powerpc/sysdev/mpic_u3msi.c:
> + *
> + * Copyright 2006, Segher Boessenkool, IBM Corporation.
> + * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2 of the
> + * License.
> + *
> + */
> +
> +#undef DEBUG
> +
> +#include <linux/irq.h>
> +#include <linux/bootmem.h>
> +#include <linux/msi.h>
> +#include <asm/mpic.h>
> +#include <asm/prom.h>
> +#include <asm/hw_irq.h>
> +#include <asm/ppc-pci.h>
> +
> +#include "mpic.h"
> +
> +/* Allocate 16 interrupts per device, to give an alignment of 16,
> + * since that's the size of the grouping w.r.t. affinity. If someone
> + * needs more than 32 MSI's down the road we'll have to rethink this,
> + * but it should be OK for now.
> + */
> +#define ALLOC_CHUNK 16
> +
> +#define PASEMI_MSI_ADDR 0xfc080000
> +
> +/* A bit ugly, can we get this from the pci_dev somehow? */
> +static struct mpic *msi_mpic;


Before the ugliness spreads .. I'm pretty sure we can get this from the
chip_data of the virq - I haven't fixed it though because I wasn't sure
if using chip_data was kosher or not.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-EuWI5Gc+uY+3jM1VKk6i
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHX4SDdSjSd0sB4dIRAppLAJ9AMVkhu1u2pEnCe6o/efVXL4MaWQCgk6bP
h+1DnHAZR+Pb7uvXpacYBwY=
=P71N
-----END PGP SIGNATURE-----

--=-EuWI5Gc+uY+3jM1VKk6i--
