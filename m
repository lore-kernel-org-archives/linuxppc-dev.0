Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKLHq6tSPzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 14:37:59 +1100 (AEDT)
Date: Fri, 10 Feb 2017 14:07:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v4 08/10] KVM: PPC: Separate TCE validation from
 update
Message-ID: <20170210030723.GG27610@umbus.fritz.box>
References: <20170207071711.28938-1-aik@ozlabs.ru>
 <20170207071711.28938-9-aik@ozlabs.ru>
 <20170209035151.GA14524@umbus>
 <609bac92-9567-6250-c728-76c1f69b8271@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ag0ALTx5bNxCf4La"
In-Reply-To: <609bac92-9567-6250-c728-76c1f69b8271@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Ag0ALTx5bNxCf4La
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 07:20:11PM +1100, Alexey Kardashevskiy wrote:
> On 09/02/17 14:51, David Gibson wrote:
> > On Tue, Feb 07, 2017 at 06:17:09PM +1100, Alexey Kardashevskiy wrote:
> >> For the emulated devices it does not matter much if we get a broken TCE
> >> half way handling a TCE list but for VFIO it will matter as it has
> >> more chances to fail so we try to do our best and check as much as we
> >> can before proceeding.
> >>
> >> This separates a guest view table update from validation. No change in
> >> behavior is expected.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++++++
> >>  arch/powerpc/kvm/book3s_64_vio_hv.c | 8 ++++++--
> >>  2 files changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3=
s_64_vio.c
> >> index 15df8ae627d9..9a7b7fca5e84 100644
> >> --- a/arch/powerpc/kvm/book3s_64_vio.c
> >> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> >> @@ -282,6 +282,14 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *v=
cpu,
> >>  		ret =3D kvmppc_tce_validate(stt, tce);
> >>  		if (ret !=3D H_SUCCESS)
> >>  			goto unlock_exit;
> >> +	}
> >> +
> >> +	for (i =3D 0; i < npages; ++i) {
> >> +		if (get_user(tce, tces + i)) {
> >> +			ret =3D H_TOO_HARD;
> >> +			goto unlock_exit;
> >> +		}
> >> +		tce =3D be64_to_cpu(tce);
> >=20
> > This doesn't look safe.  The contents of user memory could change
> > between the two get_user()s, meaning that you're no longer guaranteed
> > a TCE loaded into kernel has been validated at all.
> >=20
> > I think you need to either:
> >=20
> >     a) Make sure things safe against a bad TCE being loaded into a TCE
> >     table and move all validation to where the TCE is used, rather
> >     than loaded
> >=20
> > or
> >     b) Copy the whole set of indirect entries to a temporary in-kernel
> >        buffer, then validate, then load into the actual TCE table.
>=20
>=20
> Correct :( The problem is I do not know how far I want to go in reverting
> the state as it was when I started handling H_PUT_TCE_INDIRECT.
>=20
> For example, 1 container, 2 IOMMU groups with disabled shared tables, so -
> 2 tables, 512 TCEs request and TCE#100 does not translate to host physical
> address.
>=20
>=20
> To do a) I'll need to remember old content of each hardware table entry as
> when I reach TCE#100, I'll need to revert to the initial state which means
> I need to write back old TCEs to all affected hardware tables and update
> reference counters of all affected preregistered areas. Well, the actual
> tables must not have different addresses (BUG_ON? is it worth testing whi=
le
> writing to hardware tables that values I am replacing are the same in all
> tables?) so I can have just a single array of old TCEs from hardware tabl=
es
> in vcpu.

I thought you said shared tables were disabled, so the two tables
would have different addresses?

Hmm.  Now I'm trying to remember, will the gpa->hpa translation fail
only if the guest/qemu does something wrong, or can it fail for other
reasons?  What about in real mode vs. virtual mode?

I think the key to this approach will be to think carefully about what
semantics you guarantee for mappings shadowed into the hardware
tables.  For example, it might work to specify that the host mappings
only match the GPA mappings if those GPA mapings are valid in the
first place.  So, H_PUT_TCE etc. would succeed as long as they're able
to update the view of the table in terms of GPA.  But when you shadow
those into the HPA tables, any entries which can't be translated you
just replace with a cleared entry. That should be enough to protect
the host.  Obviously you can expect the device to fail when you
actually attempt to DMA there, but that's the guest's (or qemu's) own
fault for putting bad addresses in the TCE table.

Obviously that might not be great for debugging, since mappings will
appear to succeed, but then not work later on.

This does have the nice property that it's reasonably obvious what to
do if you have some GPA mappings for emulated devices, then hotplug a
VFIO device and at that point hit a gpa->hpa translation error.
There's no hcall in this case, so there's no obvious way to return an
error to the guest.

> To do b) I'll need:
>=20
> 1. to have a copy of TCEs from the guest in vcpu,

I don't quite understand this.  You need a temporary copy, yes, but I
don't see why it needs to be attached to the vcpu.

