Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2EDC1B7BB9
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 19:44:24 +1000 (EST)
Date: Sat, 3 Oct 2009 11:44:17 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc/5200: make BestComm gen_bd microcode exchangeable
Message-ID: <20091003094417.GA24206@pengutronix.de>
References: <1254426938.3252.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
In-Reply-To: <1254426938.3252.1@antares>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Albrecht,

you wrote your own microcode? :)
approach looks ok to me in general, but this patch is line-wrapped.

On Thu, Oct 01, 2009 at 09:55:38PM +0200, Albrecht Dre=DF wrote:
> This patch adds a method for defining different microcodes than the =20
> pe-defined ones for the MPC52xx processor's BestComm General Buffer =20

pre-defined

> Descriptor (gen_db) tasks.  The default microcode is still the one from =
=20
> bcom_gen_bd_[rt]x_task, but it can be replaced by calling =20
> bcom_gen_bd_set_microcode() which is more efficient than explicitly =20
> loading it via bcom_load_image() after each bcom_gen_bd_[rt]x_reset().
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
>
>
> ---
>
>
> diff -uprN -X linux-2.6.30.3/Documentation/dontdiff =20
> linux-2.6.30.3.orig/arch/powerpc/sysdev/bestcomm/gen_bd.c =20
> linux-2.6.30.3/arch/powerpc/sysdev/bestcomm/gen_bd.c
> --- linux-2.6.30.3.orig/arch/powerpc/sysdev/bestcomm/gen_bd.c	2009-07-24=
=20
> 23:47:51.000000000 +0200
> +++ linux-2.6.30.3/arch/powerpc/sysdev/bestcomm/gen_bd.c	2009-10-01=20
> 14:26:33.000000000 +0200
> @@ -78,6 +78,7 @@ struct bcom_gen_bd_priv {
>  	int		initiator;
>  	int		ipr;
>  	int		maxbufsize;
> +	u32    *microcode;

spaces instead of tabs

>  };
>
>
> @@ -104,6 +105,7 @@ bcom_gen_bd_rx_init(int queue_len, phys_
>  	priv->initiator	=3D initiator;
>  	priv->ipr	=3D ipr;
>  	priv->maxbufsize =3D maxbufsize;
> +	priv->microcode =3D bcom_gen_bd_rx_task;
>
>  	if (bcom_gen_bd_rx_reset(tsk)) {
>  		bcom_task_free(tsk);
> @@ -128,7 +130,7 @@ bcom_gen_bd_rx_reset(struct bcom_task *t
>  	var =3D (struct bcom_gen_bd_rx_var *) bcom_task_var(tsk->tasknum);
>  	inc =3D (struct bcom_gen_bd_rx_inc *) bcom_task_inc(tsk->tasknum);
>
> -	if (bcom_load_image(tsk->tasknum, bcom_gen_bd_rx_task))
> +	if (bcom_load_image(tsk->tasknum, priv->microcode))
>  		return -1;
>
>  	var->enable	=3D bcom_eng->regs_base +
> @@ -188,6 +190,7 @@ bcom_gen_bd_tx_init(int queue_len, phys_
>  	priv->fifo	=3D fifo;
>  	priv->initiator	=3D initiator;
>  	priv->ipr	=3D ipr;
> +	priv->microcode =3D bcom_gen_bd_tx_task;
>
>  	if (bcom_gen_bd_tx_reset(tsk)) {
>  		bcom_task_free(tsk);
> @@ -212,7 +215,7 @@ bcom_gen_bd_tx_reset(struct bcom_task *t
>  	var =3D (struct bcom_gen_bd_tx_var *) bcom_task_var(tsk->tasknum);
>  	inc =3D (struct bcom_gen_bd_tx_inc *) bcom_task_inc(tsk->tasknum);
>
> -	if (bcom_load_image(tsk->tasknum, bcom_gen_bd_tx_task))
> +	if (bcom_load_image(tsk->tasknum, priv->microcode))
>  		return -1;
>
>  	var->enable	=3D bcom_eng->regs_base +
> @@ -253,6 +256,16 @@ bcom_gen_bd_tx_release(struct bcom_task
>  }
>  EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_release);
>
> +void
> +bcom_gen_bd_set_microcode(struct bcom_task *tsk, u32 *microcode)
> +{
> +	struct bcom_gen_bd_priv *priv =3D tsk->priv;
> +
> +	priv->microcode =3D microcode;
> +}
> +EXPORT_SYMBOL_GPL(bcom_gen_bd_set_microcode);
> +
> +

Two empty lines.

>  /* =20
> ---------------------------------------------------------------------
>   * PSC support code
>   */
> diff -uprN -X linux-2.6.30.3/Documentation/dontdiff =20
> linux-2.6.30.3.orig/arch/powerpc/sysdev/bestcomm/gen_bd.h =20
> linux-2.6.30.3/arch/powerpc/sysdev/bestcomm/gen_bd.h
> --- linux-2.6.30.3.orig/arch/powerpc/sysdev/bestcomm/gen_bd.h	2009-07-24=
=20
> 23:47:51.000000000 +0200
> +++ linux-2.6.30.3/arch/powerpc/sysdev/bestcomm/gen_bd.h	2009-10-01=20
> 14:26:50.000000000 +0200
> @@ -43,6 +43,9 @@ bcom_gen_bd_tx_reset(struct bcom_task *t
>  extern void
>  bcom_gen_bd_tx_release(struct bcom_task *tsk);
>
> +extern void
> +bcom_gen_bd_set_microcode(struct bcom_task *tsk, u32 *microcode);
> +
>
>  /* PSC support utility wrappers */
>  struct bcom_task * bcom_psc_gen_bd_rx_init(unsigned psc_num, int =20
> queue_len,
>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrHHPEACgkQD27XaX1/VRvCtgCeMzLMUJss+9WX8dya/SdUcTtA
7oIAoK3J6c4FivC8i57bTCUKfd6/yIBE
=tk7j
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
