Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c0Xl6HbpzF2TT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 13:11:19 +1000 (AEST)
Date: Thu, 3 May 2018 13:11:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: kvm-ppc@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, kvm@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access
 full VCPU ID space
Message-ID: <20180503031113.GM13229@umbus.fritz.box>
References: <70974cfb62a7f09a53ec914d2909639884228244.1523516498.git.sam.bobroff@au1.ibm.com>
 <20180416040942.GB20551@umbus.fritz.box>
 <1e01ea66-6103-94c8-ccb1-ed35b3a3104b@kaod.org>
 <20180424031914.GA25846@tungsten.ozlabs.ibm.com>
 <20180424034825.GN19804@umbus.fritz.box>
 <20180501044206.GA8330@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
In-Reply-To: <20180501044206.GA8330@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2018 at 02:52:21PM +1000, Sam Bobroff wrote:
> On Tue, Apr 24, 2018 at 01:48:25PM +1000, David Gibson wrote:
> > On Tue, Apr 24, 2018 at 01:19:15PM +1000, Sam Bobroff wrote:
> > > On Mon, Apr 23, 2018 at 11:06:35AM +0200, C=E9dric Le Goater wrote:
> > > > On 04/16/2018 06:09 AM, David Gibson wrote:
[snip]
> > > At the moment, kvm->vcores[] and xive->vp_base are both sized by NR_C=
PUS
> > > (via KVM_MAX_VCPUS and KVM_MAX_VCORES which are both NR_CPUS). This is
> > > enough space for the maximum number of VCPUs, and some space is wasted
> > > when the guest uses less than this (but KVM doesn't know how many will
> > > be created, so we can't do better easily). The problem is that the
> > > indicies overflow before all of those VCPUs can be created, not that
> > > more space is needed.
> > >=20
> > > We could fix the overflow by expanding these areas to KVM_MAX_VCPU_ID
> > > but that will use 8x the space we use now, and we know that no more t=
han
> > > KVM_MAX_VCPUS will be used so all this new space is basically wasted.
> > >=20
> > > So remapping seems better if it will work. (Ben H. was strongly again=
st
> > > wasting more XIVE space if possible.)
> >=20
> > Hm, ok.  Are the relevant arrays here per-VM, or global?  Or some of bo=
th?
>=20
> Per-VM. They are the kvm->vcores[] array and the blocks of memory
> pointed to by xive->vp_base.

Hm.  If it were global (where you can't know the size of a specific
VM) I'd certainly see the concern about not expanding the size of the
array.

As it is, I'm a little perplexed that we care so much about the
difference between KVM_MAX_VCPUS and KVM_MAX_VCPU_ID, a factor of 8,
when we apparently don't care about the difference between the vm's
actual number of cpus and KVM_MAX_VCPUS, a factor of maybe 2048 (for a
1vcpu guest and powernv_defconfig).

>=20
> > > In short, remapping provides a way to allow the guest to create it's =
full set
> > > of VCPUs without wasting any more space than we do currently, without
> > > having to do something more complicated like tracking used IDs or add=
ing
> > > additional KVM CAPs.
> > >=20
> > > > >> +
> > > > >>  #endif /* __ASM_KVM_BOOK3S_H__ */
> > > > >> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/boo=
k3s_hv.c
> > > > >> index 9cb9448163c4..49165cc90051 100644
> > > > >> --- a/arch/powerpc/kvm/book3s_hv.c
> > > > >> +++ b/arch/powerpc/kvm/book3s_hv.c
> > > > >> @@ -1762,7 +1762,7 @@ static int threads_per_vcore(struct kvm *k=
vm)
> > > > >>  	return threads_per_subcore;
> > > > >>  }
> > > > >> =20
> > > > >> -static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm=
, int core)
> > > > >> +static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm=
, int id)
> > > > >>  {
> > > > >>  	struct kvmppc_vcore *vcore;
> > > > >> =20
> > > > >> @@ -1776,7 +1776,7 @@ static struct kvmppc_vcore *kvmppc_vcore_c=
reate(struct kvm *kvm, int core)
> > > > >>  	init_swait_queue_head(&vcore->wq);
> > > > >>  	vcore->preempt_tb =3D TB_NIL;
> > > > >>  	vcore->lpcr =3D kvm->arch.lpcr;
> > > > >> -	vcore->first_vcpuid =3D core * kvm->arch.smt_mode;
> > > > >> +	vcore->first_vcpuid =3D id;
> > > > >>  	vcore->kvm =3D kvm;
> > > > >>  	INIT_LIST_HEAD(&vcore->preempt_list);
> > > > >> =20
> > > > >> @@ -1992,12 +1992,18 @@ static struct kvm_vcpu *kvmppc_core_vcpu=
_create_hv(struct kvm *kvm,
> > > > >>  	mutex_lock(&kvm->lock);
> > > > >>  	vcore =3D NULL;
> > > > >>  	err =3D -EINVAL;
> > > > >> -	core =3D id / kvm->arch.smt_mode;
> > > > >> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> > > > >> +		BUG_ON(kvm->arch.smt_mode !=3D 1);
> > > > >> +		core =3D kvmppc_pack_vcpu_id(kvm, id);
> > > > >> +	} else {
> > > > >> +		core =3D id / kvm->arch.smt_mode;
> > > > >> +	}
> > > > >>  	if (core < KVM_MAX_VCORES) {
> > > > >>  		vcore =3D kvm->arch.vcores[core];
> > > > >> +		BUG_ON(cpu_has_feature(CPU_FTR_ARCH_300) && vcore);
> > > > >>  		if (!vcore) {
> > > > >>  			err =3D -ENOMEM;
> > > > >> -			vcore =3D kvmppc_vcore_create(kvm, core);
> > > > >> +			vcore =3D kvmppc_vcore_create(kvm, id & ~(kvm->arch.smt_mode=
 - 1));
> > > > >>  			kvm->arch.vcores[core] =3D vcore;
> > > > >>  			kvm->arch.online_vcores++;
> > > > >>  		}
> > > > >> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/b=
ook3s_xive.c
> > > > >> index f9818d7d3381..681dfe12a5f3 100644
> > > > >> --- a/arch/powerpc/kvm/book3s_xive.c
> > > > >> +++ b/arch/powerpc/kvm/book3s_xive.c
> > > > >> @@ -317,6 +317,11 @@ static int xive_select_target(struct kvm *k=
vm, u32 *server, u8 prio)
> > > > >>  	return -EBUSY;
> > > > >>  }
> > > > >> =20
> > > > >> +static u32 xive_vp(struct kvmppc_xive *xive, u32 server)
> > > > >> +{
> > > > >> +	return xive->vp_base + kvmppc_pack_vcpu_id(xive->kvm, server);
> > > > >> +}
> > > > >> +
> > > > >=20
> > > > > I'm finding the XIVE indexing really baffling.  There are a bunch=
 of
> > > > > other places where the code uses (xive->vp_base + NUMBER) directl=
y.
> > >=20
> > > Ugh, yes. It looks like I botched part of my final cleanup and all the
> > > cases you saw in kvm/book3s_xive.c should have been replaced with a c=
all to
> > > xive_vp(). I'll fix it and sorry for the confusion.
> >=20
> > Ok.
> >=20
> > > > This links the QEMU vCPU server NUMBER to a XIVE virtual processor =
number=20
> > > > in OPAL. So we need to check that all used NUMBERs are, first, cons=
istent=20
> > > > and then, in the correct range.
> > >=20
> > > Right. My approach was to allow XIVE to keep using server numbers that
> > > are equal to VCPU IDs, and just pack down the ID before indexing into
> > > the vp_base area.
> > >=20
> > > > > If those are host side references, I guess they don't need update=
s for
> > > > > this.
> > >=20
> > > These are all guest side references.
> > >=20
> > > > > But if that's the case, then how does indexing into the same array
> > > > > with both host and guest server numbers make sense?
> > >=20
> > > Right, it doesn't make sense to mix host and guest server numbers when
> > > we're remapping only the guest ones, but in this case (without native
> > > guest XIVE support) it's just guest ones.
> >=20
> > Right.  Will this remapping be broken by guest-visible XIVE?  That is
> > for the guest visible XIVE are we going to need to expose un-remapped
> > XIVE server IDs to the guest?
>=20
> I'm not sure, I'll start looking at that next.
>=20
> > > > yes. VPs are allocated with KVM_MAX_VCPUS :
> > > >=20
> > > > 	xive->vp_base =3D xive_native_alloc_vp_block(KVM_MAX_VCPUS);
> > > >=20
> > > > but
> > > >=20
> > > > 	#define KVM_MAX_VCPU_ID  (threads_per_subcore * KVM_MAX_VCORES)
> > > >=20
> > > > WE would need to change the allocation of the VPs I guess.
> > >=20
> > > Yes, this is one of the structures that overflow if we don't pack the=
 IDs.
