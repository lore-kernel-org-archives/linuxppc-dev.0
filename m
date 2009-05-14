Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D61ABDE026
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 00:55:43 +1000 (EST)
Subject: Re: [RFC Patch 6/6] Adapt kexec and samples code to recognise
	PPC64 hardware breakpoint usage
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0905141617480.2225@vixen.sonytel.be>
References: <20090514133312.360702378@prasadkr_t60p.in.ibm.com>
	<20090514134614.GG14229@in.ibm.com>
	<alpine.LRH.2.00.0905141557260.2225@vixen.sonytel.be>
	<1242310317.8608.1.camel@concordia>
	<alpine.LRH.2.00.0905141617480.2225@vixen.sonytel.be>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-6VbPPiLEI6QCyVCJWgEm"
Date: Fri, 15 May 2009 00:55:42 +1000
Message-Id: <1242312942.8608.38.camel@concordia>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6VbPPiLEI6QCyVCJWgEm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-05-14 at 16:18 +0200, Geert Uytterhoeven wrote:
> On Fri, 15 May 2009, Michael Ellerman wrote:
> > On Thu, 2009-05-14 at 15:59 +0200, Geert Uytterhoeven wrote:
> > > On Thu, 14 May 2009, K.Prasad wrote:
> > > > Modify kexec code to disable DABR registers before a reboot. Adapt =
the samples
> > > > code to populate PPC64-arch specific fields.
> > > >=20
> > > > Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> > > > ---
> > > >  arch/powerpc/kernel/machine_kexec_64.c   |    6=20
> > > >  samples/hw_breakpoint/data_breakpoint.c  |    4=20
> > > >=20
> > > > Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/machine_kexec_64.c
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > --- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/machine_kexec_64.c=
	2009-05-14 00:17:24.000000000 +0530
> > > > +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/machine_kexec_64.c	2009=
-05-14 09:48:09.000000000 +0530
> > > > @@ -24,6 +24,7 @@
> > > >  #include <asm/sections.h>	/* _end */
> > > >  #include <asm/prom.h>
> > > >  #include <asm/smp.h>
> > > > +#include <asm/hw_breakpoint.h>
> > > > =20
> > > >  int default_machine_kexec_prepare(struct kimage *image)
> > > >  {
> > > > @@ -214,6 +215,9 @@
> > > >  	put_cpu();
> > > > =20
> > > >  	local_irq_disable();
> > > > +#ifdef CONFIG_PPC64
> > >    ^^^^^^^^^^^^^^^^^^^
> > > > +	hw_breakpoint_disable();
> > > > +#endif
> > >    ^^^^^^
> > >=20
> > > What about providing a dummy definition of hw_breakpoint_disable()
> > > in <asm/hw_breakpoint.h> if !CONFIG_PPC64?
> >=20
> > That would be good.
> >=20
> > What would be better, is to notice that machine_kexec_64.c is only ever
> > built for 64-bit - hence the name. And so no ifdefs or anything else is
> > required.
>=20
> Right ;-)
>=20
> But that can't be said for other files, like e.g. arch/powerpc/kernel/ptr=
ace.c.

Yeah you're right, the rest of this series could use lots of #ifdefs in
headers love.

cheers

--=-6VbPPiLEI6QCyVCJWgEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoMMO4ACgkQdSjSd0sB4dK9WACfUfsqtS8ssKOWvYmIFeoLbB8I
u24An2Cerw5RpMUwbriR455zVbwgr+nP
=zR7P
-----END PGP SIGNATURE-----

--=-6VbPPiLEI6QCyVCJWgEm--
