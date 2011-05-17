Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id CD351B6EDD
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2011 17:54:38 +1000 (EST)
Subject: Re: [PATCH 11/13] kvm/powerpc: Handle some PAPR hcalls in the kernel
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110511104530.GL2837@brick.ozlabs.ibm.com>
Date: Tue, 17 May 2011 09:54:35 +0200
Message-Id: <2C53DD5C-4F74-4FC4-9C65-4F401AE9AF78@suse.de>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104530.GL2837@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.05.2011, at 12:45, Paul Mackerras wrote:

> This adds the infrastructure for handling PAPR hcalls in the kernel,
> either early in the guest exit path while we are still in real mode,
> or later once the MMU has been turned back on and we are in the full
> kernel context.  The advantage of handling hcalls in real mode if
> possible is that we avoid two partition switches -- and this will
> become more important when we support SMT4 guests, since a partition
> switch means we have to pull all of the threads in the core out of
> the guest.  The disadvantage is that we can only access the kernel
> linear mapping, not anything vmalloced or ioremapped, since the MMU
> is off.
>=20
> This also adds code to handle the following hcalls in real mode:
>=20
> H_ENTER       Add an HPTE to the hashed page table
> H_REMOVE      Remove an HPTE from the hashed page table
> H_READ        Read HPTEs from the hashed page table
> H_PROTECT     Change the protection bits in an HPTE
> H_BULK_REMOVE Remove up to 4 HPTEs from the hashed page table
> H_SET_DABR    Set the data address breakpoint register
>=20
> Plus code to handle the following hcalls in the kernel:
>=20
> H_CEDE        Idle the vcpu until an interrupt or H_PROD hcall arrives
> H_PROD        Wake up a ceded vcpu
> H_REGISTER_VPA Register a virtual processor area (VPA)
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> arch/powerpc/include/asm/hvcall.h       |    5 +
> arch/powerpc/include/asm/kvm_host.h     |   11 +
> arch/powerpc/include/asm/kvm_ppc.h      |    1 +
> arch/powerpc/kernel/asm-offsets.c       |    2 +
> arch/powerpc/kvm/book3s_64_mmu_hv.c     |  342 =
+++++++++++++++++++++++++++++++
> arch/powerpc/kvm/book3s_hv.c            |  170 +++++++++++++++-
> arch/powerpc/kvm/book3s_hv_rmhandlers.S |  150 +++++++++++++-
> arch/powerpc/kvm/powerpc.c              |    2 +-
> 8 files changed, 679 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/hvcall.h =
b/arch/powerpc/include/asm/hvcall.h
> index 8edec71..a226002 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -29,6 +29,10 @@
> #define H_LONG_BUSY_ORDER_100_SEC	9905  /* Long busy, hint that =
100sec \
> 						 is a good time to retry =
*/
> #define H_LONG_BUSY_END_RANGE		9905  /* End of long busy range =
*/
> +
> +/* Hacked in for HV-aware kvm support */
> +#define H_TOO_HARD	9999

Not sure I like the name - when is it used? :)
Also, if it's not in the PAPR, the guest should never receive it, right?