> > >=20
> > > > >>  static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
> > > > >>  			     struct kvmppc_xive_src_block *sb,
> > > > >>  			     struct kvmppc_xive_irq_state *state)
> > > > >> @@ -1084,7 +1089,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_de=
vice *dev,
> > > > >>  		pr_devel("Duplicate !\n");
> > > > >>  		return -EEXIST;
> > > > >>  	}
> > > > >> -	if (cpu >=3D KVM_MAX_VCPUS) {
> > > > >> +	if (cpu >=3D KVM_MAX_VCPU_ID) {>>
> > > > >>  		pr_devel("Out of bounds !\n");
> > > > >>  		return -EINVAL;
> > > > >>  	}
> > > > >> @@ -1098,7 +1103,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_de=
vice *dev,
> > > > >>  	xc->xive =3D xive;
> > > > >>  	xc->vcpu =3D vcpu;
> > > > >>  	xc->server_num =3D cpu;
> > > > >> -	xc->vp_id =3D xive->vp_base + cpu;
> > > > >> +	xc->vp_id =3D xive_vp(xive, cpu);
> > > > >>  	xc->mfrr =3D 0xff;
> > > > >>  	xc->valid =3D true;
> > > > >> =20
> > > > >=20
> > > >=20
> >=20
> >=20
> >=20
>=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqfdEACgkQbDjKyiDZ
s5IvrBAA2vbUmHcQkzFZ294Dl2Rhl1H4khtEf3LgwOaLKRxxu5WN9ueqiT+Jss3H
MrjsRz779w5A32TS6Vqm6zobIc+cGQpAceKSn2zpTFPu0Pa1XGAOnH/QmRLLDU9U
Hbj9jMTUzUBBh+QIjjcFMqfzXfZFlD1MZaIGJ7uL0jbFz7M24CVP/JLhaFsssVap
opuIicEGQZmfrJ2Rrrsi+niEO4VcZGp3v8zYud3hdHVhemzdPJBR8H/5PftJj4zK
oZWITi4+kXSlA0AKeVN4WTKGZvgL46DVEbTZ9/CbNtv2HZpq+Cq9JpfBTRk/myFu
4tqCFojIw0jUOJOvYjrtnvC1R7kN69N/NpEjIDS0zi/y6RaBHpwauwNq8vP+knFF
D2Uw+Y2SQgApsgH4GAed0iEQLwNmS7cGve/t+wk9jw9MNE831+es0hjnr8a6rSmg
yJQHtkKY1IAptjRrVAoSdzv7hDffmKEBa59IjTOuG2BYPreYVGiVqHmlITDk2+U1
nJEZz0T6DaZ/wx9tQ/PicX/yWOTWt4GOIhkXs+MVJE/GVX5UfAi4jhNZhAmpFKeM
2EwaV47Hs6y1M7sISAPMUCuR4jCXU8GttJdGgmXP/i/9iZVReo3rlccBMkGHx085
LzzF3pw+1nGEQYFhwgJC/t2Vk92NJUUdilDtEzq28UBP0pksE/0=
=yDNT
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--
