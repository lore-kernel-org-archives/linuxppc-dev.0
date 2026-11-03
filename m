Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4D606A324
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=byWC7uNh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJy4m6J7Lz2xdX;
	Wed, 04 Nov 2026 05:38:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793731096;
	cv=none; b=hgiVpzHA3wQOAsyVCCZ2jzH+LmWxMvsdPaSXOEBgTPeIQoSr+5NG6xYQs1DQd2+TkTL+LD+CGYLGuGDYC0vSEFPpsuTuxPldX5L6gc1fGqTtiKJU0NWr2J/MASDqkaGI7bSVm9Er4aedEqzuy81RV/yYP9N395/cmS1QlcA+RkZ+l8Aw7cQlyZIyW7yjDhRaoFahOlMM8lXiZCu3l8Tf4YumcLSr2SdefjoPFgPuRfsnTw9N04zT5w8ZpzzaF82JNb70vRF8c+Ckp+c3aCJnF5XdlnxyYiVy31lB5j9w1mouyV++A9xf2sc1NfwEgUdAmml0MPrX4g1SBCRB+peIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793731096; c=relaxed/relaxed;
	bh=CGbm9EJEB5hNXXRNfY8Hb9YZuJsenYM7BZIV4eVSx/k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=g0LaGAe6AN1W19eO11vnjTwKiZUM79DsMEVpzJ2uN4YPuTIkdHxpU0rC7o/8FIs8gI1qE+eK6jZiKZWdZbj7kzVQfa4+d+Rl8vvkrrYfEh0QPr5V5GilQPBfaAD7QuOgYpUrcyK4RTnLW91rQKemIGL5iIBNUyBGu8ypm4FLHf9FhuHckRTSCFn8d5n0Je0607tK5lOomU07cQKdg00Cz4simydz0fIuAw4N7oBPBVWvbX4K0V93t3EgOoA5flg7nZoC1mqmmzKvUfmqE7Ho4xh9FaNrgdOXwXJ8BqR/uD6cAuZhbRHI/8mKRtyCWh27odsZ0D9AnusRG7tw12dPGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=byWC7uNh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=byWC7uNh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJy4h2fxxz2xSZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 05:38:11 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-369f33df08eso8591223eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 10:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793731090; x=1794335890; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CGbm9EJEB5hNXXRNfY8Hb9YZuJsenYM7BZIV4eVSx/k=;
        b=byWC7uNhTQKE5Tn5NZfJLshoJyGUSqBzWcFIDLiOch5B0fsylp2xIM9FxTwGeqR7uM
         B9qbpQjrFl1XS3QC2C02/EbzCGHMResxyiTox2XUOKopJXC5AEf9Qn/PPQ/CYNJpiFLX
         SSOqT1pybne+5WIYKbxIXZ9zmUQplZMJvXySkuqTYKacA9AfLGeqTBJVNAeAmLsnuvgq
         qxhZSRm2h4rZitfYUeR3WlEgB356VMI+Eeu/+s1WBrnXF9NGs+DyXFM1eTQjFGyVk3LW
         ap29Pl4ZGV9Vk58g+FOIjm/+W3w4ADv+xHTtIGo+UgTMSIq1bApPChHeEgxwGYEUppfL
         wmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731090; x=1794335890;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CGbm9EJEB5hNXXRNfY8Hb9YZuJsenYM7BZIV4eVSx/k=;
        b=aAbnXyOni54YDz2Cm4EpO9JgJAV7sN0CVgji0SL+Ev/B1ZMPd4OUkSNtuH9eGv9wxs
         WlfNjcPtJ3oD7YonuYaNrUpcIizwsYq9oXXHIeF4EckZ9hzLOFokrBJfRiCb4vrGJNmc
         6Lnl5HfQKVvtoWEzuy8+Unay4KoogdAn3UMmwdtEkrVToxkusz/NIGrU91WY8gPGTkwI
         ECbeaTUL0zyagkEsfhtShJzQW/kd7ZUi4zeJ2/rCvgFguUkvMzFeSqaQgMwoBYi09XKZ
         RU228aP328IkPY/wGduAzFd0DPUil4q8iHKkKCUPZK8e3VvWtugwQ9x1s1amSLBM29CZ
         69Pw==
