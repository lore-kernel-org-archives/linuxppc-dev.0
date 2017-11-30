Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynNzV2n1kzDrKt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 15:03:02 +1100 (AEDT)
Date: Thu, 30 Nov 2017 14:53:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: linux-kernel@vger.kernel.org, michael@ellerman.id.au, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: PPC: Book3S HV: Remove redundant parameter from
 resize_hpt_release()
Message-ID: <20171130035331.GR3023@umbus.fritz.box>
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
 <1511973506-65683-5-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LkYZvX65tyO4RZtj"
In-Reply-To: <1511973506-65683-5-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LkYZvX65tyO4RZtj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:38:26AM -0500, Serhii Popovych wrote:
> There is no need to pass it explicitly from the caller:
> struct kvm_resize_hpt already contains it.
>=20
> Additional benefit from this change is that BUG_ON()
> assertion now checks that mutex is held on kvm instance
> associated with resize structure we going to release.
>=20
> Also kill check for resize being NULL to make code
> simpler and we called with resize !=3D NULL in all
> places except kvm_vm_ioctl_resize_hpt_commit().
>=20
> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3=
s_64_mmu_hv.c
> index 690f061..a74a0ad 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -1415,12 +1415,11 @@ static void resize_hpt_pivot(struct kvm_resize_hp=
t *resize)
>  	resize_hpt_debug(resize, "resize_hpt_pivot() done\n");
>  }
> =20
> -static void resize_hpt_release(struct kvm *kvm, struct kvm_resize_hpt *r=
esize)
> +static void resize_hpt_release(struct kvm_resize_hpt *resize)
>  {
> -	BUG_ON(!mutex_is_locked(&kvm->lock));
> +	struct kvm *kvm =3D resize->kvm;
> =20
> -	if (!resize)
> -		return;
> +	BUG_ON(!mutex_is_locked(&kvm->lock));
> =20
>  	if (resize->error !=3D -EBUSY) {
>  		kvmppc_free_hpt(&resize->hpt);
> @@ -1469,7 +1468,7 @@ static void resize_hpt_prepare_work(struct work_str=
uct *work)
>  	resize->error =3D err;
> =20
>  	if (kvm->arch.resize_hpt !=3D resize)
> -		resize_hpt_release(kvm, resize);
> +		resize_hpt_release(resize);
> =20
>  	mutex_unlock(&kvm->lock);
>  }
> @@ -1499,13 +1498,13 @@ long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *=
kvm,
>  			if (ret =3D=3D -EBUSY)
>  				ret =3D 100; /* estimated time in ms */
>  			else if (ret)
> -				resize_hpt_release(kvm, resize);
> +				resize_hpt_release(resize);
> =20
>  			goto out;
>  		}
> =20
>  		/* not suitable, cancel it */
> -		resize_hpt_release(kvm, resize);
> +		resize_hpt_release(resize);
>  	}
> =20
>  	ret =3D 0;
> @@ -1590,7 +1589,8 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
>  	kvm->arch.mmu_ready =3D 1;
>  	smp_mb();
>  out_no_hpt:
> -	resize_hpt_release(kvm, resize);
> +	if (resize)
> +		resize_hpt_release(resize);
>  	mutex_unlock(&kvm->lock);
>  	return ret;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LkYZvX65tyO4RZtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofgLsACgkQbDjKyiDZ
s5JXMg//bzzqrVwhIs182eCxXRY2ydIB3H7KAvTzWM1lBK8L8wZ+1kfTTIaUg8Mn
r4DcKi1dwIgl9gLPvzqOTmx+feLIhQ/xqKWPud3OV/0IZ7dwNM61yMVzsFKzV8J8
yXbWauquctw0LHMuAp/mUseSylCLpxxofPDg5pDmMwklFeABxsXcYwXbszHGXgpN
VEsK7zOK5UWvK0jdEqo3HyfuANhPbeaTbydHIUm3VOp5uM0aPPdB7D1jE5P4iPrr
h2Uga9nE/Vj04O+Xka5hZj+d5InGIUVTUqGx7KTRfkOlm3/Q21VuWecEbnknfLKa
0xY/VHF17PT1G4+nrIV2io2TDxp4SmkhJMoyHCnUNkRP/GL67FCEtJfPOZLF+aeh
4h+XQ6CQai3TDbd9SLxTvaIQpghxzUO/fJhW0VR3Z2vJQ0V61cW0Bd7ZBher1I5k
r7XnZv1OIa7A+z3BkQtIrkuUzaDo6A/PHQRbmdGuWsz3NWJX55DPO+D+A6725NJ4
vPtup5AarS9AdR4ei3revYMRxrYcJdSyi0Z+3DgOB/LRUlzXMzQljbs5wp1RYhTX
4K8pMPGMSufuyztQAeCgLX+EKACmIqDM/Cd4If4xjjpYFUFbMotVF9I/H1FHham2
n1/3duptRrvGJXqp50ZdPORWyhMX4t71NUCWnWlfENnD0sqzdz0=
=1hbw
-----END PGP SIGNATURE-----

--LkYZvX65tyO4RZtj--
