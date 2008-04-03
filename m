Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id EE55BDDF50
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 22:05:56 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/4] [POWERPC] Implement support for the GPIO LIB API
Date: Thu, 3 Apr 2008 13:05:51 +0200
References: <20080311184012.GA28466@localhost.localdomain>
	<20080311184220.GB32164@localhost.localdomain>
In-Reply-To: <20080311184220.GB32164@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6426166.rSWoAMKIng";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804031305.53469.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart6426166.rSWoAMKIng
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Anton,

On Tuesday 11 March 2008 19:42, Anton Vorontsov wrote:
> This patch implements support for the GPIO LIB API. Two calls
> unimplemented though: irq_to_gpio and gpio_to_irq.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   52 ++++++++++++++++++++=
++++
>  arch/powerpc/Kconfig                         |    5 ++
>  include/asm-powerpc/gpio.h                   |   55 ++++++++++++++++++++=
++++++
>  3 files changed, 112 insertions(+), 0 deletions(-)
>  create mode 100644 include/asm-powerpc/gpio.h

[snip]

> diff --git a/include/asm-powerpc/gpio.h b/include/asm-powerpc/gpio.h
> new file mode 100644
> index 0000000..057840d
> --- /dev/null
> +++ b/include/asm-powerpc/gpio.h
> @@ -0,0 +1,55 @@
> +/*
> + * Generic GPIO API implementation for PowerPC.
> + *
> + * Copyright (c) 2007-2008  MontaVista Software, Inc.
> + *
> + * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __ASM_POWERPC_GPIO_H
> +#define __ASM_POWERPC_GPIO_H
> +
> +#include <asm-generic/gpio.h>
> +
> +#ifdef CONFIG_HAVE_GPIO_LIB
> +
> +/*
> + * We don't (yet) implement inlined/rapid versions for on-chip gpios.
> + * Just call gpiolib.
> + */
> +static inline int gpio_get_value(unsigned int gpio)
> +{
> +	return __gpio_get_value(gpio);
> +}
> +
> +static inline void gpio_set_value(unsigned int gpio, int value)
> +{
> +	__gpio_set_value(gpio, value);
> +}
> +
> +static inline int gpio_cansleep(unsigned int gpio)
> +{
> +	return __gpio_cansleep(gpio);
> +}
> +
> +/*
> + * Not implemented, yet.
> + */
> +static inline int gpio_to_irq(unsigned int gpio)
> +{
> +	return -ENOSYS;
> +}
> +
> +static inline int irq_to_gpio(unsigned int irq)
> +{
> +	return -EINVAL;
> +}

You should include <linux/errno.h>.

> +#endif /* CONFIG_HAVE_GPIO_LIB */
> +
> +#endif /* __ASM_POWERPC_GPIO_H */

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart6426166.rSWoAMKIng
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH9LoR8y9gWxC9vpcRAstXAKDKPjpQyvctjtnGRomEsHhPmhHnTQCfc46I
31ZxKB/HkacMPNXQiPbHvJk=
=6pNo
-----END PGP SIGNATURE-----

--nextPart6426166.rSWoAMKIng--