X-Forwarded-Encrypted: i=1; AKwUvBxqRwjvh8obNDqE1GC7nmjLjHn35xmU9L7gA7/ezX5QWk4ccaGiHt9qLRdjCoKqna2pIAKo82dOpLsy/4E=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z96r3leaKoeKN0HgsLaz9v5e/5KGqgu+ji3iLltoECXcSkZRGj1
	R97OP/WH9InnglEmXyORkF/5ZmZLSWt0pZZMOz86Lc9fqldHxjT4qooDy9N4wg==
X-Gm-Gg: AYBFou3kvHLJl+5OAM3dNCKWYYmZPhYn2xYdRjOUCPhtl0310zjTqK8YIeQe8jTpDMe
	9r2zZrNzyfeBh5uhbBPLcSWlcf1s2harQMSFSsUwPWI+nFki+yHv2sKwZtRe/DhBwcyd1qsENyL
	rItlFN3J/2YbB0XRspIazCYpYosg7XoTJMZS8cJL6EnDWaSUojS+YnNslc0Gu87BvePuSfWGt/C
	29s1MdTXXmzjZNi5UGMmhyCdzaXdtaidC7lCz/Cx+mjBpeKvvFAD+i95/tBmJiEQcO4kczpDv5y
	tAvea0XeygyCBtptPz1xgLaD59kFfXEdHsEO+AnTPlJS2nUBFYQfdeIcSsN9/pMAr8rjqmRKNmP
	RccWCN1e0IvSvt9az6eTLLGgl7eynKuvJpUTkXxEzmjQyx83Sux7OOtXsD5JHL+jR5GD5V4KrmR
	ET7ZL3GuZiEiKZXNuUHRRBoMTSt6VbXIxwFCIbqzhNGAqIe/C7uCPLt2oH5FdW7rSr4ijVH4VPh
	i2ZhJIouU5EynSX1NCJC7WhCvr7d/okn5x2gtGy1p/58Cr00X9mk2/6N6N0FM2OUeDoUNlIeiXo
	WcOAyXS42yP/iYrOSzXjQTIrOac=
X-Received: by 2002:a05:693c:4153:20b0:358:8f02:e0ca with SMTP id 5a478bee46e88-36a4236903fmr21434174eec.9.1793731089637;
        Tue, 03 Nov 2026 10:38:09 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm58473902eec.25.2026.11.03.10.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:38:08 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 12/23] KVM: Destroy memslots immediately after mmu_notifiers are unregistered
In-Reply-To: <auitWWkOopYYbBH3@google.com>
Date: Tue, 03 Nov 2026 23:38:34 +0530
Message-ID: <se1h6b4t.ritesh.list@gmail.com>
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-13-seanjc@google.com> <sashiko-outbox-191627@kernel.org> <auitWWkOopYYbBH3@google.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sean Christopherson <seanjc@google.com> writes:

> +Gautam and PPC lists/maintainers
>
> On Fri, Oct 30, 2026, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] KVM: PPC: Book3S HV: rmap_nested memory leak in kvmhv_release_all_nested()
>> --
>> 
>> commit 9c25a1b4a76e8526eb8a2b11e1b9e63893b0de80
>> Author: Sean Christopherson <seanjc@google.com>
>> 
>> KVM: Destroy memslots immediately after mmu_notifiers are unregistered
>> 
>> This commit replaces active memslots with an empty memslot set and frees all
>> memslots immediately after unregistering the MMU notifier in kvm_destroy_vm(),
>> prior to calling kvm_arch_destroy_vm().
>> 
>> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> > index fa548b12228ff..2eda12a52bf4b 100644
>> > --- a/virt/kvm/kvm_main.c
>> > +++ b/virt/kvm/kvm_main.c
>> 
>> [ ... ]
>> 
>> > @@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
>> >  		kvm->mn_active_invalidate_count = 0;
>> >  	else
>> >  		WARN_ON(kvm->mmu_invalidate_in_progress);
>> > +	kvm_destroy_memslots(kvm);
>> > +
>> >  	kvm_arch_destroy_vm(kvm);
>> >  	kvm_destroy_devices(kvm);
>> > -	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>> > -		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>> > -	}
>> 
>> [Severity: Medium]
>> Does hoisting kvm_destroy_memslots() above kvm_arch_destroy_vm() leak
>> struct rmap_nested allocations in slot->arch.rmap on PowerPC Book3S HV when
>> destroying a VM with nested virtualization enabled?
>
> I don't think so?  Patch 3[*], "KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()",
> should free the rmaps in response to kvm_arch_flush_shadow_all().   From what I
> can tell, the page tables have to be in radix mode, and so the rmaps are freed via:
>
>   kvmppc_radix_flush_memslot()
>   |
>   -> kvmppc_unmap_pte()
>      |
>      -> kvmhv_remove_nest_rmap_range()
>         |
>         -> kvmhv_remove_nest_rmap_list()
>

