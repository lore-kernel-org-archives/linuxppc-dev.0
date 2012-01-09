Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CBA92B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 02:35:57 +1100 (EST)
Subject: Re: [RFC PATCH 04/16] KVM: PPC: factor out lpid allocator from
 book3s_64_mmu_hv
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111221013420.GD8378@schlenkerla.am.freescale.net>
Date: Mon, 9 Jan 2012 16:35:52 +0100
Message-Id: <CE2DB77D-1D57-4D7A-92E6-08368733DE6F@suse.de>
References: <20111221013420.GD8378@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 KVM mailing list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 21.12.2011, at 02:34, Scott Wood wrote:

> We'll use it on e500mc as well.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/include/asm/kvm_book3s.h |    3 ++
> arch/powerpc/include/asm/kvm_booke.h  |    3 ++
> arch/powerpc/include/asm/kvm_ppc.h    |    5 ++++
> arch/powerpc/kvm/book3s_64_mmu_hv.c   |   26 +++++++++---------------
> arch/powerpc/kvm/powerpc.c            |   34 =
+++++++++++++++++++++++++++++++++
> 5 files changed, 55 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h =
b/arch/powerpc/include/asm/kvm_book3s.h
> index 60e069e..58c8bec 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -448,4 +448,7 @@ static inline bool kvmppc_critical_section(struct =
kvm_vcpu *vcpu)
>=20
> #define INS_DCBZ			0x7c0007ec
>=20
> +/* LPIDs we support with this build -- runtime limit may be lower */
> +#define KVMPPC_NR_LPIDS			(LPID_RSVD + 1)
> +
> #endif /* __ASM_KVM_BOOK3S_H__ */
> diff --git a/arch/powerpc/include/asm/kvm_booke.h =
b/arch/powerpc/include/asm/kvm_booke.h
> index e20c162..138118e 100644
> --- a/arch/powerpc/include/asm/kvm_booke.h
> +++ b/arch/powerpc/include/asm/kvm_booke.h
> @@ -23,6 +23,9 @@
> #include <linux/types.h>
> #include <linux/kvm_host.h>
>=20
> +/* LPIDs we support with this build -- runtime limit may be lower */
> +#define KVMPPC_NR_LPIDS                        64
> +
> static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, =
ulong val)
> {
> 	vcpu->arch.regs.gpr[num] =3D val;
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h =
b/arch/powerpc/include/asm/kvm_ppc.h
> index a61b5b5..5524f88 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -202,4 +202,9 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu =
*vcpu,
> int kvm_vcpu_ioctl_dirty_tlb(struct kvm_vcpu *vcpu,
> 			     struct kvm_dirty_tlb *cfg);
>=20
> +long kvmppc_alloc_lpid(void);
> +void kvmppc_claim_lpid(long lpid);
> +void kvmppc_free_lpid(long lpid);
> +void kvmppc_init_lpid(unsigned long nr_lpids);
> +
> #endif /* __POWERPC_KVM_PPC_H__ */
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c =
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 66d6452..45b6f0e 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -36,13 +36,11 @@
>=20
> /* POWER7 has 10-bit LPIDs, PPC970 has 6-bit LPIDs */
> #define MAX_LPID_970	63
> -#define NR_LPIDS	(LPID_RSVD + 1)
> -unsigned long lpid_inuse[BITS_TO_LONGS(NR_LPIDS)];
>=20
> long kvmppc_alloc_hpt(struct kvm *kvm)
> {
> 	unsigned long hpt;
> -	unsigned long lpid;
> +	long lpid;
> 	struct revmap_entry *rev;
>=20
> 	/* Allocate guest's hashed page table */
> @@ -62,14 +60,9 @@ long kvmppc_alloc_hpt(struct kvm *kvm)
> 	}
> 	kvm->arch.revmap =3D rev;
>=20
> -	/* Allocate the guest's logical partition ID */
> -	do {
> -		lpid =3D find_first_zero_bit(lpid_inuse, NR_LPIDS);
> -		if (lpid >=3D NR_LPIDS) {
> -			pr_err("kvm_alloc_hpt: No LPIDs free\n");
> -			goto out_freeboth;
> -		}
> -	} while (test_and_set_bit(lpid, lpid_inuse));
> +	lpid =3D kvmppc_alloc_lpid();
> +	if (lpid < 0)
> +		goto out_freeboth;
>=20
> 	kvm->arch.sdr1 =3D __pa(hpt) | (HPT_ORDER - 18);
> 	kvm->arch.lpid =3D lpid;
> @@ -86,7 +79,7 @@ long kvmppc_alloc_hpt(struct kvm *kvm)
>=20
> void kvmppc_free_hpt(struct kvm *kvm)
> {
> -	clear_bit(kvm->arch.lpid, lpid_inuse);
> +	kvmppc_free_lpid(kvm->arch.lpid);
> 	vfree(kvm->arch.revmap);
> 	free_pages(kvm->arch.hpt_virt, HPT_ORDER - PAGE_SHIFT);
> }
> @@ -158,8 +151,7 @@ int kvmppc_mmu_hv_init(void)
> 	if (!cpu_has_feature(CPU_FTR_HVMODE))
> 		return -EINVAL;
>=20
> -	memset(lpid_inuse, 0, sizeof(lpid_inuse));
> -
> +	/* POWER7 has 10-bit LPIDs, PPC970 and e500mc have 6-bit LPIDs =
*/
> 	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
> 		host_lpid =3D mfspr(SPRN_LPID);	/* POWER7 */
> 		rsvd_lpid =3D LPID_RSVD;
> @@ -168,9 +160,11 @@ int kvmppc_mmu_hv_init(void)
> 		rsvd_lpid =3D MAX_LPID_970;
> 	}
>=20
> -	set_bit(host_lpid, lpid_inuse);
> +	kvmppc_init_lpid(rsvd_lpid + 1);
> +
> +	kvmppc_claim_lpid(host_lpid);
> 	/* rsvd_lpid is reserved for use in partition switching */
> -	set_bit(rsvd_lpid, lpid_inuse);
> +	kvmppc_claim_lpid(rsvd_lpid);
>=20
> 	return 0;
> }
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 64c738dc..42701e5 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c

