Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c18g3jvXzF2TZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 13:38:59 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w433ZFki084039
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 23:38:57 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hqpjfgcre-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 23:38:56 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Thu, 3 May 2018 04:38:54 +0100
Date: Thu, 3 May 2018 13:38:48 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, kvm-ppc@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, kvm@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access
 full VCPU ID space
References: <70974cfb62a7f09a53ec914d2909639884228244.1523516498.git.sam.bobroff@au1.ibm.com>
 <20180416040942.GB20551@umbus.fritz.box>
 <1e01ea66-6103-94c8-ccb1-ed35b3a3104b@kaod.org>
 <20180424031914.GA25846@tungsten.ozlabs.ibm.com>
 <20180424034825.GN19804@umbus.fritz.box>
 <20180501044206.GA8330@tungsten.ozlabs.ibm.com>
 <20180503031113.GM13229@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
In-Reply-To: <20180503031113.GM13229@umbus.fritz.box>
Message-Id: <20180503033848.GA14954@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 01:11:13PM +1000, David Gibson wrote:
> On Tue, May 01, 2018 at 02:52:21PM +1000, Sam Bobroff wrote:
> > On Tue, Apr 24, 2018 at 01:48:25PM +1000, David Gibson wrote:
> > > On Tue, Apr 24, 2018 at 01:19:15PM +1000, Sam Bobroff wrote:
> > > > On Mon, Apr 23, 2018 at 11:06:35AM +0200, C=E9dric Le Goater wrote:
> > > > > On 04/16/2018 06:09 AM, David Gibson wrote:
> [snip]
> > > > At the moment, kvm->vcores[] and xive->vp_base are both sized by NR=
_CPUS
> > > > (via KVM_MAX_VCPUS and KVM_MAX_VCORES which are both NR_CPUS). This=
 is
