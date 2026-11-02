Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E9F6072ED2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gbisa96b
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJG2R6Fk3z3dHj;
	Tue, 03 Nov 2026 02:33:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633631;
	cv=none; b=WGfm38utQxC8resu1Wf7IzI5S6sSsxT6SZHa2ObyojdbymEnJPnaEMAwSzpTOVi9V0KdnjQmGjHJVJUwjGj8xzKMr/HEXZDaxFpn2eVgQpddfbn92dRzuonI4LByfokepKHSkWj6wDphJ4xmpCpeULf6PySeItdQg/0aeVc50mazy+xL16jEg8yM4qySIIYWmZB8kIBDSsbt6Fzbv40TA1cRmD/jcjkctzPeDIxq5mhyVWP492g4YmLKoJ30Pq5oQUfMYtAB0L4waTLW+qU+5+jjkOWYYf2jx0+pM2iBUiKplC5DMiJX4rGZY2hHY1oV++4Xj+YVocDGGH5uBeMZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633631; c=relaxed/relaxed;
	bh=TUC01fxFkyGA6yFwHL7rirhUUtJ+C7CbbSnK6VkA0MA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KdNsgCanDA/w3sHjxD+HJPnTVao8zpNW30vTY60VaniRsrjSpBvs80FBJylNGs+/lM9dvy0hAenyE9BYWn6FhfSxPmf8MS5QvtDQaSPkxe483y8Qdyn9i8d3Jm35XzyH/SIsQ3Av6d8wsjOG753BB3e4IlsLGOzOBWDUlMdWPTyKrFHzf7wf6nOGM0iHWMvhp7Ii6tNz3ePRaQ9fxpeFYTiwvZuXWLEwDsMrhr7n6bZ0Z0Ep+7eCvBNFdCmljNxRsWCqIuHaGfhZISLCxJ7O5QhSv/jxtE9wQ/CjV6txkMagCO75MRhZ+w9n8iRjAkv++XTuvPujBjyztIJGyY60Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gbisa96b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3wa3oagykdlqmyuhdwaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gbisa96b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3wa3oagykdlqmyuhdwaiiafy.wigfchorjjw-xypfcmnm.itfuvm.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com [IPv6:2607:f8b0:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJG2Q3SKvz3bkP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:33:49 +1100 (AEDT)
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e832c03576so48250645ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633627; x=1794238427; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TUC01fxFkyGA6yFwHL7rirhUUtJ+C7CbbSnK6VkA0MA=;
        b=gbisa96bXDtZMI4NbptyHlw+wJWQrKFslEUlzTOL9OwBZ3ScLXG16PZpk948msh9JE
         WagIBp+nnqD3bBbi688D40Vfv9SQnmMYQTOoIXiaU/On/3R7p0sh5e/fnYjBflN2kY5H
         mLZqzUixI/03jHe602AJ6gAXDhoDbtSUGLTghV7d6Q71wriitjzTTSduWQcY0tKwk94l
         SkBSonJImtyVtcH+Qpil+ln8Hd9BlqI60xDEpKtYND7/IlqMDJNrfa6dXMc5TG0IYUZ8
         akdfcIl//TsOl+yMHdI6FVMST681NrkFV9WS5wI02cMk1gYP1yMGbZQLQpUXc+TJYgWn
         eOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633627; x=1794238427;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUC01fxFkyGA6yFwHL7rirhUUtJ+C7CbbSnK6VkA0MA=;
        b=vqKdi/tItgZ9a4fqJ6cuYaORPzzAeRz/HyCqIbq46vRqpfqDgV9oyGKhMpSsb2NxM5
         db6UjCuN6KWhqV5mLG57aq0dyMO5iwiT+2lniXRfdWf6yq9rxtaxeoYa5q6n01Ph33bw
         bqQXYU4uQHZfhK1WGvc5ZPEiJC0MNSeL64Y/e9DJmHtzWIwaI0SpYGymeUJ8blWYIrtZ
         KkWasEfwvny7SOW99HFRhepBKSKU1sEvF8xe3cMoA13AsrpORYSGi0QNRxQazW5wHozd
         O22SVZ4ezR2Fb3SbSeCOtXrQtraHZgcrFvsACZmEnXdNxqnKVFigTONCnIPaQz0h2yjz
         jBFw==
X-Forwarded-Encrypted: i=1; AKwUvBxk2bbJ0IDSC7XiToScnyRXAuv0BwmgwwXjMedem1gml/57wAclDnGur2V4AUlVz1uWXZgfPO2zNe/C7OY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9Gqu61HEy0cnJZwOPF78pJuY+S/y3cs6s8OBIC3SqDmIAdVSGx
	RyUAW6PzdU84kLVMxUChbR9CjFbl6N/OA6Yqg94tNpVU3BBHV8TkMXFuqHh6sznMPzF0q6AAcsQ
	N6Zg01w==
X-Received: from plgv20.prod.google.com ([2002:a17:902:e8d4:b0:2ea:3bc:770d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:24b:b0:2e9:776f:66b4
 with SMTP id d9443c01a7336-2eb364f6eafmr93325065ad.44.1793633625745; Mon, 02
 Nov 2026 07:33:45 -0800 (PST)
Date: Mon, 2 Nov 2026 07:33:45 -0800
In-Reply-To: <sashiko-outbox-191627@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-13-seanjc@google.com>
 <sashiko-outbox-191627@kernel.org>
Message-ID: <auitWWkOopYYbBH3@google.com>
Subject: Re: [PATCH v4 12/23] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+Gautam and PPC lists/maintainers

On Fri, Oct 30, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] KVM: PPC: Book3S HV: rmap_nested memory leak in kvmhv_release_=
all_nested()
> --
>=20
> commit 9c25a1b4a76e8526eb8a2b11e1b9e63893b0de80
> Author: Sean Christopherson <seanjc@google.com>
>=20
> KVM: Destroy memslots immediately after mmu_notifiers are unregistered
>=20
> This commit replaces active memslots with an empty memslot set and frees =
all
> memslots immediately after unregistering the MMU notifier in kvm_destroy_=
vm(),
> prior to calling kvm_arch_destroy_vm().
>=20
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index fa548b12228ff..2eda12a52bf4b 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
>=20
> [ ... ]
>=20
> > @@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
> >  		kvm->mn_active_invalidate_count =3D 0;
> >  	else
> >  		WARN_ON(kvm->mmu_invalidate_in_progress);
> > +	kvm_destroy_memslots(kvm);
> > +
> >  	kvm_arch_destroy_vm(kvm);
> >  	kvm_destroy_devices(kvm);
> > -	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
> > -	}
>=20
> [Severity: Medium]
> Does hoisting kvm_destroy_memslots() above kvm_arch_destroy_vm() leak
> struct rmap_nested allocations in slot->arch.rmap on PowerPC Book3S HV wh=
en
> destroying a VM with nested virtualization enabled?

I don't think so?  Patch 3[*], "KVM: PPC: Flush/zap all memslots on kvm_arc=
h_flush_shadow_all()",
should free the rmaps in response to kvm_arch_flush_shadow_all().   From wh=
at I
can tell, the page tables have to be in radix mode, and so the rmaps are fr=
eed via:

  kvmppc_radix_flush_memslot()
  |
  -> kvmppc_unmap_pte()
     |
     -> kvmhv_remove_nest_rmap_range()
        |
        -> kvmhv_remove_nest_rmap_list()

And if that doesn't work, it means memslot deletion on an active VM is comp=
letely
broken.

However, it means the memslot code in kvmhv_release_all_nested() is dead co=
de, so
this as follow-up to patch 3?  Or maybe folded in?

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_=
hv_nested.c
index a6ff42d7666c..27985210f972 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -802,8 +802,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
 	int lpid;
 	struct kvm_nested_guest *gp;
 	struct kvm_nested_guest *freelist =3D NULL;
-	struct kvm_memory_slot *memslot;
-	int srcu_idx, bkt;
=20
 	spin_lock(&kvm->mmu_lock);
 	idr_for_each_entry(&kvm->arch.kvm_nested_guest_idr, gp, lpid) {
@@ -820,11 +818,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
 		freelist =3D gp->next;
 		kvmhv_release_nested(gp);
 	}
-
-	srcu_idx =3D srcu_read_lock(&kvm->srcu);
-	kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
-		kvmhv_free_memslot_nest_rmap(memslot);
-	srcu_read_unlock(&kvm->srcu, srcu_idx);
 }
