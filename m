Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 63B66B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 11:33:39 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55EF2DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 11:33:39 +1000 (EST)
Subject: Re: [PATCH 1/5] dynamic logical partitioning infrastructure
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4AAABCE3.5090702@austin.ibm.com>
References: <4AAABC55.4070207@austin.ibm.com> <4AAABCE3.5090702@austin.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-vtYoZ2qP1Kp3jSIzK/z+"
Date: Wed, 16 Sep 2009 11:33:36 +1000
Message-Id: <1253064816.5600.103.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-vtYoZ2qP1Kp3jSIzK/z+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-09-11 at 16:10 -0500, Nathan Fontenot wrote:
> This patch provides the kernel DLPAR infrastructure in a new filed named
> dlpar.c.  The functionality provided is for acquiring and releasing a=20
> resource from firmware and the parsing of information returned from the
> ibm,configure-connector rtas call.  Additionally this exports the=20
> pSeries reconfiguration notifier chain so that it can be invoked when
> device tree updates are made.
>=20
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> ---
>=20
> Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2009-09-11 12:51:52.00=
0000000 -0500
> @@ -0,0 +1,416 @@
> +/*
> + * dlpar.c - support for dynamic reconfiguration (including PCI
> + * Hotplug and Dynamic Logical Partitioning on RPA platforms).
> + *
> + * Copyright (C) 2009 Nathan Fontenot
> + * Copyright (C) 2009 IBM Corporation
> + *
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/kref.h>
> +#include <linux/notifier.h>
> +#include <linux/proc_fs.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/prom.h>
> +#include <asm/machdep.h>
> +#include <asm/uaccess.h>
> +#include <asm/rtas.h>
> +#include <asm/pSeries_reconfig.h>
> +
> +#define CFG_CONN_WORK_SIZE	4096
> +static char workarea[CFG_CONN_WORK_SIZE];
> +spinlock_t workarea_lock;
> +
> +static struct property *parse_cc_property(char *workarea)
> +{
> +	struct property *prop;
> +	u32 *work_ints;
> +	char *name;
> +	char *value;
> +
> +	prop =3D kzalloc(sizeof(*prop), GFP_KERNEL);
> +	if (!prop)
> +		return NULL;
> +
> +	work_ints =3D (u32 *)workarea;
> +	name =3D workarea + work_ints[2];
> +	prop->name =3D kzalloc(strlen(name) + 1, GFP_KERNEL);
> +	if (!prop->name) {
> +		kfree(prop);
> +		return NULL;
> +	}
> +
> +	strcpy(prop->name, name);
> +
> +	prop->length =3D work_ints[3];
> +	value =3D workarea + work_ints[4];
> +	prop->value =3D kzalloc(prop->length, GFP_KERNEL);


The use of work_ints is a bit opaque, it might be clearer if you define
a struct, something like:

struct cc_prop {
	u32 ?;
	u32 ?;
	u32 name_offset;
	u32 length;
	u32 value_offset;
};

cc =3D (struct cc_prop *)workarea;

name =3D workarea + cc->name_offset;
..
prop->length =3D cc->length;
value =3D workarea + cc->value_offset;

etc.


Also I don't see any checking of the offsets into workarea (for name &
value), vs the size of workarea.

cheers


--=-vtYoZ2qP1Kp3jSIzK/z+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqwQHAACgkQdSjSd0sB4dLz2ACfQOyYPpoTOZx8sNZTZTrKWHJ2
hnMAmgIO8HI6VIXegZConFcNptuHUT0M
=W0WT
-----END PGP SIGNATURE-----

--=-vtYoZ2qP1Kp3jSIzK/z+--
