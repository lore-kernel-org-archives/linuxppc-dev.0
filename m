Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWlx918JYzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 13:27:57 +1100 (AEDT)
Date: Mon, 27 Feb 2017 12:53:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v5 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
Message-ID: <20170227015352.GP17615@umbus.fritz.box>
References: <20170222082133.10277-1-aik@ozlabs.ru>
 <20170222082133.10277-11-aik@ozlabs.ru>
 <20170224021432.GH17615@umbus.fritz.box>
 <7b2d6cba-73e7-e846-a520-fc2837694c11@ozlabs.ru>
 <20170224033607.GQ17615@umbus.fritz.box>
 <784555a2-2c4e-5a49-7b7e-68b0417ef5e1@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o6HUWsywbRjTg5uW"
In-Reply-To: <784555a2-2c4e-5a49-7b7e-68b0417ef5e1@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--o6HUWsywbRjTg5uW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 02:43:05PM +1100, Alexey Kardashevskiy wrote:
> On 24/02/17 14:36, David Gibson wrote:
> > On Fri, Feb 24, 2017 at 02:29:14PM +1100, Alexey Kardashevskiy wrote:
> >> On 24/02/17 13:14, David Gibson wrote:
> >>> On Wed, Feb 22, 2017 at 07:21:33PM +1100, Alexey Kardashevskiy
> wrote:
[snip]
> >>>> +static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
> >>>> +		struct iommu_table *tbl, unsigned long entry)
> >>>> +{
> >>>> +	enum dma_data_direction dir =3D DMA_NONE;
> >>>> +	unsigned long hpa =3D 0;
> >>>> +	long ret;
> >>>> +
> >>>> +	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
> >>>> +		return H_HARDWARE;
> >>>
> >>> To avoid a double WARN() (and to make the warnings easier to
> >>> understand) I'd suggest putting a WARN_ON() here, rather than in the
> >>> callers when they receieve an H_HARDWARE.  IIUC this really shouldn't
> >>> ever happen, and it certainly can't be the guest's fault?
> >>
> >>
> >> Makes sense.
> >=20
> > I guess it might want WARN_ON_ONCE() to avoid spamming the user with
> > errors for every TCE, though.
>=20
>=20
> We do not expect this to happen at all :) I can convert all of them to
> _ONCE really as the purpose of WARN_ON is mostly to document what we do n=
ot
> expect.

Sure, seems reasonable.

[snip]
> >>>> @@ -220,9 +338,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vc=
pu *vcpu,
> >>>>  {
> >>>>  	struct kvmppc_spapr_tce_table *stt;
> >>>>  	long i, ret =3D H_SUCCESS;
> >>>> -	unsigned long tces, entry, ua =3D 0;
> >>>> +	unsigned long tces, entry, ua =3D 0, tce, gpa;
> >>>>  	unsigned long *rmap =3D NULL;
> >>>>  	bool prereg =3D false;
> >>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
> >>>> =20
> >>>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> >>>>  	if (!stt)
> >>>> @@ -287,12 +406,24 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_v=
cpu *vcpu,
> >>>>  	}
> >>>> =20
> >>>>  	for (i =3D 0; i < npages; ++i) {
> >>>> -		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
> >>>> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);
> >>>> =20
> >>>>  		ret =3D kvmppc_tce_validate(stt, tce);
> >>>>  		if (ret !=3D H_SUCCESS)
> >>>>  			goto unlock_exit;
> >>>> =20
> >>>> +		gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> >>>> +
> >>>> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
> >>>> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
> >>>> +					stit->tbl, entry + i, gpa,
> >>>> +					iommu_tce_direction(tce));
> >>>> +			if (WARN_ON_ONCE(ret =3D=3D H_HARDWARE))
> >>>
> >>> I don't think you need the WARN() here - the only H_HARDWARE failure
> >>> path in iommu_map() already includes a WARN().
> >>
> >>
> >> True, I can drop it here.
> >>
> >>
> >>>
> >>>> +				kvmppc_rm_clear_tce(stit->tbl, entry);
> >>>> +			else if (ret !=3D H_SUCCESS)
> >>>> +				goto unlock_exit;
> >>>
> >>> It's also not clear to me why the H_HARDWARE error path clears the
> >>> entry, but the other failure paths don't.  Or why an H_HARDWARE will
> >>> result in continuing to set the rest of the TCEs, but other failures
> >>> won't.
> >>
> >>
> >> The idea was that other failures still have some chance that handling =
may
> >> succeed in virtual mode or via QEMU, H_HARDWARE is fatal.
> >=20
> > Um... yes.. but the logic seems to be backwards for that: on
> > H_HARDWARE you warn and keep going, on other errors you bail out
> > entirely.
>=20
> By "fatal" I means fatal for this particular hardware TCE(s), no hope in
> trying this particular TCE in virtual mode.

Ok... still not following why that means the "fatal" error results in
continuing to attempt for the rest of the updated TCEs, whereas the
"non fatal" one bails out.  Especially since the bail out will only go
to virtual mode if ret =3D=3D H_TOO_HARD, which it isn't clear is the only
possibility.

> >> I am just not sure if H_PARAMETER is what I want to return at [1], to =
make
> >> the calling code simplier, I could return H_HARDWARE there as well (in=
stead
> >> of H_PARAMETER).
> >=20
> > That sounds right, IIUC the gpa to ua translation shouldn't ever
> > fail because of something the guest did.=20
>=20
>=20
> The guest can easily pass bad TCE/GPA which is not in any registered slot.
> So it is rather H_PARAMETER.

Ah, yes.

> > So I'd expect either
> > H_HARDWARE, or H_TOO_HARD (if there's some hope that virtual mode can
> > make the translation when real mode couldn't).
>=20
> No, virtual mode uses the exact same helper.

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--o6HUWsywbRjTg5uW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs4auAAoJEGw4ysog2bOShiUP/jQqTTyCp7mZdcXTDINdH3en
AH1azx3WEBnJJSNkKPNANm26LIIhP4yRA6YqKAWikbwOoFj1Pnd0glR+Deu8gcB5
309jS/KJzSFgKnDmIbuQ0tKJbpw/rDUZSNUy4RWY+zl5FQpyGeA4jCmUvwfMSigJ
VBQ4z0JhLB+pG0ngWBjtIUdt8fR2Y59aWI/CUMr6hlTneQWOpfXxBsQFt8dOp3UW
6OlQPOpzTpVJxJMXwgj22YJbiQwhjn/kpeYAzyxjFQCWHUjmaVIC+28FYFvigns7
yjfIuErQj0V9YyKVuh7ROhAJiobv5+Xxv9Gc56cKkrm3XhiotsBB/uFBxf7eb82E
rWwqH7cR8SlUoO+u5PSjJfAhNfOupYybI9TVgcNjgWJwyiNUuZABJvsK8T4cDJZm
HI+/ttyxH7gozpzCxrroduBTjKbdB2V7U/PgxFboYdW6chvuN4zaz13QQidOKWoa
hAOBd4sU0/Bcg7hR6bv0o8GVAAT2/rmmsre2nFTaoGEH+y/NFr46SdtBIlWY+MbG
kMJLp8xkcBGW9yZYDaWOrrRtd3VQssSgVTd9Viiwh+7+rYCXK7yn4GRrGi8fXb5a
WkvdyPJZyBa6FYXUL+/KdXVoxjNM4TWNxB+iEsYrR5o6jvrPKCqqw/PZ9i2jeWxF
QeFFGQqKwX+6p2ievKwp
=Tfdb
-----END PGP SIGNATURE-----

--o6HUWsywbRjTg5uW--
