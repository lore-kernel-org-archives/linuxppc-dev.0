Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C816070DBA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i7SRxlPW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJGp96j8rz3btf;
	Tue, 03 Nov 2026 03:08:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793635697;
	cv=none; b=N2xAmmTavOSNE5c1zvIzwocjJqXfkEsGBJ9/U42IpVxq47TkwLwbm3pRDY978ywionnDVFZ05u/IO9QTrojGs/Z/icULKhIOs8kLMmizjpa6eEUqu6xvuvG3MrOuFrYUcrbKQbD5taZ7eDXM4kWkEDGsNCppm/QM+xl5guTPT7K64g3cjhp0/VjF63e5VoVXxxGF23MaSIU6pJqZI9cxoRM8Y/vWWdgkdR3oTahy0brEb3l5s0OZ7QPSYcsVmMNQXRX6k+gRJa6XJKZE9HA9Z4piw2sytf9gpLdnUphavpClEN7UFJPwtizePVW/mLr9Vsp54fmCnk+L/g+DT5ChKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793635697; c=relaxed/relaxed;
	bh=xnYP2kl3oXU+8Wscp7gvUSQVPhbXp/NrXcsdPdJbRyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DidNF1zrb8VptOz2JjFb9ETrvaoytsnRA0VElndMGOQbK2GvklHE5B5/3p25sQKWgyFLRbPw88zx2iPcAk6IgqK4QMOqHTDcVZmYZ+WoqlyByDDAnCd5AFb6tB8Cdc+/SplZFYpNTTkcElsCrHS0Q7Bf7uXmQagVpzP1c4xgns6J8luPp8u/vxHEeJMHz6EKcdEuVrLBTvyopVHIhQRrPMLJdbTySM7sgigZ59LQ5XRhnJLEHLCKH/D6kMdLqFGpd4ZxeY5vrGP2+FOMLTrMNLvnQtcXYfs8yR07VEpTQWtwn6KCUsvRvON+J/RxfOm8wnv7bBj0LonozElPbogaew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i7SRxlPW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3bbxoagykdngm84hd6aiiaf8.6igfchorjj6-78pfcmnm.itf45m.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i7SRxlPW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3bbxoagykdngm84hd6aiiaf8.6igfchorjj6-78pfcmnm.itf45m.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com [IPv6:2607:f8b0:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJGp84xqyz3btZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 03:08:15 +1100 (AEDT)
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e869e00005so50283165ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793635694; x=1794240494; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xnYP2kl3oXU+8Wscp7gvUSQVPhbXp/NrXcsdPdJbRyI=;
        b=i7SRxlPWhredFO0YjZuq3k9Cr6uOjhsAacOymkLUPde9aAt8cNhxmkvr3Tg7NpeZB5
         U9YvtKPTbDhDm8DXCFQF2beg8eau/1T9XDtqGJ93LKHA1c+qKH4wgFOAgdBjlZLiX4Xf
         T6cKmJhvY2Pg8NvpbOQ6pZ/dDX0jhJSo266EKLT8Ce597fi9NmEVJfDlvoWPSUS6U4Qg
         ypN17NsNCLdQd1IBVvYwN32HGj2Oy/zQAW8ylBx+ZglGZjT2NPrZFvIa8Geja+awXenp
         c/192x8XfblkyWwEC+9ckuYTwG2ctLyXpajn6Wss48RujMlAOsOAPZ/xXSzaErY6PoXa
         GiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635694; x=1794240494;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnYP2kl3oXU+8Wscp7gvUSQVPhbXp/NrXcsdPdJbRyI=;
        b=qCE7FD4P2yaFe65ArwOSYl2HkA0NPGh3JT85E48aMDtR7Lk/t/ntJTH55EamVuGAQy
         CYKKxo1cZ2aY0isHfObAv6Hd54dv7swz5osA5rP5wyGRj1xTJendr/+x0UA2Uo1KQ7QP
         4huYqutLhQjW7jgOffSfPZzOyliqU0clM101QQuocvSr1vJuVbHFXBWq3mMVnGS1JNCL
         ymGXWllAEJVAvlfi+6nUI/RO+z81uMAvyVmHWIG/3aQK4otyoV5snUASUwPo0kV4lfS7
         dtTo7JvoLpgNKgW02CzboyaFxuBHxYefm0AeJQ7KGwVGNxz8m0f7qYkam92h5ZlEYdHz
         d/nQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1iibSS3KZ7woLzcwWH1OruqkEqSk0SiPO8CrutMBRIJ5d/7erBpNPVWSdJawpEKKhPlmD+wNSigp8bBY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/zS6QGRemOZapQKiJUwstEKUQn5L4veHHKl2SOx4k2bcS2N91o
	ZChC5QWCVlOF8Ebe7owV+/6zTvFk8vyIyhFrnS3/Df1zux/zs5IaDtmNnJzHe8d2zpWOl2hYRRf
	CClVeog==
X-Received: from pjbfh3.prod.google.com ([2002:a17:90b:343:b0:3ac:7545:d82e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b51:b0:39e:6795:f7da
 with SMTP id 98e67ed59e1d1-3ae897c7d22mr8880600a91.19.1793635693550; Mon, 02
 Nov 2026 08:08:13 -0800 (PST)
Date: Mon, 2 Nov 2026 08:08:12 -0800
In-Reply-To: <auitWWkOopYYbBH3@google.com>
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
 <sashiko-outbox-191627@kernel.org> <auitWWkOopYYbBH3@google.com>
Message-ID: <aui1bOy-PwIgKOFk@google.com>
Subject: Re: [PATCH v4 12/23] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+Ritesh as well

On Mon, Nov 02, 2026, Sean Christopherson wrote:
> +Gautam and PPC lists/maintainers
>=20
> On Fri, Oct 30, 2026, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] KVM: PPC: Book3S HV: rmap_nested memory leak in kvmhv_releas=
e_all_nested()
> > --
> >=20
> > commit 9c25a1b4a76e8526eb8a2b11e1b9e63893b0de80
> > Author: Sean Christopherson <seanjc@google.com>
> >=20
> > KVM: Destroy memslots immediately after mmu_notifiers are unregistered
> >=20
> > This commit replaces active memslots with an empty memslot set and free=
s all
> > memslots immediately after unregistering the MMU notifier in kvm_destro=
y_vm(),
> > prior to calling kvm_arch_destroy_vm().
> >=20
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index fa548b12228ff..2eda12a52bf4b 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> >=20
> > [ ... ]
> >=20
> > > @@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
> > >  		kvm->mn_active_invalidate_count =3D 0;
> > >  	else
> > >  		WARN_ON(kvm->mmu_invalidate_in_progress);
> > > +	kvm_destroy_memslots(kvm);
> > > +
> > >  	kvm_arch_destroy_vm(kvm);
> > >  	kvm_destroy_devices(kvm);
> > > -	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> > > -		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
> > > -		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
> > > -	}
> >=20
> > [Severity: Medium]
> > Does hoisting kvm_destroy_memslots() above kvm_arch_destroy_vm() leak
> > struct rmap_nested allocations in slot->arch.rmap on PowerPC Book3S HV =
when
> > destroying a VM with nested virtualization enabled?
>=20
> I don't think so?  Patch 3[*], "KVM: PPC: Flush/zap all memslots on kvm_a=
rch_flush_shadow_all()",
> should free the rmaps in response to kvm_arch_flush_shadow_all().   From =
what I
> can tell, the page tables have to be in radix mode, and so the rmaps are =
freed via:
>=20
>   kvmppc_radix_flush_memslot()
>   |
>   -> kvmppc_unmap_pte()
>      |
>      -> kvmhv_remove_nest_rmap_range()
>         |
>         -> kvmhv_remove_nest_rmap_list()
>=20
> And if that doesn't work, it means memslot deletion on an active VM is co=
mpletely
> broken.
>=20
> However, it means the memslot code in kvmhv_release_all_nested() is dead =
code, so
> this as follow-up to patch 3?  Or maybe folded in?
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3=
s_hv_nested.c
> index a6ff42d7666c..27985210f972 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -802,8 +802,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
>  	int lpid;
>  	struct kvm_nested_guest *gp;
>  	struct kvm_nested_guest *freelist =3D NULL;
> -	struct kvm_memory_slot *memslot;
> -	int srcu_idx, bkt;
> =20
>  	spin_lock(&kvm->mmu_lock);
>  	idr_for_each_entry(&kvm->arch.kvm_nested_guest_idr, gp, lpid) {
> @@ -820,11 +818,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
>  		freelist =3D gp->next;
>  		kvmhv_release_nested(gp);
>  	}
> -
> -	srcu_idx =3D srcu_read_lock(&kvm->srcu);
> -	kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
> -		kvmhv_free_memslot_nest_rmap(memslot);
> -	srcu_read_unlock(&kvm->srcu, srcu_idx);
>  }
> =20
>  /* caller must hold gp->tlb_lock */
> 		=09
>=20
> [*] https://lore.kernel.org/all/20261030212112.2598640-4-seanjc@google.co=
m
>=20
> > In virt/kvm/kvm_main.c, kvm_destroy_memslots() replaces kvm->memslots[i=
]
> > with kvm_empty_memslots and frees each memslot via
> > kvm_free_memslot() -> kvm_arch_free_memslot() -> kvmppc_core_free_memsl=
ot_hv()
> > in arch/powerpc/kvm/book3s_hv.c:
> >=20
> >     static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *slo=
t)
> >     {
> >             vfree(slot->arch.rmap);
> >             slot->arch.rmap =3D NULL;
> >     }
> >=20
> > which frees the slot->arch.rmap array without freeing the linked
> > struct rmap_nested entries.
> >=20
> > Previously, those entries were freed before memslot destruction via
> > kvm_arch_destroy_vm() -> kvmppc_core_destroy_vm_hv() ->
> > kvmhv_release_all_nested() in arch/powerpc/kvm/book3s_hv_nested.c:
> >=20
> >     srcu_idx =3D srcu_read_lock(&kvm->srcu);
> >     kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
> >             kvmhv_free_memslot_nest_rmap(memslot);
> >     srcu_read_unlock(&kvm->srcu, srcu_idx);
> >=20
> > With kvm_destroy_memslots() running before kvm_arch_destroy_vm(),
> > kvm_memslots(kvm) now returns kvm_empty_memslots and the memslots have
> > already been freed when kvmhv_release_all_nested() runs, so
> > kvmhv_free_memslot_nest_rmap() is never called. Any struct rmap_nested
> > entries remaining in slot->arch.rmap at teardown (for example, when
> > KVMPPC_SECURE_INIT_DONE causes kvmppc_radix_flush_memslot() to return e=
arly,
> > or when 4KB PTEs were replaced by a huge page in kvmppc_unmap_free_pte(=
))
> > will be leaked.
> >=20
> > --=20
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030212112.=
2598640-1-seanjc@google.com?part=3D12
> >=20
>=20

