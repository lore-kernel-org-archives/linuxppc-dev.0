Return-Path: <linuxppc-dev+bounces-19922-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51539F94CB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 00:27:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0g5t4F4qz2xll;
	Wed, 22 Apr 2026 10:27:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776817634;
	cv=none; b=IK700gglwFvW6DfvubSL9ugwqoNwYPIDPrIV2tdzHPqYQFf8pFFwfE5yeDcwqlunGByfiRRYC+zDF2nraP4mF9rj5sbPHSuriZufgj8jwRVRgaU1e9i1paBgEIYTmbNuQ8GHki7/qRDLBaa5PzP/0dLTGXUH9RKJ2j8Omm/4QVNUcycO5Rq8012q7R828+bQM+N+svGf5UDYcAArrpTUL2kl3A0QB0Ye4abav1BixJ7KGwTNE02pjZ2RyOBUKAfx9KjqjjBkOZrpYJW5cynUbD2+g6A5o/exj1CwgxmJPsnV9VcLeBdVli4X+HP3JQ/CeXRvw3ASVdW+Fn7kduKwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776817634; c=relaxed/relaxed;
	bh=MkuNkxnVBbjR5jOr4YpsELZt5k3k1MevbvKLS2DXHXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMG0ej971cOzyGcM99J/oqx7s3sp4cJNkeBT2k94RGohokhSa4bUyV9xq/TYIP9WIP5Nx9cQCFXXjIq+ird7+oVkTus2tCCWMk1Hm4DObMK7tzJpGZrL6u9Pvw3Y2DtB4FWTC5JKkR40s54U2gaSISJuONTEkV+PvIFv/JegHZhouVA1Pmpu+PZ7itTX7DP4MjmHg1eD4RkwtjrdUQY6lByWa0JkBxSdcQFhT1mBBMlDLW4REXtMKsMr+3uMWaJRIptJEe5dAAfL6NZW0DABeI3ls1X9Y1qS7JUS7CtbKM7q6yiT29kEGhIju4Jy6XkH6KLqTlPAnHVPUm5/pX/e5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=l70tCAdI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=33rxoaqykdp4ykgtpimuumrk.iusrot03vvi-jk1royzy.u5rghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=l70tCAdI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=33rxoaqykdp4ykgtpimuumrk.iusrot03vvi-jk1royzy.u5rghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0g5r6n4Nz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 10:27:12 +1000 (AEST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-82f504f6b75so2718489b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776817630; x=1777422430; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkuNkxnVBbjR5jOr4YpsELZt5k3k1MevbvKLS2DXHXQ=;
        b=l70tCAdITVs3UA38i+g/rPrcUeB8gk9aCsZRYaz5jaAfK40o5IoNd+K+99BkPrcxv1
         QYRoTcshhG3xYgPOsCYpTm2twiBT48Y0vUjG64L615nNbagcks/ZwYwGYy5Rfts2kf5j
         wE0uxb3Ktch8rd8708IW/mzYBMufuMi5QB5Cm/YshhB2G0L3Mc38TGfqIDwW5RUuJQU/
         5Up5hHXrf9J77RiWDcGyyDXIgL9LzesnE9V3o77W/Kr3/MrLCjEHbpQBKY+Thiem3bUb
         PCVh9NfWtTFIeP8pHYf8F3YMgr1TK5V7SmOO2xcWg4kGin7/6t0Qs1csJE8yXu5DSxLH
         Yt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776817630; x=1777422430;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MkuNkxnVBbjR5jOr4YpsELZt5k3k1MevbvKLS2DXHXQ=;
        b=R0WNgfinCpwshI6aIcDohhYs8Q2EkZjSRHhshB3u92tPvfyjDcrOkyG3echT9fqcvD
         D8q80RvdDLjRONkurBkXOcSz/F5b87KqHKwrO2nFr8ZqP5kHq3qlXJ1xfHadtTyCoosU
         vPLG/h1OXggLJo84xTcjBhwco6fjohG3v928CooFI8EFZfwe5mXKpHpwUXIwtXASGM2S
         kQPqJdn6UQaXasQGOX8poeQzPTcSlYz1uJxapW8WP2bWfFpbLXC4lBWe52p1lq9z8boB
         nEQMviU9l3Gr40t1cdU1fz+bJ1mdjxSUWvImI5ejFgteTjburh342qi3okJq4wmeo/dl
         20yw==
X-Forwarded-Encrypted: i=1; AFNElJ+hO8W3/ECTHMyJAukoMVDIhKDzr/5nttM76YEe58YMZ/dMB2rXqV3tedZ1oqQSsjSRC4S8BokIRdko4xs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwlKkxWk/6GEvw9Qb4XSWwTzbX86zB2QqiduwbXpU1IPekrWVNu
	L/mHNoAGf6bQAJe2dRwoKK2Vnoc4h9wK9QGuvKM25/GlRCKzbODiqvCg02vKvAtS2Wo3w74qDE3
	fTB0UaQ==
X-Received: from pfbfc32.prod.google.com ([2002:a05:6a00:2e20:b0:82f:5eca:2b2d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da2:b0:82a:7471:eb90
 with SMTP id d2e1a72fcca58-82f8c8bbe01mr18749722b3a.30.1776817629995; Tue, 21
 Apr 2026 17:27:09 -0700 (PDT)
Date: Wed, 22 Apr 2026 00:27:08 +0000
In-Reply-To: <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com> <aegIPGYPH-nxGsua@google.com> <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
Message-ID: <aegV3ELp20DlC5Ge@google.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> On Tue, Apr 21, 2026 at 4:29=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Apr 21, 2026, Sean Christopherson wrote:
> > > On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > > > On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > > > > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() a=
nd
> > > > > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reduc=
ing
> > > > > boilerplate at call sites.
> > > > >
> > > > > __kvm_vcpu_map() still takes a gfn_t because guest page mapping i=
s
> > > > > fundamentally GFN-based.
> > > > >
> > > > > No functional change intended.
> > > > >
> > > > > Compile-tested on x86 and ppc, which are the current users of the=
se
> > > > > interfaces.
> > > > >
> > > > > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > > > > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > > > > ---
> > > >
> > > > I was going to suggest a WARN in kvm_vcpu_map() and
> > > > kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but =
Sean
> > > > usually hates my paranoid WARN suggestions.
> > >
> > > Heh, for good reason.  Adding such a WARN would be triggered by this =
code:
> > >
> > >                 if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr=
, map)) {
> > >                         vmx->nested.pi_desc =3D
> > >                                 (struct pi_desc *)(((void *)map->hva)=
 +
> > >                                 offset_in_page(vmcs12->posted_intr_de=
sc_addr));
> > >
> > > The PI descriptor only needs to be 64-bit aligned, not page-aligned.

To answer your other question: yes, 64-byte, not 64-bit.

> > To elaborate a bit, I'm all for adding WARNs in flows where something b=
ad is all
> > but guaranteed to happen if an assumption is violated, or in APIs where=
 there's
> > a history of goofs and/or subtlety in how the API behaves.
> >
> > What I'm against is adding WARNs because someone could write bad code i=
n the
> > future, or because KVM doesn't do XYZ at this time.  Such WARNs usualy =
just add
> > noise, and can even be actively harmful.  E.g. in this case, ignoring t=
he PID
> > usage, a reader might look at the WARN and think it's _wrong_ to map a =
page in
> > order to access a subset of the page, which is just not true.
>=20
> Yeah I agree with most/all of your objections to my suggestions, it's
> usually that I don't have enough context to understand how the WARN
> could be harmful (like here), or am just being too paranoid or
> defending against bad code as you mentioned. I was mentioning your
> objections semi-sarcastically and intentionally bringing up the WARN
> in case it's actually useful.
>=20
> Taking a step back, what I really want to clarify and/or detect misuse
> of, is that kvm_vcpu_map() will map exactly one page, the one that the
> GPA lies in. For example, there's nothing protecting against the PID
> address being the last byte of the page,=20

Well, technically there is:

	    CC(!kvm_vcpu_is_legal_aligned_gpa(vcpu, vmcs12->posted_intr_desc_addr,=
 64))))
		return -EINVAL;

