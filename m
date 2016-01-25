Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E09511A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:20:45 +1100 (AEDT)
Date: Mon, 25 Jan 2016 16:21:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 6/6] KVM: PPC: Add support for multiple-TCE
 hcalls
Message-ID: <20160125052138.GA32205@voom.redhat.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-7-git-send-email-aik@ozlabs.ru>
 <20160125004402.GF27454@voom.redhat.com>
 <56A5794D.4080704@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
In-Reply-To: <56A5794D.4080704@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 12:24:29PM +1100, Alexey Kardashevskiy wrote:
> On 01/25/2016 11:44 AM, David Gibson wrote:
> >On Thu, Jan 21, 2016 at 06:39:37PM +1100, Alexey Kardashevskiy wrote:
> >>This adds real and virtual mode handlers for the H_PUT_TCE_INDIRECT and
> >>H_STUFF_TCE hypercalls for user space emulated devices such as IBMVIO
> >>devices or emulated PCI.  These calls allow adding multiple entries
> >>(up to 512) into the TCE table in one call which saves time on
> >>transition between kernel and user space.
> >>
> >>This implements the KVM_CAP_PPC_MULTITCE capability. When present,
> >>the kernel will try handling H_PUT_TCE_INDIRECT and H_STUFF_TCE.
> >>If they can not be handled by the kernel, they are passed on to
> >>the user space. The user space still has to have an implementation
> >>for these.
> >>
> >>Both HV and PR-syle KVM are supported.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>Changes:
> >>v2:
> >>* compare @ret with H_SUCCESS instead of assuming H_SUCCESS is zero
> >>* s/~IOMMU_PAGE_MASK_4K/SZ_4K-1/ when testing @tce_list
> >>---
> >>  Documentation/virtual/kvm/api.txt       |  25 ++++++
> >>  arch/powerpc/include/asm/kvm_ppc.h      |  12 +++
> >>  arch/powerpc/kvm/book3s_64_vio.c        | 110 +++++++++++++++++++++++-
> >>  arch/powerpc/kvm/book3s_64_vio_hv.c     | 145 +++++++++++++++++++++++=
+++++++--
> >>  arch/powerpc/kvm/book3s_hv.c            |  26 +++++-
> >>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |   6 +-
> >>  arch/powerpc/kvm/book3s_pr_papr.c       |  35 ++++++++
> >>  arch/powerpc/kvm/powerpc.c              |   3 +
> >>  8 files changed, 349 insertions(+), 13 deletions(-)
> >>
> >>diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/=
kvm/api.txt
> >>index 07e4cdf..da39435 100644
> >>--- a/Documentation/virtual/kvm/api.txt
> >>+++ b/Documentation/virtual/kvm/api.txt
> >>@@ -3035,6 +3035,31 @@ Returns: 0 on success, -1 on error
> >>
> >>  Queues an SMI on the thread's vcpu.
> >>
> >>+4.97 KVM_CAP_PPC_MULTITCE
> >>+
> >>+Capability: KVM_CAP_PPC_MULTITCE
> >>+Architectures: ppc
> >>+Type: vm
> >>+
> >>+This capability means the kernel is capable of handling hypercalls
> >>+H_PUT_TCE_INDIRECT and H_STUFF_TCE without passing those into the user
> >>+space. This significantly accelerates DMA operations for PPC KVM guest=
s.
> >>+User space should expect that its handlers for these hypercalls
> >>+are not going to be called if user space previously registered LIOBN
> >>+in KVM (via KVM_CREATE_SPAPR_TCE or similar calls).
> >>+
> >>+In order to enable H_PUT_TCE_INDIRECT and H_STUFF_TCE use in the guest,
> >>+user space might have to advertise it for the guest. For example,
> >>+IBM pSeries (sPAPR) guest starts using them if "hcall-multi-tce" is
> >>+present in the "ibm,hypertas-functions" device-tree property.
> >>+
> >>+The hypercalls mentioned above may or may not be processed successfully
> >>+in the kernel based fast path. If they can not be handled by the kerne=
l,
> >>+they will get passed on to user space. So user space still has to have
> >>+an implementation for these despite the in kernel acceleration.
> >>+
> >>+This capability is always enabled.
> >>+
> >>  5. The kvm_run structure
> >>  ------------------------
> >>
> >>diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/=
asm/kvm_ppc.h
> >>index 9513911..4cadee5 100644
> >>--- a/arch/powerpc/include/asm/kvm_ppc.h
> >>+++ b/arch/powerpc/include/asm/kvm_ppc.h
> >>@@ -166,12 +166,24 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcp=
u *vcpu);
> >>
> >>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> >>  				struct kvm_create_spapr_tce *args);
> >>+extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
> >>+		struct kvm_vcpu *vcpu, unsigned long liobn);
> >>  extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> >>  		unsigned long ioba, unsigned long npages);
> >>  extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
> >>  		unsigned long tce);
> >>+extern long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
> >>+		unsigned long *ua, unsigned long **prmap);
> >
> >Putting a userspace address into an unsigned long is pretty nasty: it
> >should be a something __user *.
> >
> >>+extern void kvmppc_tce_put(struct kvmppc_spapr_tce_table *tt,
> >>+		unsigned long idx, unsigned long tce);
> >>  extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long lio=
bn,
> >>  			     unsigned long ioba, unsigned long tce);
> >>+extern long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
> >>+		unsigned long liobn, unsigned long ioba,
> >>+		unsigned long tce_list, unsigned long npages);
> >>+extern long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>+		unsigned long liobn, unsigned long ioba,
> >>+		unsigned long tce_value, unsigned long npages);
> >>  extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long lio=
bn,
> >>  			     unsigned long ioba);
> >>  extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
> >>diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s=
_64_vio.c
> >>index 975f0ab..987f406 100644
> >>--- a/arch/powerpc/kvm/book3s_64_vio.c
> >>+++ b/arch/powerpc/kvm/book3s_64_vio.c
> >>@@ -14,6 +14,7 @@
> >>   *
> >>   * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
> >>   * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
> >>+ * Copyright 2016 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.c=
om>
> >>   */
> >>
> >>  #include <linux/types.h>
> >>@@ -37,8 +38,7 @@
> >>  #include <asm/kvm_host.h>
> >>  #include <asm/udbg.h>
> >>  #include <asm/iommu.h>
> >>-
> >>-#define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> >>+#include <asm/tce.h>
> >>
> >>  static unsigned long kvmppc_stt_npages(unsigned long window_size)
> >>  {
> >>@@ -200,3 +200,109 @@ fail:
> >>  	}
> >>  	return ret;
> >>  }
> >>+
> >>+long kvmppc_h_put_tce(struct kvm_vcpu *vcpu,
> >>+		unsigned long liobn, unsigned long ioba,
> >>+		unsigned long tce)
> >>+{
> >>+	long ret;
> >>+	struct kvmppc_spapr_tce_table *stt;
> >>+
> >>+	stt =3D kvmppc_find_table(vcpu, liobn);
> >>+	if (!stt)
> >>+		return H_TOO_HARD;
> >>+
> >>+	ret =3D kvmppc_ioba_validate(stt, ioba, 1);
> >>+	if (ret !=3D H_SUCCESS)
> >>+		return ret;
> >>+
> >>+	ret =3D kvmppc_tce_validate(stt, tce);
> >>+	if (ret !=3D H_SUCCESS)
> >>+		return ret;
> >>+
> >>+	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
> >>+
> >>+	return H_SUCCESS;
> >>+}
> >>+EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
> >>+
> >>+long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
> >>+		unsigned long liobn, unsigned long ioba,
> >>+		unsigned long tce_list, unsigned long npages)
> >>+{
> >>+	struct kvmppc_spapr_tce_table *stt;
> >>+	long i, ret =3D H_SUCCESS, idx;
> >>+	unsigned long entry, ua =3D 0;
> >>+	u64 __user *tces, tce;
> >>+
> >>+	stt =3D kvmppc_find_table(vcpu, liobn);
> >>+	if (!stt)
> >>+		return H_TOO_HARD;
> >>+
> >>+	entry =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> >>+	/*
> >>+	 * SPAPR spec says that the maximum size of the list is 512 TCEs
> >>+	 * so the whole table fits in 4K page
> >>+	 */
> >>+	if (npages > 512)
> >>+		return H_PARAMETER;
> >>+
> >>+	if (tce_list & (SZ_4K - 1))
> >>+		return H_PARAMETER;
> >>+
> >>+	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> >>+	if (ret !=3D H_SUCCESS)
> >>+		return ret;
> >>+
> >>+	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> >>+	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
> >>+		ret =3D H_TOO_HARD;
> >>+		goto unlock_exit;
> >>+	}
> >>+	tces =3D (u64 __user *) ua;
> >>+
> >>+	for (i =3D 0; i < npages; ++i) {
> >>+		if (get_user(tce, tces + i)) {
> >>+			ret =3D H_PARAMETER;
> >>+			goto unlock_exit;
> >>+		}
> >>+		tce =3D be64_to_cpu(tce);
> >>+
> >>+		ret =3D kvmppc_tce_validate(stt, tce);
> >>+		if (ret !=3D H_SUCCESS)
> >>+			goto unlock_exit;
> >>+
> >>+		kvmppc_tce_put(stt, entry + i, tce);
> >>+	}
> >>+
> >>+unlock_exit:
> >>+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> >>+
> >>+	return ret;
> >>+}
> >>+EXPORT_SYMBOL_GPL(kvmppc_h_put_tce_indirect);
> >>+
> >>+long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>+		unsigned long liobn, unsigned long ioba,
> >>+		unsigned long tce_value, unsigned long npages)
> >>+{
> >>+	struct kvmppc_spapr_tce_table *stt;
> >>+	long i, ret;
> >>+
> >>+	stt =3D kvmppc_find_table(vcpu, liobn);
> >>+	if (!stt)
> >>+		return H_TOO_HARD;
> >>+
> >>+	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> >>+	if (ret !=3D H_SUCCESS)
> >>+		return ret;
> >>+
> >>+	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
> >>+		return H_PARAMETER;
> >
> >Do we really need to allow no-permission but non-zero TCEs?
>=20
> Not sure, for debugging purposes one could want to poison the table. Tota=
lly
> useless?

Hmm, I guess.  Ok, leave it as is.

> >>+
> >>+	for (i =3D 0; i < npages; ++i, ioba +=3D IOMMU_PAGE_SIZE_4K)
> >>+		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
> >>+
> >>+	return H_SUCCESS;
> >>+}
> >>+EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
> >>diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/boo=
k3s_64_vio_hv.c
> >>index 8cd3a95..58c63ed 100644
> >>--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> >>+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> >>@@ -14,6 +14,7 @@
> >>   *
> >>   * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
> >>   * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
> >>+ * Copyright 2016 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.c=
om>
> >>   */
> >>
> >>  #include <linux/types.h>
> >>@@ -30,6 +31,7 @@
> >>  #include <asm/kvm_ppc.h>
> >>  #include <asm/kvm_book3s.h>
> >>  #include <asm/mmu-hash64.h>
> >>+#include <asm/mmu_context.h>
> >>  #include <asm/hvcall.h>
> >>  #include <asm/synch.h>
> >>  #include <asm/ppc-opcode.h>
> >>@@ -37,6 +39,7 @@
> >>  #include <asm/udbg.h>
> >>  #include <asm/iommu.h>
> >>  #include <asm/tce.h>
> >>+#include <asm/iommu.h>
> >>
> >>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> >>
> >>@@ -46,7 +49,7 @@
> >>   * WARNING: This will be called in real or virtual mode on HV KVM and=
 virtual
