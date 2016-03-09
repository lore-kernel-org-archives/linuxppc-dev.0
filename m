Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF6E21A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 10:52:28 +1100 (AEDT)
Date: Thu, 10 Mar 2016 10:46:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 3/9] KVM: PPC: Use preregistered memory API to
 access TCE list
Message-ID: <20160309234627.GP22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-4-git-send-email-aik@ozlabs.ru>
 <20160307060014.GL22546@voom.fritz.box>
 <56DE6768.4030202@ozlabs.ru>
 <20160308063018.GA22546@voom.fritz.box>
 <56DFE519.6040605@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/F2XdnRjS8y2HUtp"
In-Reply-To: <56DFE519.6040605@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/F2XdnRjS8y2HUtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 07:55:53PM +1100, Alexey Kardashevskiy wrote:
> On 03/08/2016 05:30 PM, David Gibson wrote:
> >On Tue, Mar 08, 2016 at 04:47:20PM +1100, Alexey Kardashevskiy wrote:
> >>On 03/07/2016 05:00 PM, David Gibson wrote:
> >>>On Mon, Mar 07, 2016 at 02:41:11PM +1100, Alexey Kardashevskiy wrote:
> >>>>VFIO on sPAPR already implements guest memory pre-registration
> >>>>when the entire guest RAM gets pinned. This can be used to translate
> >>>>the physical address of a guest page containing the TCE list
> >>>>from H_PUT_TCE_INDIRECT.
> >>>>
> >>>>This makes use of the pre-registrered memory API to access TCE list
> >>>>pages in order to avoid unnecessary locking on the KVM memory
> >>>>reverse map.
> >>>>
> >>>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>
> >>>Ok.. so, what's the benefit of not having to lock the rmap?
> >>
> >>Less locking -> less racing =3D=3D good, no?
> >
> >Well.. maybe.  The increased difficulty in verifying that the code is
> >correct isn't always a good price to pay.
> >
> >>>>---
> >>>>  arch/powerpc/kvm/book3s_64_vio_hv.c | 86 ++++++++++++++++++++++++++=
++++-------
> >>>>  1 file changed, 70 insertions(+), 16 deletions(-)
> >>>>
> >>>>diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/b=
ook3s_64_vio_hv.c
> >>>>index 44be73e..af155f6 100644
> >>>>--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> >>>>+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> >>>>@@ -180,6 +180,38 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned =
long gpa,
> >>>>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> >>>>
> >>>>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> >>>>+static mm_context_t *kvmppc_mm_context(struct kvm_vcpu *vcpu)
> >>>>+{
> >>>>+	struct task_struct *task;
> >>>>+
> >>>>+	task =3D vcpu->arch.run_task;
> >>>>+	if (unlikely(!task || !task->mm))
> >>>>+		return NULL;
> >>>>+
> >>>>+	return &task->mm->context;
> >>>>+}
> >>>>+
> >>>>+static inline bool kvmppc_preregistered(struct kvm_vcpu *vcpu)
> >>>>+{
> >>>>+	mm_context_t *mm =3D kvmppc_mm_context(vcpu);
> >>>>+
> >>>>+	if (unlikely(!mm))
> >>>>+		return false;
> >>>>+
> >>>>+	return mm_iommu_preregistered(mm);
> >>>>+}
> >>>>+
> >>>>+static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
> >>>>+		struct kvm_vcpu *vcpu, unsigned long ua, unsigned long size)
> >>>>+{
> >>>>+	mm_context_t *mm =3D kvmppc_mm_context(vcpu);
> >>>>+
> >>>>+	if (unlikely(!mm))
> >>>>+		return NULL;
> >>>>+
> >>>>+	return mm_iommu_lookup_rm(mm, ua, size);
> >>>>+}
> >>>>+
> >>>>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> >>>>  		      unsigned long ioba, unsigned long tce)
> >>>>  {
> >>>>@@ -261,23 +293,44 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vc=
pu *vcpu,
> >>>>  	if (ret !=3D H_SUCCESS)
> >>>>  		return ret;
> >>>>
> >>>>-	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> >>>>-		return H_TOO_HARD;
> >>>>+	if (kvmppc_preregistered(vcpu)) {
> >>>>+		/*
> >>>>+		 * We get here if guest memory was pre-registered which
> >>>>+		 * is normally VFIO case and gpa->hpa translation does not
> >>>>+		 * depend on hpt.
> >>>>+		 */
> >>>>+		struct mm_iommu_table_group_mem_t *mem;
> >>>>
> >>>>-	rmap =3D (void *) vmalloc_to_phys(rmap);
> >>>>+		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
> >>>>+			return H_TOO_HARD;
> >>>>
> >>>>-	/*
> >>>>-	 * Synchronize with the MMU notifier callbacks in
> >>>>-	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> >>>>-	 * While we have the rmap lock, code running on other CPUs
> >>>>-	 * cannot finish unmapping the host real page that backs
> >>>>-	 * this guest real page, so we are OK to access the host
> >>>>-	 * real page.
> >>>>-	 */
> >>>>-	lock_rmap(rmap);
> >>>>-	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> >>>>-		ret =3D H_TOO_HARD;
> >>>>-		goto unlock_exit;
> >>>>+		mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
> >>>>+		if (!mem || mm_iommu_rm_ua_to_hpa(mem, ua, &tces))
> >>>>+			return H_TOO_HARD;
> >>>>+	} else {
> >>>>+		/*
> >>>>+		 * This is emulated devices case.
> >>>>+		 * We do not require memory to be preregistered in this case
> >>>>+		 * so lock rmap and do __find_linux_pte_or_hugepte().
> >>>>+		 */
> >>>>+		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> >>>>+			return H_TOO_HARD;
> >>>>+
> >>>>+		rmap =3D (void *) vmalloc_to_phys(rmap);
> >>>>+
> >>>>+		/*
> >>>>+		 * Synchronize with the MMU notifier callbacks in
> >>>>+		 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> >>>>+		 * While we have the rmap lock, code running on other CPUs
> >>>>+		 * cannot finish unmapping the host real page that backs
> >>>>+		 * this guest real page, so we are OK to access the host
> >>>>+		 * real page.
> >>>>+		 */
> >>>>+		lock_rmap(rmap);
> >>>>+		if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> >>>>+			ret =3D H_TOO_HARD;
> >>>>+			goto unlock_exit;
> >>>>+		}
> >>>>  	}
> >>>>
> >>>>  	for (i =3D 0; i < npages; ++i) {
> >>>>@@ -291,7 +344,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu=
 *vcpu,
> >>>>  	}
> >>>>
> >>>>  unlock_exit:
> >>>>-	unlock_rmap(rmap);
> >>>>+	if (rmap)
> >>>
> >>>I don't see where rmap is initialized to NULL in the case where it's
> >>>not being used.
> >>
> >>@rmap is not new to this function, and it has always been initialized to
> >>NULL as it was returned via a pointer from kvmppc_gpa_to_ua().
> >
> >This comment confuses me.  Looking closer at the code I see you're
> >right, and it's initialized to NULL where defined, which I missed.
> >
> >But that has nothing to do with being returned by pointer from
> >kvmppc_gpa_to_ua(), since one of your branches in the new code no
> >longer passes &rmap to that function.
>=20
>=20
> So? The code is still correct - the "preregistered branch" does not touch
> NULL pointer, it remains NULL and unlock_rmap() is not called. I agree the
> patch is not the easiest to read but how can I improve it to get your "rb=
"?
> Replace "if(rmap)" with "if (kvmppc_preregistered(vcpu))"? Move that loop
> between lock_rmap/unlock_rmap to a helper? kvmppc_rm_h_put_tce_indirect()=
 is
