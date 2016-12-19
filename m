Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thtrC30S3zDwMS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 19:10:03 +1100 (AEDT)
Date: Mon, 19 Dec 2016 17:37:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Cc: paulus@samba.org, michael@ellerman.id.au, benh@kernel.crashing.org,
 sjitindarsingh@gmail.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 01/11] powerpc/kvm: Reserve capabilities and ioctls for
 HPT resizing
Message-ID: <20161219063718.GB23176@umbus.fritz.box>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-2-david@gibson.dropbear.id.au>
 <8e032a54-de3d-b3dc-527e-a58f4874e6fe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
In-Reply-To: <8e032a54-de3d-b3dc-527e-a58f4874e6fe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2016 at 02:15:30PM +0100, Thomas Huth wrote:
> On 15.12.2016 06:53, David Gibson wrote:
> > This adds a new powerpc-specific KVM_CAP_SPAPR_RESIZE_HPT capability to
> > advertise whether KVM is capable of handling the PAPR extensions for
> > resizing the hashed page table during guest runtime.
> >=20
> > At present, HPT resizing is possible with KVM PR without kernel
> > modification, since the HPT is managed within qemu.  It's not possible =
yet
> > with KVM HV, because the HPT is managed by KVM.  At present, qemu has to
> > use other capabilities which (by accident) reveal whether PR or HV is in
> > use to know if it can advertise HPT resizing capability to the guest.
> >=20
> > To avoid ambiguity with existing kernels, the encoding is a bit odd.
> >     0 means "unknown" since that's what previous kernels will return
> >     1 means "HPT resize possible if available if and only if the HPT is=
 allocated in
> >       userspace, rather than in the kernel".  Userspace can check
> >       KVM_CAP_PPC_ALLOC_HTAB to determine if that's the case.  In pract=
ice
> >       this will give the same results as userspace's fallback check.
> >     2 will mean "HPT resize available and implemented via ioctl()s
> >       KVM_PPC_RESIZE_HPT_PREPARE and KVM_PPC_RESIZE_HPT_COMMIT"
> >=20
> > For now we always return 1, but the intention is to return 2 once HPT
> > resize is implemented for KVM HV.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  arch/powerpc/kvm/powerpc.c |  3 +++
> >  include/uapi/linux/kvm.h   | 10 ++++++++++
> >  2 files changed, 13 insertions(+)
> >=20
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index efd1183..bb23923 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -605,6 +605,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
> >  	case KVM_CAP_SPAPR_MULTITCE:
> >  		r =3D 1;
> >  		break;
> > +	case KVM_CAP_SPAPR_RESIZE_HPT:
> > +		r =3D 1; /* resize allowed only if HPT is outside kernel */
> > +		break;
> >  #endif
> >  	case KVM_CAP_PPC_HTM:
> >  		r =3D cpu_has_feature(CPU_FTR_TM_COMP) &&
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index cac48ed..904afe0 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -685,6 +685,12 @@ struct kvm_ppc_smmu_info {
> >  	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
> >  };
> > =20
> > +/* for KVM_PPC_RESIZE_HPT_{PREPARE,COMMIT} */
> > +struct kvm_ppc_resize_hpt {
> > +	__u64 flags;
> > +	__u32 shift;
> > +};
>=20
> I think you should also add a final "__u32 pad" to that struct to make
> sure that it is naturally aligned (like it is done with struct
> kvm_coalesced_mmio_zone already for example).

Seems reasonable; done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYV4AdAAoJEGw4ysog2bOS2s0P/2ov/ehWqZ0lovWp7W4slANj
e41H0mTqK3y6VRRdnVp725YXgPWXkCpeRNB6yqS7oydLrxM6Rs4cx+9VGZRQ4/5a
5YnjJVTgAabxHGftqhTgSJgmpJG71kjyTLSKNGke/kIl9KtRUjtX2BDawXo3QHe5
+YTNNGHv7K3qPzGG6SPmYITyZY6bRKvXH+XW5ygV8TvEgzH3pfZDf5Rye2LPQ6I2
+7olyD//518hOhjQJgGxQb4ym0b3OqpGX2tIySLnoQ2R2Cfj7w714m85j1nttknp
7ITf2M9iPy7MUCMsQAnu871Tk5kLO0yua5Sx1FtIya77+Uil40gKsYu6YDTLVkdz
odw8gDEes423szqz0E0SSX0Hdp2+KPZ5LgRa7w7dlB81DMR/x909ut6kZT4H1mwB
XYM5Q26h0b10gA+VIrEpZJL86iIJiDMUKhiFfu5MsbGztmEMxnCORPbP3cFP0GLm
7bad0lGJLr44YZvDPb9P/N24PmFbVr9BowPMQh5/SSAfR00XkJLDZXQBzKlI9cNl
wH+6GNSdtpgvBU5Ap5tNhyWoZbgbdDK11SOQXOzQ0ijtk0lgIRNzukFOcPPtfHKt
+geTPSxGqNZ8IF0VETpGadybBsGsE1Q/LLTDSGI4fVWZ//frWbGHXjZxYKz7t8AL
6uC34q/ciK2QDfW+Thor
=+Xum
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
