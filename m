Return-Path: <linuxppc-dev+bounces-22574-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD5BCD98CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 15:17:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcNRh3CY3z2ykX;
	Sat, 13 Jun 2026 01:17:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781277456;
	cv=none; b=faBmk78dLfBBTk2tVRa6zubm0vTa21eH67XfvG3scRSTWzfei87ljsZCgS2d/PumNXWQvi/2nsUYSxwk+Ov9HmRXHyE2n0dHfgd+aBHTAhfGEwYiEvm0kqbCKKJDDGgdRGUScYcr+o0KB1+xZqC/hoFdIDOw+HNhykoKOZ9L8jeYmCVBYCjASMsPnA3hHAd6EhGqyC34I3HTXnQttuyV/k/QEVOn1UtA3t3dqekf8ptlqC3T2GUZklEKU57SFM/EIdT3lhhd1rKSPaeGynnA2g5aoxf5Ogh31MibITVGLtFlkBE5Mf+Ny+jkE1bc33AZuoc61tAAN+behj8LKaxMew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781277456; c=relaxed/relaxed;
	bh=hKi6voXMiSHRHdUtGCaL73/GFSuif8U6u8yo1gqGgaw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=hTTXxevcIxBM69oEJC6qJrwgyrdZ/xtf/+LJaMu1ClN/p2QajTcCSesr96+YzeG+vFId2F5ZfIy8s8GUJtwFIfrElIEWwEGTCP8wjyWuvM81UWeeXxa1Zt+cxZgMPVtgWtLF7E76ZOZ69uQmztCLr4OqdCs6kxkcf0+k4tB0HYKA2rzQfVtv47T7DR8ua/e/tTTJ2H0ssCRQzK5jRixhAdn/lbX5TANPy7iEa1F3ypX4xaXyi9nLEaZDnOJCyofUU8L19/AomblY4DmoW61BrVt1F0i/HgQG2JAvYgvDmeMCPfb8454sB6O7EUHUYj3dW0OzMrV90SNGHKByTDs+Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ryo0yPGs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ryo0yPGs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcNRg1ncSz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 01:17:34 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso10033465ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781277452; x=1781882252; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hKi6voXMiSHRHdUtGCaL73/GFSuif8U6u8yo1gqGgaw=;
        b=ryo0yPGsiwPz0yNu6t5SRB+5/PaZVt7zPaiqZF+DuCTkjs3WqZuSFKqKLIpaJNgZV8
         SRbGvzv2r8B2DgN+rWApT9YwH2tsW1xGwL3W0+4zyc02p+XW6VvoPMdxmIandDt0OQcm
         4vynBhVUvXWeHke1tGUEVpCS3T9H/giNI+f58AyjvrOFNpSgSkIVx9+lntjs0nu3CC98
         7u/2RlY7ThladF+zUb8NenWTooJ6ipoOKykkJXZ6reMa19J/zOQTXMWk/RnPH3AUbleo
         GO5PCsAwo/BAQTBWIFDC7PWdbXpXPBOr+ZobUqSlDxP0v3INvixgei6dkwvsF3pku14j
         t64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781277452; x=1781882252;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKi6voXMiSHRHdUtGCaL73/GFSuif8U6u8yo1gqGgaw=;
        b=HYsgkMejo0oEuB5ZoKThxk3SPVRa30PB3RyLehr6GJA/nU/mX73ZPI4dZdr6IRuwl8
         fbxv+E57mh1Q6wW9Jbkbo3gJC70tX1H9J2xaETe066jVBU5j5spY7gta5H+O6CW6tN36
         RUkReNLomoiGhKyBKfLxsdihpUPLqZr6B65IlHu59jJbA8Ys0Nx/7vdp7J5uSQp8tFIr
         sTO91qiO3Q36PXw+rHP9qdCMgUskpsvg1kIxBOd7k624r6K4sJm9u10uQ02lG8/D9anh
         FB1mDiGwrkPyOV9aRqFTObJLC3EwLJRJQQ/7apVDdBTOimBDgHNWXmTX/ALAHukRyNl6
         mirw==
X-Forwarded-Encrypted: i=1; AFNElJ9Xo6aY9KBnsgAqWtykBOf2DvyqTLRbhn+xI7+h/WPPyrnlitPiB6PaP1XOKxag2fkDijvXJW2kWcDLAEw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxcN5vimMxociowvNJBDSuK0x4NgE/EMjM8nW4R3RJ1vmVvr2bF
	i2dmWv0SkVRqmMlcc/i1WGLhXzo4NtryZnSOMejlgcTItT+X15aQ1cJ7
X-Gm-Gg: Acq92OHm2ZwD/7Sy9zXC08DiaF45LZ5X9T9qnEBiLR3ZjOV+9gzXvVHCvQnlusaXIPi
	diiR0F8XbOmQitf3wBdqvEFwNsQOpkonW28KSO+eF167tXHK3DXerko2IrLXb7cOjbkSEvOf5sF
	6Q5s3lchv8M0LHbSqT38no5DVgdXTGyq9ZPQUYsm0MBGdtx+tmHFgwYi+ZlsTj4giCEv3QWeje9
	e4Svh6KHjmT/sP8XXHLpFZWuOVfBDCfTi6BQWwLnEKqoEZ7n4LdxwSoTBbFSUEyYcwys4eD72Wc
	R4+8jLUkiUZCAWYAZPcE4PiskqCEMnX/6JrZNzEFxcSMe1ZqzhD50tEyP7F8EkvS8TKJEFfowzy
	I9cDkw0Aru6+1YX4reGxaxK4ByoGXoUnkvGFJJLz4OLHYUqsleS/QJ5Jw8mwGC1LdLWRFyXtnbW
	uNwRw0gr9e/wWiLqCzN5A3JMKH0Q==
