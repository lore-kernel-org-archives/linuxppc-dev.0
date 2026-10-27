Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A83606A31D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AwsXiTxm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDm5D1ksRz30DZ;
	Wed, 28 Oct 2026 09:54:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793141648;
	cv=none; b=LSYjAUmgjjM9vUL4vkzqdIkQWrWn3VyEHjcNIJUvZocQk0coKNxEbwGM5YKSPenBCMuAkKOaNVp1inc537BXzeuLFgk8os0HKJikz6EWaDAEcN8Feh8menvveqzuvSJ+OFymsfKkgji8iGqCmu1dP7vxSoMhZiMoc3E+wsz/cdHN7PYBk9BSO7QFssqea+mKix3EBgyVHEtGbBjQGiK0NNm6zoOkv3pjNr+9+wtUQsCc/wtPXArEt121bOconMUL8FTNHT5xoxgs5GCpbDCoAMVsLUHj3ZVNIEYyappt1onuCByb4SK19zY8qT61Or+uff53M8squEXdN94ARs9oAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793141648; c=relaxed/relaxed;
	bh=aTRn4SWx70tTlL1t7OA3leiDcQwKF7nF9/sYzOx9ZSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TnAHQwLE9GctW6g+lM5NpXntrh3UmmaGoPhtRGGRFpQcQ7bGF5BHNml/iOZDLa5Uw73AZIQrm3BwTjzIIw4cujCCoA2tWZUtCRrNUwN/gtXp5mSASoeF+bWrcX6AMmOJxiNNRtxaGzj6TnaqfRvPYi4q6pCyxq/MTOtzERjNy2fFp4P8QxnuQTWT4BdZCFx28PpA2XecdRCARrFqXzElidcrPT4tznPRuuLbGpkB1DeM7ThkzhgqBO5Sz7me6Bi4dwl0s8S2+HdjuTtagBQjk/OqmU7BGDH1etG1dD6rX7fBoQrc/YVbtR4etwC+JFHG93+78H4P2DE7kPBTTMz8qQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AwsXiTxm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com; envelope-from=3iyvhagykdmq2okxtmqyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AwsXiTxm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com; envelope-from=3iyvhagykdmq2okxtmqyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com [IPv6:2607:f8b0:4864:20::648])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDm5C1Mj8z30DY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:54:06 +1100 (AEDT)
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2eaae8d29e0so2449865ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793141644; x=1793746444; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTRn4SWx70tTlL1t7OA3leiDcQwKF7nF9/sYzOx9ZSQ=;
        b=AwsXiTxmQpiJ22UJrEZYoRbLINAtiK3tBdKlzBY4VZk2RVy/HwFqzWOgKPWslPqhLj
         3QD9atZfSReyt0Ju0kuyZxQ1JFJfNkCoTNyaxbJwB8wFpDCukc1CNDtmLF48cKm7SlM4
         XM5+e24rpkBBD8SLUwB7OFS6P1092iJWU7wlNhjxUcsuL1lx9F8/BvJx6BllUAYi8R8m
         lQLW3T9t3OB1U4Mh1i6oncHFvA7diK/CcHfW5/CiGGpVe72mqLFKqSYN/2icAALAZpHF
         MWc3LyhiI82A9W58lFEmckkxwYZx7R/Ejdg32TReWNfUJ2gFgG+IqH9WNNrCvJt9b9iW
         /kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141644; x=1793746444;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aTRn4SWx70tTlL1t7OA3leiDcQwKF7nF9/sYzOx9ZSQ=;
        b=UiOVSfdvEf51284+zaCnA1h++Iw2ckx0hfyEP5BDE/yOyLBWlhbAzh3E96BuHQOgOy
         pXBj4IMd6mSULrgvlIrhHwxxPSp0Nq98DoN2OCCLS0jZ84KO7Bm7RXsqeziyuQyozDs1
         FW84IsDagGDQpmmb9vhSmjtIvIiYv40QHBXVhG19UaxWgBSCtz8b7kCZnOrIYLyseaQd
         QspeRNFUPYCgxfvUaaUut7Jn8+IqWrYfx0BKDagdQ1tw8VVzaD+XdiFQZBSiHGSzP/lV
         YdXn0z3ikscjy7f3+HuRVpaOiGY802n4hRRpjITxDtQc9XF/mh7aZ+L/QJIFR+7DAEcf
         F0zg==
X-Forwarded-Encrypted: i=1; AKwUvBw8kJOxYp2MKfyaykIhm1bOUgUSVBa3+CeQGHVOe2qGEe3Qb0sBqwlzN76NvgxTyals1lrxxqEuWxWXlhE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLz2i747T652v31caXqEPTWjoqMh7rA9T9H4bd6FWo/huaWn7Xq
	6vsqWIvHUKtO5hL/dVp2tqgCfSLl//gB/tqyGxpten0G21oq8OXLJlFiEqE2H3FhLcDxv0hJf6+
	YF38J6Q==