> not big enough to justify splitting, the comments inside it are though...

Sorry, I wasn't clear.  I no longer have a specific objection.  I left
out the R-b, since there have been enough other comments on the series
that I was expecting a respin, so I was planning to re-review in the
context of an updated series.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/F2XdnRjS8y2HUtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW4LXTAAoJEGw4ysog2bOSegsP/jloquu9dTStOnyIb3UzFbHi
4cF+XC9cBmFY44NeYtNHN4/wdHNXsU7KXV1lGfGFVxwcNssxUYdnCUwbB4C8bnEE
J/kTQ0Au/vJrNGt+ZwnV9S6T1b8hleS/rQvY9Lr5nsXG8iv6vR1EFRoIPzYL+nXG
J0SxWIys/4RtMBy5U2HYuCP2lWkG1chjZerghWH/iynzHTA6Lxin+4fiNDimP+0v
6ADa/dDxVKfjHbi1qAS1rVuXQoWxWdfbXpUiyOApHdS4rjRje8swGbw/3hl28hxn
gpegBF9Wtd15OgAXpwD2iTaKYZ6x+Ou331zzIvzpPy/ADhbbQEInPHblyDSzE1SE
ZqbHb5gb7BP8CyLOxcRxC26tETKaKNfZKt9A+S8U7Nejco3J5kjaiqzteFlU0RCP
m3atV2Awa4C0Y8VofpnkvctYbWjP5qjIf31dW77AybUH5uxxvNKDNQ5IP5vT2DP6
hIpTS4DMD2PE1sr524CMErW/DDOjfeftkqBZVQ0hS6QeoEahqP+wFIPzT6i2TrNS
lVFo233tcUbw3xEsQPgj+wmv4xLMvvW8vV8R7Ml44y6IYhZlb64mFBsE0iOM0Wnw
7mc7fDwiQgZIb/ePO+vvnSpDV9blW1QSGQ8AHzoi9zsjpRvkxIsp90gxOGwM4TLn
R/+BncT4h3w+UeEpk7QX
=xEMT
-----END PGP SIGNATURE-----

--/F2XdnRjS8y2HUtp--