That's correct. Maybe, I think Sashiko didn't consider patch-3 of the series
during review of this patch-12.

> And if that doesn't work, it means memslot deletion on an active VM is completely
> broken.
>
> However, it means the memslot code in kvmhv_release_all_nested() is
> dead code,

Not really. I do see a caller of this, for when we switch from radix
to HPT. So we still need it.

INCOMING CALLS
- f kvmhv_release_all_nested
  - f kvmppc_switch_mmu_to_hpt    [arch/powerpc/kvm/book3s_hv.c:5591]
    + f kvmppc_alloc_reset_hpt    [arch/powerpc/kvm/book3s_64_mmu_hv.c:144]
    + f kvmhv_configure_mmu       [arch/powerpc/kvm/book3s_hv.c:6330]
  + f kvmppc_core_destroy_vm_hv   [arch/powerpc/kvm/book3s_hv.c:5930]



So FWIW patch-12 as such looks good to me from PowerPC perspective,
since those rmap entries will get freed up as part of the
mmu_notifier_unregister() (after patch-3). Agreed that Sashiko
comment does not look correct.

Thanks for looking into this.

-ritesh


> so this as follow-up to patch 3?  Or maybe folded in?
>
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
> index a6ff42d7666c..27985210f972 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -802,8 +802,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
>  	int lpid;
>  	struct kvm_nested_guest *gp;
>  	struct kvm_nested_guest *freelist = NULL;
> -	struct kvm_memory_slot *memslot;
> -	int srcu_idx, bkt;
>  
>  	spin_lock(&kvm->mmu_lock);
>  	idr_for_each_entry(&kvm->arch.kvm_nested_guest_idr, gp, lpid) {
> @@ -820,11 +818,6 @@ void kvmhv_release_all_nested(struct kvm *kvm)
>  		freelist = gp->next;
>  		kvmhv_release_nested(gp);
>  	}
> -
> -	srcu_idx = srcu_read_lock(&kvm->srcu);
> -	kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
> -		kvmhv_free_memslot_nest_rmap(memslot);
> -	srcu_read_unlock(&kvm->srcu, srcu_idx);
>  }
>  
>  /* caller must hold gp->tlb_lock */
> 			
>
> [*] https://lore.kernel.org/all/20261030212112.2598640-4-seanjc@google.com
>
>> In virt/kvm/kvm_main.c, kvm_destroy_memslots() replaces kvm->memslots[i]
>> with kvm_empty_memslots and frees each memslot via
>> kvm_free_memslot() -> kvm_arch_free_memslot() -> kvmppc_core_free_memslot_hv()
>> in arch/powerpc/kvm/book3s_hv.c:
>> 
>>     static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *slot)
>>     {
>>             vfree(slot->arch.rmap);
>>             slot->arch.rmap = NULL;
>>     }
>> 
>> which frees the slot->arch.rmap array without freeing the linked
>> struct rmap_nested entries.
>> 
>> Previously, those entries were freed before memslot destruction via
>> kvm_arch_destroy_vm() -> kvmppc_core_destroy_vm_hv() ->
>> kvmhv_release_all_nested() in arch/powerpc/kvm/book3s_hv_nested.c:
>> 
>>     srcu_idx = srcu_read_lock(&kvm->srcu);
>>     kvm_for_each_memslot(memslot, bkt, kvm_memslots(kvm))
>>             kvmhv_free_memslot_nest_rmap(memslot);
>>     srcu_read_unlock(&kvm->srcu, srcu_idx);
>> 
>> With kvm_destroy_memslots() running before kvm_arch_destroy_vm(),
>> kvm_memslots(kvm) now returns kvm_empty_memslots and the memslots have
>> already been freed when kvmhv_release_all_nested() runs, so
>> kvmhv_free_memslot_nest_rmap() is never called. Any struct rmap_nested
>> entries remaining in slot->arch.rmap at teardown (for example, when
>> KVMPPC_SECURE_INIT_DONE causes kvmppc_radix_flush_memslot() to return early,
>> or when 4KB PTEs were replaced by a huge page in kvmppc_unmap_free_pte())
>> will be leaked.
>> 
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20261030212112.2598640-1-seanjc@google.com?part=12
>> 

