Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD42E1A011E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 17:33:01 +1100 (AEDT)
Date: Tue, 8 Mar 2016 17:30:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 3/9] KVM: PPC: Use preregistered memory API to
 access TCE list
Message-ID: <20160308063018.GA22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-4-git-send-email-aik@ozlabs.ru>
 <20160307060014.GL22546@voom.fritz.box>
 <56DE6768.4030202@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="d6nDKxlhctiV7bVq"
In-Reply-To: <56DE6768.4030202@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--d6nDKxlhctiV7bVq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 08, 2016 at 04:47:20PM +1100, Alexey Kardashevskiy wrote:
> On 03/07/2016 05:00 PM, David Gibson wrote:
> >On Mon, Mar 07, 2016 at 02:41:11PM +1100, Alexey Kardashevskiy wrote:
> >>VFIO on sPAPR already implements guest memory pre-registration
> >>when the entire guest RAM gets pinned. This can be used to translate
> >>the physical address of a guest page containing the TCE list
> >>from H_PUT_TCE_INDIRECT.
> >>
> >>This makes use of the pre-registrered memory API to access TCE list
> >>pages in order to avoid unnecessary locking on the KVM memory
> >>reverse map.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >
> >Ok.. so, what's the benefit of not having to lock the rmap?
>=20
> Less locking -> less racing =3D=3D good, no?

Well.. maybe.  The increased difficulty in verifying that the code is
correct isn't always a good price to pay.

> >>---
> >>  arch/powerpc/kvm/book3s_64_vio_hv.c | 86 ++++++++++++++++++++++++++++=
++-------
> >>  1 file changed, 70 insertions(+), 16 deletions(-)
> >>
> >>diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/boo=
k3s_64_vio_hv.c
> >>index 44be73e..af155f6 100644
> >>--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> >>+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> >>@@ -180,6 +180,38 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned lo=
ng gpa,
> >>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> >>
> >>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> >>+static mm_context_t *kvmppc_mm_context(struct kvm_vcpu *vcpu)
> >>+{
> >>+	struct task_struct *task;
> >>+
> >>+	task =3D vcpu->arch.run_task;
> >>+	if (unlikely(!task || !task->mm))
> >>+		return NULL;
> >>+
> >>+	return &task->mm->context;
> >>+}
> >>+
> >>+static inline bool kvmppc_preregistered(struct kvm_vcpu *vcpu)
> >>+{
> >>+	mm_context_t *mm =3D kvmppc_mm_context(vcpu);
> >>+
> >>+	if (unlikely(!mm))
> >>+		return false;
> >>+
> >>+	return mm_iommu_preregistered(mm);
> >>+}
> >>+
> >>+static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
> >>+		struct kvm_vcpu *vcpu, unsigned long ua, unsigned long size)
> >>+{
> >>+	mm_context_t *mm =3D kvmppc_mm_context(vcpu);
> >>+
> >>+	if (unlikely(!mm))
> >>+		return NULL;
> >>+
> >>+	return mm_iommu_lookup_rm(mm, ua, size);
> >>+}
> >>+
> >>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> >>  		      unsigned long ioba, unsigned long tce)
> >>  {
> >>@@ -261,23 +293,44 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu=
 *vcpu,
> >>  	if (ret !=3D H_SUCCESS)
> >>  		return ret;
> >>
> >>-	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> >>-		return H_TOO_HARD;
> >>+	if (kvmppc_preregistered(vcpu)) {
> >>+		/*
> >>+		 * We get here if guest memory was pre-registered which
> >>+		 * is normally VFIO case and gpa->hpa translation does not
> >>+		 * depend on hpt.
> >>+		 */
> >>+		struct mm_iommu_table_group_mem_t *mem;
> >>
> >>-	rmap =3D (void *) vmalloc_to_phys(rmap);
> >>+		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
> >>+			return H_TOO_HARD;
> >>
> >>-	/*
> >>-	 * Synchronize with the MMU notifier callbacks in
> >>-	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> >>-	 * While we have the rmap lock, code running on other CPUs
> >>-	 * cannot finish unmapping the host real page that backs
> >>-	 * this guest real page, so we are OK to access the host
> >>-	 * real page.
> >>-	 */
> >>-	lock_rmap(rmap);
> >>-	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> >>-		ret =3D H_TOO_HARD;
> >>-		goto unlock_exit;
> >>+		mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
> >>+		if (!mem || mm_iommu_rm_ua_to_hpa(mem, ua, &tces))
> >>+			return H_TOO_HARD;
> >>+	} else {
> >>+		/*
> >>+		 * This is emulated devices case.
> >>+		 * We do not require memory to be preregistered in this case
> >>+		 * so lock rmap and do __find_linux_pte_or_hugepte().
> >>+		 */
> >>+		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> >>+			return H_TOO_HARD;
> >>+
> >>+		rmap =3D (void *) vmalloc_to_phys(rmap);
> >>+
> >>+		/*
> >>+		 * Synchronize with the MMU notifier callbacks in
> >>+		 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> >>+		 * While we have the rmap lock, code running on other CPUs
> >>+		 * cannot finish unmapping the host real page that backs
> >>+		 * this guest real page, so we are OK to access the host
> >>+		 * real page.
> >>+		 */
> >>+		lock_rmap(rmap);
> >>+		if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> >>+			ret =3D H_TOO_HARD;
> >>+			goto unlock_exit;
> >>+		}
> >>  	}
> >>
> >>  	for (i =3D 0; i < npages; ++i) {
> >>@@ -291,7 +344,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *=
vcpu,
> >>  	}
> >>
> >>  unlock_exit:
> >>-	unlock_rmap(rmap);
> >>+	if (rmap)
> >
> >I don't see where rmap is initialized to NULL in the case where it's
> >not being used.
>=20
> @rmap is not new to this function, and it has always been initialized to
> NULL as it was returned via a pointer from kvmppc_gpa_to_ua().

