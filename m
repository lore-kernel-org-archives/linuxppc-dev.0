Return-Path: <michael@ellerman.id.au>
Subject: Re: alignment exceptionhandler sleeps in invalid context
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17489.63055.968862.256370@cargo.ozlabs.ibm.com>
References: <20060424173246.GA22318@suse.de>
	<17489.63055.968862.256370@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/NyXEDtnvWewDXaDOUcs"
Date: Sat, 29 Apr 2006 12:34:13 +1000
Message-Id: <1146278053.14733.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/NyXEDtnvWewDXaDOUcs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-04-28 at 21:02 +1000, Paul Mackerras wrote:
> Olaf Hering writes:
>=20
> > I'm not sure where the bug is. Does it mean the network stack does
> > something nasty, or is the exception handler itself broken? (probably t=
he latter)
> > This is 2.6.16.9 on a p270.
>=20
> This patch should fix it, I hope.  If you can verify that it fixes it
> I'll send it to Linus.
>=20
> Paul.
>=20
> diff --git a/include/asm-powerpc/uaccess.h b/include/asm-powerpc/uaccess.=
h
> index 3872e92..b02d858 100644
> --- a/include/asm-powerpc/uaccess.h
> +++ b/include/asm-powerpc/uaccess.h
> @@ -179,7 +179,8 @@ do {								\
>  #define __put_user_nocheck(x, ptr, size)			\
>  ({								\
>  	long __pu_err;						\
> -	might_sleep();						\
> +	if ((unsigned long)ptr < PAGE_OFFSET)			\
> +		might_sleep();					\

+	if (!is_kernel_addr((unsigned long)ptr))		\
+		might_sleep();					\

In asm/page.h :)

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/NyXEDtnvWewDXaDOUcs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEUtCldSjSd0sB4dIRAvuAAJoCRE2IY9vUNJktvgvQ4SseLuwagQCgnKy2
OcZQ2hoeI9hbV1DTcIAIAdM=
=5euB
-----END PGP SIGNATURE-----

--=-/NyXEDtnvWewDXaDOUcs--