> I populate it via
> get_user() to make sure they won't change;
> 2. an array of userspace addresses translated from given TCEs; and in ord=
er
> to make sure these addresses won't go away, I'll need to reference each
> preregistered memory area via mm_iommu_mapped_inc().
>=20
> When I reach TCE#100, I'll have to revert the change, i.e. call
> mm_iommu_mapped_dec().

Ugh.. yeah, I think to do this sanely, what you'd have to do is copy
the updated translations into a temp buffer.  Then you'd to make more
temp buffers to store the UA and HPA translations (although maybe you
could overwrite/reuse the original temp buffer if you're careful).
Then only if all of those succeed do you copy them into the real
hardware tables.

Which sounds like it might be kinda messy, at least in real mode.

> So I will end up having 2 arrays in a vcpu and simpler reverting code.
>=20
>=20
> Or I can do simpler version of b) which would store guest TCEs in
> kvm_vcpu_arch::tces[512] and use them after checking. If a malicious guest
> does something bad and I return from H_PUT_TCE_INDIRECT in a middle of
> request, some preregistered regions will stay referenced till the guest is
> killed or rebooted (and this will prevent memory from unregistering) - but
> this means no harm to the host;

Hrm.. that's not really true.  It's not the worst thing that can
happen, but allowing the guest to permanently lock extra chunks of
memory is a form of harm to the host.

> and with preregistered RAM, there is no
> valid reason for H_PUT_TCE_INDIRECT to fail for a good guest.
>=20
>=20
>=20
> Which approach to pick?
>=20
>=20
> LoPAPR says:
> =3D=3D=3D
> If the TCE parameter represents the logical page address of a page that is
> not valid for the calling partition, return
> H_Parameter.
> =3D=3D=3D
>=20
>=20
>=20
> >> =20
> >>  		kvmppc_tce_put(stt, entry + i, tce);
> >>  	}
> >> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/bo=
ok3s_64_vio_hv.c
> >> index 918af76ab2b6..f8a54b7c788e 100644
> >> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> >> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> >> @@ -237,7 +237,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu =
*vcpu,
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt;
> >>  	long i, ret =3D H_SUCCESS;
> >> -	unsigned long tces, entry, ua =3D 0;
> >> +	unsigned long tces, entry, tce, ua =3D 0;
> >>  	unsigned long *rmap =3D NULL;
> >> =20
> >>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
> >> @@ -279,11 +279,15 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcp=
u *vcpu,
> >>  	}
> >> =20
> >>  	for (i =3D 0; i < npages; ++i) {
> >> -		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
> >> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);
> >> =20
> >>  		ret =3D kvmppc_tce_validate(stt, tce);
> >>  		if (ret !=3D H_SUCCESS)
> >>  			goto unlock_exit;
> >> +	}
> >> +
> >> +	for (i =3D 0; i < npages; ++i) {
> >> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);
> >=20
> > Same problem here.
> >=20
> >> =20
> >>  		kvmppc_tce_put(stt, entry + i, tce);
> >>  	}
> >=20
>=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ag0ALTx5bNxCf4La
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnS5pAAoJEGw4ysog2bOSxCAQAJPlGy+W3XibSPnjg6MRCu8F
DxR9VgrdLolhl21GDgJoGNUn91dnywGnTBkrcgnwtuqRfGWZl5MCcOy3VJtmqvFU
QQ9r/iKkUW0KvTfmyAQUBF34elCgH61kTcSzUXzZAzkf870Iq3IcM9b/hggylQjK
QpYtbsWftCHkNh5JIahJ9r8TR/bDb0xw8rYl3Dn+VPSByTfW0HXSaHeBXxP9yVfQ
feXPaRKOWRiPaTVwsn1jAPvlFE+23rq6MLFgSNvxMlrObsS/EivBhQcZqtxE0egY
dJZSuCQs4KWXB/nKd5XenwRZlzM5pyOf29an6DsuSAMzzsTFbRiyi6MpyfuUw0AW
Z5E4lqEriJJ30Uma6orppw0FQziWma2zcWIZ9t1+xQeYPsMCBvWqKflf+4OFH/A7
OwqrB2tOp9xRhzngJu7G7SLkl+iljGQdb0gjioaltRhTBkhi1Qb7PLRurcqCE7qW
BwOobyIa7bXjlGy2dUTUvR7714+pv7PDos+SC2VJzck7x2reobhvYfJUsdoa3awP
gzFC6FZCR4Dd7s8lj/+3zmrvWoTkqGelwG1znbCXt/TXURRtSeLSrZtrOAgv9uT8
xiaqILnXmNszQ9mS7eeopf1yqWiPl2wCSM52UXzHXLCBGaoNH4fgB/Bh4mFIHfsy
40pAqdw0vxOwHlBZ2r5X
=564A
-----END PGP SIGNATURE-----

--Ag0ALTx5bNxCf4La--
