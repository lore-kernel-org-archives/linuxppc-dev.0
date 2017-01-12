Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzZbf2D5XzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 16:50:06 +1100 (AEDT)
Date: Thu, 12 Jan 2017 16:49:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 05/11] KVM: PPC: Use preregistered memory API
 to access TCE list
Message-ID: <20170112054959.GR14026@umbus.fritz.box>
References: <20161218012900.18142-1-aik@ozlabs.ru>
 <20161218012900.18142-6-aik@ozlabs.ru>
 <20161221040843.GD13024@umbus.fritz.box>
 <ef7b6306-a403-390f-ac25-5cffd546d66b@ozlabs.ru>
 <342e6541-7d92-fe4b-cb3a-8ab4cd3b6e02@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zsAhXfiBV62A5hVr"
In-Reply-To: <342e6541-7d92-fe4b-cb3a-8ab4cd3b6e02@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zsAhXfiBV62A5hVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2017 at 05:35:21PM +1100, Alexey Kardashevskiy wrote:
> On 21/12/16 19:57, Alexey Kardashevskiy wrote:
> > On 21/12/16 15:08, David Gibson wrote:
> >> On Sun, Dec 18, 2016 at 12:28:54PM +1100, Alexey Kardashevskiy wrote:
> >>> VFIO on sPAPR already implements guest memory pre-registration
> >>> when the entire guest RAM gets pinned. This can be used to translate
> >>> the physical address of a guest page containing the TCE list
> >>> from H_PUT_TCE_INDIRECT.
> >>>
> >>> This makes use of the pre-registrered memory API to access TCE list
> >>> pages in order to avoid unnecessary locking on the KVM memory
> >>> reverse map as we know that all of guest memory is pinned and
> >>> we have a flat array mapping GPA to HPA which makes it simpler and
> >>> quicker to index into that array (even with looking up the
> >>> kernel page tables in vmalloc_to_phys) than it is to find the memslot,
> >>> lock the rmap entry, look up the user page tables, and unlock the rmap
> >>> entry. Note that the rmap pointer is initialized to NULL
> >>> where declared (not in this patch).
> >>>
> >>> If a requested chunk of memory has not been preregistered,
> >>> this will fail with H_TOO_HARD so the virtual mode handle can
> >>> handle the request.
> >>>
> >>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>> ---
> >>> Changes:
> >>> v2:
> >>> * updated the commit log with David's comment
> >>> ---
> >>>  arch/powerpc/kvm/book3s_64_vio_hv.c | 65 +++++++++++++++++++++++++++=
+---------
> >>>  1 file changed, 49 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/b=
ook3s_64_vio_hv.c
> >>> index d461c440889a..a3be4bd6188f 100644
> >>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> >>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> >>> @@ -180,6 +180,17 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned =
long gpa,
> >>>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> >>> =20
> >>>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> >>> +static inline bool kvmppc_preregistered(struct kvm_vcpu *vcpu)
> >>> +{
> >>> +	return mm_iommu_preregistered(vcpu->kvm->mm);
> >>> +}
> >>> +
> >>> +static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
> >>> +		struct kvm_vcpu *vcpu, unsigned long ua, unsigned long size)
> >>> +{
> >>> +	return mm_iommu_lookup_rm(vcpu->kvm->mm, ua, size);
> >>> +}
> >>
> >> I don't see that there's much point to these inlines.
> >>
> >>>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
> >>>  		unsigned long ioba, unsigned long tce)
> >>>  {
> >>> @@ -260,23 +271,44 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vc=
pu *vcpu,
> >>>  	if (ret !=3D H_SUCCESS)
> >>>  		return ret;
> >>> =20
> >>> -	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> >>> -		return H_TOO_HARD;
> >>> +	if (kvmppc_preregistered(vcpu)) {
> >>> +		/*
> >>> +		 * We get here if guest memory was pre-registered which
> >>> +		 * is normally VFIO case and gpa->hpa translation does not
> >>> +		 * depend on hpt.
> >>> +		 */
> >>> +		struct mm_iommu_table_group_mem_t *mem;
> >>> =20
> >>> -	rmap =3D (void *) vmalloc_to_phys(rmap);
> >>> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
> >>> +			return H_TOO_HARD;
> >>> =20
> >>> -	/*
> >>> -	 * Synchronize with the MMU notifier callbacks in
> >>> -	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> >>> -	 * While we have the rmap lock, code running on other CPUs
> >>> -	 * cannot finish unmapping the host real page that backs
> >>> -	 * this guest real page, so we are OK to access the host
> >>> -	 * real page.
> >>> -	 */
> >>> -	lock_rmap(rmap);
> >>> -	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> >>> -		ret =3D H_TOO_HARD;
> >>> -		goto unlock_exit;
> >>> +		mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
> >>> +		if (!mem || mm_iommu_ua_to_hpa_rm(mem, ua, &tces))
> >>> +			return H_TOO_HARD;
> >>> +	} else {
> >>> +		/*
> >>> +		 * This is emulated devices case.
> >>> +		 * We do not require memory to be preregistered in this case
> >>> +		 * so lock rmap and do __find_linux_pte_or_hugepte().
> >>> +		 */
> >>
> >> Hmm.  So this isn't wrong as such, but the logic and comments are
> >> both misleading.  The 'if' here isn't really about VFIO vs. emulated -
> >> it's about whether the mm has *any* preregistered chunks, without any
> >> regard to which particular device you're talking about.  For example
> >> if your guest has two PHBs, one with VFIO devices and the other with
> >> emulated devices, then the emulated devices will still go through the
> >> "VFIO" case here.
> >=20
> > kvmppc_preregistered() checks for a single pointer, kvmppc_rm_ua_to_hpa=
()
> > goes through __find_linux_pte_or_hugepte() which is unnecessary
> > complication here.

Except that you're going to call kvmppc_rm_ua_to_hpa() eventually anyway.

> > s/emulated devices case/case of a guest with emulated devices
> only/ ?

Changing that in the comments would help, yes.

> >=20
> >=20
> >> Really what you have here is a fast case when the tce_list is in
> >> preregistered memory, and a fallback case when it isn't.  But that's
> >> obscured by the fact that if for whatever reason you have some
> >> preregistered memory but it doesn't cover the tce_list, then you don't
> >> go to the fallback case here, but instead fall right back to the
> >> virtual mode handler.
> >=20
> > This is purely acceleration, I am trying to make obvious cases faster, =
and
> > other cases safer. If some chunk is not preregistered but others are and
> > there is H_PUT_TCE_INDIRECT with tce_list from non-preregistered memory,
> > then I have no idea what this userspace is and what it is doing, so I j=
ust
> > do not want to accelerate anything for it in real mode (I have poor
> > imagination and since I cannot test it - I better drop it).

You have this all backwards.  The kernel SHOULD NOT have a
preconceived idea of what userspace is and how it's using the kernel
facilities.  It should just provide the kernel interfaces with their
defined semantics, and userspace can use them however it wants.

This is a frequent cause of problems in your patches: you base
comments and code around what you imagine to be the usage model in
userspace.  This makes the comments misleading, and the code fragile
against future changes in use cases.  Userspace and the kernel should
always be isolated from each other by a well defined API, and not go
making assumptions about each other's behaviour beyond those defined
API semantics.

> >> So, I think you should either:
> >>     1) Fallback to the code below whenever you can't access the
> >>        tce_list via prereg memory, regardless of whether there's any
> >>        _other_ prereg memory
> >=20
> > Using prereg was the entire point here as if something goes wrong (i.e.
> > some TCE fails to translate), I may stop in a middle of TCE list and wi=
ll
> > have to do complicated rollback to pass the request in the virtual mode=
 to
> > finish processing (note that there is nothing to revert when it is
> > emulated-devices-only-guest).

But you *still* have that problem with the code above.  If the
userspace has preregistered memory chunks you still won't know until
you look closer whether the indirect table specifically is covered by
the prereg region.  You lose nothing by checking *that* and falling
back to the slow path if the prereg lookup fails.

> >> or
> >>     2) Drop the code below entirely and always return H_TOO_HARD if
> >>        you can't get the tce_list from prereg.
> >=20
> > This path cannot fail for emulated device and it is really fast path, w=
hy
> > to drop it?

