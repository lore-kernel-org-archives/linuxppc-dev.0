Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 64BEF2C0204
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 09:50:45 +1000 (EST)
Date: Mon, 9 Jul 2012 09:50:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: put the gpr sabe/restore functions in their
 own section
Message-Id: <20120709095038.2a4df8320949480dfb44cce7@canb.auug.org.au>
In-Reply-To: <1341644121.30371.2.camel@concordia>
References: <20120706170940.e3457b04a58ddd18d963c14a@canb.auug.org.au>
 <1341644121.30371.2.camel@concordia>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__9_Jul_2012_09_50_38_+1000_7tnIu5zBj77H=I_0"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>, Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__9_Jul_2012_09_50_38_+1000_7tnIu5zBj77H=I_0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Sat, 07 Jul 2012 16:55:21 +1000 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> On Fri, 2012-07-06 at 17:09 +1000, Stephen Rothwell wrote:
> > This allows the linker to know that calls to them do not need to switch
> > TOC and stop errors like the following when linking large configuration=
s:
>=20
> >  arch/powerpc/lib/crtsavres.S |    5 ++++-
>=20
> You didn't make any change to the linker script? How does this section
> get in there? I don't see a .text* anywhere?

Yeah.  ld just seems to figure it out (I note that we also have sections
called .text.unlikely and .text.startup).

> > diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
> > index 1c893f0..b2c68ce 100644
> > --- a/arch/powerpc/lib/crtsavres.S
> > +++ b/arch/powerpc/lib/crtsavres.S
> > @@ -41,12 +41,13 @@
> >  #include <asm/ppc_asm.h>
> > =20
> >  	.file	"crtsavres.S"
> > -	.section ".text"
> > =20
> >  #ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> > =20
> >  #ifndef CONFIG_PPC64
> > =20
> > +	.section ".text"
> > +
> >  /* Routines for saving integer registers, called by the compiler.  */
> >  /* Called with r11 pointing to the stack header word of the caller of =
the */
> >  /* function, just beyond the end of the integer save area.  */
> > @@ -232,6 +233,8 @@ _GLOBAL(_rest32gpr_31_x)
> > =20
> >  #else /* CONFIG_PPC64 */
> > =20
> > +	.section ".text.save.restore","ax",@progbits
> > +
> >  .globl	_savegpr0_14
> >  _savegpr0_14:
> >  	std	r14,-144(r1)
>=20
> Any reason to not put the 32-bit versions in the same section? AFAICS
> nothing in that file uses the TOC.=20

32 bit does not use a toc (apparently).  And I figured to make the
minimal change to the output.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__9_Jul_2012_09_50_38_+1000_7tnIu5zBj77H=I_0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP+hzPAAoJEECxmPOUX5FEddgP/02H76beg/VVSHqeheU/uoZl
6rAfo3fjHT/gCPyklebZIKST7KGS3CPYPfU+xf5b5OcljfXJNnqPmXj8GDhuHaHs
hU0INd1Dz3Qd/GQi84x0uRXH7dijd3YNvSc/bEeJIjiePMGsvDWFHT9s7A78cpCG
PruWg2zb8D7o+sgyqbS7EKnpcxjNX2I5rXJ2bHxfGFiVl2gf/RBSTcm0rDe3M2Z5
k1s6SKMIIybaN5oxwxkay1tzmkTy7Xgb/A6zFo8lpb6QS1ZeLGCJY0D5M1kfy98v
zMpXxKmUTB0JDtz81y5JTfQf5ZAdI0kt2HCt9GpEF1uxs9Oifbkp3374hYm/tpIk
Doua2kPoQT1ezEwwVmIYhhuDSXyDquN2EpOI1IudZeF4QI4uwCQnjHr7ia3sOeHb
LffOBcDoKB/nzWH+oiRUWjx0FhG3c2teo+OS39NY7PvCEYH8k1FFIRn/J60Yk/+k
kkOa5cPJAoAnBBN2Q0IWdcJ3S8hBnb8U3pkknVbDkhXhMLBcVMII4sVdWvhGIVp2
OUbcmUug76FFFuMg5SoI2FT9gMDAF8ucZK2YOLERsd+8p8tkML8ehNs6xZ/BPDMX
AVAa9QFj6mbOLV5sgsyAcKKN95tHwxS5S27kM8AxGa2CltTU0Wc0Q/ZXQiwW3U0F
lKSY9NEgOJEQM8lTeXnj
=/D85
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Jul_2012_09_50_38_+1000_7tnIu5zBj77H=I_0--
