Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynNzT5b3hzDqwr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 15:03:01 +1100 (AEDT)
Date: Thu, 30 Nov 2017 14:40:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: linux-kernel@vger.kernel.org, michael@ellerman.id.au, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 1/4] KVM: PPC: Book3S HV: Drop prepare_done from struct
 kvm_resize_hpt and cleanups
Message-ID: <20171130034040.GO3023@umbus.fritz.box>
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
 <1511973506-65683-2-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Thv7PGoFpDPJ7Oar"
In-Reply-To: <1511973506-65683-2-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Thv7PGoFpDPJ7Oar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:38:23AM -0500, Serhii Popovych wrote:
> Replace ->prepare_done flag functionality with special handling
> of -EBUSY in ->error as indicator that allocation work is running.
>=20
> Besides cosmetics this reduces size of struct kvm_resize_hpt by
> __alignof__(struct kvm_hpt_info) and saves few bytes of code.
>=20
> While there correct comment in struct kvm_resize_hpt about locking
> used to protect access to certain fields.
>=20
> Assert with BUG_ON() in case of HPT allocation thread work runs
> more than once for resize request or resize_hpt_allocate()
> returns -EBUSY that is treated specially.
>=20
> Change comparison against zero to make checkpatch.pl happy.
>=20
> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 42 ++++++++++++++++++++++---------=
------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3=
s_64_mmu_hv.c
> index 235319c..0534aab 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -65,11 +65,17 @@ struct kvm_resize_hpt {
>  	u32 order;
> =20
>  	/* These fields protected by kvm->lock */
> +
> +	/* Possible values and their usage:
> +	 *  <0     an error occurred during allocation,
> +	  * -EBUSY allocation is in the progress,
> +	 *  0      allocation made successfuly.
> +	 */
>  	int error;
> -	bool prepare_done;
> =20
> -	/* Private to the work thread, until prepare_done is true,
> -	 * then protected by kvm->resize_hpt_sem */
> +	/* Private to the work thread, until error !=3D -EBUSY,
> +	 * then protected by kvm->lock.
> +	 */
>  	struct kvm_hpt_info hpt;
>  };
> =20
> @@ -1432,15 +1438,21 @@ static void resize_hpt_prepare_work(struct work_s=
truct *work)
>  	struct kvm *kvm =3D resize->kvm;
>  	int err;
> =20
> +	BUG_ON(resize->error !=3D -EBUSY);
> +
>  	resize_hpt_debug(resize, "resize_hpt_prepare_work(): order =3D %d\n",
>  			 resize->order);
> =20
>  	err =3D resize_hpt_allocate(resize);
> =20
> +	/* We have strict assumption about -EBUSY
> +	 * when preparing for HPT resize.
> +	 */
> +	BUG_ON(err =3D=3D -EBUSY);
> +
>  	mutex_lock(&kvm->lock);
> =20
>  	resize->error =3D err;
> -	resize->prepare_done =3D true;
> =20
>  	mutex_unlock(&kvm->lock);
>  }
> @@ -1465,14 +1477,12 @@ long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *=
kvm,
> =20
>  	if (resize) {
>  		if (resize->order =3D=3D shift) {
> -			/* Suitable resize in progress */
> -			if (resize->prepare_done) {
> -				ret =3D resize->error;
> -				if (ret !=3D 0)
> -					resize_hpt_release(kvm, resize);
> -			} else {
> +			/* Suitable resize in progress? */
> +			ret =3D resize->error;
> +			if (ret =3D=3D -EBUSY)
>  				ret =3D 100; /* estimated time in ms */
> -			}
> +			else if (ret)
> +				resize_hpt_release(kvm, resize);
> =20
>  			goto out;
>  		}
> @@ -1492,6 +1502,8 @@ long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kv=
m,
>  		ret =3D -ENOMEM;
>  		goto out;
>  	}
> +
> +	resize->error =3D -EBUSY;
>  	resize->order =3D shift;
>  	resize->kvm =3D kvm;
>  	INIT_WORK(&resize->work, resize_hpt_prepare_work);
> @@ -1546,16 +1558,12 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *k=
vm,
>  	if (!resize || (resize->order !=3D shift))
>  		goto out;
> =20
> -	ret =3D -EBUSY;
> -	if (!resize->prepare_done)
> -		goto out;
> -
>  	ret =3D resize->error;
> -	if (ret !=3D 0)
> +	if (ret)
>  		goto out;
> =20
>  	ret =3D resize_hpt_rehash(resize);
> -	if (ret !=3D 0)
> +	if (ret)
>  		goto out;
> =20
>  	resize_hpt_pivot(resize);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Thv7PGoFpDPJ7Oar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloffbUACgkQbDjKyiDZ
s5IQhhAA31vBjydx799tzGBY59NqRkjQpMIRv1nPPDi2jZsLI7QJf0l1bSWCAHhs
Qfcx1xB0MZlU+ZTegcKvcPu8FodlvR4m5o/+2mzSl4zwAeeasJYgus7TylFjeeQg
KXDHWziWgTMpP+lFPzTFJOZu2J8NCcpkSKttcKzy7tH6eSBmwGjvXM+U7+IszMmT
cuLFOTB81MxRUb8sjLWRfmlimiWSts4WKzkaRIYxVWPIT+0VnYMeKrTwNUN8Mtcd
iKjLNhY9dhTzRQd4dOgPcud4Y11wdh40vEST/UaSM7L8FFkLMmsfRaKxQY1nQ/Aq
DdZ2DfEdQnlQGo7wwOZXv/3Fdy1Vy1VWb5Diw46pWeLDCIYxjJxIJv3FjVVFrgsC
YikBQXn7A07g7vRw6UxjR4SpuWEjo4gh8DhtLY5HLPQrUg0yfhCwrod82hZlE2Pg
4M6I/ZIHHNNgxaXaO33tQk5f4RsRWw7sZhmPVTfqrzTSYbB34trJNkOpsd3b3PlX
alfWhJxA5BnySCfarRvhw3ZjvTWRO48ZMamtLRgXvhT30y+EJLtSq4tkXBDO844v
pV17K+iD59RKM0mzZsA5gmj/rOeKu86s9KA57yftIvMwO8ZVc0zXtiQOlBkK+bkg
1nS0cypTJkdRsGjKZXHmEHuNjzCVcTmNpRu3oEFZxhqPqAC0AtM=
=c929
-----END PGP SIGNATURE-----

--Thv7PGoFpDPJ7Oar--
