Return-Path: <michael@ellerman.id.au>
Subject: Re: why do we need reloc_offset ??
From: Michael Ellerman <michael@ellerman.id.au>
To: HongWoo Lee <hongwoo7@gmail.com>
In-Reply-To: <5e2889710909012333q69874b24qf6e3c0abfceb8dfd@mail.gmail.com>
References: <5e2889710909012333q69874b24qf6e3c0abfceb8dfd@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-QVxIQKbTg0KVOAV8Aleg"
Date: Thu, 03 Sep 2009 12:19:49 +1000
Message-Id: <1251944389.6261.11.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-QVxIQKbTg0KVOAV8Aleg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-09-02 at 15:33 +0900, HongWoo Lee wrote:
> Hi everyone~=20
>=20
> In ther linux kernel code, I found the reloc_offset.=20
>=20
> {{{
> // file : misc.S=20
> /* Returns (address we are running at) - (address we were linked at)
>  * for use before the text and data are mapped to KERNELBASE.
>  */
> _GLOBAL(reloc_offset)
> }}}
>=20
> I couldn't understand the comment saying "Returns (address we are
> running at) - (address we were linked at)".=20
> For now, I'm studying each instruction.=20
>=20
> And below is best comment I can explain for each instruction.=20
>=20
> _GLOBAL(reloc_offset)
>         mflr    r0                // move from link register, save the re=
turn address
>         bl      1f                 // bl 1f
> 1:     mflr    r3                // move from link register, r3 is just r=
eturn address pointing itself=20

At this point r3 contains the value of LR based on the branch we just
did. So it's the address of the current instruction, based on where the
code is _running_.

>         LOAD_REG_IMMEDIATE(r4,1b)    // get the 1b address, r4 is the add=
ress=20

Here we load into r4 the address of the previous instruction, but based
on the label "1b". The address of the label is calculated by the linker,
so r4 contains the address the instruction was linked at.

>         subf    r3,r4,r3        // r3 =3D r3 =E2=80=93 r4=20

So here we calculate any difference between the address the code was
linked at and the address it's running at.

>         mtlr    r0                // restore return address=20
>         blr
>=20
> After this, I still don't know why "r3-r4" is the offset.=20
> And what does it mean ??=20

The offset is just the difference between the address the code was
linked at and the address it's running it. It's used in places where the
code might be (or is always) running at an address other than the
address it was linked at.

cheers

--=-QVxIQKbTg0KVOAV8Aleg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqfJ8EACgkQdSjSd0sB4dI+EwCeLhAOUtVmqKBhcFcUU2KuaAc3
9y0AoJ09RonOANNwwDzwOO/kedBC+k2K
=DJA/
-----END PGP SIGNATURE-----

--=-QVxIQKbTg0KVOAV8Aleg--
