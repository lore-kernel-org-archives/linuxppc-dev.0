Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A2F17DDE31
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 01:05:26 +1100 (EST)
Date: Mon, 22 Jan 2007 16:43:16 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: CPM2 interrupt controller fix
Message-ID: <20070122164316.79569af9@localhost.localdomain>
In-Reply-To: <17844.35471.554647.189851@cargo.ozlabs.ibm.com>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<17844.35471.554647.189851@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_edSiHX8P=JF3+RwdHD1.MzJ";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_edSiHX8P=JF3+RwdHD1.MzJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2007 20:57:35 +1100
Paul Mackerras wrote:

> Vitaly Bordug writes:
>=20
> > This contains important fixes for the CPM2 PIC code. Eliminated
> > CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the
> > interrupt mapping. Updated devicetree files to reflect that.
> > Changed direct IC-related IO accesses to the IO accessors. Fixed
> > all the sense values to keep coherency with ipic. In the current
> > code, CPM2 stuff will have no IRQs and hence could be hardly usable.
>=20
> You seem to be adding significant stuff; include/asm-powerpc/mpc8260.h
> is new, and there is this hunk in your patch 4/5:
As I said, new io.h in powerpc broke compilation for both 8272 and 8560 tha=
t were committted.

>=20
> > diff --git a/arch/powerpc/platforms/Makefile
> > b/arch/powerpc/platforms/Makefile index 507d1b9..f750212 100644
> > --- a/arch/powerpc/platforms/Makefile
> > +++ b/arch/powerpc/platforms/Makefile
> > @@ -8,6 +8,7 @@ endif
> >  obj-$(CONFIG_PPC_MPC52xx)	+=3D 52xx/
> >  obj-$(CONFIG_PPC_CHRP)		+=3D chrp/
> >  obj-$(CONFIG_4xx)		+=3D 4xx/
> > +obj-$(CONFIG_PPC_82xx)		+=3D 82xx/
yes, as it was missed from the original primer 82xx commit. All the stuff i=
s already there so this is nothing
but a fix for (a silly) miss.=20

>=20
> Also, this stuff seems to be used on 85xx, and I have not heard from
> Kumar or anyone else working on 85xx as to how these changes are going
> to affect 85xx.  So I'm sorry, but I'm not pushing these changes in
> for 2.6.20.
>=20
Hmm? I did the IRQ senses generalisation as per Kumar's request - this in f=
act is resubmit of the same.

> Also, with the changes like this one:
>=20
> > -	irq_nr -=3D CPM_IRQ_OFFSET;
> > +	unsigned int irq_nr =3D (unsigned int)irq_map[irq].hwirq;
>=20
> you should probably use the virq_to_hw() function defined in
> include/asm-powerpc/irq.h, and you should definitely lose the
> unnecessary (unsigned int) cast.
>=20
OK, I'll try to use virq...() stuff instead.

> > +#ifndef _ISA_MEM_BASE
> > +#define _ISA_MEM_BASE   0
> > +#endif
> > +
> > +#ifndef PCI_DRAM_OFFSET
> > +#define PCI_DRAM_OFFSET 0
> > +#endif
>=20
> Why do we need to have these things defined in mpc8260.h?  Shouldn't
> we get the correct definition from io.h?
>=20
Will check and clean if it is not required.

Thanks,=20
-Vitaly

--Sig_edSiHX8P=JF3+RwdHD1.MzJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFtL91uOg9JvQhSEsRAnxSAJ9oCyctXJ6TebsIQtniqX2eESBiXgCeK8MD
Trr0QaSUx/o8USCPZ2bu5zM=
=tNRL
-----END PGP SIGNATURE-----

--Sig_edSiHX8P=JF3+RwdHD1.MzJ--
