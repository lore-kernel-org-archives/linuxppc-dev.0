Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjGyT2tM5zDwcn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 10:16:49 +1100 (AEDT)
Date: Tue, 20 Dec 2016 10:16:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Cc: paulus@samba.org, michael@ellerman.id.au, benh@kernel.crashing.org,
 sjitindarsingh@gmail.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 06/11] powerpc/kvm: Allow KVM_PPC_ALLOCATE_HTAB ioctl()
 to change HPT size
Message-ID: <20161219231630.GE23176@umbus.fritz.box>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-7-david@gibson.dropbear.id.au>
 <6c2566ea-cc80-4c02-27a2-258284d8f98b@redhat.com>
 <20161219004809.GL12146@umbus.fritz.box>
 <51db41a4-f779-2c4a-5434-839c55025114@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
In-Reply-To: <51db41a4-f779-2c4a-5434-839c55025114@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 08:49:24AM +0100, Thomas Huth wrote:
> On 19.12.2016 01:48, David Gibson wrote:
> > On Fri, Dec 16, 2016 at 01:44:57PM +0100, Thomas Huth wrote:
> >> On 15.12.2016 06:53, David Gibson wrote:
> >>> The KVM_PPC_ALLOCATE_HTAB ioctl() is used to set the size of hashed p=
age
> >>> table (HPT) that userspace expects a guest VM to have, and is also us=
ed to
> >>> clear that HPT when necessary (e.g. guest reboot).
> >>>
> >>> At present, once the ioctl() is called for the first time, the HPT si=
ze can
> >>> never be changed thereafter - it will be cleared but always sized as =
=66rom
> >>> the first call.
> >>>
> >>> With upcoming HPT resize implementation, we're going to need to allow
> >>> userspace to resize the HPT at reset (to change it back to the defaul=
t size
> >>> if the guest changed it).
> >>>
> >>> So, we need to allow this ioctl() to change the HPT size.
> >>>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> [...]
> >>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/b=
ook3s_64_mmu_hv.c
> >>> index 68bb228..8e5ac2f 100644
> >>> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> >>> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> >>> @@ -104,10 +104,22 @@ void kvmppc_set_hpt(struct kvm *kvm, struct kvm=
_hpt_info *info)
> >>>  		info->virt, (long)info->order, kvm->arch.lpid);
> >>>  }
> >>> =20
> >>> -long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
> >>> +void kvmppc_free_hpt(struct kvm_hpt_info *info)
> >>> +{
> >>> +	vfree(info->rev);
> >>> +	if (info->cma)
> >>> +		kvm_free_hpt_cma(virt_to_page(info->virt),
> >>> +				 1 << (info->order - PAGE_SHIFT));
> >>> +	else
> >>> +		free_pages(info->virt, info->order - PAGE_SHIFT);
> >>> +	info->virt =3D 0;
> >>> +	info->order =3D 0;
> >>> +}
> >>
> >> Why do you need to move kvmppc_free_hpt() around? Seems like unecessary
> >> code churn to me?
> >=20
> > Previously, kvmppc_free_hpt() wasn't needed in
> > kvmppc_alloc_reset_hpt(), now it is.  So we need to move it above that
> > function.  I could move it in the previous patch, but that would
> > obscure what the actual changes are to it, so it seemed better to do
> > it here.
>=20
> kvmppc_free_hpt() is not a static function, there is a prototype in a
> header for this somewhere, so as far as I can see, it should also work
> without moving this function?

Oh yeah.. how did I miss that..

