Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E4880B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 16:19:03 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 032F1DDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 16:19:01 +1000 (EST)
Date: Tue, 30 Jun 2009 08:18:47 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
Message-ID: <20090630061847.GA24164@pengutronix.de>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
In-Reply-To: <20090629234214.12670.9082.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Mon, Jun 29, 2009 at 05:42:21PM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> AC97 bus register read/write hooks need to provide locking, but the
> mpc5200-psc-ac97 driver does not.  This patch adds a mutex around
> the register access routines.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>=20
>  sound/soc/fsl/mpc5200_dma.c      |    1 +
>  sound/soc/fsl/mpc5200_dma.h      |    1 +
>  sound/soc/fsl/mpc5200_psc_ac97.c |   17 ++++++++++++++++-
>  3 files changed, 18 insertions(+), 1 deletions(-)
>=20
>=20
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index efec33a..f0a2d40 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -456,6 +456,7 @@ int mpc5200_audio_dma_create(struct of_device *op)
>  		return -ENODEV;
> =20
>  	spin_lock_init(&psc_dma->lock);
> +	mutex_init(&psc_dma->mutex);
>  	psc_dma->id =3D be32_to_cpu(*prop);
>  	psc_dma->irq =3D irq;
>  	psc_dma->psc_regs =3D regs;
> diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
> index 2000803..8d396bb 100644
> --- a/sound/soc/fsl/mpc5200_dma.h
> +++ b/sound/soc/fsl/mpc5200_dma.h
> @@ -55,6 +55,7 @@ struct psc_dma {
>  	unsigned int irq;
>  	struct device *dev;
>  	spinlock_t lock;
> +	struct mutex mutex;
>  	u32 sicr;
>  	uint sysclk;
>  	int imr;
> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc=
_ac97.c
> index 794a247..7eb5499 100644
> --- a/sound/soc/fsl/mpc5200_psc_ac97.c
> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
> @@ -34,13 +34,20 @@ static unsigned short psc_ac97_read(struct snd_ac97 *=
ac97, unsigned short reg)
>  	int status;
>  	unsigned int val;
> =20
> +	mutex_lock(&psc_dma->mutex);
> +
>  	/* Wait for command send status zero =3D ready */
>  	status =3D spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.stat=
us) &
>  				MPC52xx_PSC_SR_CMDSEND), 100, 0);
>  	if (status =3D=3D 0) {
>  		pr_err("timeout on ac97 bus (rdy)\n");
> +		mutex_unlock(&psc_dma->mutex);
>  		return -ENODEV;
>  	}
> +
> +	/* Force clear the data valid bit */
> +	in_be32(&psc_dma->psc_regs->ac97_data);
> +

No mutex involved here. I think this is either a seperate patch or it needs=
 at
least to be mentioned in the patch description.

>  	/* Send the read */
>  	out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0x7f) << 24));
> =20
> @@ -50,16 +57,19 @@ static unsigned short psc_ac97_read(struct snd_ac97 *=
ac97, unsigned short reg)
>  	if (status =3D=3D 0) {
>  		pr_err("timeout on ac97 read (val) %x\n",
>  				in_be16(&psc_dma->psc_regs->sr_csr.status));
> +		mutex_unlock(&psc_dma->mutex);
>  		return -ENODEV;
>  	}
>  	/* Get the data */
>  	val =3D in_be32(&psc_dma->psc_regs->ac97_data);
>  	if (((val >> 24) & 0x7f) !=3D reg) {
>  		pr_err("reg echo error on ac97 read\n");
> +		mutex_unlock(&psc_dma->mutex);
>  		return -ENODEV;
>  	}
>  	val =3D (val >> 8) & 0xffff;
> =20
> +	mutex_unlock(&psc_dma->mutex);
>  	return (unsigned short) val;
>  }
> =20
> @@ -68,16 +78,21 @@ static void psc_ac97_write(struct snd_ac97 *ac97,
>  {
>  	int status;
> =20
> +	mutex_lock(&psc_dma->mutex);
> +
>  	/* Wait for command status zero =3D ready */
>  	status =3D spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.stat=
us) &
>  				MPC52xx_PSC_SR_CMDSEND), 100, 0);
>  	if (status =3D=3D 0) {
>  		pr_err("timeout on ac97 bus (write)\n");
> -		return;
> +		goto out;
>  	}
>  	/* Write data */
>  	out_be32(&psc_dma->psc_regs->ac97_cmd,
>  			((reg & 0x7f) << 24) | (val << 8));
> +
> + out:
> +	mutex_unlock(&psc_dma->mutex);
>  }
> =20
>  static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpJrkcACgkQD27XaX1/VRsY/QCgyx8IMANjokbNnrOQlXINRLeW
lT4AnAy3ES9r3wriGkRN7ivnLA3zyRHb
=RUPr
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