> >>   *          mode on PR KVM
> >>   */
> >>-static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcp=
u *vcpu,
> >>+struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
> >>  		unsigned long liobn)
> >>  {
> >>  	struct kvm *kvm =3D vcpu->kvm;
> >>@@ -58,6 +61,7 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_tab=
le(struct kvm_vcpu *vcpu,
> >>
> >>  	return NULL;
> >>  }
> >>+EXPORT_SYMBOL_GPL(kvmppc_find_table);
> >>
> >>  /*
> >>   * Validates IO address.
> >>@@ -150,11 +154,31 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table=
 *stt,
> >>  }
> >>  EXPORT_SYMBOL_GPL(kvmppc_tce_put);
> >>
> >>-/* WARNING: This will be called in real-mode on HV KVM and virtual
> >>- *          mode on PR KVM
> >>- */
> >>-long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> >>-		      unsigned long ioba, unsigned long tce)
> >>+long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
> >>+		unsigned long *ua, unsigned long **prmap)
> >>+{
> >>+	unsigned long gfn =3D gpa >> PAGE_SHIFT;
> >>+	struct kvm_memory_slot *memslot;
> >>+
> >>+	memslot =3D search_memslots(kvm_memslots(kvm), gfn);
> >>+	if (!memslot)
> >>+		return -EINVAL;
> >>+
> >>+	*ua =3D __gfn_to_hva_memslot(memslot, gfn) |
> >>+		(gpa & ~(PAGE_MASK | TCE_PCI_READ | TCE_PCI_WRITE));
> >>+
> >>+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> >
> >It's a bit odd to see a test for HV_POSSIBLE in a file named
> >book3s_64_vio_hv.c
>=20
>=20
> True, the file name should have probably been changed book3s_64_vio_rm.c.
>=20
>=20
> >
> >>+	if (prmap)
> >>+		*prmap =3D &memslot->arch.rmap[gfn - memslot->base_gfn];
> >>+#endif
> >>+
> >>+	return 0;
> >>+}
> >>+EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> >>+
> >>+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> >>+long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> >>+		unsigned long ioba, unsigned long tce)
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt =3D kvmppc_find_table(vcpu, liobn=
);
> >>  	long ret;
> >>@@ -177,7 +201,112 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsi=
gned long liobn,
> >>
> >>  	return H_SUCCESS;
> >>  }
> >>-EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
> >>+
> >>+static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
> >>+		unsigned long ua, unsigned long *phpa)
> >
> >ua should be a something __user * rather than an unsigned long.  And
> >come to that hpa should be a something * rather than an unsigned long.
>=20
>=20
> @ua is the return type of __gfn_to_hva_memslot() so I kept it. Also, the
> only place where I actually read from this address is the virtualmode's
> H_PUT_TCE_INDIRECT handler, all other places just do translation with it =
so
> making it "unsigned long" saves some type convertions. It is also used in
> mm_iommu_ua_to_hpa() which is in upstream now (commit 15b244a88e1b289, pa=
rt
> of DDW and preregistration patchset). Still need to change it?