> > > > enough space for the maximum number of VCPUs, and some space is was=
ted
> > > > when the guest uses less than this (but KVM doesn't know how many w=
ill
> > > > be created, so we can't do better easily). The problem is that the
> > > > indicies overflow before all of those VCPUs can be created, not that
> > > > more space is needed.
> > > >=20
> > > > We could fix the overflow by expanding these areas to KVM_MAX_VCPU_=
ID
> > > > but that will use 8x the space we use now, and we know that no more=
 than
> > > > KVM_MAX_VCPUS will be used so all this new space is basically waste=
d.
> > > >=20
> > > > So remapping seems better if it will work. (Ben H. was strongly aga=
inst
> > > > wasting more XIVE space if possible.)
> > >=20
> > > Hm, ok.  Are the relevant arrays here per-VM, or global?  Or some of =
both?
> >=20
> > Per-VM. They are the kvm->vcores[] array and the blocks of memory
> > pointed to by xive->vp_base.
>=20
> Hm.  If it were global (where you can't know the size of a specific
> VM) I'd certainly see the concern about not expanding the size of the
> array.
>=20
> As it is, I'm a little perplexed that we care so much about the
> difference between KVM_MAX_VCPUS and KVM_MAX_VCPU_ID, a factor of 8,
> when we apparently don't care about the difference between the vm's
> actual number of cpus and KVM_MAX_VCPUS, a factor of maybe 2048 (for a
> 1vcpu guest and powernv_defconfig).

I agree, and we should do better (more because of the XIVE area than the
vcores array), but that will require a coordinated change to QEMU and
KVM to export the information KVM needs and that's going to be more
complicated. So basically, yes, this is only partially fixing it but
it's easy to do.

As for how we could solve the bigger problem; I've discussed with Paul
the idea of adding the guest's threading mode as a second parameter when
QEMU sets KVM_CAP_SMT to set the VSMT mode but that only helps with
packing; KVM still needs to know the maximum number of (hot pluggable)
CPUs so we'll need some other extension as well.

> > > > In short, remapping provides a way to allow the guest to create it'=
s full set
> > > > of VCPUs without wasting any more space than we do currently, witho=
ut
> > > > having to do something more complicated like tracking used IDs or a=
dding
> > > > additional KVM CAPs.
> > > >=20
> > > > > >> +
> > > > > >>  #endif /* __ASM_KVM_BOOK3S_H__ */
> > > > > >> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/b=
ook3s_hv.c
> > > > > >> index 9cb9448163c4..49165cc90051 100644
> > > > > >> --- a/arch/powerpc/kvm/book3s_hv.c
> > > > > >> +++ b/arch/powerpc/kvm/book3s_hv.c
> > > > > >> @@ -1762,7 +1762,7 @@ static int threads_per_vcore(struct kvm =
*kvm)
> > > > > >>  	return threads_per_subcore;
> > > > > >>  }
> > > > > >> =20
> > > > > >> -static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *k=
vm, int core)
> > > > > >> +static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *k=
vm, int id)
> > > > > >>  {
> > > > > >>  	struct kvmppc_vcore *vcore;
> > > > > >> =20
> > > > > >> @@ -1776,7 +1776,7 @@ static struct kvmppc_vcore *kvmppc_vcore=
_create(struct kvm *kvm, int core)
> > > > > >>  	init_swait_queue_head(&vcore->wq);
> > > > > >>  	vcore->preempt_tb =3D TB_NIL;
> > > > > >>  	vcore->lpcr =3D kvm->arch.lpcr;
> > > > > >> -	vcore->first_vcpuid =3D core * kvm->arch.smt_mode;
> > > > > >> +	vcore->first_vcpuid =3D id;
> > > > > >>  	vcore->kvm =3D kvm;
> > > > > >>  	INIT_LIST_HEAD(&vcore->preempt_list);
> > > > > >> =20
> > > > > >> @@ -1992,12 +1992,18 @@ static struct kvm_vcpu *kvmppc_core_vc=
pu_create_hv(struct kvm *kvm,
> > > > > >>  	mutex_lock(&kvm->lock);
> > > > > >>  	vcore =3D NULL;
> > > > > >>  	err =3D -EINVAL;
> > > > > >> -	core =3D id / kvm->arch.smt_mode;
> > > > > >> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> > > > > >> +		BUG_ON(kvm->arch.smt_mode !=3D 1);
> > > > > >> +		core =3D kvmppc_pack_vcpu_id(kvm, id);
> > > > > >> +	} else {
> > > > > >> +		core =3D id / kvm->arch.smt_mode;
> > > > > >> +	}
> > > > > >>  	if (core < KVM_MAX_VCORES) {
> > > > > >>  		vcore =3D kvm->arch.vcores[core];
> > > > > >> +		BUG_ON(cpu_has_feature(CPU_FTR_ARCH_300) && vcore);
> > > > > >>  		if (!vcore) {
> > > > > >>  			err =3D -ENOMEM;
> > > > > >> -			vcore =3D kvmppc_vcore_create(kvm, core);
> > > > > >> +			vcore =3D kvmppc_vcore_create(kvm, id & ~(kvm->arch.smt_mo=
de - 1));
> > > > > >>  			kvm->arch.vcores[core] =3D vcore;
> > > > > >>  			kvm->arch.online_vcores++;
> > > > > >>  		}
> > > > > >> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm=
/book3s_xive.c
> > > > > >> index f9818d7d3381..681dfe12a5f3 100644
> > > > > >> --- a/arch/powerpc/kvm/book3s_xive.c
> > > > > >> +++ b/arch/powerpc/kvm/book3s_xive.c
> > > > > >> @@ -317,6 +317,11 @@ static int xive_select_target(struct kvm =
*kvm, u32 *server, u8 prio)
> > > > > >>  	return -EBUSY;
> > > > > >>  }
> > > > > >> =20
> > > > > >> +static u32 xive_vp(struct kvmppc_xive *xive, u32 server)
> > > > > >> +{
> > > > > >> +	return xive->vp_base + kvmppc_pack_vcpu_id(xive->kvm, server=
);
> > > > > >> +}
> > > > > >> +
> > > > > >=20
> > > > > > I'm finding the XIVE indexing really baffling.  There are a bun=
ch of
> > > > > > other places where the code uses (xive->vp_base + NUMBER) direc=
tly.
> > > >=20
> > > > Ugh, yes. It looks like I botched part of my final cleanup and all =
the
> > > > cases you saw in kvm/book3s_xive.c should have been replaced with a=
 call to
> > > > xive_vp(). I'll fix it and sorry for the confusion.
> > >=20
> > > Ok.
> > >=20
> > > > > This links the QEMU vCPU server NUMBER to a XIVE virtual processo=
r number=20
> > > > > in OPAL. So we need to check that all used NUMBERs are, first, co=
nsistent=20
> > > > > and then, in the correct range.
> > > >=20
> > > > Right. My approach was to allow XIVE to keep using server numbers t=
hat
> > > > are equal to VCPU IDs, and just pack down the ID before indexing in=
to
> > > > the vp_base area.
> > > >=20
> > > > > > If those are host side references, I guess they don't need upda=
tes for
> > > > > > this.
> > > >=20
> > > > These are all guest side references.
> > > >=20
> > > > > > But if that's the case, then how does indexing into the same ar=
ray
> > > > > > with both host and guest server numbers make sense?
> > > >=20
> > > > Right, it doesn't make sense to mix host and guest server numbers w=
hen
> > > > we're remapping only the guest ones, but in this case (without nati=
ve
> > > > guest XIVE support) it's just guest ones.
> > >=20
> > > Right.  Will this remapping be broken by guest-visible XIVE?  That is
> > > for the guest visible XIVE are we going to need to expose un-remapped
> > > XIVE server IDs to the guest?
> >=20
> > I'm not sure, I'll start looking at that next.
> >=20
> > > > > yes. VPs are allocated with KVM_MAX_VCPUS :
> > > > >=20
> > > > > 	xive->vp_base =3D xive_native_alloc_vp_block(KVM_MAX_VCPUS);
> > > > >=20
> > > > > but
> > > > >=20
> > > > > 	#define KVM_MAX_VCPU_ID  (threads_per_subcore * KVM_MAX_VCORES)
> > > > >=20
> > > > > WE would need to change the allocation of the VPs I guess.
> > > >=20
> > > > Yes, this is one of the structures that overflow if we don't pack t=
he IDs.
> > > >=20
> > > > > >>  static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
> > > > > >>  			     struct kvmppc_xive_src_block *sb,
> > > > > >>  			     struct kvmppc_xive_irq_state *state)
> > > > > >> @@ -1084,7 +1089,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_=
device *dev,
> > > > > >>  		pr_devel("Duplicate !\n");
> > > > > >>  		return -EEXIST;
> > > > > >>  	}
> > > > > >> -	if (cpu >=3D KVM_MAX_VCPUS) {
> > > > > >> +	if (cpu >=3D KVM_MAX_VCPU_ID) {>>
> > > > > >>  		pr_devel("Out of bounds !\n");
> > > > > >>  		return -EINVAL;
> > > > > >>  	}
> > > > > >> @@ -1098,7 +1103,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_=
device *dev,
> > > > > >>  	xc->xive =3D xive;
> > > > > >>  	xc->vcpu =3D vcpu;
> > > > > >>  	xc->server_num =3D cpu;
> > > > > >> -	xc->vp_id =3D xive->vp_base + cpu;
> > > > > >> +	xc->vp_id =3D xive_vp(xive, cpu);
> > > > > >>  	xc->mfrr =3D 0xff;
> > > > > >>  	xc->valid =3D true;
> > > > > >> =20
> > > > > >=20
> > > > >=20
> > >=20
> > >=20
> > >=20
> >=20
> >=20
>=20
>=20
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlrqhEAACgkQMX8w6AQl
/iJSSwgAnPtI1fsA7xGwIJ+zMbDIWZkDopLJWmmdOAWt6rvNPMPZVR52BLawfqyB
RnhgO+20KVUfL3VctLsEHG7IWZB0AZsdJlwIVM86ziAdPYh+duwS0c1SCYNZmEN+
cGZqHi/kRUv1C1XLl4p/SZ0WZKkmJ21BZqDjkPOGJ9dThZSnvsA5OzeL0CCpazsb
HsnZ9fT3/sRcr81adgwuC9ndQ6jf1swBJOSnnnHLbLpF+Tf9Zw9dnGG5ZS+D3akJ
au5uBnfwq/xx9PLXff8j5o7Gs8JYR1MYx+FtqeFtY4/xGhyjd7SJtula1XH0fl39
EEFZYA4wKnFiKGWEf25lNjAcTiu8dA==
=ZV1T
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