But I'm pretty sure what you're saying is that "nothing in the common helpe=
r code
protects against a stupid caller".

> in which case accessing all of it would be wrong as it spans the mapped p=
age
> boundary. This is difficult to hit if you are passing in a GFN, as it's m=
ore
> obvious that KVM is mapping one physical page.

Eh, that just leads to a different class of bugs (and possible even *worse*=
 bugs).
E.g. caller passes in a GFN, accesses the kernel mapping beyond the page, a=
nd
reads/write arbitrary kernel memory (pfn_valid() case using the direct map)=
, or
hits a !PRESENT #PF (remap case).

> Perhaps we just need to rename the functions (e.g.
> kvm_vcpu_map_page()), or more intrusively pass in a size and do bounds
> checking.

Definitely the latter.  Or both I guess, but probably just the latter.

Commit 025dde582bbf ("KVM: Harden guest memory APIs against out-of-bounds a=
ccesses")
added that type of hardening for the "slow" APIs, exactly because of the ty=
pe of
OOB bug you're describing: commit f559b2e9c5c5 ("KVM: nSVM: Ignore nCR3[4:0=
] when
loading PDPTEs from memory").

Actually, that's actually useful feedback for patch 3.  __kvm_vcpu_map() sh=
ould
do the GPA=3D>GFN conversion, not its caller.