Hmm, I guess not.

> Regarding @phpa, the agreement here that we use "void *" for 0xC000.... t=
ype
> of addresses; and we use "unsigned long" if top 4 bits are not set as
> dereferencing such pointers will normally fail.

Ah, yes, sorry, forgot that it was an HV physical addr, not an HV
virtual addr.

>=20
>=20
>=20
> >>+{
> >>+	pte_t *ptep, pte;
> >>+	unsigned shift =3D 0;
> >>+
> >>+	ptep =3D __find_linux_pte_or_hugepte(vcpu->arch.pgdir, ua, NULL, &shi=
ft);
> >>+	if (!ptep || !pte_present(*ptep))
> >>+		return -ENXIO;
> >>+	pte =3D *ptep;
> >>+
> >>+	if (!shift)
> >>+		shift =3D PAGE_SHIFT;
> >>+
> >>+	/* Avoid handling anything potentially complicated in realmode */
> >>+	if (shift > PAGE_SHIFT)
> >>+		return -EAGAIN;
> >>+
> >>+	if (!pte_young(pte))
> >>+		return -EAGAIN;
> >>+
> >>+	*phpa =3D (pte_pfn(pte) << PAGE_SHIFT) | (ua & ((1ULL << shift) - 1))=
 |
> >>+			(ua & ~PAGE_MASK);
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>+long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
> >>+		unsigned long liobn, unsigned long ioba,
> >>+		unsigned long tce_list,	unsigned long npages)
> >>+{
> >>+	struct kvmppc_spapr_tce_table *stt;
> >>+	long i, ret =3D H_SUCCESS;
> >>+	unsigned long tces, entry, ua =3D 0;
> >>+	unsigned long *rmap =3D NULL;
> >>+
> >>+	stt =3D kvmppc_find_table(vcpu, liobn);
> >>+	if (!stt)
> >>+		return H_TOO_HARD;
> >>+
> >>+	entry =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> >>+	/*
> >>+	 * The spec says that the maximum size of the list is 512 TCEs
> >>+	 * so the whole table addressed resides in 4K page
> >>+	 */
> >>+	if (npages > 512)
> >>+		return H_PARAMETER;
> >>+
> >>+	if (tce_list & (SZ_4K - 1))
> >>+		return H_PARAMETER;
> >>+
> >>+	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> >>+	if (ret !=3D H_SUCCESS)
> >>+		return ret;
> >>+
> >>+	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> >>+		return H_TOO_HARD;
> >>+
> >>+	rmap =3D (void *) vmalloc_to_phys(rmap);
> >>+
> >>+	lock_rmap(rmap);
> >>+	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> >>+		ret =3D H_TOO_HARD;
> >>+		goto unlock_exit;
> >>+	}
> >>+
> >>+	for (i =3D 0; i < npages; ++i) {
> >>+		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
> >>+
> >>+		ret =3D kvmppc_tce_validate(stt, tce);
> >>+		if (ret !=3D H_SUCCESS)
> >>+			goto unlock_exit;
> >>+
> >>+		kvmppc_tce_put(stt, entry + i, tce);
> >>+	}
> >>+
> >>+unlock_exit:
> >>+	unlock_rmap(rmap);
> >>+
> >>+	return ret;
> >>+}
> >>+
> >>+long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
> >>+		unsigned long liobn, unsigned long ioba,
> >>+		unsigned long tce_value, unsigned long npages)
> >
> >Unlike put_indirect, this code appears to be identical to the non
> >realmode code - can you combine them?
>=20
>=20
> It is at this point but this will get different bits in "KVM: PPC: vfio k=
vm
> device: support spapr tce" later, may be sometime later I will manage to =
get
> to that part, eventually...