X-Received: from pjx16.prod.google.com ([2002:a17:90b:5690:b0:3ab:3069:a58c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c5:b0:3ac:a11a:7c7f
 with SMTP id 98e67ed59e1d1-3ae581006c1mr311269a91.23.1793141643965; Tue, 27
 Oct 2026 15:54:03 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:54:03 -0700
In-Reply-To: <20261027221209.1560865-3-seanjc@google.com>
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
References: <20261027221209.1560865-1-seanjc@google.com> <20261027221209.1560865-3-seanjc@google.com>
Message-ID: <auEri3Ld3sp0515i@google.com>
Subject: Re: [PATCH v3 02/15] KVM: nVMX: Don't force a full nested VM-Exit
 when destroying a vCPU
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+Hyunwoo

On Tue, Oct 27, 2026, Sean Christopherson wrote:
> For all intents and purposes, revert commit b4b65b5642d6 ("KVM: x86: cleanup
> freeing of nested state") and go back to manually tearing down nested state
> when freeing a vCPU.
> 
> When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
> VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:
> 
>   vmx_vcpu_free()
>   |-> nested_vmx_free_vcpu()
>       |-> vmx_leave_nested()
>           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
>               |-> nested_flush_cached_shadow_vmcs12()
>                   |-> kvm_write_guest_cached()
>                       |-> __copy_to_user(ghc->hva, ...)
> 
> Accessing user memory via a memslot during VM destruction is broken, as
> there are no guarantees that current->mm == kvm->mm when the VM is dying,
> because the last reference to the VM can be put from a different process
> than the original creating processes.
> 
> And even if the original process does put the final reference, during
> process exit, do_exit() calls exit_mm() before closing file descriptors, so
> vCPU destruction runs with current->mm == NULL on a borrowed lazy TLB
> active_mm.  If the borrowed address space has a writable mapping at the
> to-be-written userspace address, KVM will corrupt an unrelated task's
> memory since uaccess APIs, including __copy_to_user(), don't sanity check
> current->mm (and *can't* sanity perform KVM's current->mm == kvm->mm check
> since that is firmly a KVM-only concept).
> 
> Furthermore, the shadow VMCS flaw is only the tip of the iceberg, as the
> MSR load/store lists mean that emulating a nested VM-Exit can read or write
> an arbitrary set of MSRs, e.g. if MSR_KVM_SYSTEM_TIME_NEW is in L1's MSR
> load list:
> 
>       kvm_arch_vcpu_destroy()
>         kvmclock_reset() - takes pv_time off kvm->gpc_list
>         vmx_vcpu_free()
>           nested_vmx_free_vcpu()
>             vmx_leave_nested()
>               nested_vmx_vmexit()
>                 __nested_vmx_vmexit()
>                   load_vmcs12_host_state()
>                     nested_vmx_load_msr() - writes the MSRs that L1 listed
>                   kvm_cpu_has_injectable_intr() - reads Xen's vcpu_info
>         kvm_xen_destroy_vcpu() - deactivates the vcpu_info cache
> 
> processing the MSR write puts the "pv_time" cache back on kvm->gpc_list,
> and the next list_del() writes into the freed vCPU.  And as effectively
> pointed out by syzbot[*], attempting to fix each case individually is a
> losing game of whack-a-mole.
> 
> Deliberately leave "nested_run_pending" as-is, because even though doing so
> creates potentitally inconsistent state, KVM should *never* consume said
> state while freeing a vCPU.  I.e. if leaving nested_run_pending set trips a
> sanity check or bug, then that just means there's more fixing to be done.
> 
> Open code only the "free vCPU" path, i.e. keep emulating a nested VM-Exit
> when forcing a vCPU out of L2 via vmx_leave_nested(), as there are a number
> of updates buried in the nested VM-Exit flow that are needed if the vCPU is
> going to run in L1, e.g. clearing pending exceptions and MTF traps, setting
> the TSC offset+scale information back to L1, and so on and so forth.  Note,
> this means svm_leave_nested() is all but guaranteed to be buggy, but that's
> basically an open secret at this point and at least any bugs "only" break
> L1, i.e. don't corrupt host state as is the case for abusing nested VM-Exit
> when freeing a vCPU.
> 
> Link: https://lore.kernel.org/all/6ac0145f.34119e79.2f92f3.0003.GAE@google.com [*]
> Fixes: b4b65b5642d6 ("KVM: x86: cleanup freeing of nested state")
> Cc: stable@vger.kernel.org

I completely forgot that Hyunwoo also reported this, so this also needs:

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/all/am3Bs0DjZ5kay9NJ@v4bel

