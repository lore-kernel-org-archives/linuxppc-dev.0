Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9778606D806
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ldg9gdGA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJxQP4yQbz2xjM;
	Wed, 04 Nov 2026 05:08:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793729309;
	cv=none; b=J1Q9mbTE8XypbnxYcilf8fDxFKQKZrOFuREx4/6tVNHzFaYtgfFql5PNafZLcODnU2Nn5w9jvm+jScV77PE+9R/Kk78WQTq4CGg0o7+1afIP9dCTUHYf+v3jafMbRESbohtAmNSpARVdEZsDemvHIgcB9rk749/4Uvnc0YYunDg3edjSaUxglKwZ7sa/BnjZVAuCKMi2juObBqz0wG9n5Pw7wA96wVstmeZZNsBILG70xYv3DYEn6kdg7CW61g2f7YH6XqmQ+fVxjypF/+hZkGqdj9H7ILgvlJWzYfiiMSKPD06Pif6fYGn/kNwl13233Ic81IMJz+zw0V97mDmSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793729309; c=relaxed/relaxed;
	bh=aIKiDgYd/jXgONymQ12SSZ5b8e5yxBJKR0/jjx24Mc0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=UtZAs3D791z9d7D6BLrs0Qt+mbsOAxd1FYUNY1uC/GZvhdWVyktj7TMwCaNKs0T0j6vd36rZt6qmDPYdRUY7m5SLx332lfIqrkXe01W6hp9XBjMqhXLhB+r6iCytE/8v/eCcGRDZEx9H9pIm4e8HqYHoTOgcsFW3LXUvkUt5w5UyPh4ngnSBO0rNyAv2NaRLnih5GyfWfrV7F1bS5kOqdp6NV2ovZVPIE7LN9Da9VB9pfCv0kZcuVMiKkCTdJBmp+fbQT3jKG+DMgYU/ojGzFz4NvCTtY5OIWLBYUmmF50z6gdBnXk92ap1Sh8K25Qyb14bMChew9njFJ7Fp40friQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ldg9gdGA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ldg9gdGA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJxQP0hWMz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 05:08:28 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso7455808eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 10:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729307; x=1794334107; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aIKiDgYd/jXgONymQ12SSZ5b8e5yxBJKR0/jjx24Mc0=;
        b=Ldg9gdGAZ9QUAIzftKg7iODv1CicTR/8s9HN7GKh+r3WrbNIyP101LLh2zFugAGgXD
         sPXxWaPwQxH3gHWGyWacOB4IXMcyl9O05onO6lV3vMVPJN9Cbw42Dgq55Qwv4+Lc/iDF
         N9qxg7H2jtCFZ96i72RXXX6Ud40+UJC8+eIQejmUvjf+weDGkIGufZvu9Tch2LtIicJa
         JoKISEi6ITpatLNAvQBj/6zHazdZdxxxVUoRd7N2pTOaCWau3O5PSbH5OpnCdLh7fFm3
         om4x3Bw9oH43FPBNDg6X8COvjWXw4bbiqZJTsYBxpsEAm9ccdQ0izWB+grDZmp/0c1Nh
         TBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729307; x=1794334107;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIKiDgYd/jXgONymQ12SSZ5b8e5yxBJKR0/jjx24Mc0=;
        b=m2zpqCY8MwvS0ntPSw88pWqdp+UKabi75QV3t1dxPf1WZHtzjHcDLHjq8tt46WD8Q2
         aF5Ea0W4nQs9tzwg+DL4ff9ZOa0xsTXuMFR78XA3/swDHBrs1XjuiYQyPp8rM75EmJdv
         sz+48xoifQlkzHpgULgVAerlx37HGKQQB8747AdwdhaVWW/PmuwcU6Pnsjp21x7zzkBH
         U5rEwWt8SXCohzRPRcXoxzftLOnV0Un+X0AmuvAIhiVpwvF4nhsqtGTeORArrd/qojOo
         QY8AsPXwe+z4z6le45hL0jpYT7SV05lVt1griXvKaU6+j81ihF3O+zZLhRz059op1Dmy
         GNtA==
