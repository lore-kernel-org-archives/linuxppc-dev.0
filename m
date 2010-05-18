Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Make request_ras_irqs() available to
	other pseries code
From: Michael Ellerman <michael@ellerman.id.au>
To: Mark Nelson <markn@au1.ibm.com>
In-Reply-To: <201005172233.01183.markn@au1.ibm.com>
References: <201005172233.01183.markn@au1.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-QhU7aKkG+bZYhVenyOmt"
Date: Tue, 18 May 2010 22:40:51 +1000
Message-ID: <1274186451.26143.8.camel@concordia>
Mime-Version: 1.0
Cc: Tseng-hui Lin <tsenglin@us.ibm.com>, engebret@us.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-QhU7aKkG+bZYhVenyOmt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-05-17 at 22:33 +1000, Mark Nelson wrote:
> At the moment only the RAS code uses event-sources interrupts (for EPOW
> events and internal errors) so request_ras_irqs() (which actually request=
s
> the event-sources interrupts) is found in ras.c and is static.

Hi Mark,

Just a few niggles,

...

> +
> +void request_event_sources_irqs(struct device_node *np,
> +				irq_handler_t handler,
> +				const char *name)
> +{
> +	int i, index, count =3D 0;
> +	struct of_irq oirq;
> +	const u32 *opicprop;
> +	unsigned int opicplen;
> +	unsigned int virqs[16];
> +
> +	/* Check for obsolete "open-pic-interrupt" property. If present, then
> +	 * map those interrupts using the default interrupt host and default
> +	 * trigger
> +	 */
> +	opicprop =3D of_get_property(np, "open-pic-interrupt", &opicplen);
> +	if (opicprop) {
> +		opicplen /=3D sizeof(u32);
> +		for (i =3D 0; i < opicplen; i++) {
> +			if (count > 15)
> +				break;
> +			virqs[count] =3D irq_create_mapping(NULL, *(opicprop++));
> +			if (virqs[count] =3D=3D NO_IRQ)
> +				printk(KERN_ERR "Unable to allocate interrupt "
> +				       "number for %s\n", np->full_name);
> +			else
> +				count++;
> +
> +		}
> +	}
> +	/* Else use normal interrupt tree parsing */
> +	else {
> +		/* First try to do a proper OF tree parsing */
> +		for (index =3D 0; of_irq_map_one(np, index, &oirq) =3D=3D 0;
> +		     index++) {
> +			if (count > 15)
> +				break;
> +			virqs[count] =3D irq_create_of_mapping(oirq.controller,
> +							    oirq.specifier,
> +							    oirq.size);
> +			if (virqs[count] =3D=3D NO_IRQ)
> +				printk(KERN_ERR "Unable to allocate interrupt "
> +				       "number for %s\n", np->full_name);
> +			else
> +				count++;
> +		}
> +	}
> +
> +	/* Now request them */
> +	for (i =3D 0; i < count; i++) {
> +		if (request_irq(virqs[i], handler, 0, name, NULL)) {
> +			printk(KERN_ERR "Unable to request interrupt %d for "
> +			       "%s\n", virqs[i], np->full_name);
> +			return;
> +		}
> +	}

Existing code I know, but the error handling in here is a little lax,
what's not going to work if we miss some or all of the interrupts?

> Index: upstream/arch/powerpc/platforms/pseries/event_sources.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ upstream/arch/powerpc/platforms/pseries/event_sources.h
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (C) 2001 Dave Engebretsen IBM Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
USA
> + */
> +
> +#ifndef _POWERPC_EVENT_SOURCES_H
> +#define _POWERPC_EVENT_SOURCES_H
> +
> +#include <linux/interrupt.h>
> +
> +struct device_node;
> +
> +extern void request_event_sources_irqs(struct device_node *np,
> +				       irq_handler_t handler, const char *name);

This could just go in platforms/pseries/pseries.h

> Index: upstream/arch/powerpc/platforms/pseries/ras.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- upstream.orig/arch/powerpc/platforms/pseries/ras.c
> +++ upstream/arch/powerpc/platforms/pseries/ras.c
> @@ -50,6 +50,7 @@
>  #include <asm/firmware.h>
> =20
>  #include "pseries.h"
> +#include "event_sources.h"

:)


cheers

--=-QhU7aKkG+bZYhVenyOmt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvyitMACgkQdSjSd0sB4dLwXACglHESPsmaEBWIz8AAdNPRbnJ7
x9gAoImLrXkDeT3ovmLlxzcculphWfu0
=TVwS
-----END PGP SIGNATURE-----

--=-QhU7aKkG+bZYhVenyOmt--