>=20
> [...]
> >>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_h=
v.c
> >>> index 71c5adb..957e473 100644
> >>> --- a/arch/powerpc/kvm/book3s_hv.c
> >>> +++ b/arch/powerpc/kvm/book3s_hv.c
> >>> @@ -3600,12 +3600,9 @@ static long kvm_arch_vm_ioctl_hv(struct file *=
filp,
> >>>  		r =3D -EFAULT;
> >>>  		if (get_user(htab_order, (u32 __user *)argp))
> >>>  			break;
> >>> -		r =3D kvmppc_alloc_reset_hpt(kvm, &htab_order);
> >>> +		r =3D kvmppc_alloc_reset_hpt(kvm, htab_order);
> >>>  		if (r)
> >>>  			break;
> >>> -		r =3D -EFAULT;
> >>> -		if (put_user(htab_order, (u32 __user *)argp))
> >>> -			break;
> >>
> >> Now that htab_order is not changed anymore by the kernel, I'm pretty
> >> sure you need some checks on the value here before calling
> >> kvmppc_alloc_reset_hpt(), e.g. return an error code if htab_order <
> >> PPC_MIN_HPT_ORDER.
> >=20
> > Right.  I've done that by putting the checks into
> > kvmppc_allocate_hpt() in the earlier patch.
> >=20
> >> And, I'm not sure if I got that right, but in former times, the
> >> htab_order from the userspace application was just a suggestion, and n=
ow
> >> it's mandatory, right? So if an old userspace used a very high value
> >> here (or even something smaller than PPC_MIN_HPT_ORDER like 0), the
> >> kernel fixed this up and the userspace could run happily with the fixed
> >> value afterwards. But since this value from userspace if mandatory now,
> >> such an userspace application is broken now. So maybe it's better to
> >> introduce a new ioctl for this new behavior instead, to avoid breaking
> >> old userspace applications?
> >=20
> > A long time ago it was just a hint.  However, that behaviour was
> > already changed in 572abd5 "KVM: PPC: Book3S HV: Don't fall back to
> > smaller HPT size in allocation ioctl".  This is important: without
> > that we could get a different HPT size on the two ends of a migration,
> > which broke things nastily.
>=20
> OK, makes sense, especially if the userspace provided an order. But if I
> get that patch right, it was still possible to call with order =3D=3D 0 to
> get the automatic sizing?

No, I don't think so.  It was possible to pass a NULL htab_orderp to
the allocation functions to get autosizing, but that would only
actually happen when called from kvm run because the explicit
allocation ioctl() hadn't been called yet.

> Do we need to preserve that behavior for some
> very old userspace applications?

No; as long as userspace has used this ioctl() at all, it has always
passed an explicit size, never attempted to use autosizing.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYWGpLAAoJEGw4ysog2bOSpM4P/0I/na0yUFj6JE2fVBKJy0ba
803nOX+Q7PQa1vRrEREePsvV49m5IA3UmnOq2pPD7oKRgNrbwVUcSmwN8R8krEYK
URe3OvNl9bmVq71/JSUe+7AgjiRj91ZgEYVts0jFXjtygI5fK60SrcCrpq8JR7iO
oJuo4bc62gsI8B5UjbQn4fk1TY1XEmMYJ7jH+YcAwOgV6dhFHSVuAYYBt/4vnUdS
OwDvAcoYkfflGL9hN+tkiq0aD+/5Z3Igv1Edjd3GbLwCczKD/Kbp7ZU0kMAAjiKY
ctXQF3WjDD/iYu3B8KcBfurLx57Yh0tOVknHL1mq9Dfk2efHEvkyTaN5lVkWtomI
jJxDRbf5OLxUiMcm0oRWNsrek8YDnlnZ2gJw7Du6DdOq7l/S1A156Lh/fe0PfeCh
TjLzeq8SFdKFC2eU/dA+RPt//PDs/1VxLo8ITZorErw8FE8dv5+eVBYDp0nVce/K
n0HPNrIinS6nWAU6ZAQK65BBoyCNCz3Ud05icCVu0IkmYZrRbVvONm7OkraDVxGx
VfnxwsOX6YfXkIrd7u/pF/D1Sca/BqBpP5mdfRxXa79pjvkL4AOhtiK9t9xKpYuf
Sjido6yVhkmOE9aMWzjor+u+UD6yublYcoKznCv52J4iXrl+Rt3DaguTb4XFQPxC
KCgOUAYULOnJoqHEOS9q
=Fd4s
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