Anyways, back to the hardening.  We can do it with minimal additional churn=
.  After
patch 3 (passing a @gpa to __kvm_vcpu_map(), not a @gfn), do the below over=
 a few
patches (completely untested).  This way the common case of mapping and acc=
essing
an entire page Just Works, and flows like the PI descriptor handling don't =
have to
many provide the length (which also can be error prone).

---
 arch/x86/kvm/vmx/nested.c | 12 ++++--------
 include/linux/kvm_host.h  | 22 ++++++++++++++++------
 virt/kvm/kvm_main.c       | 28 +++++++++++++++++++---------
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ee3ff76a8678..eb75d97c7453 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3453,7 +3453,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *=
vcpu)
 		map =3D &vmx->nested.virtual_apic_map;
=20
 		if (!kvm_vcpu_map(vcpu, vmcs12->virtual_apic_page_addr, map)) {
-			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, pfn_to_hpa(map->pfn));
+			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, map->hpa));
 		} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
 		           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
 			   !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
@@ -3478,12 +3478,9 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu =
*vcpu)
 	if (nested_cpu_has_posted_intr(vmcs12)) {
 		map =3D &vmx->nested.pi_desc_map;
=20
-		if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, map)) {
-			vmx->nested.pi_desc =3D
-				(struct pi_desc *)(((void *)map->hva) +
-				offset_in_page(vmcs12->posted_intr_desc_addr));
-			vmcs_write64(POSTED_INTR_DESC_ADDR,
-				     pfn_to_hpa(map->pfn) + offset_in_page(vmcs12->posted_intr_desc_ad=
dr));
+		if (!kvm_vcpu_map_ptr(vcpu, vmcs12->posted_intr_desc_addr,
+				      vmx->nested.pi_desc, map)) {
+			vmcs_write64(POSTED_INTR_DESC_ADDR, map->hpa);
 		} else {
 			/*
 			 * Defer the KVM_INTERNAL_EXIT until KVM tries to
@@ -3491,7 +3488,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *=
vcpu)
 			 * descriptor. (Note that KVM may do this when it
 			 * should not, per the architectural specification.)
 			 */
-			vmx->nested.pi_desc =3D NULL;
 			pin_controls_clearbit(vmx, PIN_BASED_POSTED_INTR);
 		}
 	}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 893a8c76a665..da6f08aa0ac4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -291,10 +291,11 @@ struct kvm_host_map {
 	 */
 	struct page *pinned_page;
 	struct page *page;
-	void *hva;
-	kvm_pfn_t pfn;
 	kvm_pfn_t gfn;
 	bool writable;
+
+	hpa_t hpa;
+	void *hva;
 };
