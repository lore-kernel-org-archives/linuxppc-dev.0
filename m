Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2sLG4FkPzF06g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 13:05:58 +1100 (AEDT)
Date: Fri, 22 Dec 2017 11:54:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, benh@au1.ibm.com
Subject: Re: [PATCH 1/1] powerpc/pseries: Use the system workqueue as
 fallback to hotplug workqueue
Message-ID: <20171222005410.GB26042@umbus.fritz.box>
References: <20171221154448.22965-1-joserz@linux.vnet.ibm.com>
 <20171221154448.22965-2-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
In-Reply-To: <20171221154448.22965-2-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2017 at 01:44:48PM -0200, Jose Ricardo Ziviani wrote:
> The hotplug engine uses its own workqueue to handle IRQ requests, the
> problem is that such workqueue is initialized not so early in the boot
> process.
>=20
> Thus, when the kernel is ready to handle IRQ requests, after the system
> workqueue is initialized, we have a timeframe where any hotplug issued
> by the client will result in a kernel panic. That timeframe goes until
> the hotplug workqueue is initialized.
>=20
> It would be good to have the hotplug workqueue initialized as soon as
> the system workqueue but I don't think it is possible. So, this patch
> uses the system workqueue as a fallback the handle such IRQs.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

I don't think this is the right approach.

It seems to me the bug is that the hotplug interrupt is registered in
init_ras_IRQ(), before the work queue is initialized in
pseries_dlpar_init().  We need to correct that ordering.

> ---
>  arch/powerpc/platforms/pseries/dlpar.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platfo=
rms/pseries/dlpar.c
> index 6e35780c5962..0474aa14b5f6 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -399,7 +399,15 @@ void queue_hotplug_event(struct pseries_hp_errorlog =
*hp_errlog,
>  		work->errlog =3D hp_errlog_copy;
>  		work->hp_completion =3D hotplug_done;
>  		work->rc =3D rc;
> -		queue_work(pseries_hp_wq, (struct work_struct *)work);
> +
> +		/* The hotplug workqueue may happen to be NULL at the moment
> +		 * this code is executed, during the boot phase. So, in this
> +		 * scenario, we can fallback to the system workqueue.
> +		 */
> +		if (unlikely(pseries_hp_wq =3D=3D NULL))
> +			schedule_work((struct work_struct *)work);
> +		else
> +			queue_work(pseries_hp_wq, (struct work_struct *)work);
>  	} else {
>  		*rc =3D -ENOMEM;
>  		kfree(hp_errlog_copy);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo8V68ACgkQbDjKyiDZ
s5Lj+w/+M5LAbH6d2+21SPxI9DcSHehnd1SU4b4+yUnZYKfak9skKwxxXuUrlVJw
DsusG6TGYIAHKdsfF0Fgjh464PjBmKpP01momrDemG94/jJeK0PMr5d24pMPfCAk
zGIfmG2cW50Z+myh/lEeRMRLGcAsPKCoc65E+d1Z6/OKxhvbarSYg1mT9tPiiDwG
FIlvKtI7n7roSl4pFxO3XzGtwwhk/3CD91TOHXUMseG9igU3ltfVHIhq3SF0BLoA
+HfGf31zTsaCy404+0/MIJ41A66a2M0zno+jIvVT1v7uU8m/JX735f3CCnA+0jTI
yJly1ifJ4oYnAD00Pa7aGAbYTMbBa3lTWVf4anPsO/bnsiwap1Ag4IRn+NC0xgBi
6exbWkgb2Bc8oT+AN8LoBfSF+Hj7gYb6BgO6D8O7CSn7C+qE3Cjba43wSTxPZ5ZV
f5j/00H7WmHxgy/VLJF5WDGQNe53RrGMRi37oPvQOvHtHGaKY2r4uTApSWQg7rUm
CfY64eEQRni/zk3ZJcBhYcha//RUlT+jyp95QpcgBJuAheaqsO+OSoOQAuGq22oF
X486CY50jmmAkeKLuX64OhuQn6P0QWb9syLd38wLrGR4I2sZDrspBU+xj3d9/xDM
XfTBDcnyuWmeqQ8WnjOWxS9vMDjPBpA7Uv/J//ypnQkxn1sfX6w=
=ncVZ
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
