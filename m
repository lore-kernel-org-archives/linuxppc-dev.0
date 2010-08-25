Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Check end of stack canary at oops time
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100824231528.GC28360@kryten>
References: <20100824231528.GC28360@kryten>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-GeqlrKlbBrNhMMsHEQvT"
Date: Wed, 25 Aug 2010 11:29:38 +1000
Message-ID: <1282699778.21145.54.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-GeqlrKlbBrNhMMsHEQvT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-08-25 at 09:15 +1000, Anton Blanchard wrote:
> Add a check for the stack canary when we oops, similar to x86. This shoul=
d make
> it clear that we overran our stack:
>=20
> Unable to handle kernel paging request for data at address 0x24652f63700a=
c689
> Faulting instruction address: 0xc000000000063d24
> Thread overran stack, or stack corrupted
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> Index: powerpc.git/arch/powerpc/mm/fault.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- powerpc.git.orig/arch/powerpc/mm/fault.c	2010-08-25 08:41:08.23008618=
6 +1000
> +++ powerpc.git/arch/powerpc/mm/fault.c	2010-08-25 09:12:38.276553103 +10=
00
> @@ -30,6 +30,7 @@
>  #include <linux/kprobes.h>
>  #include <linux/kdebug.h>
>  #include <linux/perf_event.h>
> +#include <linux/magic.h>
> =20
>  #include <asm/firmware.h>
>  #include <asm/page.h>
> @@ -385,6 +386,7 @@ do_sigbus:
>  void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig=
)
>  {
>  	const struct exception_table_entry *entry;
> +	unsigned long *stackend;
> =20
>  	/* Are we prepared to handle this fault?  */
>  	if ((entry =3D search_exception_tables(regs->nip)) !=3D NULL) {
> @@ -413,5 +415,9 @@ void bad_page_fault(struct pt_regs *regs
>  	printk(KERN_ALERT "Faulting instruction address: 0x%08lx\n",
>  		regs->nip);
> =20
> +	stackend =3D end_of_stack(current);
> +	if (current !=3D &init_task && *stackend !=3D STACK_END_MAGIC)
> +		printk(KERN_ALERT "Thread overran stack, or stack corrupted\n");

The check for init is just because we haven't set the magic value for
init's stack right? But we could.

cheers


--=-GeqlrKlbBrNhMMsHEQvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkx0cf0ACgkQdSjSd0sB4dLKSgCdE4/Tkfk101MR9wAHPuBWpQSk
gxMAniU13LqzkCExI63IK62/KmhmwwFV
=6oqg
-----END PGP SIGNATURE-----

--=-GeqlrKlbBrNhMMsHEQvT--
