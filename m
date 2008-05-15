Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch 1/4] powerpc: fix for OProfile callgraph for Power 64
	bit user apps
From: Michael Ellerman <michael@ellerman.id.au>
To: akpm@linux-foundation.org
In-Reply-To: <200805142312.m4ENCqLg026256@imap1.linux-foundation.org>
References: <200805142312.m4ENCqLg026256@imap1.linux-foundation.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5QLaZ1+PCjPLR+KsMRk9"
Date: Thu, 15 May 2008 10:20:44 +1000
Message-Id: <1210810844.7603.17.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cel@us.ibm.com, paulus@samba.org, carll@us.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-5QLaZ1+PCjPLR+KsMRk9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-05-14 at 16:12 -0700, akpm@linux-foundation.org wrote:
> From: Carl Love <cel@us.ibm.com>
>=20
> Fix the 64 bit user code backtrace which currently may hang the system.
>=20
> Signed-off-by: Carl Love <carll@us.ibm.com>
> Cc: Maynard Johnson <maynardj@us.ibm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Hi Carl,

I'm a bit confused by this change ..

> diff -puN arch/powerpc/oprofile/backtrace.c~powerpc-fix-for-oprofile-call=
graph-for-power-64-bit-user-apps arch/powerpc/oprofile/backtrace.c
> --- a/arch/powerpc/oprofile/backtrace.c~powerpc-fix-for-oprofile-callgrap=
h-for-power-64-bit-user-apps
> +++ a/arch/powerpc/oprofile/backtrace.c
> @@ -53,19 +53,40 @@ static unsigned int user_getsp32(unsigne
>  #ifdef CONFIG_PPC64
>  static unsigned long user_getsp64(unsigned long sp, int is_first)
>  {
> -	unsigned long stack_frame[3];
> +	unsigned long stk_frm_lr;
> +	unsigned long stk_frm_sp;
> +	unsigned long size;
> +
> +	/* Issue the __copy_from_user_inatomic() third argument currently
> +	 * only takes sizes 1, 2, 4 or 8 bytes.  Don't read more then the
> +	 * first 48 bytes of the stack frame.  That is all that is
> +	 * guaranteed to exist.  Reading more may cause the system to hang.

__copy_from_user_inatomic() accepts any value for n, it just has a
special case for 1, 2, 4 and 8 - but it should still work for other
values.

The old code copied 24 bytes from sp, and the new code copies 8 bytes
from sp and 8 bytes from sp + 16 - so I don't see where the 48 bytes
comes in to it?

=EF=BB=BFAlso the comment is a little hard to parse, I think you mean "Issu=
e:
the ..", but I read "Issue" as a verb in that sentence. And "Don't read
more then" should be "than".

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-5QLaZ1+PCjPLR+KsMRk9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIK4HcdSjSd0sB4dIRAviDAKCeZsfkplQBSa1NqDAIRdBBEFZosQCgyrC9
OYESvVN+kUHGM3+i3+7FuqI=
=4b33
-----END PGP SIGNATURE-----

--=-5QLaZ1+PCjPLR+KsMRk9--