=20
 /*
@@ -1893,22 +1894,31 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
 	return (hpa_t)pfn << PAGE_SHIFT;
 }
=20
-int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *=
map,
-		   bool writable);
+int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, gpa_t len,
+		   struct kvm_host_map *map, bool writable);
 void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
=20
 static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa,
 			       struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map, true);
+	return __kvm_vcpu_map(vcpu, gpa, PAGE_SIZE, map, true);
 }
=20
 static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gpa_t gpa,
 					struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map, false);
+	return __kvm_vcpu_map(vcpu, gpa, PAGE_SIZE, map, false);
 }
=20
+#define kvm_vcpu_map_ptr(__vcpu, __gpa, __ptr, __map)				\
+({										\
+	int r;									\
+										\
+	r =3D __kvm_vcpu_map(__vcpu, __gpa, sizeof(*(__ptr)), __map, true);	\
+	__ptr =3D !r ? (__map)->hva : NULL;					\
+	r;									\
+})
+
 static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
 					   struct kvm_host_map *map)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9093251beb39..e8d2e98b0068 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3114,9 +3114,10 @@ struct page *__gfn_to_page(struct kvm *kvm, gfn_t gf=
n, bool write)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__gfn_to_page);
=20
-int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *=
map,
-		   bool writable)
+int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, gpa_t len,
+		   struct kvm_host_map *map, bool writable)
 {
+	gfn_t gfn =3D gpa_to_gfn(gpa);
 	struct kvm_follow_pfn kfp =3D {
 		.slot =3D kvm_vcpu_gfn_to_memslot(vcpu, gfn),
 		.gfn =3D gfn,
@@ -3124,6 +3125,10 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn,=
 struct kvm_host_map *map,
 		.refcounted_page =3D &map->pinned_page,
 		.pin =3D true,
 	};
+	kvm_pfn_t pfn;
+
+	if (WARN_ON_ONCE(offset_in_page(gpa) + len > PAGE_SIZE))
+		return -EINVAL;
=20
 	map->pinned_page =3D NULL;
 	map->page =3D NULL;
@@ -3131,20 +3136,25 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn=
, struct kvm_host_map *map,
 	map->gfn =3D gfn;
 	map->writable =3D writable;
=20
-	map->pfn =3D kvm_follow_pfn(&kfp);
-	if (is_error_noslot_pfn(map->pfn))
+	pfn =3D kvm_follow_pfn(&kfp);
+	if (is_error_noslot_pfn(pfn))
 		return -EINVAL;
=20
-	if (pfn_valid(map->pfn)) {
-		map->page =3D pfn_to_page(map->pfn);
+	map->hpa =3D pfn_to_hpa(pfn);
+	if (pfn_valid(pfn)) {
+		map->page =3D pfn_to_page(pfn);
 		map->hva =3D kmap(map->page);
 #ifdef CONFIG_HAS_IOMEM
 	} else {
-		map->hva =3D memremap(pfn_to_hpa(map->pfn), PAGE_SIZE, MEMREMAP_WB);
+		map->hva =3D memremap(map->hpa, PAGE_SIZE, MEMREMAP_WB);
+		if (!map->hva)
+			return -EFAULT;
 #endif
 	}
=20
-	return map->hva ? 0 : -EFAULT;
+	map->hpa +=3D offset_in_page(gpa);
+	map->hva +=3D offset_in_page(gpa);
+	return 0;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_vcpu_map);
=20
@@ -3157,7 +3167,7 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm=
_host_map *map)
 		kunmap(map->page);
 #ifdef CONFIG_HAS_IOMEM
 	else
-		memunmap(map->hva);
+		memunmap(PTR_ALIGN_DOWN(map->hva, PAGE_SIZE));
 #endif
=20
 	if (map->writable)

base-commit: d9d61b2f6793deb6b72aa792ae70c09fa26fda37
--=20

