Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5153EB6F9C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 03:23:59 +1100 (EST)
Subject: Re: [RFC PATCH 12/16] KVM: PPC: e500: emulate tlbilx
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111221013438.GL8378@schlenkerla.am.freescale.net>
Date: Mon, 9 Jan 2012 17:23:52 +0100
Message-Id: <62B1389D-F96A-4D96-A450-7CE9F7E345CE@suse.de>
References: <20111221013438.GL8378@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 21.12.2011, at 02:34, Scott Wood wrote:

> tlbilx is the new, preferred invalidation instruction.  It is not
> found on e500 prior to e500mc, but there should be no harm in
> supporting it on all e500.
>=20
> Based on code from Ashish Kalra <Ashish.Kalra@freescale.com>.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/kvm/e500.h         |    1 +
> arch/powerpc/kvm/e500_emulate.c |    9 ++++++
> arch/powerpc/kvm/e500_tlb.c     |   52 =
+++++++++++++++++++++++++++++++++++++++
> 3 files changed, 62 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
> index f4dee55..ce3f163 100644
> --- a/arch/powerpc/kvm/e500.h
> +++ b/arch/powerpc/kvm/e500.h
> @@ -124,6 +124,7 @@ int kvmppc_e500_emul_mt_mmucsr0(struct =
kvmppc_vcpu_e500 *vcpu_e500,
> int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu);
> int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu);
> int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int rb);
> +int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, =
int rb);
> int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, int rb);
> int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500);
> void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *vcpu_e500);
> diff --git a/arch/powerpc/kvm/e500_emulate.c =
b/arch/powerpc/kvm/e500_emulate.c
> index c80794d..af02c18 100644
> --- a/arch/powerpc/kvm/e500_emulate.c
> +++ b/arch/powerpc/kvm/e500_emulate.c
> @@ -22,6 +22,7 @@
> #define XOP_TLBSX   914
> #define XOP_TLBRE   946
> #define XOP_TLBWE   978
> +#define XOP_TLBILX  18
>=20
> int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
>                            unsigned int inst, int *advance)
> @@ -29,6 +30,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 	int emulated =3D EMULATE_DONE;
> 	int ra;
> 	int rb;
> +	int rt;
>=20
> 	switch (get_op(inst)) {
> 	case 31:
> @@ -47,6 +49,13 @@ int kvmppc_core_emulate_op(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 			emulated =3D kvmppc_e500_emul_tlbsx(vcpu,rb);
> 			break;
>=20
> +		case XOP_TLBILX:
> +			ra =3D get_ra(inst);
> +			rb =3D get_rb(inst);
> +			rt =3D get_rt(inst);
> +			emulated =3D kvmppc_e500_emul_tlbilx(vcpu, rt, =
ra, rb);
> +			break;
> +
> 		case XOP_TLBIVAX:
> 			ra =3D get_ra(inst);
> 			rb =3D get_rb(inst);
> diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
> index 031fd5b..121cd68 100644
> --- a/arch/powerpc/kvm/e500_tlb.c
> +++ b/arch/powerpc/kvm/e500_tlb.c
> @@ -631,6 +631,58 @@ int kvmppc_e500_emul_tlbivax(struct kvm_vcpu =
*vcpu, int ra, int rb)
> 	return EMULATE_DONE;
> }
>=20
> +static void tlbilx_all(struct kvmppc_vcpu_e500 *vcpu_e500, int =
tlbsel,
> +		       int pid, int rt)
> +{
> +	struct kvm_book3e_206_tlb_entry *tlbe;
> +	int tid, esel;
> +
> +	/* invalidate all entries */
> +	for (esel =3D 0; esel < vcpu_e500->gtlb_params[tlbsel].entries; =
esel++) {

By dereferencing the struct inside the loop you're creating a new load =
on every iteration. Please use a variable for entries.

> +		tlbe =3D get_entry(vcpu_e500, tlbsel, esel);
> +		tid =3D get_tlb_tid(tlbe);
> +		if (rt =3D=3D 0 || tid =3D=3D pid) {
> +			inval_gtlbe_on_host(vcpu_e500, tlbsel, esel);
> +			kvmppc_e500_gtlbe_invalidate(vcpu_e500, tlbsel, =
esel);
> +		}
> +	}
> +}
> +
> +static void tlbilx_one(struct kvmppc_vcpu_e500 *vcpu_e500, int pid,
> +		       int ra, int rb)
> +{
> +	int tlbsel, esel;
> +	gva_t ea;
> +
> +	ea =3D kvmppc_get_gpr(&vcpu_e500->vcpu, rb);
> +	if (ra)
> +		ea +=3D kvmppc_get_gpr(&vcpu_e500->vcpu, ra);
> +
> +	for (tlbsel =3D 0; tlbsel < 2; tlbsel++) {
> +		esel =3D kvmppc_e500_tlb_index(vcpu_e500, ea, tlbsel, =
pid, -1);
> +		if (esel >=3D 0) {
> +			inval_gtlbe_on_host(vcpu_e500, tlbsel, esel);
> +			kvmppc_e500_gtlbe_invalidate(vcpu_e500, tlbsel, =
esel);
> +			break;
> +		}
> +	}
> +}
> +
> +int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, =
int rb)
> +{
> +	struct kvmppc_vcpu_e500 *vcpu_e500 =3D to_e500(vcpu);
> +	int pid =3D get_cur_spid(vcpu);
> +
> +	if (rt =3D=3D 0 || rt =3D=3D 1) {
> +		tlbilx_all(vcpu_e500, 0, pid, rt);
> +		tlbilx_all(vcpu_e500, 1, pid, rt);
> +	} else if (rt =3D=3D 3) {

too many magic constants :)


Alex