=20
 /* caller must hold gp->tlb_lock */
		=09

[*] https://lore.kernel.org/all/20261030212112.2598640-4-seanjc@google.com

> In virt/kvm/kvm_main.c, kvm_destroy_memslots() replaces kvm->memslots[i]
> with kvm_empty_memslots and frees each memslot via
> kvm_free_memslot() -> kvm_arch_free_memslot() -> kvmppc_core_free_memslot=
_hv()
> in arch/powerpc/kvm/book3s_hv.c:
>=20
>     static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *slot)
>     {
>             vfree(slot->arch.rmap);
>             slot->arch.rmap =3D NULL;
>     }
>=20
> which frees the slot->arch.rmap array without freeing the linked
> struct rmap_nested entries.
>=20
> Previously, those entries were freed before memslot destruction via
> kvm_arch_destroy_vm() -> kvmppc_core_destroy_vm_hv() ->
> kvmhv_release_all_nested() in arch/powerpc/kvm/book3s_hv_nested.c:
>=20
>     srcu_idx =3D srcu_read_lock(&kvm->srcu);
>     kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
>             kvmhv_free_memslot_nest_rmap(memslot);
>     srcu_read_unlock(&kvm->srcu, srcu_idx);
>=20
> With kvm_destroy_memslots() running before kvm_arch_destroy_vm(),
> kvm_memslots(kvm) now returns kvm_empty_memslots and the memslots have
> already been freed when kvmhv_release_all_nested() runs, so
> kvmhv_free_memslot_nest_rmap() is never called. Any struct rmap_nested
> entries remaining in slot->arch.rmap at teardown (for example, when
> KVMPPC_SECURE_INIT_DONE causes kvmppc_radix_flush_memslot() to return ear=
ly,
> or when 4KB PTEs were replaced by a huge page in kvmppc_unmap_free_pte())
> will be leaked.
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030212112.25=
98640-1-seanjc@google.com?part=3D12
>=20