I think I'd prefer to see them split only in the patch that actually
makes them different.

>=20
>=20
> >>+{
> >>+	struct kvmppc_spapr_tce_table *stt;
> >>+	long i, ret;
> >>+
> >>+	stt =3D kvmppc_find_table(vcpu, liobn);
> >>+	if (!stt)
> >>+		return H_TOO_HARD;
> >>+
> >>+	ret =3D kvmppc_ioba_validate(stt, ioba, npages);
> >>+	if (ret !=3D H_SUCCESS)
> >>+		return ret;
> >>+
> >>+	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
> >>+		return H_PARAMETER;
> >>+
> >>+	for (i =3D 0; i < npages; ++i, ioba +=3D IOMMU_PAGE_SIZE_4K)
> >>+		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
> >>+
> >>+	return H_SUCCESS;
> >>+}
> >>
> >>  long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> >>  		unsigned long ioba)
> >>@@ -204,3 +333,5 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsign=
ed long liobn,
> >>  	return H_SUCCESS;
> >>  }
> >>  EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);
> >>+
> >>+#endif /* KVM_BOOK3S_HV_POSSIBLE */
> >>diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> >>index cff207b..df3fbae 100644
> >>--- a/arch/powerpc/kvm/book3s_hv.c
> >>+++ b/arch/powerpc/kvm/book3s_hv.c
> >>@@ -768,7 +768,31 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
> >>  		if (kvmppc_xics_enabled(vcpu)) {
> >>  			ret =3D kvmppc_xics_hcall(vcpu, req);
> >>  			break;
> >>-		} /* fallthrough */
> >>+		}
> >>+		return RESUME_HOST;
> >>+	case H_PUT_TCE:
> >>+		ret =3D kvmppc_h_put_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
> >>+						kvmppc_get_gpr(vcpu, 5),
> >>+						kvmppc_get_gpr(vcpu, 6));
> >>+		if (ret =3D=3D H_TOO_HARD)
> >>+			return RESUME_HOST;
> >>+		break;
> >>+	case H_PUT_TCE_INDIRECT:
> >>+		ret =3D kvmppc_h_put_tce_indirect(vcpu, kvmppc_get_gpr(vcpu, 4),
> >>+						kvmppc_get_gpr(vcpu, 5),
> >>+						kvmppc_get_gpr(vcpu, 6),
> >>+						kvmppc_get_gpr(vcpu, 7));
> >>+		if (ret =3D=3D H_TOO_HARD)
> >>+			return RESUME_HOST;
> >>+		break;
> >>+	case H_STUFF_TCE:
> >>+		ret =3D kvmppc_h_stuff_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
> >>+						kvmppc_get_gpr(vcpu, 5),
> >>+						kvmppc_get_gpr(vcpu, 6),
> >>+						kvmppc_get_gpr(vcpu, 7));
> >>+		if (ret =3D=3D H_TOO_HARD)
> >>+			return RESUME_HOST;
> >>+		break;
> >>  	default:
> >>  		return RESUME_HOST;
> >>  	}
> >>diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm=
/book3s_hv_rmhandlers.S
> >>index 3c6badc..3bf6e72 100644
> >>--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> >>+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> >>@@ -1928,7 +1928,7 @@ hcall_real_table:
> >>  	.long	DOTSYM(kvmppc_h_clear_ref) - hcall_real_table
> >>  	.long	DOTSYM(kvmppc_h_protect) - hcall_real_table
> >>  	.long	DOTSYM(kvmppc_h_get_tce) - hcall_real_table
> >>-	.long	DOTSYM(kvmppc_h_put_tce) - hcall_real_table
> >>+	.long	DOTSYM(kvmppc_rm_h_put_tce) - hcall_real_table
> >>  	.long	0		/* 0x24 - H_SET_SPRG0 */
> >>  	.long	DOTSYM(kvmppc_h_set_dabr) - hcall_real_table
> >>  	.long	0		/* 0x2c */
> >>@@ -2006,8 +2006,8 @@ hcall_real_table:
> >>  	.long	0		/* 0x12c */
> >>  	.long	0		/* 0x130 */
> >>  	.long	DOTSYM(kvmppc_h_set_xdabr) - hcall_real_table
> >>-	.long	0		/* 0x138 */
> >>-	.long	0		/* 0x13c */
> >>+	.long	DOTSYM(kvmppc_rm_h_stuff_tce) - hcall_real_table
> >>+	.long	DOTSYM(kvmppc_rm_h_put_tce_indirect) - hcall_real_table
> >>  	.long	0		/* 0x140 */
> >>  	.long	0		/* 0x144 */
> >>  	.long	0		/* 0x148 */
> >>diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3=
s_pr_papr.c
> >>index f2c75a1..02176fd 100644
> >>--- a/arch/powerpc/kvm/book3s_pr_papr.c
> >>+++ b/arch/powerpc/kvm/book3s_pr_papr.c
> >>@@ -280,6 +280,37 @@ static int kvmppc_h_pr_logical_ci_store(struct kvm=
_vcpu *vcpu)
> >>  	return EMULATE_DONE;
> >>  }
> >>
> >>+static int kvmppc_h_pr_put_tce_indirect(struct kvm_vcpu *vcpu)
> >>+{
> >>+	unsigned long liobn =3D kvmppc_get_gpr(vcpu, 4);
> >>+	unsigned long ioba =3D kvmppc_get_gpr(vcpu, 5);
> >>+	unsigned long tce =3D kvmppc_get_gpr(vcpu, 6);
> >>+	unsigned long npages =3D kvmppc_get_gpr(vcpu, 7);
> >>+	long rc;
> >>+
> >>+	rc =3D kvmppc_h_put_tce_indirect(vcpu, liobn, ioba,
> >>+			tce, npages);
> >>+	if (rc =3D=3D H_TOO_HARD)
> >>+		return EMULATE_FAIL;
> >>+	kvmppc_set_gpr(vcpu, 3, rc);
> >>+	return EMULATE_DONE;
> >>+}
> >>+
> >>+static int kvmppc_h_pr_stuff_tce(struct kvm_vcpu *vcpu)
> >>+{
> >>+	unsigned long liobn =3D kvmppc_get_gpr(vcpu, 4);
> >>+	unsigned long ioba =3D kvmppc_get_gpr(vcpu, 5);
> >>+	unsigned long tce_value =3D kvmppc_get_gpr(vcpu, 6);
> >>+	unsigned long npages =3D kvmppc_get_gpr(vcpu, 7);
> >>+	long rc;
> >>+
> >>+	rc =3D kvmppc_h_stuff_tce(vcpu, liobn, ioba, tce_value, npages);
> >>+	if (rc =3D=3D H_TOO_HARD)
> >>+		return EMULATE_FAIL;
> >>+	kvmppc_set_gpr(vcpu, 3, rc);
> >>+	return EMULATE_DONE;
> >>+}
> >>+
> >>  static int kvmppc_h_pr_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd)
> >>  {
> >>  	long rc =3D kvmppc_xics_hcall(vcpu, cmd);
> >>@@ -306,6 +337,10 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned lo=
ng cmd)
> >>  		return kvmppc_h_pr_bulk_remove(vcpu);
> >>  	case H_PUT_TCE:
> >>  		return kvmppc_h_pr_put_tce(vcpu);
> >>+	case H_PUT_TCE_INDIRECT:
> >>+		return kvmppc_h_pr_put_tce_indirect(vcpu);
> >>+	case H_STUFF_TCE:
> >>+		return kvmppc_h_pr_stuff_tce(vcpu);
> >>  	case H_CEDE:
> >>  		kvmppc_set_msr_fast(vcpu, kvmppc_get_msr(vcpu) | MSR_EE);
> >>  		kvm_vcpu_block(vcpu);
> >>diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> >>index 6fd2405..164735c 100644
> >>--- a/arch/powerpc/kvm/powerpc.c
> >>+++ b/arch/powerpc/kvm/powerpc.c
> >>@@ -569,6 +569,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
> >>  	case KVM_CAP_PPC_GET_SMMU_INFO:
> >>  		r =3D 1;
> >>  		break;
> >>+	case KVM_CAP_SPAPR_MULTITCE:
> >>+		r =3D 1;
> >>+		break;
> >
> >Hmm, usual practice has been not to enable new KVM hcalls, unless
> >userspace (qemu) explicitly enables them with ENABLE_HCALL.  I don't
> >see an obvious way this extension could break, but it's probably
> >safest to continue that pattern.
>=20
>=20
> This advertises the capability but does not enable it, this is still
> required in QEMU:
>=20
> ret =3D kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_ENABLE_HCALL, 0,
>                         H_PUT_TCE_INDIRECT, 1);
> ret =3D kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_ENABLE_HCALL, 0,
>                         H_STUFF_TCE, 1);
>=20
> as multi-tce hcalls are not in the default_hcall_list list in
> arch/powerpc/kvm/book3s_hv.c.

