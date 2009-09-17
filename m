Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC] [PATCH] Write to HVC terminal from purgatory code
From: Michael Ellerman <michael@ellerman.id.au>
To: mohan@in.ibm.com
In-Reply-To: <20090907051407.GA2990@in.ibm.com>
References: <20090907051407.GA2990@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-UpJcPJzNS2Bm79QXCm4g"
Date: Thu, 17 Sep 2009 21:54:40 +1000
Message-Id: <1253188480.6156.90.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org,
	miltonm@bga.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-UpJcPJzNS2Bm79QXCm4g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-09-07 at 10:44 +0530, M. Mohan Kumar wrote:
> Write to HVC terminal from purgatory code
>=20
> Current x86/x86-64 kexec-tools print the message "I'm in purgatory" to
> serial console/VGA while executing the purgatory code.  Implement this
> feature for POWERPC pseries platform by using the H_PUT_TERM_CHAR
> hypervisor call by printng to hvc console.


Hi Mohan, just a few comments ...

> diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
> index b01ff86..bd9d36c 100644
> --- a/kexec/arch/ppc64/fs2dt.c
> +++ b/kexec/arch/ppc64/fs2dt.c
> @@ -434,6 +434,9 @@ static void putnode(void)
>  	if (!strcmp(basename,"/chosen/")) {
>  		size_t cmd_len =3D 0;
>  		char *param =3D NULL;
> +		char filename[MAXPATH];
> +		char buff[64];
> +		int fd;
> =20
>  		cmd_len =3D strlen(local_cmdline);
>  		if (cmd_len !=3D 0) {
> @@ -446,7 +449,6 @@ static void putnode(void)
> =20
>  		/* ... if not, grab root=3D from the old command line */
>  		if (!param) {
> -			char filename[MAXPATH];
>  			FILE *fp;
>  			char *last_cmdline =3D NULL;
>  			char *old_param;
> @@ -483,8 +485,51 @@ static void putnode(void)
>  		dt +=3D (cmd_len + 3)/4;
> =20
>  		fprintf(stderr, "Modified cmdline:%s\n", local_cmdline);
> +
> +		/*
> +		 * Determine the platform type/stdout type, so that purgatory
> +		 * code can print 'I'm in purgatory' message. Currently only
> +		 * pseries/hvcterminal is supported.
> +		 */
> +		strcpy(filename, pathname);
> +		strcat(filename, "linux,stdout-path");

strncat() ?

> +		fd =3D open(filename, O_RDONLY);
> +		if (fd =3D=3D -1) {
> +			printf("Unable to find linux,stdout-path, printing"
> +					" from purgatory is diabled\n");
> +			goto no_debug;
> +		}
> +		if (fstat(fd, &statbuf)) {
> +			printf("Unable to stat linux,stdout-path, printing"
> +					" from purgatory is diabled\n");
> +			close(fd);
> +			goto no_debug;
> +		}
> +		read(fd, buff, statbuf.st_size);

Be nice to check it's going to fit in buff here.

> +		close(fd);
> +		strcpy(filename, "/proc/device-tree/");
> +		strcat(filename, buff);
> +		strcat(filename, "/compatible");

strncpy / strncat.

> +		fd =3D open(filename, O_RDONLY);
> +		if (fd =3D=3D -1) {
> +			printf("Unable to find linux,stdout-path/compatible, "
> +				" printing from purgatory is diabled\n");

You may as well print the actual path here, seeing as you have it.

> +			goto no_debug;
> +		}
> +		if (fstat(fd, &statbuf)) {
> +			printf("Unable to stat linux,stdout-path/compatible, "
> +				" printing from purgatory is diabled\n");
> +			close(fd);
> +			goto no_debug;
> +		}
> +		read(fd, buff, statbuf.st_size);
> +		if (!strcmp(buff, "hvterm1") ||
> +					!strcmp(buff, "hvterm-protocol"))
> +			my_debug =3D 1;

I have a personal hatred for variables called my_foo, but that's just
personal taste I guess :)

> +		close(fd);
>  	}
> =20
> +no_debug:
>  	for (i=3D0; i < numlist; i++) {
>  		dp =3D namelist[i];
>  		strcpy(dn, dp->d_name);

> diff --git a/purgatory/arch/ppc64/console-ppc64.c b/purgatory/arch/ppc64/=
console-ppc64.c
> index d6da7b3..78a233b 100644
> --- a/purgatory/arch/ppc64/console-ppc64.c
> +++ b/purgatory/arch/ppc64/console-ppc64.c
> @@ -20,8 +20,22 @@
>   */
> =20
>  #include <purgatory.h>
> +#include "hvCall.h"
> +
> +extern int debug;
> =20
>  void putchar(int c)
>  {
> +	char buff[16];
> +	unsigned long *lbuf =3D (unsigned long *)buff;
> +
> +	if (!debug) /* running on non pseries */
> +		return;
> +
> +	if (c =3D=3D '\n')
> +		putchar('\r');
> +
> +	buff[0] =3D c;
> +	plpar_hcall_norets(H_PUT_TERM_CHAR, 0, 1, lbuf[0], lbuf[1]);
>  	return;
>  }
> diff --git a/purgatory/arch/ppc64/hvCall.S b/purgatory/arch/ppc64/hvCall.=
S
> new file mode 100644
> index 0000000..e401f81
> --- /dev/null
> +++ b/purgatory/arch/ppc64/hvCall.S
> @@ -0,0 +1,28 @@
> +/*
> + * This file contains the generic function to perform a call to the
> + * pSeries LPAR hypervisor.
> + *
> + * Created by M. Mohan Kumar (mohan@in.ibm.com)
> + * Copyright (C) IBM Corporation
> + * Taken from linux/arch/powerpc/platforms/pseries/hvCall.S
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#define HVSC	.long 0x44000022
> +.text
> +	.machine ppc64
> +.globl .plpar_hcall_norets
> +.plpar_hcall_norets:
> +	or	6,6,6			# medium low priority
> +        mfcr	0
> +        stw	0,8(1)
> +
> +        HVSC 				/* invoke the hypervisor */
> +
> +        lwz	0,8(1)
> +        mtcrf	0xff,0
> +        blr                             /* return r3 =3D status */

It's much easier to read if you use r0, r1 etc.


cheers

--=-UpJcPJzNS2Bm79QXCm4g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqyI3wACgkQdSjSd0sB4dIg2gCgsLoKhHCH4MG3JAMXpLctpiET
ysQAn3u1c+U299U78zR5a12sMut7IpKw
=XgGK
-----END PGP SIGNATURE-----

--=-UpJcPJzNS2Bm79QXCm4g--