> +
> #define H_HARDWARE	-1	/* Hardware error */
> #define H_FUNCTION	-2	/* Function not supported */
> #define H_PRIVILEGE	-3	/* Caller not privileged */
> @@ -100,6 +104,7 @@
> #define H_PAGE_SET_ACTIVE	H_PAGE_STATE_CHANGE
> #define H_AVPN			(1UL<<(63-32))	/* An avpn is =
provided as a sanity test */
> #define H_ANDCOND		(1UL<<(63-33))
> +#define H_LOCAL			(1UL<<(63-35))
> #define H_ICACHE_INVALIDATE	(1UL<<(63-40))	/* icbi, etc.  (ignored =
for IO pages) */
> #define H_ICACHE_SYNCHRONIZE	(1UL<<(63-41))	/* dcbst, icbi, etc =
(ignored for IO pages */
> #define H_ZERO_PAGE		(1UL<<(63-48))	/* zero the page before =
mapping (ignored for IO pages) */
> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
> index ec62365..af6703e 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -59,6 +59,10 @@ struct kvm;
> struct kvm_run;
> struct kvm_vcpu;
>=20
> +struct lppaca;
> +struct slb_shadow;
> +struct dtl;
> +
> struct kvm_vm_stat {
> 	u32 remote_tlb_flush;
> };
> @@ -341,7 +345,14 @@ struct kvm_vcpu_arch {
> 	u64 dec_expires;
> 	unsigned long pending_exceptions;
> 	u16 last_cpu;
> +	u8 ceded;
> +	u8 prodded;
> 	u32 last_inst;
> +
> +	struct lppaca *vpa;
> +	struct slb_shadow *slb_shadow;
> +	struct dtl *dtl;
> +	struct dtl *dtl_end;
> 	int trap;
> 	struct kvm_vcpu_arch_shared *shared;
> 	unsigned long magic_page_pa; /* phys addr to map the magic page =
to */
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h =
b/arch/powerpc/include/asm/kvm_ppc.h
> index cd9ad96..b4ee11a 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -116,6 +116,7 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm,
> 				struct kvm_userspace_memory_region =
*mem);
> extern void kvmppc_map_vrma(struct kvm *kvm,
> 			    struct kvm_userspace_memory_region *mem);
> +extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
> extern int kvmppc_core_init_vm(struct kvm *kvm);
> extern void kvmppc_core_destroy_vm(struct kvm *kvm);
> extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
> diff --git a/arch/powerpc/kernel/asm-offsets.c =
b/arch/powerpc/kernel/asm-offsets.c
> index 49e97fd..fd56f14 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -189,6 +189,7 @@ int main(void)
> 	DEFINE(LPPACADECRINT, offsetof(struct lppaca, =
int_dword.fields.decr_int));
> 	DEFINE(LPPACA_PMCINUSE, offsetof(struct lppaca, =
pmcregs_in_use));
> 	DEFINE(LPPACA_DTLIDX, offsetof(struct lppaca, dtl_idx));
> +	DEFINE(LPPACA_YIELDCOUNT, offsetof(struct lppaca, yield_count));
> 	DEFINE(PACA_DTL_RIDX, offsetof(struct paca_struct, dtl_ridx));
> #endif /* CONFIG_PPC_STD_MMU_64 */
> 	DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
> @@ -467,6 +468,7 @@ int main(void)
> 	DEFINE(VCPU_DEC, offsetof(struct kvm_vcpu, arch.dec));
> 	DEFINE(VCPU_DEC_EXPIRES, offsetof(struct kvm_vcpu, =
arch.dec_expires));
> 	DEFINE(VCPU_LPCR, offsetof(struct kvm_vcpu, arch.lpcr));
> +	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa));
> 	DEFINE(VCPU_MMCR, offsetof(struct kvm_vcpu, arch.mmcr));
> 	DEFINE(VCPU_PMC, offsetof(struct kvm_vcpu, arch.pmc));
> 	DEFINE(VCPU_SLB, offsetof(struct kvm_vcpu, arch.slb));
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c =
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 52d1be1..623caae 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -219,6 +219,348 @@ void kvmppc_map_vrma(struct kvm *kvm, struct =
kvm_userspace_memory_region *mem)
> 	}
> }
>=20
> +#define HPTE_V_HVLOCK	0x40UL
> +
> +static inline long lock_hpte(unsigned long *hpte, unsigned long bits)
> +{
> +	unsigned long tmp, old;
> +
> +	asm volatile("	ldarx	%0,0,%2\n"
> +		     "	and.	%1,%0,%3\n"
> +		     "	bne	2f\n"
> +		     "	ori	%0,%0,%4\n"
> +		     "  stdcx.	%0,0,%2\n"
> +		     "	beq+	2f\n"
> +		     "	li	%1,%3\n"
> +		     "2:	isync"
> +		     : "=3D&r" (tmp), "=3D&r" (old)
> +		     : "r" (hpte), "r" (bits), "i" (HPTE_V_HVLOCK)
> +		     : "cc", "memory");
> +	return old =3D=3D 0;
> +}
> +
> +long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
> +		    long pte_index, unsigned long pteh, unsigned long =
ptel)
> +{
> +	unsigned long porder;
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned long i, lpn, pa;
> +	unsigned long *hpte;
> +
> +	/* only handle 4k, 64k and 16M pages for now */
> +	porder =3D 12;
> +	if (pteh & HPTE_V_LARGE) {
> +		if ((ptel & 0xf000) =3D=3D 0x1000) {
> +			/* 64k page */
> +			porder =3D 16;
> +		} else if ((ptel & 0xff000) =3D=3D 0) {
> +			/* 16M page */
> +			porder =3D 24;
> +			/* lowest AVA bit must be 0 for 16M pages */
> +			if (pteh & 0x80)
> +				return H_PARAMETER;
> +		} else
> +			return H_PARAMETER;
> +	}
> +	lpn =3D (ptel & HPTE_R_RPN) >> kvm->arch.ram_porder;
> +	if (lpn >=3D kvm->arch.ram_npages || porder > =
kvm->arch.ram_porder)
> +		return H_PARAMETER;
> +	pa =3D kvm->arch.ram_pginfo[lpn].pfn << PAGE_SHIFT;
> +	if (!pa)
> +		return H_PARAMETER;
> +	/* Check WIMG */
> +	if ((ptel & HPTE_R_WIMG) !=3D HPTE_R_M &&
> +	    (ptel & HPTE_R_WIMG) !=3D (HPTE_R_W | HPTE_R_I | HPTE_R_M))
> +		return H_PARAMETER;
> +	pteh &=3D ~0x60UL;
> +	ptel &=3D ~(HPTE_R_PP0 - kvm->arch.ram_psize);
> +	ptel |=3D pa;
> +	if (pte_index >=3D (HPT_NPTEG << 3))
> +		return H_PARAMETER;
> +	if (likely((flags & H_EXACT) =3D=3D 0)) {
> +		pte_index &=3D ~7UL;
> +		hpte =3D (unsigned long *)(kvm->arch.hpt_virt + =
(pte_index << 4));
> +		for (i =3D 0; ; ++i) {
> +			if (i =3D=3D 8)
> +				return H_PTEG_FULL;
> +			if ((*hpte & HPTE_V_VALID) =3D=3D 0 &&
> +			    lock_hpte(hpte, HPTE_V_HVLOCK | =
HPTE_V_VALID))
> +				break;
> +			hpte +=3D 2;
> +		}
> +	} else {
> +		i =3D 0;
> +		hpte =3D (unsigned long *)(kvm->arch.hpt_virt + =
(pte_index << 4));
> +		if (!lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
> +			return H_PTEG_FULL;
> +	}
> +	hpte[1] =3D ptel;
> +	eieio();
> +	hpte[0] =3D pteh;
> +	asm volatile("ptesync" : : : "memory");
> +	atomic_inc(&kvm->arch.ram_pginfo[lpn].refcnt);
> +	vcpu->arch.gpr[4] =3D pte_index + i;
> +	return H_SUCCESS;
> +}
> +
> +static unsigned long compute_tlbie_rb(unsigned long v, unsigned long =
r,
> +				      unsigned long pte_index)
> +{
> +	unsigned long rb, va_low;
> +
> +	rb =3D (v & ~0x7fUL) << 16;		/* AVA field */
> +	va_low =3D pte_index >> 3;
> +	if (v & HPTE_V_SECONDARY)
> +		va_low =3D ~va_low;
> +	/* xor vsid from AVA */
> +	if (!(v & HPTE_V_1TB_SEG))
> +		va_low ^=3D v >> 12;
> +	else
> +		va_low ^=3D v >> 24;
> +	va_low &=3D 0x7ff;
> +	if (v & HPTE_V_LARGE) {
> +		rb |=3D 1;			/* L field */
> +		if (r & 0xff000) {
> +			/* non-16MB large page, must be 64k */
> +			/* (masks depend on page size) */
> +			rb |=3D 0x1000;		/* page encoding in LP =
field */
> +			rb |=3D (va_low & 0x7f) << 16; /* 7b of VA in =
AVA/LP field */
> +			rb |=3D (va_low & 0xfe);	/* AVAL field =
(P7 doesn't seem to care) */
> +		}
> +	} else {
> +		/* 4kB page */
> +		rb |=3D (va_low & 0x7ff) << 12;	/* remaining 11b of VA =
*/
> +	}
> +	rb |=3D (v >> 54) & 0x300;		/* B field */
> +	return rb;
> +}
> +
> +#define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
> +
> +static inline int try_lock_tlbie(unsigned int *lock)
> +{
> +	unsigned int tmp, old;
> +	unsigned int token =3D LOCK_TOKEN;
> +
> +	asm volatile("1:lwarx	%1,0,%2\n"
> +		     "	cmpwi	cr0,%1,0\n"
> +		     "	bne	2f\n"
> +		     "  stwcx.	%3,0,%2\n"
> +		     "	bne-	1b\n"
> +		     "  isync\n"
> +		     "2:"
> +		     : "=3D&r" (tmp), "=3D&r" (old)
> +		     : "r" (lock), "r" (token)
> +		     : "cc", "memory");
> +	return old =3D=3D 0;
> +}
> +
> +long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
> +		     unsigned long pte_index, unsigned long avpn,
> +		     unsigned long va)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned long *hpte;
> +	unsigned long v, r, rb;
> +
> +	if (pte_index >=3D (HPT_NPTEG << 3))
> +		return H_PARAMETER;
> +	hpte =3D (unsigned long *)(kvm->arch.hpt_virt + (pte_index << =
4));
> +	while (!lock_hpte(hpte, HPTE_V_HVLOCK))
> +		cpu_relax();
> +	if ((hpte[0] & HPTE_V_VALID) =3D=3D 0 ||
> +	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) !=3D avpn) ||
> +	    ((flags & H_ANDCOND) && (hpte[0] & avpn) !=3D 0)) {
> +		hpte[0] &=3D ~HPTE_V_HVLOCK;
> +		return H_NOT_FOUND;
> +	}
> +	if (atomic_read(&kvm->online_vcpus) =3D=3D 1)
> +		flags |=3D H_LOCAL;
> +	vcpu->arch.gpr[4] =3D v =3D hpte[0] & ~HPTE_V_HVLOCK;
> +	vcpu->arch.gpr[5] =3D r =3D hpte[1];
> +	rb =3D compute_tlbie_rb(v, r, pte_index);
> +	hpte[0] =3D 0;
> +	if (!(flags & H_LOCAL)) {
> +		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
> +			cpu_relax();
> +		asm volatile("ptesync" : : : "memory");
> +		asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
> +			     : : "r" (rb), "r" (kvm->arch.lpid));
> +		asm volatile("ptesync" : : : "memory");
> +		kvm->arch.tlbie_lock =3D 0;
> +	} else {
> +		asm volatile("ptesync" : : : "memory");
> +		asm volatile("tlbiel %0" : : "r" (rb));
> +		asm volatile("ptesync" : : : "memory");
> +	}
> +	return H_SUCCESS;
> +}
> +
> +long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned long *args =3D &vcpu->arch.gpr[4];
> +	unsigned long *hp, tlbrb[4];
> +	long int i, found;
> +	long int n_inval =3D 0;
> +	unsigned long flags, req, pte_index;
> +	long int local =3D 0;
> +	long int ret =3D H_SUCCESS;
> +
> +	if (atomic_read(&kvm->online_vcpus) =3D=3D 1)
> +		local =3D 1;
> +	for (i =3D 0; i < 4; ++i) {
> +		pte_index =3D args[i * 2];
> +		flags =3D pte_index >> 56;
> +		pte_index &=3D ((1ul << 56) - 1);
> +		req =3D flags >> 6;
> +		flags &=3D 3;
> +		if (req =3D=3D 3)
> +			break;
> +		if (req !=3D 1 || flags =3D=3D 3 ||
> +		    pte_index >=3D (HPT_NPTEG << 3)) {
> +			/* parameter error */
> +			args[i * 2] =3D ((0xa0 | flags) << 56) + =
pte_index;
> +			ret =3D H_PARAMETER;
> +			break;
> +		}
> +		hp =3D (unsigned long *)(kvm->arch.hpt_virt + (pte_index =
<< 4));
> +		while (!lock_hpte(hp, HPTE_V_HVLOCK))
> +			cpu_relax();
> +		found =3D 0;
> +		if (hp[0] & HPTE_V_VALID) {
> +			switch (flags & 3) {
> +			case 0:		/* absolute */
> +				found =3D 1;
> +				break;
> +			case 1:		/* andcond */
> +				if (!(hp[0] & args[i * 2 + 1]))
> +					found =3D 1;
> +				break;
> +			case 2:		/* AVPN */
> +				if ((hp[0] & ~0x7fUL) =3D=3D args[i * 2 =
+ 1])
> +					found =3D 1;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			hp[0] &=3D ~HPTE_V_HVLOCK;
> +			args[i * 2] =3D ((0x90 | flags) << 56) + =
pte_index;
> +			continue;
> +		}
> +		/* insert R and C bits from PTE */
> +		flags |=3D (hp[1] >> 5) & 0x0c;
> +		args[i * 2] =3D ((0x80 | flags) << 56) + pte_index;
> +		tlbrb[n_inval++] =3D compute_tlbie_rb(hp[0], hp[1], =
pte_index);
> +		hp[0] =3D 0;
> +	}
> +	if (n_inval =3D=3D 0)
> +		return ret;
> +
> +	if (!local) {
> +		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
> +			cpu_relax();
> +		asm volatile("ptesync" : : : "memory");
> +		for (i =3D 0; i < n_inval; ++i)
> +			asm volatile(PPC_TLBIE(%1,%0)
> +				     : : "r" (tlbrb[i]), "r" =
(kvm->arch.lpid));
> +		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
> +		kvm->arch.tlbie_lock =3D 0;
> +	} else {
> +		asm volatile("ptesync" : : : "memory");
> +		for (i =3D 0; i < n_inval; ++i)
> +			asm volatile("tlbiel %0" : : "r" (tlbrb[i]));
> +		asm volatile("ptesync" : : : "memory");
> +	}
> +	return ret;
> +}
> +
> +long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
> +		      unsigned long pte_index, unsigned long avpn,
> +		      unsigned long va)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned long *hpte;
> +	unsigned long v, r, rb;
> +
> +	if (pte_index >=3D (HPT_NPTEG << 3))
> +		return H_PARAMETER;
> +	hpte =3D (unsigned long *)(kvm->arch.hpt_virt + (pte_index << =
4));
> +	while (!lock_hpte(hpte, HPTE_V_HVLOCK))
> +		cpu_relax();
> +	if ((hpte[0] & HPTE_V_VALID) =3D=3D 0 ||
> +	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) !=3D avpn)) {
> +		hpte[0] &=3D ~HPTE_V_HVLOCK;
> +		return H_NOT_FOUND;
> +	}
> +	if (atomic_read(&kvm->online_vcpus) =3D=3D 1)
> +		flags |=3D H_LOCAL;
> +	v =3D hpte[0];
> +	r =3D hpte[1] & ~(HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N |
> +			HPTE_R_KEY_HI | HPTE_R_KEY_LO);
> +	r |=3D (flags << 55) & HPTE_R_PP0;
> +	r |=3D (flags << 48) & HPTE_R_KEY_HI;
> +	r |=3D flags & (HPTE_R_PP | HPTE_R_N | HPTE_R_KEY_LO);
> +	rb =3D compute_tlbie_rb(v, r, pte_index);
> +	hpte[0] =3D v & ~HPTE_V_VALID;
> +	if (!(flags & H_LOCAL)) {
> +		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
> +			cpu_relax();
> +		asm volatile("ptesync" : : : "memory");
> +		asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
> +			     : : "r" (rb), "r" (kvm->arch.lpid));
> +		asm volatile("ptesync" : : : "memory");
> +		kvm->arch.tlbie_lock =3D 0;
> +	} else {
> +		asm volatile("ptesync" : : : "memory");
> +		asm volatile("tlbiel %0" : : "r" (rb));
> +		asm volatile("ptesync" : : : "memory");
> +	}
> +	hpte[1] =3D r;
> +	eieio();
> +	hpte[0] =3D v & ~HPTE_V_HVLOCK;
> +	asm volatile("ptesync" : : : "memory");
> +	return H_SUCCESS;
> +}
> +
> +static unsigned long reverse_xlate(struct kvm *kvm, unsigned long =
realaddr)
> +{
> +	long int i;
> +	unsigned long offset, rpn;
> +
> +	offset =3D realaddr & (kvm->arch.ram_psize - 1);
> +	rpn =3D (realaddr - offset) >> PAGE_SHIFT;
> +	for (i =3D 0; i < kvm->arch.ram_npages; ++i)
> +		if (rpn =3D=3D kvm->arch.ram_pginfo[i].pfn)
> +			return (i << PAGE_SHIFT) + offset;
> +	return HPTE_R_RPN;	/* all 1s in the RPN field */
> +}
> +
> +long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
> +		   unsigned long pte_index)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned long *hpte, r;
> +	int i, n =3D 1;
> +
> +	if (pte_index >=3D (HPT_NPTEG << 3))
> +		return H_PARAMETER;
> +	if (flags & H_READ_4) {
> +		pte_index &=3D ~3;
> +		n =3D 4;
> +	}
> +	for (i =3D 0; i < n; ++i, ++pte_index) {
> +		hpte =3D (unsigned long *)(kvm->arch.hpt_virt + =
(pte_index << 4));
> +		r =3D hpte[1];
> +		if ((flags & H_R_XLATE) && (hpte[0] & HPTE_V_VALID))
> +			r =3D reverse_xlate(kvm, r & HPTE_R_RPN) |
> +				(r & ~HPTE_R_RPN);
> +		vcpu->arch.gpr[4 + i * 2] =3D hpte[0];
> +		vcpu->arch.gpr[5 + i * 2] =3D r;
> +	}
> +	return H_SUCCESS;
> +}
> +
> int kvmppc_mmu_hv_init(void)
> {
> 	if (!cpu_has_feature(CPU_FTR_HVMODE_206))
> diff --git a/arch/powerpc/kvm/book3s_hv.c =
b/arch/powerpc/kvm/book3s_hv.c
> index f6b7cd1..377a35a 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -126,6 +126,158 @@ void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
> 	       vcpu->arch.last_inst);
> }
>=20
> +struct kvm_vcpu *kvmppc_find_vcpu(struct kvm *kvm, int id)
> +{
> +	int r;
> +	struct kvm_vcpu *v, *ret =3D NULL;
> +
> +	mutex_lock(&kvm->lock);
> +	kvm_for_each_vcpu(r, v, kvm) {
> +		if (v->vcpu_id =3D=3D id) {
> +			ret =3D v;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&kvm->lock);
> +	return ret;
> +}
> +
> +static void init_vpa(struct kvm_vcpu *vcpu, struct lppaca *vpa)
> +{
> +	vpa->shared_proc =3D 1;
> +	vpa->yield_count =3D 1;
> +}
> +
> +static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
> +				       unsigned long flags,
> +				       unsigned long vcpuid, unsigned =
long vpa)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned long pg_index, ra, len;
> +	unsigned long pg_offset;
> +	void *va;
> +	struct kvm_vcpu *tvcpu;
> +
> +	tvcpu =3D kvmppc_find_vcpu(kvm, vcpuid);
> +	if (!tvcpu)
> +		return H_PARAMETER;
> +
> +	flags >>=3D 63 - 18;
> +	flags &=3D 7;
> +	if (flags =3D=3D 0 || flags =3D=3D 4)
> +		return H_PARAMETER;
> +	if (flags < 4) {
> +		if (vpa & 0x7f)
> +			return H_PARAMETER;
> +		/* registering new area; convert logical addr to real */
> +		pg_index =3D vpa >> kvm->arch.ram_porder;
> +		pg_offset =3D vpa & (kvm->arch.ram_psize - 1);
> +		if (pg_index >=3D kvm->arch.ram_npages)
> +			return H_PARAMETER;
> +		if (kvm->arch.ram_pginfo[pg_index].pfn =3D=3D 0)
> +			return H_PARAMETER;
> +		ra =3D kvm->arch.ram_pginfo[pg_index].pfn << PAGE_SHIFT;
> +		ra |=3D pg_offset;
> +		va =3D __va(ra);
> +		if (flags <=3D 1)
> +			len =3D *(unsigned short *)(va + 4);
> +		else
> +			len =3D *(unsigned int *)(va + 4);
> +		if (pg_offset + len > kvm->arch.ram_psize)
> +			return H_PARAMETER;
> +		switch (flags) {
> +		case 1:		/* register VPA */
> +			if (len < 640)
> +				return H_PARAMETER;
> +			tvcpu->arch.vpa =3D va;
> +			init_vpa(vcpu, va);
> +			break;
> +		case 2:		/* register DTL */
> +			if (len < 48)
> +				return H_PARAMETER;
> +			if (!tvcpu->arch.vpa)
> +				return H_RESOURCE;
> +			len -=3D len % 48;
> +			tvcpu->arch.dtl =3D va;
> +			tvcpu->arch.dtl_end =3D va + len;
> +			break;
> +		case 3:		/* register SLB shadow buffer */
> +			if (len < 8)
> +				return H_PARAMETER;
> +			if (!tvcpu->arch.vpa)
> +				return H_RESOURCE;
> +			tvcpu->arch.slb_shadow =3D va;
> +			len =3D (len - 16) / 16;
> +			tvcpu->arch.slb_shadow =3D va;
> +			break;
> +		}
> +	} else {
> +		switch (flags) {
> +		case 5:		/* unregister VPA */
> +			if (tvcpu->arch.slb_shadow || tvcpu->arch.dtl)
> +				return H_RESOURCE;
> +			tvcpu->arch.vpa =3D NULL;
> +			break;
> +		case 6:		/* unregister DTL */
> +			tvcpu->arch.dtl =3D NULL;
> +			break;
> +		case 7:		/* unregister SLB shadow buffer */
> +			tvcpu->arch.slb_shadow =3D NULL;
> +			break;
> +		}
> +	}
> +	return H_SUCCESS;
> +}
> +
> +int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long req =3D kvmppc_get_gpr(vcpu, 3);
> +	unsigned long target, ret =3D H_SUCCESS;
> +	struct kvm_vcpu *tvcpu;
> +
> +	switch (req) {
> +	case H_CEDE:
> +		vcpu->arch.msr |=3D MSR_EE;
> +		vcpu->arch.ceded =3D 1;
> +		smp_mb();
> +		if (!vcpu->arch.prodded)
> +			kvmppc_vcpu_block(vcpu);
> +		else
> +			vcpu->arch.prodded =3D 0;
> +		smp_mb();
> +		vcpu->arch.ceded =3D 0;
> +		break;
> +	case H_PROD:
> +		target =3D kvmppc_get_gpr(vcpu, 4);
> +		tvcpu =3D kvmppc_find_vcpu(vcpu->kvm, target);
> +		if (!tvcpu) {
> +			ret =3D H_PARAMETER;
> +			break;
> +		}
> +		tvcpu->arch.prodded =3D 1;
> +		smp_mb();
> +		if (vcpu->arch.ceded) {
> +			if (waitqueue_active(&vcpu->wq)) {
> +				wake_up_interruptible(&vcpu->wq);
> +				vcpu->stat.halt_wakeup++;
> +			}
> +		}
> +		break;
> +	case H_CONFER:
> +		break;
> +	case H_REGISTER_VPA:
> +		ret =3D do_h_register_vpa(vcpu, kvmppc_get_gpr(vcpu, 4),
> +					kvmppc_get_gpr(vcpu, 5),
> +					kvmppc_get_gpr(vcpu, 6));
> +		break;
> +	default:
> +		return RESUME_HOST;
> +	}
> +	kvmppc_set_gpr(vcpu, 3, ret);
> +	vcpu->arch.hcall_needed =3D 0;
> +	return RESUME_GUEST;
> +}
> +
> static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu =
*vcpu,
> 			      struct task_struct *tsk)
> {
> @@ -307,7 +459,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
>=20
> extern int __kvmppc_vcore_entry(struct kvm_run *kvm_run, struct =
kvm_vcpu *vcpu);
>=20
> -int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
> +static int kvmppc_run_vcpu(struct kvm_run *run, struct kvm_vcpu =
*vcpu)
> {
> 	u64 now;
>=20
> @@ -338,6 +490,22 @@ int kvmppc_vcpu_run(struct kvm_run *run, struct =
kvm_vcpu *vcpu)
> 	return kvmppc_handle_exit(run, vcpu, current);
> }
>=20
> +int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
> +{
> +	int r;
> +
> +	do {
> +		r =3D kvmppc_run_vcpu(run, vcpu);
> +
> +		if (run->exit_reason =3D=3D KVM_EXIT_PAPR_HCALL &&
> +		    !(vcpu->arch.msr & MSR_PR)) {
> +			r =3D kvmppc_pseries_do_hcall(vcpu);
> +			kvmppc_core_deliver_interrupts(vcpu);
> +		}
> +	} while (r =3D=3D RESUME_GUEST);
> +	return r;
> +}
> +
> int kvmppc_core_prepare_memory_region(struct kvm *kvm,
> 				struct kvm_userspace_memory_region *mem)
> {
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S =
b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 813b01c..e8a8f3c 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -195,6 +195,14 @@ kvmppc_handler_trampoline_enter:
> 	/* Save R1 in the PACA */
> 	std	r1, PACA_KVM_SVCPU + SVCPU_HOST_R1(r13)
>=20
> +	/* Increment yield count if they have a VPA */
> +	ld	r3, VCPU_VPA(r4)
> +	cmpdi	r3, 0
> +	beq	25f
> +	lwz	r5, LPPACA_YIELDCOUNT(r3)
> +	addi	r5, r5, 1
> +	stw	r5, LPPACA_YIELDCOUNT(r3)
> +25:
> 	/* Load up DAR and DSISR */
> 	ld	r5, VCPU_DAR(r4)
> 	lwz	r6, VCPU_DSISR(r4)
> @@ -432,6 +440,10 @@ kvmppc_interrupt:
> 	cmpwi	r3,0
> 	bge	ignore_hdec
> 2:
> +	/* See if this is something we can handle in real mode */
> +	cmpwi	r12,0xc00

use the define please

> +	beq	hcall_real_mode

This is simply a hcall helper, as the name suggests. So the comment is =
slightly misleading - it should rather read like "Try to handle =
hypercalls in real mode".

> +hcall_real_cont:
>=20
> 	/* Check for mediated interrupts (could be done earlier really =
...) */
> 	cmpwi	r12,0x500
> @@ -607,13 +619,28 @@ hdec_soon:
> 	std	r5, VCPU_SPRG2(r9)
> 	std	r6, VCPU_SPRG3(r9)
>=20
> -	/* Save PMU registers */
> +	/* Increment yield count if they have a VPA */
> +	ld	r8, VCPU_VPA(r9)	/* do they have a VPA? */
> +	cmpdi	r8, 0
> +	beq	25f
> +	lwz	r3, LPPACA_YIELDCOUNT(r8)
> +	addi	r3, r3, 1
> +	stw	r3, LPPACA_YIELDCOUNT(r8)
> +25:
> +	/* Save PMU registers if requested */
> +	/* r8 and cr0.eq are live here */
> 	li	r3, 1
> 	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) =
bit */
> 	mfspr	r4, SPRN_MMCR0		/* save MMCR0 */
> 	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable =
ints */
> 	isync
> -	mfspr	r5, SPRN_MMCR1
> +	beq	21f			/* if no VPA, save PMU stuff =
anyway */
> +	lbz	r7, LPPACA_PMCINUSE(r8)
> +	cmpwi	r7, 0			/* did they ask for PMU stuff to =
be saved? */
> +	bne	21f
> +	std	r3, VCPU_MMCR(r9)	/* if not, set saved MMCR0 to FC =
*/
> +	b	22f
> +21:	mfspr	r5, SPRN_MMCR1
> 	mfspr	r6, SPRN_MMCRA
> 	std	r4, VCPU_MMCR(r9)
> 	std	r5, VCPU_MMCR + 8(r9)
> @@ -650,6 +677,119 @@ kvmppc_handler_trampoline_exit_end:
> 	mfspr	r7,SPRN_HDSISR
> 	b	7b
>=20
> +	.globl	hcall_real_mode
> +hcall_real_mode:
> +	ld	r3,VCPU_GPR(r3)(r9)
> +	andi.	r0,r11,MSR_PR
> +	bne	hcall_real_cont
> +	clrrdi	r3,r3,2
> +	cmpldi	r3,hcall_real_table_end - hcall_real_table
> +	bge	hcall_real_cont
> +	LOAD_REG_ADDR(r4, hcall_real_table)
> +	lwzx	r3,r3,r4
> +	cmpwi	r3,0
> +	beq	hcall_real_cont
> +	add	r3,r3,r4
> +	mtctr	r3
> +	mr	r3,r9		/* get vcpu pointer */
> +	ld	r4,VCPU_GPR(r4)(r9)
> +	bctrl
> +	cmpdi	r3,H_TOO_HARD
> +	beq	hcall_real_fallback

Ah, very good. Please mark the constant as "for internal use only" then, =
as that's certainly fine :).

> +	ld	r4,PACA_KVM_VCPU(r13)
> +	std	r3,VCPU_GPR(r3)(r4)
> +	ld	r10,VCPU_PC(r4)
> +	ld	r11,VCPU_MSR(r4)
> +	b	fast_guest_return
> +
> +	/* We've attempted a real mode hcall, but it's punted it back
> +	 * to userspace.  We need to restore some clobbered volatiles
> +	 * before resuming the pass-it-to-qemu path */
> +hcall_real_fallback:
> +	li	r12,0xc00

use the define please :)


Alex
