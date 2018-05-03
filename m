Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c0Xl5nSkzF2TR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 13:11:19 +1000 (AEST)
Date: Thu, 3 May 2018 13:07:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, paulus@samba.org, clg@kaod.org
Subject: Re: [PATCH v2 RFC 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access
 full VCPU ID space
Message-ID: <20180503030706.GL13229@umbus.fritz.box>
References: <aafa1e1ec2e331b0842855c2e5e46a0c2d011acc.1525150933.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
In-Reply-To: <aafa1e1ec2e331b0842855c2e5e46a0c2d011acc.1525150933.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2018 at 03:04:41PM +1000, Sam Bobroff wrote:
> From: Sam Bobroff <sam.bobroff@au1.ibm.com>
>=20
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

That's understandable.  My worry about it is substantially mitigated
by the fact that it's not visible to userspace or the guest, so we can
fix it without corresponding changes being needed there.

> I've posted it as an RFC because I have not tested it with guest native-X=
IVE,
> and I suspect that it will take some work to support it.

Yeah.. guest-native XIVE is still rather a ways off.

> =3D=3D=3D=3D=3D=3D v1 -> v2: =3D=3D=3D=3D=3D=3D
>=20
> Patch 1/1: KVM: PPC: Book3S HV: pack VCORE IDs to access full VCPU ID spa=
ce
> * Corrected places in kvm/book3s_xive.c where IDs weren't packed.
> * Because kvmppc_pack_vcpu_id() is only called on P9, there is no need to=
 test "emul_smt_mode > 1", so remove it.
> * Re-ordered block_offsets[] to be more ascending.
> * Added more detailed description of the packing algorithm.
>=20
> =3D=3D=3D=3D=3D=3D v1: =3D=3D=3D=3D=3D=3D

Excluding concerns about native XIVE,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> Patch 1/1: KVM: PPC: Book3S HV: pack VCORE IDs to access full VCPU ID spa=
ce
>=20
>  arch/powerpc/include/asm/kvm_book3s.h | 44 +++++++++++++++++++++++++++++=
++++++
>  arch/powerpc/kvm/book3s_hv.c          | 14 +++++++----
>  arch/powerpc/kvm/book3s_xive.c        | 19 +++++++++------
>  3 files changed, 66 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include=
/asm/kvm_book3s.h
> index 376ae803b69c..a8d9d625e873 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -368,4 +368,48 @@ extern int kvmppc_h_logical_ci_store(struct kvm_vcpu=
 *vcpu);
>  #define SPLIT_HACK_MASK			0xff000000
>  #define SPLIT_HACK_OFFS			0xfb000000
> =20
> +/* Pack a VCPU ID from the [0..KVM_MAX_VCPU_ID) space down to the
> + * [0..KVM_MAX_VCPUS) space, while using knowledge of the guest's core s=
tride
> + * (but not it's actual threading mode, which is not available) to avoid
> + * collisions.
> + *
> + * The implementation leaves VCPU IDs from the range [0..KVM_MAX_VCPUS) =
(block
> + * 0) unchanged: if the guest is filling each VCORE completely then it w=
ill be
> + * using consecutive IDs and it will fill the space without any packing.
> + *
> + * For higher VCPU IDs, the packed ID is based on the VCPU ID modulo
> + * KVM_MAX_VCPUS (effectively masking off the top bits) and then an offs=
et is
> + * added to avoid collisions.
> + *
> + * VCPU IDs in the range [KVM_MAX_VCPUS..(KVM_MAX_VCPUS*2)) (block 1) ar=
e only
> + * possible if the guest is leaving at least 1/2 of each VCORE empty, so=
 IDs
> + * can be safely packed into the second half of each VCORE by adding an =
offset
> + * of (stride / 2).
> + *
> + * Similarly, if VCPU IDs in the range [(KVM_MAX_VCPUS*2)..(KVM_MAX_VCPU=
S*4))
> + * (blocks 2 and 3) are seen, the guest must be leaving at least 3/4 of =
each
> + * VCORE empty so packed IDs can be offset by (stride / 4) and (stride *=
 3 / 4).
> + *
> + * Finally, VCPU IDs from blocks 5..7 will only be seen if the guest is =
using a
> + * stride of 8 and 1 thread per core so the remaining offsets of 1, 3, 5=
 and 7
> + * must be free to use.
> + *
> + * (The offsets for each block are stored in block_offsets[], indexed by=
 the
> + * block number if the stride is 8. For cases where the guest's stride i=
s less
> + * than 8, we can re-use the block_offsets array by multiplying the block
> + * number by (MAX_SMT_THREADS / stride) to reach the correct entry.)
> + */
> +static inline u32 kvmppc_pack_vcpu_id(struct kvm *kvm, u32 id)
> +{
> +	const int block_offsets[MAX_SMT_THREADS] =3D {0, 4, 2, 6, 1, 3, 5, 7};
> +	int stride =3D kvm->arch.emul_smt_mode;
> +	int block =3D (id / KVM_MAX_VCPUS) * (MAX_SMT_THREADS / stride);
> +	u32 packed_id;
> +
> +	BUG_ON(block >=3D MAX_SMT_THREADS);
> +	packed_id =3D (id % KVM_MAX_VCPUS) + block_offsets[block];
> +	BUG_ON(packed_id >=3D KVM_MAX_VCPUS);
> +	return packed_id;
> +}
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
> index f9818d7d3381..dbd5887daf4a 100644
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
>  static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
>  			     struct kvmppc_xive_src_block *sb,
>  			     struct kvmppc_xive_irq_state *state)
> @@ -362,7 +367,7 @@ static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
>  	 */
>  	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
>  		xive_native_configure_irq(hw_num,
> -					  xive->vp_base + state->act_server,
> +					  xive_vp(xive, state->act_server),
>  					  MASKED, state->number);
>  		/* set old_p so we can track if an H_EOI was done */
>  		state->old_p =3D true;
> @@ -418,7 +423,7 @@ static void xive_finish_unmask(struct kvmppc_xive *xi=
ve,
>  	 */
>  	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
>  		xive_native_configure_irq(hw_num,
> -					  xive->vp_base + state->act_server,
> +					  xive_vp(xive, state->act_server),
>  					  state->act_priority, state->number);
>  		/* If an EOI is needed, do it here */
>  		if (!state->old_p)
> @@ -495,7 +500,7 @@ static int xive_target_interrupt(struct kvm *kvm,
>  	kvmppc_xive_select_irq(state, &hw_num, NULL);
> =20
>  	return xive_native_configure_irq(hw_num,
> -					 xive->vp_base + server,
> +					 xive_vp(xive, server),
>  					 prio, state->number);
>  }
> =20
> @@ -883,7 +888,7 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned =
long guest_irq,
>  	 * which is fine for a never started interrupt.
>  	 */
>  	xive_native_configure_irq(hw_irq,
> -				  xive->vp_base + state->act_server,
> +				  xive_vp(xive, state->act_server),
>  				  state->act_priority, state->number);
> =20
>  	/*
> @@ -959,7 +964,7 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned =
long guest_irq,
> =20
>  	/* Reconfigure the IPI */
>  	xive_native_configure_irq(state->ipi_number,
> -				  xive->vp_base + state->act_server,
> +				  xive_vp(xive, state->act_server),
>  				  state->act_priority, state->number);
> =20
>  	/*
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

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqfNgACgkQbDjKyiDZ
s5I3iw//fQ33kB/F49mhcMPihyfYaJObRrYphF4tch/fTv5ERvaGahzFQnXwzpt8
LPKXUz77RfOXq8t0e1Ank2eM1QkcqRolZVSqjbDMPmImMyVJl4KF8GfGxm7/9shN
rXxK4UJDUIHnPMkCsxdMhTO4i7JwPBqLwMKhTYyBdkDBthOu4WXtiWB7MHVunBm+
tZEvppE3IzzFRTzIsNG5xt/27fNIp6FjBXnP1HVHWmC//uG4Q/9s9SxykCusfaKw
cpK5xMwZgaF765zdYQstJeiGhuKiCr92ifIJ0s7LfRjsDIEvL9M3AVVpEVxmmQBI
4zYEk2gDLQ41Bl79/JzHskgdMIQjSFlP2T4NmKMntSuN3epdtuRixtkEcOeG6VUE
3sFjwcLBGXx2jZ/fpglL+CZkxaQ/7eezthw5+NUcCGiWFaP/kIm5UqpAv8PGiQmL
tsYKtpQ174glf92vwLs75B62Eg2vdqjPlyfxnYphCDvY7uLFxHGq4Olljbt04xOt
W+G5UJUkj5QZnCHsotKcuAd2ZrHUY9aZahJY/IkbZTtemmMopipgmAWg0HkH7BM9
zxL27QMkkMpr9axtvddLhcfcxaEmCblEjuf6puSpGXlyoBM+9D0JFY5hL30tVECD
udyYyJokCin+JX6ZBKjPei5jyhEp8ZVKVcmzZjj9KCUuIPcPPzQ=
=rM5z
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--
