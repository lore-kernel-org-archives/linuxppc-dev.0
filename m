Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41b3c767TJzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 15:26:15 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6P5NaFS128652
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 01:26:12 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kejtu8mc7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 01:26:12 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 25 Jul 2018 06:26:10 +0100
Date: Wed, 25 Jul 2018 15:26:04 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, david@gibson.dropbear.id.au, clg@kaod.org
Subject: Re: [PATCH v3 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access
 full VCPU ID space
References: <1fb3aea5f44f1029866ee10db40abde7e18b24ad.1531967105.git.sbobroff@linux.ibm.com>
 <20180723054337.GA29207@fergus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
In-Reply-To: <20180723054337.GA29207@fergus>
Message-Id: <20180725052603.GA4799@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 03:43:37PM +1000, Paul Mackerras wrote:
> On Thu, Jul 19, 2018 at 12:25:10PM +1000, Sam Bobroff wrote:
> > From: Sam Bobroff <sam.bobroff@au1.ibm.com>
> >=20
> > It is not currently possible to create the full number of possible
> > VCPUs (KVM_MAX_VCPUS) on Power9 with KVM-HV when the guest uses less
> > threads per core than it's core stride (or "VSMT mode"). This is
> > because the VCORE ID and XIVE offsets to grow beyond KVM_MAX_VCPUS
> > even though the VCPU ID is less than KVM_MAX_VCPU_ID.
> >=20
> > To address this, "pack" the VCORE ID and XIVE offsets by using
> > knowledge of the way the VCPU IDs will be used when there are less
> > guest threads per core than the core stride. The primary thread of
> > each core will always be used first. Then, if the guest uses more than
> > one thread per core, these secondary threads will sequentially follow
> > the primary in each core.
> >=20
> > So, the only way an ID above KVM_MAX_VCPUS can be seen, is if the
> > VCPUs are being spaced apart, so at least half of each core is empty
> > and IDs between KVM_MAX_VCPUS and (KVM_MAX_VCPUS * 2) can be mapped
> > into the second half of each core (4..7, in an 8-thread core).
> >=20
> > Similarly, if IDs above KVM_MAX_VCPUS * 2 are seen, at least 3/4 of
> > each core is being left empty, and we can map down into the second and
> > third quarters of each core (2, 3 and 5, 6 in an 8-thread core).
> >=20
> > Lastly, if IDs above KVM_MAX_VCPUS * 4 are seen, only the primary
> > threads are being used and 7/8 of the core is empty, allowing use of
> > the 1, 3, 5 and 7 thread slots.
> >=20
> > (Strides less than 8 are handled similarly.)
> >=20
> > This allows the VCORE ID or offset to be calculated quickly from the
> > VCPU ID or XIVE server numbers, without access to the VCPU structure.
> >=20
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
>=20
> I have some comments relating to the situation where the stride
> (i.e. kvm->arch.emul_smt_mode) is less than 8; see below.
>=20
> [snip]
> > +static inline u32 kvmppc_pack_vcpu_id(struct kvm *kvm, u32 id)
> > +{
> > +	const int block_offsets[MAX_SMT_THREADS] =3D {0, 4, 2, 6, 1, 3, 5, 7};
>=20
> This needs to be {0, 4, 2, 6, 1, 5, 3, 7} (with the 3 and 5 swapped
> from what you have) for the case when stride =3D=3D 4 and block =3D=3D 3.=
  In
> that case we need block_offsets[block] to be 3; if it is 5, then we
> will collide with the case where block =3D=3D 2 for the next virtual core.

Agh! Yes it does.

> > +	int stride =3D kvm->arch.emul_smt_mode;
> > +	int block =3D (id / KVM_MAX_VCPUS) * (MAX_SMT_THREADS / stride);
> > +	u32 packed_id;
> > +
> > +	BUG_ON(block >=3D MAX_SMT_THREADS);
> > +	packed_id =3D (id % KVM_MAX_VCPUS) + block_offsets[block];
> > +	BUG_ON(packed_id >=3D KVM_MAX_VCPUS);
> > +	return packed_id;
> > +}
> > +
> >  #endif /* __ASM_KVM_BOOK3S_H__ */
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index de686b340f4a..363c2fb0d89e 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -1816,7 +1816,7 @@ static int threads_per_vcore(struct kvm *kvm)
> >  	return threads_per_subcore;
> >  }
> > =20
> > -static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int c=
ore)
> > +static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int i=
d)
> >  {
> >  	struct kvmppc_vcore *vcore;
> > =20
> > @@ -1830,7 +1830,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(s=
truct kvm *kvm, int core)
> >  	init_swait_queue_head(&vcore->wq);
> >  	vcore->preempt_tb =3D TB_NIL;
> >  	vcore->lpcr =3D kvm->arch.lpcr;
> > -	vcore->first_vcpuid =3D core * kvm->arch.smt_mode;
> > +	vcore->first_vcpuid =3D id;
> >  	vcore->kvm =3D kvm;
> >  	INIT_LIST_HEAD(&vcore->preempt_list);
> > =20
> > @@ -2048,12 +2048,18 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create=
_hv(struct kvm *kvm,
> >  	mutex_lock(&kvm->lock);
> >  	vcore =3D NULL;
> >  	err =3D -EINVAL;
> > -	core =3D id / kvm->arch.smt_mode;
> > +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> > +		BUG_ON(kvm->arch.smt_mode !=3D 1);
> > +		core =3D kvmppc_pack_vcpu_id(kvm, id);
>=20
> We now have a way for userspace to trigger a BUG_ON, as far as I can
> see.  The only check on id up to this point is that it is less than
> KVM_MAX_VCPU_ID, which means that the BUG_ON(block >=3D MAX_SMT_THREADS)
> can be triggered, if kvm->arch.emul_smt_mode < MAX_SMT_THREADS, by
> giving an id that is greater than or equal to KVM_MAX_VCPUS *
> kvm->arch.emul_smt+mode.
>=20
> > +	} else {
> > +		core =3D id / kvm->arch.smt_mode;
> > +	}
> >  	if (core < KVM_MAX_VCORES) {
> >  		vcore =3D kvm->arch.vcores[core];
> > +		BUG_ON(cpu_has_feature(CPU_FTR_ARCH_300) && vcore);
>=20
> Doesn't this just mean that userspace has chosen an id big enough to
> cause a collision in the output space of kvmppc_pack_vcpu_id()?  How
> is this not user-triggerable?
>=20
> Paul.

Yep, good point. Particularly when dealing with a malicious userspace
that won't follow QEMU's allocation pattern.

I'll re-work it and re-post. I'll discuss the changes in the next
version.

Thanks for the review!

Sam.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAltYCckACgkQMX8w6AQl
/iIEdQf/Zt9grnf6ncLvV6N3mxzd0zjXguHRDwKBtwUxWIzhuCFX0vWe9G+I9FzP
OyhVUZml1jzUTYS88uO4X7SkLy6lyAt2yq+yeQizctilT5XFM6oosz57yEv5nVHc
4XfTsVHqbzB2mHSh846xJNV25B3cyI0DUIoCg4j0ZL7bWxjCx2kN+XWiGsAaBBNP
lcNFU+IVl1SquMB7El4NSRusYvO3FBM2HYx59VHkBurnH9kv6HjTvQ7BV3M5fdGm
BIfFPbs4easRm7KhyyG9S3N1FDXlL1aLwgIAH1PPrCaxXSytxpFKxpZIBVoyHZa+
9NsD5VVWSqihiRQOfdm+0bu4Rig3AQ==
=EeZc
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