This comment confuses me.  Looking closer at the code I see you're
right, and it's initialized to NULL where defined, which I missed.

But that has nothing to do with being returned by pointer from
kvmppc_gpa_to_ua(), since one of your branches in the new code no
longer passes &rmap to that function.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6nDKxlhctiV7bVq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3nF6AAoJEGw4ysog2bOS5LYQALQ+R+kAfdrutuioHcM0sczb
tkVIBfFz50XWkxXxTy7CVnbIlwT/OzbLwuWzwYKq26iFmJ+OGQU2DlAAWOc+StqP
k8YqlSWGxmO2E/gJyM8bIto8LN2pgMyKEjlSRH65srDu9bt4EQ4NMxx0pxxPSepw
IguK58rMx7Ojl51Il0bpoM4JTpRY/ZIqU+FFZ5018lg2WW+n0UgJbNvUxAqyViyG
HKG1B9iDG0A9q2bcjM6xp0MzqwHyOQlniexngEWR9ZJIPpXggIx1Ym4QZ080/1Np
1qn399pQWiSmj2kbWLbK9ngWUmOeN9YRNqgYgeGeID/KTS0I+YTg4UD/CsUVPeSV
99OeLTmbJz+vrF3PSpVJRkzEmy0W59yWHUpb++xr+dfU4X45ZnqPjTIcU4TiPYCx
cYBUXAAhhXBYmpYZnp9koU7C6Z9z9NDO3fuuaXdjqEmJn9MUcaPoddNUytxyIuby
zGIXTNBT84HOR6LEx5mwACjNq60AdYXr4tfLIu3BX20+8BxpXRORDKrtMxVgfycP
b7C2Y0bZqx+X13+vG4G0HfxVDVTMzSkezAEHkRoXoHz6Z3yLnKnpMhCDvSwB6W27
s6mFaWNVie/6k45E6Z+K0wLZv4Y51yGIytHEKeWWk4QZnk3J+2VV9EoMv1KRFrbT
+5jmqGOwnI2rs4NMa5nP
=zsBl
-----END PGP SIGNATURE-----

--d6nDKxlhctiV7bVq--
