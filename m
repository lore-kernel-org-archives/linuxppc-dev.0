Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8E4606A324
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RPVlAmAC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJQhJ6pPZz3c2H;
	Tue, 03 Nov 2026 09:03:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793657024;
	cv=pass; b=NAIjHqXY0O+JhjgPqjvZ0nPIGf0tRpWbViQfuIHqYxNT6UhTdGsTTADKwUVxaAc0CGyWNwhKNp5/OvVLCOws09BaydmlVJFGnwimunzgCdu2rfaPkajZ1dY6rPMKX5eCO2BWo3OJZmlW7cBxapwpEGZf8bYjRUogz5ZpFAJY3LUbzznLw/FJ5Ss95vxXoma0AL2NuwRV5V1kubnf15oqbOSkRzxxOzDI/pvuVwleD5Iyk2Cp8SQ45lwH8u8JZmLzQ3JcYaowNX0+xj+l1yjZfMm2m14jIpKnKuVrJQD38ELNz4nNaSQfrmchhI3xiC4JDOMVs3wVCOtQ/M6mOiRteA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793657024; c=relaxed/relaxed;
	bh=rrfVG2EGCWVcNVqJJ0w+zoLBPZPkVLhQgz0OvfGHs+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBpVH1r+hJMPk3IXPVJVnKI/4DDxNVkxLlxwWV0P3vmjEjtyRNETOiO3J3aSSMA3tS60jqP+T0VcOcBCeJ8XKdYrgAJ9luRGzIIMH7QkmlROR7e1HPOgRb/rlu9cdyyr2gwc0se0qO1w4sgQVMo+TIJKX0g5xyLULrKWmcyvmC3b9cXA9NrF5sFb4/dLrYGBDBV6t7RGSJhDTwV4A3iddiV7h95OqyEnZZd08DmiJhM0WG9Po7kt7YEInkXY/f1iNoQn+JnHD/uthmmXzo4E8kHfQyBstPhjojdxRTRUvu4m1e+g0wlmKzFUMwvc/SOTmIqj/vojCVaiE6Ozp2xJ2w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RPVlAmAC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=jmattson@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RPVlAmAC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=jmattson@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJQhH21gGz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 09:03:42 +1100 (AEDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso725a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 14:03:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793657018; cv=none;
        d=google.com; s=arc-20260327;
        b=pU+/+wv8Hvpj31vrs9P1Q7jphm7lC3YomsHYKSileeY6Il02eaq/EiHQKxnFwi+nx4
         Y55Hb2RS+ybqGX3VarFrDI8aUrwjmShSSz5uQW7zD6dE0DDWk78zeY7MF3n0IlN9JBe+
         5rhIl5FS3uXSBeuI6Xhv7m0ydUJJzLGLbMBoldn12xYgYWwKS0IxM2eO0L9bA4KlrnOJ
         rZEH8T3nb26wGPJRYrtBBewYNsLfF91CZYPOvbLmm3t+YLX6U1m944aHBRmNP2RY5ejc
         6QRtUXhQHfhTJUTyUFebR/raa1F5sZZf9D8arHefYvGYdwRuyh0NWkRO3QBj5RMv3Ve0
         Xo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rrfVG2EGCWVcNVqJJ0w+zoLBPZPkVLhQgz0OvfGHs+s=;
        fh=bkw2floFvs/0CC9ZygIyGQRCQZJnP8fX48+YHa5Rpqg=;
        b=JQFmG4zlPwT1877KQpi8ZOncxI/iZHE5+MBCO6jW+SMqnZN2AqRuFmpX590pKW4vJ1
         uPHqOSL+O5DrcLN/tCUqnP8RXZiNvnk5GPjnRDyiNZfacWKCzLZ8SsYZ+L+3Q9RzUSCG
         NH0mNicc7aODpkZHipMm+7C/8npyBTS1Enx82PaHRXjqO1Qf/P8WCtiu0lhBp0E1nedR
         8Pp5zA+w1MvNwTUILNcvNmkGbBa/bp8Q/+AQ8z0elrJNusoeerx6eOPR6LyfzQOnUXVw
         eE5xnpZgmcIpcxQrqC7rFJ2DTrYQBjrdl1AjqVrlAmXO8deXztcqtZ9ejO3L4uIB0jJ7
         P6gA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793657018; x=1794261818; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rrfVG2EGCWVcNVqJJ0w+zoLBPZPkVLhQgz0OvfGHs+s=;
        b=RPVlAmACuM7fo4uRcok7NjLGxx9M4u/2BvgQcl7YUA59RYP9yDtMa5RBkDxL6oXwlP
         /PBgYKYwjOTmp9BkKJ+5q0WUaHVUVv8qQmBq/X1f+pwVLXam9jkSYZr00lWSoET0nlOS
         HRyBk75EdcOlCJVoRglssFxCWblZ62+xoSkyl8uC+3d3PQ3NmPBt5SGGDnJDPRKAkGEt
         GT8hYk/YG3w8VZiliZ/AeQED318Hfq2OyN3j2LkZc64djnP6QMJT/kulGyZ1t1YjLFQ3
         dMdUeVSNqBNsrEl8/WOoZs/h/zaXUBr8ofO/XcfKwBMinMU3xuyvkPTLyl60XcBU5ofS
         87rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657018; x=1794261818;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rrfVG2EGCWVcNVqJJ0w+zoLBPZPkVLhQgz0OvfGHs+s=;
        b=ON77wJXhlRf0mMhwJyqvMov4Sfg0d2ImEcJ6vtksoRSu2a8+p1ByUYAEEYbvuZ6b55
         NwYwNuzItaBWUGPfzVj+CxX129w/9Aclx/oXbXB12FDZWYRyi0MLcyc9eUSCxBYXVtgR
         MB716ojkgQAbbMVCabPXeLlphWfAhcjOr7NWpIzbCPWhSCKHQeUofRDUxYAzV1+VUnF6
         +TevRKUtrvKgVR7HJNfvY3qAEZk0V4wwnEeWV2rsWuNvX+J9SbSJaLl3Zo/uqWisJS0n
         m9OaFJuNV0HEoh2tUY8usT9zY7IKtf1tlJ644v3GDMxPbMbmqoffOHqELUWK6xOD06tL
         QYRg==
X-Forwarded-Encrypted: i=1; AKwUvBz1SZQPYMTcxfwPToxWUiCQS4AL1rrWXAvrdDRuY+9BClVtQPW2llXNGmAiDyvjR7SHsmyOZx7l9shC+8U=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+wC067REcGbp3HAEB2+BVr45LiBAtVNjyAGLPKzG9CSWHtYr2u
	KXUm4/a0qkvOKjYAy6D8XoizvOVivDD57we6C88HhTuLxK3iP4mWZ4z6O3P2P/nLRC4u7X/FnPO
	VjxO6HMWv1L6p2aUTWa/YTkRwRPH+fCks+cvMhMoG
X-Gm-Gg: AYBFou08Hvct1NSlSlKq+v76cPnMx04SB70lZGyP1+PECCBIAu+7f7PE99zcWQaecFN
	BOwM7KssbgPko/PSLDF8yF3vzd4epkTBE4PVvlqcFhXLbFnvVgCi15H80FvPImY8ZHBEX2KLEl+
	jnZIl9c4VwuLbBcqsPDLBAypooYglrBSd5isvivNKxbQPzeJMfMtaN3p7+znSC/3Te/K1fyFaeO
	cjCyzWOZCNWFJIKLe3UUk2ZC5HaeWj0ZcNnY2Q/EkiuD/RtEyUurTlLEGdgEcNNLMPTYQp51yAQ
	Gz1ysOEjwCq/+RQ7g+VtsBznXGYo7GIAxy1a18aHCUWNcXaUs1H8sShREI1pd99DT8ngF6+F/W1
	jF2sgFpaynuJWOZEI5OJ+Ywo4UR8p+HHUP11+tQ==
X-Received: by 2002:a05:6402:2750:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b53e7796a1mr3987a12.15.1793657017608; Mon, 02 Nov 2026
 14:03:37 -0800 (PST)
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
MIME-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-3-seanjc@google.com>
In-Reply-To: <20261030212112.2598640-3-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 2 Nov 2026 14:03:25 -0800
X-Gm-Features: AclHuK_pbmXvVHoGFvB48dY3tOJxijbO3CKujkx_4ml0ueoZxbb4z5FYesg9juM
Message-ID: <CALMp9eR-di2U5QZzDHh7CjnVg20ZnBcTBu0CKbbWh9QCxYiJdQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/23] KVM: nVMX: Don't force a full nested VM-Exit
 when destroying a vCPU
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 2:21=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> For all intents and purposes, revert commit b4b65b5642d6 ("KVM: x86: clea=
nup
> freeing of nested state") and go back to manually tearing down nested sta=
te
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
> there are no guarantees that current->mm =3D=3D kvm->mm when the VM is dy=
ing,
> because the last reference to the VM can be put from a different process
> than the original creating processes.
>
> And even if the original process does put the final reference, during
> process exit, do_exit() calls exit_mm() before closing file descriptors, =
so
> vCPU destruction runs with current->mm =3D=3D NULL on a borrowed lazy TLB
> active_mm.  If the borrowed address space has a writable mapping at the
> to-be-written userspace address, KVM will corrupt an unrelated task's
> memory since uaccess APIs, including __copy_to_user(), don't sanity check
> current->mm (and *can't* sanity perform KVM's current->mm =3D=3D kvm->mm =
check

s/sanity//

> since that is firmly a KVM-only concept).
>
> Furthermore, the shadow VMCS flaw is only the tip of the iceberg, as the
> MSR load/store lists mean that emulating a nested VM-Exit can read or wri=
te
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
>                     nested_vmx_load_msr() - writes the MSRs that L1 liste=
d
>                   kvm_cpu_has_injectable_intr() - reads Xen's vcpu_info
>         kvm_xen_destroy_vcpu() - deactivates the vcpu_info cache
>
> processing the MSR write puts the "pv_time" cache back on kvm->gpc_list,
> and the next list_del() writes into the freed vCPU.  And as effectively
> pointed out by syzbot[*], attempting to fix each case individually is a
> losing game of whack-a-mole.
>
> Deliberately leave "nested_run_pending" as-is, because even though doing =
so
> creates potentitally inconsistent state, KVM should *never* consume said

s/potentitally/potentially/

> state while freeing a vCPU.  I.e. if leaving nested_run_pending set trips=
 a
> sanity check or bug, then that just means there's more fixing to be done.
>
> Open code only the "free vCPU" path, i.e. keep emulating a nested VM-Exit
> when forcing a vCPU out of L2 via vmx_leave_nested(), as there are a numb=
er
> of updates buried in the nested VM-Exit flow that are needed if the vCPU =
is
> going to run in L1, e.g. clearing pending exceptions and MTF traps, setti=
ng
> the TSC offset+scale information back to L1, and so on and so forth.  Not=
e,
> this means svm_leave_nested() is all but guaranteed to be buggy, but that=
's
> basically an open secret at this point and at least any bugs "only" break
> L1, i.e. don't corrupt host state as is the case for abusing nested VM-Ex=
it
> when freeing a vCPU.
>
> Link: https://lore.kernel.org/all/6ac0145f.34119e79.2f92f3.0003.GAE@googl=
e.com [*]
> Fixes: b4b65b5642d6 ("KVM: x86: cleanup freeing of nested state")
> Cc: stable@vger.kernel.org
> Co-developed-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>

