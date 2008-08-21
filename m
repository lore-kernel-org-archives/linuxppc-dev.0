Return-Path: <michael@ellerman.id.au>
Subject: Re: [machdep_calls] IRQ
From: Michael Ellerman <michael@ellerman.id.au>
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
In-Reply-To: <319b0ac50808210013p677ebb91vf3b30748138c6d4c@mail.gmail.com>
References: <319b0ac50808210013p677ebb91vf3b30748138c6d4c@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-XCrTmY/egBnbFnpB7WBE"
Date: Thu, 21 Aug 2008 18:02:47 +1000
Message-Id: <1219305767.8008.14.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-XCrTmY/egBnbFnpB7WBE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-08-21 at 09:13 +0200, S=C3=A9bastien Chr=C3=A9tien wrote:
> Hello,
>=20
> What are the constraints in order to implement a irq_init function ?=20

You mean ppc_md.init_IRQ() ?

If so, it's a hook you can use to setup your interrupt controller. It's
called from init_IRQ() (arch/powerpc/kernel/irq.c), which is called from
start_kernel() (init/main.c).

Not long after it is called irqs are enabled. I think it is the last
callback into arch code before irqs are enabled.

When it is called the device tree is unflattened, so you can use the of_
API. Bootmem is setup so you can use alloc_bootmem(), but you can't
kmalloc yet. ioremap should work.


> What is the aim or get_irq ? Does it retun an information about the
> mask, the states, or... ?

The aim of ppc_md.get_irq() ? It's called from do_IRQ()
(arch/powerpc/kernel/irq.c) which is called from assembler in the
appropriate head_x.S

It just returns the number (virtual number) of the irq that just fired.
If for some reason you took a spurious interrupt it should return
NO_IRQ.

I'm not sure what you mean about masks or states, someone else might
though.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-XCrTmY/egBnbFnpB7WBE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIrSEndSjSd0sB4dIRAtC7AKCfUvxs7aFQbeISt/vAI0rYWYf9aQCbBEA/
7WRUKxOhNHtVtKheFP5uy3c=
=muo/
-----END PGP SIGNATURE-----

--=-XCrTmY/egBnbFnpB7WBE--
