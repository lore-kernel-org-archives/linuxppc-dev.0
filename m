Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WMxs38zRzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 15:28:49 +1000 (AEST)
Date: Thu, 19 Jul 2018 15:28:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, paulus@samba.org, clg@kaod.org
Subject: Re: [PATCH v3 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access
 full VCPU ID space
Message-ID: <20180719052846.GA18205@umbus.fritz.box>
References: <1fb3aea5f44f1029866ee10db40abde7e18b24ad.1531967105.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
In-Reply-To: <1fb3aea5f44f1029866ee10db40abde7e18b24ad.1531967105.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2018 at 12:25:10PM +1000, Sam Bobroff wrote:
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Hello everyone,
>=20
> I've completed a trial merge with the guest native-XIVE code and found no
> problems; it's no more difficult than the host side and only requires a f=
ew
> calls to xive_vp().
>=20
> On that basis, here is v3 (unchanged from v2) as non-RFC and it seems to =
be
> ready to go.
>=20
> Patch set v3:
> Patch 1/1: KVM: PPC: Book3S HV: pack VCORE IDs to access full VCPU ID spa=
ce
>=20
> Patch set v2:
> Patch 1/1: KVM: PPC: Book3S HV: pack VCORE IDs to access full VCPU ID spa=
ce
> * Corrected places in kvm/book3s_xive.c where IDs weren't packed.
> * Because kvmppc_pack_vcpu_id() is only called on P9, there is no need to=
 test "emul_smt_mode > 1", so remove it.
> * Re-ordered block_offsets[] to be more ascending.
> * Added more detailed description of the packing algorithm.
>=20
> Patch set v1:
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
> index 1f345a0b6ba2..ba4b6e00fca7 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -390,4 +390,48 @@ extern int kvmppc_h_logical_ci_store(struct kvm_vcpu=
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
> index de686b340f4a..363c2fb0d89e 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1816,7 +1816,7 @@ static int threads_per_vcore(struct kvm *kvm)
>  	return threads_per_subcore;
>  }
> =20
> -static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int cor=
e)
> +static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int id)
>  {
>  	struct kvmppc_vcore *vcore;
> =20
> @@ -1830,7 +1830,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(str=
uct kvm *kvm, int core)
>  	init_swait_queue_head(&vcore->wq);
>  	vcore->preempt_tb =3D TB_NIL;
>  	vcore->lpcr =3D kvm->arch.lpcr;
> -	vcore->first_vcpuid =3D core * kvm->arch.smt_mode;
> +	vcore->first_vcpuid =3D id;
>  	vcore->kvm =3D kvm;
>  	INIT_LIST_HEAD(&vcore->preempt_list);
> =20
> @@ -2048,12 +2048,18 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_h=
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

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltQIYgACgkQbDjKyiDZ
s5I1tg/9EWTl4FCe8/uvl7SEul9CUsB1KkkCCiAAvu+proZ07KLwtv7eB/WR01L2
+47FgA3XB4AJs2qbAEtoVX9cFfudXyEUF4JW9yn2gpffYG2OImYefiC+blc7a/as
AWB4AFPDhJK8FpUxfPtk1PqYaZ875o/Wy/GyAHupcgdsg9UVgrpUqie78ZwuHoMm
JPw7+vXtRHl/3YK5D/fJyOY44ce5FNMBSTLg7hyGNpC3+4fRUyJLrF9NQ0jMQl6a
u4cL2ntinlkgMovGd3y/s3+yCJSabMY5MIU1DCxgMPOh6YGuOety8SsFU7uFpJsU
qwryHwWearKmwbXyuIZftCs8aWxEYgINBtkssPxoqDjUUKigGwmEhyTPmrB76rjE
jlhpjJBQTtAcAa+FbNreBZ4vEmhBeEfyhGGlyNiiXDP+uiYpfEaJLVqQc3bcgqIh
l3ft+2iC/It3xLLka3JlqfYWBR7MGU/KCGfdOIA39NYyUTeX3G65QC76K1iMAqq8
R7qFi2/PmaQeFKqdw1OLUUR1zZQnJHhSw8ydgHi6f1JzZHdvWTCcDTcxJCKu0MRF
AK6jZJOrboZJOdEh6ttIQmy1s/BnQn+nt3270ODThumt74oGs9RiqTh8UIsWraHS
oY3WLUThtFpW15etfMU1anb8kFOK096mS7q10WPMF7ZlC/AFHlA=
=BgCa
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