X-Forwarded-Encrypted: i=1; AKwUvBxWTDTtflf3/oiR1ncorzyJDnnU+0WmkdAiKmmWvLSI43/33c0fN/nwyXELjMTShBAvxo7kKZQ8kj0+olY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+N7f/MYcrtjINxiRourfib88GTVlxHJBU3cDe9Ov1+Xjpi1bJJ
	ClC6LFv6rdCvAyUU89NIv2R4fFfceeqGjH+VGPxFr7hnVKPgn16jGvVj
X-Gm-Gg: AYBFou1UVXmkYO9ALdVlK+cJjq2pmw6fxMtJrPEq+VY3jC2bRw8UkdboJU/GuSn/Lkb
	5IVoRyhvHmoQPrsdJhbp4/ZY8X9BHylpvdk8wfAbs3Qi+BCeKXODCER25qkQcduZl2UWFusBMMg
	KppWlOE1aVaH1h94k3qhQRG974Mdc7PFSj8Roisds5Y4gScnlXrktg0YzXsgCYMtlRyXYbzY9Ba
	U0v85vOCwAyIGQsZqx3ipTcPg257MyQrMCoU62hXHuJ/ydKQBVG253alXqzTTi8yT/fuAACKdGY
	vcX7ZIx+NZzt8Dy3NMFV7hwSVqYPvWN8dGDHpAalbh9XtYRa0WMMm8ETZcdd8TNUoznvJIpD+n+
	mIoV1mKkD9iDwYhvO2x39CwdYO28W65zJ3A9rpYToYR77c1Q0fr+OVqKsRTi0Zx5oW16QYnCCgq
	V2SSKGlXfOO0JAY7kOKm1SK3dYxYOvt0pOYDD2aW3c5vtoxuwwIKrngrdsc8Akc+l8VwSJ/zNV2
	84px5yLs5gN9LCCZoLNGFFYizWH9iu96anaue7SOznguV9kGVep1NAzpBNGV8kwDt7eW/q1osmW
	ZHXl7ZGbNWMveka1uJEXWr1negdOZcYnBjhv+h+ef5iIE5rc
X-Received: by 2002:a05:693c:87c6:10b0:367:5e31:ce29 with SMTP id 5a478bee46e88-36a42404ab3mr21838555eec.20.1793729306698;
        Tue, 03 Nov 2026 10:08:26 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a96172sm44904557eec.27.2026.11.03.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:08:25 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH v4 03/23] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
In-Reply-To: <20261030212112.2598640-4-seanjc@google.com>
Date: Tue, 03 Nov 2026 22:51:44 +0530
Message-ID: <tslx6dav.ritesh.list@gmail.com>
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-4-seanjc@google.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Sean Christopherson <seanjc@google.com> writes:

> Flush/zap every memslot in kvm_arch_flush_shadow_all(), i.e. when the
> owning userspace process is exiting, as KVM must ensure all associated
> memory is unmapped from the guest.
>

That's true and yes, this looks like a miss. I guess it must have gone
unnoticed because after the owning process exits, and when the vmfd is
closed it will issue a teardown. So the escape is only until the vmfd is
closed...
  kvm_arch_destroy_vm() -> kvmppc_free_radix()

The change looks good to me. I have only tested this on my qemu+dev
setup for now. But will give it a try on real hardware as well.

Thanks for taking care of this. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h |  1 -
>  arch/powerpc/kvm/powerpc.c          | 11 +++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 708a32f89776..50a42f80e5f1 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -910,7 +910,6 @@ struct kvm_vcpu_arch {
>  #define __KVM_HAVE_CREATE_DEVICE
>  
>  static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
> -static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
>  static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
>  
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..9e9d0865c2f6 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  	kvmppc_core_commit_memory_region(kvm, old, new, change);
>  }
>  
> +void kvm_arch_flush_shadow_all(struct kvm *kvm)
> +{
> +	struct kvm_memory_slot *slot;
> +	struct kvm_memslots *slots;
> +	int bkt;
> +
> +	slots = kvm_memslots(kvm);
> +	kvm_for_each_memslot(slot, bkt, slots)
> +		kvmppc_core_flush_memslot(kvm, slot);
> +}
> +
>  void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>  				   struct kvm_memory_slot *slot)
>  {
> -- 
> 2.56.0.385.gac671c819a-goog

