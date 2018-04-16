Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Pb4c3mB0zF1qT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 14:29:20 +1000 (AEST)
Date: Mon, 16 Apr 2018 14:09:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, paulus@samba.org, clg@kaod.org
Subject: Re: [PATCH RFC 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access
 full VCPU ID space
Message-ID: <20180416040942.GB20551@umbus.fritz.box>
References: <70974cfb62a7f09a53ec914d2909639884228244.1523516498.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
In-Reply-To: <70974cfb62a7f09a53ec914d2909639884228244.1523516498.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 05:02:06PM +1000, Sam Bobroff wrote:
> It is not currently possible to create the full number of possible
> VCPUs (KVM_MAX_VCPUS) on Power9 with KVM-HV when the guest uses less
> threads per core than it's core stride (or "VSMT mode"). This is
> because the VCORE ID and XIVE offsets to grow beyond KVM_MAX_VCPUS
> even though the VCPU ID is less than KVM_MAX_VCPU_ID.
>=20
> To address this, "pack" the VCORE ID and XIVE offsets by using
> knowledge of the way the VCPU IDs will be used when there are less
> guest threads per core than the core stride. The primary thread of
> each core will always be used first. Then, if the guest uses more than
> one thread per core, these secondary threads will sequentially follow
> the primary in each core.
>=20
> So, the only way an ID above KVM_MAX_VCPUS can be seen, is if the
> VCPUs are being spaced apart, so at least half of each core is empty
> and IDs between KVM_MAX_VCPUS and (KVM_MAX_VCPUS * 2) can be mapped
> into the second half of each core (4..7, in an 8-thread core).
>=20
> Similarly, if IDs above KVM_MAX_VCPUS * 2 are seen, at least 3/4 of
> each core is being left empty, and we can map down into the second and
> third quarters of each core (2, 3 and 5, 6 in an 8-thread core).
>=20
> Lastly, if IDs above KVM_MAX_VCPUS * 4 are seen, only the primary
> threads are being used and 7/8 of the core is empty, allowing use of
> the 1, 3, 5 and 7 thread slots.
>=20
> (Strides less than 8 are handled similarly.)
>=20
> This allows the VCORE ID or offset to be calculated quickly from the
> VCPU ID or XIVE server numbers, without access to the VCPU structure.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
> Hello everyone,
>=20
> I've tested this on P8 and P9, in lots of combinations of host and guest
> threading modes and it has been fine but it does feel like a "tricky"
> approach, so I still feel somewhat wary about it.
>=20
> I've posted it as an RFC because I have not tested it with guest native-X=
IVE,
> and I suspect that it will take some work to support it.
>=20
>  arch/powerpc/include/asm/kvm_book3s.h | 19 +++++++++++++++++++
>  arch/powerpc/kvm/book3s_hv.c          | 14 ++++++++++----
>  arch/powerpc/kvm/book3s_xive.c        |  9 +++++++--
>  3 files changed, 36 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include=
/asm/kvm_book3s.h
> index 376ae803b69c..1295056d564a 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -368,4 +368,23 @@ extern int kvmppc_h_logical_ci_store(struct kvm_vcpu=
 *vcpu);
>  #define SPLIT_HACK_MASK			0xff000000
>  #define SPLIT_HACK_OFFS			0xfb000000
> =20
> +/* Pack a VCPU ID from the [0..KVM_MAX_VCPU_ID) space down to the
> + * [0..KVM_MAX_VCPUS) space, while using knowledge of the guest's core s=
tride
> + * (but not it's actual threading mode, which is not available) to avoid
> + * collisions.
> + */
> +static inline u32 kvmppc_pack_vcpu_id(struct kvm *kvm, u32 id)
> +{
> +	const int block_offsets[MAX_SMT_THREADS] =3D {0, 4, 2, 6, 1, 5, 3, 7};

I'd suggest 1,3,5,7 at the end rather than 1,5,3,7 - accomplishes
roughly the same thing, but I think makes the pattern more obvious.

> +	int stride =3D kvm->arch.emul_smt_mode > 1 ?
> +		     kvm->arch.emul_smt_mode : kvm->arch.smt_mode;

AFAICT from BUG_ON()s etc. at the callsites, kvm->arch.smt_mode must
always be 1 when this is called, so the conditional here doesn't seem
useful.

> +	int block =3D (id / KVM_MAX_VCPUS) * (MAX_SMT_THREADS / stride);
> +	u32 packed_id;
> +
> +	BUG_ON(block >=3D MAX_SMT_THREADS);
> +	packed_id =3D (id % KVM_MAX_VCPUS) + block_offsets[block];
> +	BUG_ON(packed_id >=3D KVM_MAX_VCPUS);
> +	return packed_id;
> +}

It took me a while to wrap my head around the packing function, but I
think I got there in the end.  It's pretty clever.

One thing bothers me, though.  This certainly packs things under
KVM_MAX_VCPUS, but not necessarily under the actual number of vcpus.
e.g. KVM_MAC_VCPUS=3D=3D16, 8 vcpus total, stride 8, 2 vthreads/vcore (as
qemu sees it), gives both unpacked IDs (0, 1, 8, 9, 16, 17, 24, 25)
and packed ids of (0, 1, 8, 9, 4, 5, 12, 13) - leaving 2, 3, 6, 7
etc. unused.

So again, the question is what exactly are these remapped IDs useful
for.  If we're indexing into a bare array of structures of size
KVM_MAX_VCPUS then we're *already* wasting a bunch of space by having
more entries than vcpus.  If we're indexing into something sparser,
then why is the remapping worthwhile?



> +
>  #endif /* __ASM_KVM_BOOK3S_H__ */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 9cb9448163c4..49165cc90051 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1762,7 +1762,7 @@ static int threads_per_vcore(struct kvm *kvm)
>  	return threads_per_subcore;
>  }
> =20
> -static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int cor=
e)
> +static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int id)
>  {
>  	struct kvmppc_vcore *vcore;
> =20
> @@ -1776,7 +1776,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(str=
uct kvm *kvm, int core)
>  	init_swait_queue_head(&vcore->wq);
>  	vcore->preempt_tb =3D TB_NIL;
>  	vcore->lpcr =3D kvm->arch.lpcr;
> -	vcore->first_vcpuid =3D core * kvm->arch.smt_mode;
> +	vcore->first_vcpuid =3D id;
>  	vcore->kvm =3D kvm;
>  	INIT_LIST_HEAD(&vcore->preempt_list);
> =20
> @@ -1992,12 +1992,18 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_h=
v(struct kvm *kvm,
>  	mutex_lock(&kvm->lock);
>  	vcore =3D NULL;
>  	err =3D -EINVAL;
> -	core =3D id / kvm->arch.smt_mode;
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		BUG_ON(kvm->arch.smt_mode !=3D 1);
> +		core =3D kvmppc_pack_vcpu_id(kvm, id);
> +	} else {
> +		core =3D id / kvm->arch.smt_mode;
> +	}
>  	if (core < KVM_MAX_VCORES) {
>  		vcore =3D kvm->arch.vcores[core];
> +		BUG_ON(cpu_has_feature(CPU_FTR_ARCH_300) && vcore);
>  		if (!vcore) {
>  			err =3D -ENOMEM;
> -			vcore =3D kvmppc_vcore_create(kvm, core);
> +			vcore =3D kvmppc_vcore_create(kvm, id & ~(kvm->arch.smt_mode - 1));
>  			kvm->arch.vcores[core] =3D vcore;
>  			kvm->arch.online_vcores++;
>  		}
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index f9818d7d3381..681dfe12a5f3 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -317,6 +317,11 @@ static int xive_select_target(struct kvm *kvm, u32 *=
server, u8 prio)
>  	return -EBUSY;
>  }
> =20
> +static u32 xive_vp(struct kvmppc_xive *xive, u32 server)
> +{
> +	return xive->vp_base + kvmppc_pack_vcpu_id(xive->kvm, server);
> +}
> +

I'm finding the XIVE indexing really baffling.  There are a bunch of
other places where the code uses (xive->vp_base + NUMBER) directly.
If those are host side references, I guess they don't need updates for
this.

But if that's the case, then how does indexing into the same array
with both host and guest server numbers make sense?

>  static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
>  			     struct kvmppc_xive_src_block *sb,
>  			     struct kvmppc_xive_irq_state *state)
> @@ -1084,7 +1089,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  		pr_devel("Duplicate !\n");
>  		return -EEXIST;
>  	}
> -	if (cpu >=3D KVM_MAX_VCPUS) {
> +	if (cpu >=3D KVM_MAX_VCPU_ID) {
>  		pr_devel("Out of bounds !\n");
>  		return -EINVAL;
>  	}
> @@ -1098,7 +1103,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  	xc->xive =3D xive;
>  	xc->vcpu =3D vcpu;
>  	xc->server_num =3D cpu;
> -	xc->vp_id =3D xive->vp_base + cpu;
> +	xc->vp_id =3D xive_vp(xive, cpu);
>  	xc->mfrr =3D 0xff;
>  	xc->valid =3D true;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrUIgQACgkQbDjKyiDZ
s5IJWhAAxgEIeJGew4ZOG+dJez8giDohJDtC7fdEYkwMVosLKyBHI8d/tF3uFHR/
dUtQhJADHZrMomuQ2rhu1m9T9agUzh2GsAQ1GgWCDG1MM6JZR/PQSjbrF1p92ML3
iuFL0lbahElZmM/BkIKPmP2u+1ZxStC69SGv909Ke5Ulvss09Hp9LCXNE2Mj6GDI
aQLeqZbAW41fsZX52YNwBPMlRJfUbgFFjMdYoAP9pOeNS8EkmyckSKXiumYmBNGU
ca0ZfBUod9Def4s3RYUX3A2Oj1n9/O/Gw360o+1TcFS35o+MnqfezqUwiSsPhwO/
m3+QAern1ATjhtbnh4PUnZbN5jmUk8B8/ITm/26DVXUAnH/2Kv/nZvBK22KcHeK9
vn/pyTrfuldjJKU37czGwFSh4/D9KldtkuVwfuyFln6aEtqtnuUG8ABwY+kPhQwN
KKJxHUe0nmsozabg+XvKf/VxTtwXVaqBUedU6iTRm24EuQ/bGa9nlny073R6RkFe
oG0nxxpVZLuj7Z0GDVcaWe4bmrwFOGxqVpCAb5yd9HuTZo34dN7/nRJ7Wd9PAWS3
QBAwTBoALgPfimSoMC9MJs0iAcRTfjoPGwuug3FoL5cO1DTSkcDQQVzQOsShebSh
hoaHUf7i+7jd7YImuPnFqIe9akwizgory5HNOfx09jPr9ZFe35o=
=zZXF
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
