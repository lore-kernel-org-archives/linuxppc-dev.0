Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/fsl: Add multiple MSI bank support
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <03F1ACA1-0A02-4FD6-9FE6-AD44E0EFFD0F@kernel.crashing.org>
References: <1268923993-26689-1-git-send-email-galak@kernel.crashing.org>
	<1268968014.30747.136.camel@concordia>
	<03F1ACA1-0A02-4FD6-9FE6-AD44E0EFFD0F@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ErMP4t67sz3uq6r7TddG"
Date: Mon, 22 Mar 2010 10:04:56 +1100
Message-ID: <1269212696.3534.3.camel@concordia>
Mime-Version: 1.0
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-ErMP4t67sz3uq6r7TddG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-03-19 at 10:15 -0500, Kumar Gala wrote:
> On Mar 18, 2010, at 10:06 PM, Michael Ellerman wrote:
>=20
> > On Thu, 2010-03-18 at 09:53 -0500, Kumar Gala wrote:
> >> From: Lan Chunhe-B25806 <B25806@freescale.com>
> >>=20
> >> Freescale QorIQ P4080 has three MSI banks and the original code
> >> can not work well. This patch adds multiple MSI banks support for
> >> Freescale processor.
> >>=20
> >> Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
> >> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> >=20
> >> @@ -146,9 +149,13 @@ static int fsl_setup_msi_irqs(struct pci_dev *pde=
v, int nvec, int type)
> >> 	unsigned int virq;
> >> 	struct msi_desc *entry;
> >> 	struct msi_msg msg;
> >> -	struct fsl_msi *msi_data =3D fsl_msi;
> >> +	struct fsl_msi *msi_data;
> >>=20
> >> 	list_for_each_entry(entry, &pdev->msi_list, list) {
> >> +		if (entry->irq =3D=3D NO_IRQ)
> >> +			continue;
> >=20
> > This looks wrong, entry->irq should always be 0 here because it was jus=
t
> > kzalloc'ed - you should only be doing this check in teardown.

This was the important comment, the rest was nit-picking :)

> >> -	WARN_ON(ppc_md.setup_msi_irqs);
> >> -	ppc_md.setup_msi_irqs =3D fsl_setup_msi_irqs;
> >> -	ppc_md.teardown_msi_irqs =3D fsl_teardown_msi_irqs;
> >> -	ppc_md.msi_check_device =3D fsl_msi_check_device;
> >> +	/* The multiple setting ppc_md.setup_msi_irqs will not harm things *=
/
> >> +	if (!ppc_md.setup_msi_irqs) {
> >> +		ppc_md.setup_msi_irqs =3D fsl_setup_msi_irqs;
> >> +		ppc_md.teardown_msi_irqs =3D fsl_teardown_msi_irqs;
> >> +		ppc_md.msi_check_device =3D fsl_msi_check_device;
> >> +	} else if (ppc_md.setup_msi_irqs !=3D fsl_setup_msi_irqs) {
> >> +		dev_err(&dev->dev, "Different MSI driver already installed!\n");
> >> +		err =3D -EBUSY; /* or some other error code */
> >> +		goto error_out;
> >> +	}
> >=20
> > I liked it the way it was, because having two competing MSI backends
> > means something's probably not going to work. But it's your driver so
> > whatever you like.
>=20
> The previous WARN_ON() is problematic when we have multiple (of the
> same type) MSI blocks.  The check was intended to do exactly what you
> are suggesting.  If you think its doing something else let us know.

Right, yeah I see what you mean - dev_err() is a bit harder to spot than
a WARN() but it's probably sufficient.

cheers


--=-ErMP4t67sz3uq6r7TddG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkumphQACgkQdSjSd0sB4dI+kQCgvFobvDG4FJ2fGIf/Wh3iUzR3
PLgAniK7wBxQcC2SeEOSjLE8rQQSO8ZA
=3o4a
-----END PGP SIGNATURE-----

--=-ErMP4t67sz3uq6r7TddG--