Because it makes the RM code simpler.  If dropping this fallback from
RM is too much of a performance hit, then go for option (1) instead.

> > I am _really_ confused now. In few last respins this was not a concern,=
 now
> > it is - is the patch this bad and 100% needs to be reworked? I am tryin=
g to
> > push it last 3 years now :(

3 years, and yet it still has muddled concepts.  Postings have been
infrequent enough that I do tend to forget my context from one ronud
to the next.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zsAhXfiBV62A5hVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdxkFAAoJEGw4ysog2bOSa68QAJFjExqVMvMlnfFVam6372+p
tGHoAypAyjlhfiX5zHUvan1DdM1MDos3qyS+YFCMkriDHHhtdNzdNJViK5s4N5g7
UuWKoqBlgmgKTa3EeJ7IL46Y4VsMQMaI4rG+Hm9Qnxo+hDKklNsoOfhTw5tJegh3
89Z1wRB605ZP53CWPAM3bDSY/f9fPwiD7Ulu3sYsGoq8J0rneBr7Dlhs04nMejbB
yaSM5gYoMvQqYdzKtLPCWD/yrvOtQ8Mgd4cXmILvuy4fgwhr/zVKk35uw7FZ8v0Y
2+cpmCzs4tLxkIpioB18LJfLlBwojbeA2Z7/9wXV6wzPjw8+m4ML9R/39GMAu03P
6XiG5KgMPMn4FZJg72yjeOajJZGAPGaF2mGuqNrVsmotgme67QptFNGSwxGGOzAp
Tx8EblEigVXBNbUigMSfeOlalINXKVv8IdjLHUWREcBGH66BJnbl9F8A/+jRWnro
dSmRWlGIOhtAfkDxuXXBEzI6rdSdrOQA29B8WwILx+Z7vFjGqyU4NBYWg+VG77cY
LNUKS7l+gNWkEq3kjdMTjeGQqi+uIpa+dAPfvO+TvGcuGPVyKbXMpTYh54TU5/Iy
r+HEJZyKHGH5z+TIlQJJpE8tL7rGmxW0kJqlz9ms/6/+u+cljZ/ug2NjewSUyzgw
3A9pE1h10FxDWog446tX
=oIb/
-----END PGP SIGNATURE-----

--zsAhXfiBV62A5hVr--