Paul, does this work for you? IIRC you need this code to be available =
from real mode, which powerpc.c isn't in, right?


Alex

> @@ -800,6 +800,40 @@ out:
> 	return r;
> }
>=20
> +static unsigned long lpid_inuse[BITS_TO_LONGS(KVMPPC_NR_LPIDS)];
> +static unsigned long nr_lpids;
> +
> +long kvmppc_alloc_lpid(void)
> +{
> +	long lpid;
> +
> +	do {
> +		lpid =3D find_first_zero_bit(lpid_inuse, =
KVMPPC_NR_LPIDS);
> +		if (lpid >=3D nr_lpids) {
> +			pr_err("%s: No LPIDs free\n", __func__);
> +			return -ENOMEM;
> +		}
> +	} while (test_and_set_bit(lpid, lpid_inuse));
> +
> +	return lpid;
> +}
> +
> +void kvmppc_claim_lpid(long lpid)
> +{
> +	set_bit(lpid, lpid_inuse);
> +}
> +
> +void kvmppc_free_lpid(long lpid)
> +{
> +	clear_bit(lpid, lpid_inuse);
> +}
> +
> +void kvmppc_init_lpid(unsigned long nr_lpids_param)
> +{
> +	nr_lpids =3D min_t(unsigned long, KVMPPC_NR_LPIDS, =
nr_lpids_param);
> +	memset(lpid_inuse, 0, sizeof(lpid_inuse));
> +}
> +
> int kvm_arch_init(void *opaque)
> {
> 	return 0;
> --=20
> 1.7.7.rc3.4.g8d714
>=20
>=20