X-Received: by 2002:a17:903:2285:b0:2c0:db23:4a4 with SMTP id d9443c01a7336-2c412d25493mr38857585ad.36.1781277452015;
        Fri, 12 Jun 2026 08:17:32 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm26390065ad.38.2026.06.12.08.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 08:17:31 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 RESEND 04/10] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
In-Reply-To: <aiwd_8Jj34IH-pFH@google.com>
Date: Fri, 12 Jun 2026 20:44:17 +0530
Message-ID: <fr2reqpi.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com> <aiml9iB_vUASRRQV@google.com> <ik7nexem.ritesh.list@gmail.com> <aiwd_8Jj34IH-pFH@google.com>
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

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jun 12, 2026, Ritesh Harjani wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
>> >> From: Nicholas Piggin <npiggin@gmail.com>
>> >> 
>> >> powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
>> >> the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
>> >> VM's limit.
>> >> 
>> >> The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
>> >> to the kvm_create_max_vcpus test case to limit vCPU IDs to
>> >> KVM_CAP_MAX_VCPUS on powerpc.
>> >
>> > How is this not a KVM bug?  Literally the reason this test exists is to validate
>> > KVM's advertised KVM_CAP_MAX_VCPU_ID and KVM_CAP_MAX_VCPUS.
>> 
>> It's not a KVM bug, it's expected on PowerPC. On PowerPC, vCPU ID encodes SMT topology, e.g. on P9,
>> vcpu id = core * stride + thread,
>>   .. where the stride is same as kvm->arch.emul_smt_mode (VM's emulated SMT mode)
>> 
>> So the vcpu ID space can be sparse, however KVM_CAP_MAX_VCPU_ID is the
>> absolute ceil value (MAX_SMT_THREADS * KVM_MAX_VCORES) i.e. the value
>> with the maximum stride / SMT value.
>> 
>> Since default selftest VM uses stride 1, so it rejects IDS >= max_vcpus.
>> 
>> e.g.
>> static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
>> ...
>> 		if (id >= (KVM_MAX_VCPUS * kvm->arch.emul_smt_mode)) {
>> 			pr_devel("KVM: VCPU ID too high\n");
>> 			core = KVM_MAX_VCORES;              /* rejected case */
>> 		} else {
>> 
>> So, it's expected on PowerPC. vcpus with higher IDs can be created but
>> for that we need to set KVM_CAP_PPC_SMT and use strided (sparse) IDs.
>> But since the test as of now is not doing that - that's the reason why
>> the patch only allows to test max vcpu IDs upto max vcpus.
>> 
>> But I guess you must be hating the #ifdef __powerpc__ there. I agree I
>> don't like it either.. maybe we can do it this way?
>
> I don't love the #ifdef, but it's more that I didn't want to effectively skip a
> test because KVM was reporting bad information.  But after peeking at KVM_CAP_PPC_SMT,
> I 100% agree we don't want to deal with that here.
>
>> -#ifdef __powerpc64__
>>         /*
>> -        * powerpc has a particular format for the vcpu ID that depends on
>> -        * the guest SMT mode, and the max ID cap is too large for non-SMT
>> -        * modes, where the maximum ID is the same as the maximum vCPUs.
>> +        * Some architectures (e.g. powerpc) encode topology into the vCPU ID,
>> +        * so a default VM can't necessarily use the full advertised ID range.
>> +        * Let the arch limit the highest ID this test will create.
>>          */
>> -       kvm_max_vcpu_id = kvm_max_vcpus;
>> -#endif
>> +       kvm_max_vcpu_id = kvm_arch_vcpu_id_limit(kvm_max_vcpus, kvm_max_vcpu_id);
>> 
>> 
>> And then in kvm_util.c -
>> +
>> +__weak int kvm_arch_vcpu_id_limit(int nr_vcpus, int vcpu_id_max)
>> +{
>> +       return vcpu_id_max;
>> +}
>
> What if we do this?  We're going to be bleeding PPC details into the test no
> matter what, adding an arch hooks just seems like extra cruft and an unnecessary
> layer of indirection.
>
> 	/*
> 	 * Skip the vCPU ID test when running on PowerPC with SMT support, in
> 	 * which case system topology is encoded into the vCPU ID, and so a VM
> 	 * can't use the full advertised vCPU ID range without crafting a valid
> 	 * platform specific topology.
> 	 */
> 	if (kvm_max_vcpu_id > kvm_max_vcpus && !kvm_check_cap(KVM_CAP_PPC_SMT))
> 		test_vcpu_creation(
> 			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);

Thanks! That should do and I think that's the most cleaner version.

I will change patch-4 with your suggested changes then.

-ritesh