Ah, right, sorry.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpbDiAAoJEGw4ysog2bOS98oQAIpeMF/NEhWzzsXpBX2X1bUG
ZBBCUf9ogLtaWwgJBdFE0h7OwQs8J+ZOabiuBTNR8s9RANgicnS8Z/u1Cbf17PW/
HZQyAPErGZMGJfUDKbVe09Yr0/Y3XPLVVFknY9/FiqnbpsJkpBkwY/v1s9AyP0dM
oVixGOrgy4nLwTF/3ITOoceY5f9aSQibb6fKM+8KLxl8B4MeP5hWPIsfP9hWYjLc
qk159IkwQXZg/Px99O5qAwX1wjd8EaIImTOAkZDOx3Q1qciU9EEmJMw7WRncDLeC
wBrTjW4YWLnW8TnI9tJ9kQTGoh230rFnD+aan/vLBz4GnHex+csCIACg5H+i/Jok
ybAfx5U0YF6a2IjBjqUMSIZ+xgVqo+ihv5mZ61nJVytMsj58oDL3Q68B+nm7CP6c
/wmxIOrELWn9hEh/x9MbednS1k3223WlHeGB2y7UJGMRfJe93hzjziop5ep2wX/A
4GwttC7n1gkH/QcDbmeZvuXrTaYC8ci38r6DFZ3ZbMIsC/bxH5FB57oL+MTNuDyR
Qq9oBo0eCLZzjKw/hAIMTXsIN8+1L791/f4qND4/qF27KXggS2pNnMKQP61UBoId
KbZAWvv7ztjuYxUHhrU9PTcayrJwNWC4Zt80QoHQvZcCjrqBNtFvKVQsn6PfJFO0
lKdjnHCVEzOXqiOLQTJf
=b0+p
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
