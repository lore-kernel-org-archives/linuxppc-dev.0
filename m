Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXLN83ccSzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:19:52 +1100 (AEDT)
Date: Tue, 28 Feb 2017 11:56:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org
Cc: dan.carpenter@oracle.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: Prevent double-free on HPT resize commit path
Message-ID: <20170228005655.GK17615@umbus.fritz.box>
References: <20170215034004.9255-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qr7nXUVd9Lj/wfVJ"
In-Reply-To: <20170215034004.9255-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qr7nXUVd9Lj/wfVJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 02:40:04PM +1100, David Gibson wrote:
> resize_hpt_release(), called once the HPT resize of a KVM guest is
> completed (successfully or unsuccessfully) free()s the state structure for
> the resize.  It is currently not safe to call with a NULL pointer.
>=20
> However, one of the error paths in kvm_vm_ioctl_resize_hpt_commit() can
> invoke it with a NULL pointer.  This will occur if userspace improperly
> invokes KVM_PPC_RESIZE_HPT_COMMIT without previously calling
> KVM_PPC_RESIZE_HPT_PREPARE, or if it calls COMMIT twice without an
> intervening PREPARE.
>=20
> To fix this potential crash bug - and maybe others like it, make it safe
> (and a no-op) to call resize_hpt_release() with a NULL resize pointer.
>=20
> Found by Dan Carpenter with a static checker.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Ping,

Paul have you taken this one?

> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3=
s_64_mmu_hv.c
> index 013552f..72ccac2 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -1407,6 +1407,9 @@ static void resize_hpt_release(struct kvm *kvm, str=
uct kvm_resize_hpt *resize)
>  {
>  	BUG_ON(kvm->arch.resize_hpt !=3D resize);
> =20
> +	if (!resize)
> +		return;
> +
>  	if (resize->hpt.virt)
>  		kvmppc_free_hpt(&resize->hpt);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qr7nXUVd9Lj/wfVJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtMrWAAoJEGw4ysog2bOSqEMP/jBilOR2YBdU2/gwfd50xbIp
O0nrWx/SHLVJNreLuM15z9F1ksbCFX16f9v9WcF5wMiYDSS8+b4+wofjNtZP430X
edicxS9l0IsRaKfoKhpv1rjcOP8utBWPKgjJTecgdV7j+eAWaPQYaVZlhhIeVO6F
LwtOH+UegiKDNGzPMa3LQraV9LMVT+oJ7i0+ZqHYXDmThULXnCS4MGCnq+R3kOyk
C7BTxrpiW/xo8eRg/+wbPuWPaSMV827MDYA1G13S7EkjeKNK084VG8o1J9fYnx2k
yRc5c4EtbyihzjZVRUdvpACMSglnibGmepkg8u+mqfhKUDcNBQ4H0HPQxJg5gqYt
t1JosR5yj7Dydmx7F1EkOKdKr2m/H0EfooT4HXZJORilY9P5bWB9fS3/BKVVPpl4
AxBegDNV7pon0TcO6jvANXu91pHaiVIywEx4ArGRoX4qazSmSJp4mUJLdGyh6Y3k
re0zWQSZwNFBzAwYoxI6SkxRS4EZhVMRzZ2+TFySBKESHTIESrrTgQBYcjgqikpI
/YXN4N72lRiwkt3OTG0PFj2fC4seplrhBC9yhck5ua8uYhJWTsc5kYmNFKkGeWHM
opwwq8yRpTgbVJrodlZHyV3dYI8LK479SkKqyPMly/crS6mJHKMKUZpbEa2OEgke
BTC/zIlRe3w/P3c7BesN
=BjeB
-----END PGP SIGNATURE-----

--qr7nXUVd9Lj/wfVJ--
