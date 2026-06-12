Return-Path: <linuxppc-dev+bounces-22572-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE4CCD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:56:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMyr4Yqpz2ykX;
	Sat, 13 Jun 2026 00:56:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1049"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781276164;
	cv=none; b=gvX0WZDEZo2BoiH6vWEhb6xQJVc1nUiyb/NZ0nEApGoWDvpoiUTtmWXuPULN5lTJTcPk6mCfsWUUVqmRf0dHwX7XQUvspDOYKODfr+4gqwNYMGmmSkP/bRQIsQ6IDS6q7Qci2nT7qmONSOcykaKKGKUfywbnW14uYnKVU41M5nT8zTwSsP6TzxCD4uPOc9YQv4X3/6T1bd4zLYs2qrzaynY+cqGQJeLyD9ulgjEQ2qYJnnRVRtwy2kJGqHQuaZVqlj8vR7wvLo0EkUTimCoTWJ2VNbZ9iilHFxFF+7FKRUe5zDodhdeFIe/J/pfL6LiCQh43N/8sDQy3PMmWFwdUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781276164; c=relaxed/relaxed;
	bh=WNcpHwpm6/26X/fcZOebiiBTkHhzzv3iZNMUq4LAPaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6dGzTf3rvfmHNQ3VRhH7j0G8yAENF8J/+jLEjCGoSf1JxlvnOd5vMz38wyzdNs9DzI4ENasw1Mi41QtxJ5OR0WZdogsI1ITRt9aPIfMtYlVrvnhrpVoEINVbYg62HA47uArwg1RrPFD7FhazKJlTyo/O0qQBawbZJdwk/cFMfng6jqjy31cajnUI2zBVB/B7+QvdcQm2TFfBHl8FRR7lih48NcfV5aRDUzTv88yTmVBP1eYeISSwU0QsmrtrfiYRJRkoBTmuvc28NUT625zPLK9dtLh3lULdXgxAl/1eLikUH9WWZZ9BaCNOF99FimIO5GXVAk9APij6roIathl0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=d83+GE+5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3_x0sagykdeqykgtpimuumrk.iusrot03vvi-jk1royzy.u5rghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=d83+GE+5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3_x0sagykdeqykgtpimuumrk.iusrot03vvi-jk1royzy.u5rghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcMyp6ffPz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 00:56:02 +1000 (AEST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-36ba98cc003so833504a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781276160; x=1781880960; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WNcpHwpm6/26X/fcZOebiiBTkHhzzv3iZNMUq4LAPaI=;
        b=d83+GE+51epVmzAVFxtpfQ9mrQe9ZpnaNgaOTBjPg1/lKD9RJ0AZYX9GUTtgY//v1h
         3FFZyXCTl+ZX/90kxvuNqGzGKKvsG2LdcPVUyOcmuSEGEBKjNLnjaOEMjDYc7383bEaY
         P+Q+xEykrlUm0ky/u6JD1yAG5fDAcyl5Bz2JAUmyWiq9448HEePwfM9+YBjdZaXP3p7g
         FHAR739KodC4x+3kum+lElhvEqCQ8204ByH9TQ8DkdI5l4JltXhRggGYazzGBnmBzbkp
         kiCM5NM0KXTCVp9jW+Cfpv9gy0+WFbbqrkQD9i7QdinmTBY/pZ64yvRINZrEwlDX2Vjd
         TCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781276160; x=1781880960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNcpHwpm6/26X/fcZOebiiBTkHhzzv3iZNMUq4LAPaI=;
        b=mWSEZWF29x2eBZQorJTjULnnsZ6unVENPhuuA78UGWT9TfCQRwox8acuAFhxk9Uco7
         jcjZpx0DzyqzSWEQjiyHqholAW4znupUCxeT2ajW/r3YEBp4JJ3vQvZs7TkLjUHFmt/5
         C3MLnrW2nm0qYO6aKKzi8UugH6tGDXw0AX7meZULYiYMl7bEWVBLLfSscNheALGyjgCg
         ji4onAW1eISSZ1S6wwZmhk6hV2gxrL5xEcJj9BwcgyjFCYhHrG/eihe51EFBi0RzGzK3
         9/PQYsLsvEgCkTtZ/b52IDmAgLhHVhV5NsvcWU0g0kgubV+hTVfnSEWT+up4d69NnxHS
         uKNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ifK0kCQsvz0ZfqvuY3ALM9RCC2aTw0vBzIEeqfo/lm2yQWABiMGVDOryO1Wq13A7nNlu6T1sF5TVmpsg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwZtZ/T8vCDD+QS0Nluc0McvmcZI0EnvjhSeKsxg2nFXFwmzC4B
	IQ1cDErOyxVvSiOoUjYY9t4dWx53r59+e8lM24ahd2eO+PpQfaf6jpJQHdZ+Ccy3v0Nvc7XEmgy
	E7O+i4g==
X-Received: from pjbaz15.prod.google.com ([2002:a17:90b:28f:b0:36a:9fc9:2f25])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b87:b0:369:c5f4:9681
 with SMTP id 98e67ed59e1d1-37a041b0151mr3710931a91.22.1781276159772; Fri, 12
 Jun 2026 07:55:59 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:55:59 -0700
In-Reply-To: <ik7nexem.ritesh.list@gmail.com>
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
References: <cover.1781093720.git.ritesh.list@gmail.com> <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com>
 <aiml9iB_vUASRRQV@google.com> <ik7nexem.ritesh.list@gmail.com>
Message-ID: <aiwd_8Jj34IH-pFH@google.com>
Subject: Re: [PATCH v3 RESEND 04/10] KVM: PPC: selftests: powerpc enable
 kvm_create_max_vcpus test
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 12, 2026, Ritesh Harjani wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> >> From: Nicholas Piggin <npiggin@gmail.com>
> >> 
> >> powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
> >> the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
> >> VM's limit.
> >> 
> >> The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
> >> to the kvm_create_max_vcpus test case to limit vCPU IDs to
> >> KVM_CAP_MAX_VCPUS on powerpc.
> >
> > How is this not a KVM bug?  Literally the reason this test exists is to validate
> > KVM's advertised KVM_CAP_MAX_VCPU_ID and KVM_CAP_MAX_VCPUS.
> 
> It's not a KVM bug, it's expected on PowerPC. On PowerPC, vCPU ID encodes SMT topology, e.g. on P9,
> vcpu id = core * stride + thread,
>   .. where the stride is same as kvm->arch.emul_smt_mode (VM's emulated SMT mode)
> 
> So the vcpu ID space can be sparse, however KVM_CAP_MAX_VCPU_ID is the
> absolute ceil value (MAX_SMT_THREADS * KVM_MAX_VCORES) i.e. the value
> with the maximum stride / SMT value.
> 
> Since default selftest VM uses stride 1, so it rejects IDS >= max_vcpus.
> 
> e.g.
> static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
> ...
> 		if (id >= (KVM_MAX_VCPUS * kvm->arch.emul_smt_mode)) {
> 			pr_devel("KVM: VCPU ID too high\n");
> 			core = KVM_MAX_VCORES;              /* rejected case */
> 		} else {
> 
> So, it's expected on PowerPC. vcpus with higher IDs can be created but
> for that we need to set KVM_CAP_PPC_SMT and use strided (sparse) IDs.
> But since the test as of now is not doing that - that's the reason why
> the patch only allows to test max vcpu IDs upto max vcpus.
> 
> But I guess you must be hating the #ifdef __powerpc__ there. I agree I
> don't like it either.. maybe we can do it this way?

I don't love the #ifdef, but it's more that I didn't want to effectively skip a
test because KVM was reporting bad information.  But after peeking at KVM_CAP_PPC_SMT,
I 100% agree we don't want to deal with that here.

> -#ifdef __powerpc64__
>         /*
> -        * powerpc has a particular format for the vcpu ID that depends on
> -        * the guest SMT mode, and the max ID cap is too large for non-SMT
> -        * modes, where the maximum ID is the same as the maximum vCPUs.
> +        * Some architectures (e.g. powerpc) encode topology into the vCPU ID,
> +        * so a default VM can't necessarily use the full advertised ID range.
> +        * Let the arch limit the highest ID this test will create.
>          */
> -       kvm_max_vcpu_id = kvm_max_vcpus;
> -#endif
> +       kvm_max_vcpu_id = kvm_arch_vcpu_id_limit(kvm_max_vcpus, kvm_max_vcpu_id);
> 
> 
> And then in kvm_util.c -
> +
> +__weak int kvm_arch_vcpu_id_limit(int nr_vcpus, int vcpu_id_max)
> +{
> +       return vcpu_id_max;
> +}

What if we do this?  We're going to be bleeding PPC details into the test no
matter what, adding an arch hooks just seems like extra cruft and an unnecessary
layer of indirection.

	/*
	 * Skip the vCPU ID test when running on PowerPC with SMT support, in
	 * which case system topology is encoded into the vCPU ID, and so a VM
	 * can't use the full advertised vCPU ID range without crafting a valid
	 * platform specific topology.
	 */
	if (kvm_max_vcpu_id > kvm_max_vcpus && !kvm_check_cap(KVM_CAP_PPC_SMT))
		test_vcpu_creation(
			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);

