Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561B606D807
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o4pFpwdr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKRFP4TZMz2xSF;
	Thu, 05 Nov 2026 00:32:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793799145;
	cv=none; b=aDzuX7trgX3KVUV6s2VCcerFXQsX9XL3IEAe+h6qfgQRGocmFOyYgP0zPxwowEQQ0WJrOEFuEArKwt/IIo68pKX7f/i+FlbMwpxgZJpXnNNejZvG70FJHyJkiUMZ6seTgxOjAvJRR/B6s4Qku6g7pWjOW39GKSmKCmD5NLXfcIdc4Gw79+KoF5h4CFY1oj/8/gOLif8nW3Oph0jHwf70cQhEr/3+9xoU/ogba2bmtKAT6eIF5JnA5KwNtqOfpf/c8QK1M5Slf8CBx4EYkpjuGSlYyHN9kbfHK7yCfFMHgG8cIPlRS7Huxi0fiXL36X8NjfoWelZoQ2MXr9nt0ljifg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793799145; c=relaxed/relaxed;
	bh=f1NHckFTNi2t+UBr6oPHAijnd3s0vFDpOBlB6WEYt+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sbdcn+S7norczfZSyx1/STMC6tIdSdtP5GoVY+f/cx1F8OHJl+L3XBgST7QaB5Hm7xQYM3pFDFKqPXDgKmIw2snBm70ah6JNc/V6VuB73V47VcGEtrgSPAD4wNOGE4B3eki2c7A53aH5+eCAnrjJ7Ak0It9uvVT7eSJIs2fawHj2KOJMw2ugZ5kWVj+j0imjIIKFeAd0656rFrlyBJrEIHyifcGeo0LRNKoJk2Fr3ircQI7GdVs/Qf7U2Bw1fNH6Q8DSqF7r/qGai9YSmTVkuIhOodj7pnSwGP6hLqfvI3bWe4PQ6ZTlT/rYYmv1p0HCjUysl+RuPw8hAk+K2Roaew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o4pFpwdr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=34zpragykdfyg2yb704cc492.0ca96bildd0-12j96ghg.cn9yzg.cf4@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o4pFpwdr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=34zpragykdfyg2yb704cc492.0ca96bildd0-12j96ghg.cn9yzg.cf4@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com [IPv6:2607:f8b0:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKRFM2Jqdz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 00:32:22 +1100 (AEDT)
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e987ec84afso8279835ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793799140; x=1794403940; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f1NHckFTNi2t+UBr6oPHAijnd3s0vFDpOBlB6WEYt+4=;
        b=o4pFpwdrNVveDRLbVcwUtAxtghZh4AHe+ikHYzo0W1PzhC2LvIFpymboNJPosr4SSA
         VEyD608QZdMpB58gHF91aPhWKkwBOLBFNSlndbDKbnxS57gxTQNRqUpUr1Pp3kQrHHnw
         wt/+PSurfALgWVwd4j5ItD+1jOHXVXLsRUTzITWosTWJGYCeVB2iR+YY/T83G4maexUd
         bul1GuZvyIpZ0/sgEGkckLQ2UI4VkajGr7CP6vZR9dOniqX00sQRQtzmuNFhSzrWcqJ0
         vU+Gad0VSdZnDMrMstCWVVSTre5DkX1Gc1Y4DkUIy12hiVREnMYiG2A4rcs0xwdeSpFQ
         HDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799140; x=1794403940;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1NHckFTNi2t+UBr6oPHAijnd3s0vFDpOBlB6WEYt+4=;
        b=a2n3qXJJ+4XQyWIFqFkPe+lESZIq0OTV5TqKhbaU5ulwFuY4zJTsYjFb7Yp7FeGPN2
         H63LNZJXzXzTQW525bQgWhajiIuV8793/ekO2ZAvCsJQZ9V7SI5wjPfFSG7TOumBsJfN
         K6yim+UCRfZPDqLHTVhuVQbOYkofv+mt1HVEFqt1QHIsaAALSvmli0HLePuO+DfB85tx
         IeTdzinNRG8Zywttan26ZQn+QOmRieQIyeOLQS4RjFezsDC+ffaSBF/fhfNQolRbpIE7
         93lWW7UjJwct3+N4FYOHRbGsK0tMqQ/cVTIkTscgPZavJhwiZqGgeyXzcFn6UViKCYOV
         ts2g==
X-Forwarded-Encrypted: i=1; AKwUvBz+LRm0wHHxKK6uOj4lhRVr9I3sCGODjzKIJ3gcovOXbUjYHuiDTUF/OwezZOjBRHxA/P1dNivmoLUr/zI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8/EUVHy0vOY1MP7sdXO5c6dz4+cy1nCWZwytEW3igeOap7m63v
	XULH5vXGAX5rphOvOxwbGRVp0lMEZXf+F5uOad78IgT5B6PT/zP38l5LJx0mf6xpaAJcNdu7coG
	OJ5lbzA==
X-Received: from pjbmj22.prod.google.com ([2002:a17:90b:3696:b0:3ad:ce09:ff3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a82:b0:3b0:9f53:e8a8
 with SMTP id 98e67ed59e1d1-3b09f53f231mr985002a91.52.1793799139505; Wed, 04
 Nov 2026 05:32:19 -0800 (PST)
Date: Wed, 4 Nov 2026 05:32:17 -0800
In-Reply-To: <5bd7e8e9-3614-4006-a3d7-a51416ba5507@linux.ibm.com>
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
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-4-seanjc@google.com>
 <5bd7e8e9-3614-4006-a3d7-a51416ba5507@linux.ibm.com>
Message-ID: <ausz4VZWa_4Vr03v@google.com>
Subject: Re: [PATCH v4 03/23] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
From: Sean Christopherson <seanjc@google.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026, Narayana Murty N wrote:
> Hi Sean,
> 
> On 31/10/26 2:50 AM, Sean Christopherson wrote:
> > Flush/zap every memslot in kvm_arch_flush_shadow_all(), i.e. when the
> > owning userspace process is exiting, as KVM must ensure all associated
> > memory is unmapped from the guest.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/powerpc/include/asm/kvm_host.h |  1 -
> >   arch/powerpc/kvm/powerpc.c          | 11 +++++++++++
> >   2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> > index 708a32f89776..50a42f80e5f1 100644
> > --- a/arch/powerpc/include/asm/kvm_host.h
> > +++ b/arch/powerpc/include/asm/kvm_host.h
> > @@ -910,7 +910,6 @@ struct kvm_vcpu_arch {
> >   #define __KVM_HAVE_CREATE_DEVICE
> >   static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
> > -static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
> >   static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
> >   static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 9194cf492d1c..9e9d0865c2f6 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
> >   	kvmppc_core_commit_memory_region(kvm, old, new, change);
> >   }
> > +void kvm_arch_flush_shadow_all(struct kvm *kvm)
> > +{
> > +	struct kvm_memory_slot *slot;
> > +	struct kvm_memslots *slots;
> > +	int bkt;
> > +
> > +	slots = kvm_memslots(kvm);
> > +	kvm_for_each_memslot(slot, bkt, slots)
> > +		kvmppc_core_flush_memslot(kvm, slot);
> 
> For Book3S HV/hash, I am not sure the existing flush_memslot helper can
> be used on an active memslot like this.
> 
> The normal memslot invalidation path seems to deliberately establish
> the opposite ordering.  kvm_invalidate_memslot() first installs an
> INVALID slot and makes it active:
> 
> 	invalid_slot->flags |= KVM_MEMSLOT_INVALID;
> 	kvm_replace_memslot(kvm, old, invalid_slot);
> 	kvm_swap_active_memslots(kvm, old->as_id);
> and only then does kvm_arch_flush_shadow_memslot(kvm, old);.
> 
> The comment there explicitly states:
> /*
>  * From this point no new shadow pages pointing to a deleted,
>  * or moved, memslot will be created.
>  */
> 
> Similarly, kvmppc_core_flush_memslot_hv() in
> arch/powerpc/kvm/book3s_64_mmu_hv.c relies on the memslot already being
> invalid when testing KVMPPC_RMAP_PRESENT without locking, as no new HPTEs
> can be created.
> 
> However, kvm_arch_flush_shadow_all() in arch/powerpc/kvm/powerpc.c now
> invokes the same helper while walking active memslots.
> 
> Is there any serialization in the mmu_notifier.release() path that provides
> the same guarantee against new HPTE creation?

There can't be any outstanding *usable* references to vCPUs at this point.
mmu_notifier.release() is only invoked if the process is exiting or the VM is
dying (which requires the associated file to have been released).

If the process is existing, KVM_RUN (and most ioctls) are unreachable due to the
"dev->kvm->mm != current->mm" checks.  Not to mention that if the process is
exiting, doing anything with a memslot is completely broken because it means
things like hva_to_pfn() are somehow operating on the wrong mm.

If the VM is dying, there can't be any references to vCPU FDs, because each vCPU
holds a reference to the VM.

> Otherwise, couldn't an H_ENTER or fault path create a new HPTE while the
> rmap is being scanned, or after it has already been examined?

