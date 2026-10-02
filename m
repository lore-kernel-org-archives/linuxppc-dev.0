Return-Path: <linuxppc-dev+bounces-28782-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3898BCA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 22:16:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxNRJ6CXXz2y8r;
	Sat, 03 Oct 2026 08:16:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790979388;
	cv=none; b=MMTZhFPTbaPAmKy0+oNREkCShR42nQjebxrj5zgIwNRX9MDidSzMsdZY2EO0fdIDCKM3qHEhLlupXdE8G+ivnQ2YS5Kwao2LxA+HWwmrOK1HcRWMN43hQ87g3Aixoi/6ksWueISh1qMN82Sx4Xcl9T867MBNjIrPM2a8HYF0elP0k0S4+9hI9jbomV9Y/rncA8YK4tnQE0yxYAp8FSm4wOTJyVkevb1knTia+U5gCZyztpYXruqYjPNPUz4ViMklt9A73C91+fwVcZVOw2KHT68bYiWNUZiRdHFJ1Mwn6GJGNZJpOBHEWCoo9mteqoZZueDrdburdJLVNgPUA/W1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790979388; c=relaxed/relaxed;
	bh=4ZUOmUpFAdn6kAClohBDNQiVlfBYiZoDgK+pqSPmkXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UvlvCEkOofrgr94RysXjZ+6/v5dJBOaqQTVOg4N0wLrWr/a5KEknWgYWNXTbnnZLH4IhlGdYk1MHATiTgMbLg9YfsHYs/i8LDFF59ZvPUMzW1lehqpi0xCYOYddIlcsRCFzsa7s/towIcxqhTRvHQ7SyXWObCE63P4A2NPAXn/rUiex7R2Ug6v6ujTe1pdvXLt8RcOlyIRRbulgngPU1jmcW65KbOq8HttEER51T4IPNGAjqEkrDR+fpMNtAp+ScrzqK7Q/0nZhsvlXIQwIhDXi6Iu8yj66p9ilLorH0QmV79qANwPXB52beXvEkkqc3d85HUHunPcS4brV5hRw5vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=glvZp1dl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3ny3aagykdo4iuqdzsweewbu.secbydknffs-tulbyiji.epbqri.ehw@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=glvZp1dl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3ny3aagykdo4iuqdzsweewbu.secbydknffs-tulbyiji.epbqri.ehw@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxNRH1DrHz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 08:16:26 +1000 (AEST)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e2f3251e91so495555ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790979384; x=1791584184; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZUOmUpFAdn6kAClohBDNQiVlfBYiZoDgK+pqSPmkXA=;
        b=glvZp1dlNd2YLJv3E6OjX+6omxmTWl0Htew5PlWU0+Hqre1kSouWSLSlussY6liHOl
         2MC9N+FX5XK03hd8s45fH3D8MPfFiyzond4YjFSgEkoWI5E5nxNDm+F8mtkwtZQv8lQv
         MwKJz2bgjBvf/DkFAGahErNLZOq7y8d7PyA1aGUysGVDrXYbLEEj/Q0a4L6D+RpEGks1
         L2TaESCCRuU7zyEUXKQ/ZsOsa29+jQP8+VebVfrU7l21T20XxaKS+sP4R/Dk5415QTPv
         /8C5AP1uXxHiF1gWYw1zVUvYB5koFj8EzQzdsgQGBK+rSxHhbeDANYqVPETawZDkDS4T
         Cz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790979384; x=1791584184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZUOmUpFAdn6kAClohBDNQiVlfBYiZoDgK+pqSPmkXA=;
        b=CV+dmgxGkz1FRtPdKmBihlsQWvVh6busqzzFrOGYrzy9+/GcL4jwMoplcEQuy1ldaj
         2IDeV9fM5FtA/oV8Hwfep/MkX4L2Hsox1KoXO9SnCYfyic1mJhz2xfxdtYTyQojmTRUz
         TN3qJlwfRlkDR4vHrEGSj8MDwvB9+YGEBbdCXAPg9Qk77sRqthX+hCl5VLrLUUzK/IpL
         iXgSQ1hmVYa+OLA6ibGzhSNh8Cuqbcf3Kzj9BSmP3QVAB886LzPYWRum0zpV0JAQQvHS
         XxICT33hA1oE4CcMuOdMBvWTAnfnMCIqUsAmwxT8Ek6cD5rNYlm348LX5LRtbM3VOiKr
         27fw==
X-Forwarded-Encrypted: i=1; AKwUvBwJQapRa/4L35nJGx8ptzDXRCxv835Q7LU1uDzmwWnLAp3nZ4Hsa/Kp+3DLDucmTtIOK+kGc14O3dlj+TI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKl9KLmYuBUJff1WCYDUJ6PiWHQdyWMykXEalNK8sCnCutOK3Vr
	F8AuE748HftapiyQ4YGhe7StJnzn5QDb/PYHQrwVHijQq055jvkv+NlhTlN4Q8Dsr1litccQhRH
	kxnuNpA==
X-Received: from plbml16.prod.google.com ([2002:a17:903:34d0:b0:2e1:326b:da73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18e:b0:2e3:1bb4:6113
 with SMTP id d9443c01a7336-2e49b648c41mr42782405ad.26.1790979383748; Fri, 02
 Oct 2026 15:16:23 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:16:23 -0700
In-Reply-To: <25cdef9c45a1270dcad7e9c4140e56b6953eb27b.1790101179.git.ritesh.list@gmail.com>
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
References: <cover.1790101179.git.ritesh.list@gmail.com> <25cdef9c45a1270dcad7e9c4140e56b6953eb27b.1790101179.git.ritesh.list@gmail.com>
Message-ID: <asAtNhSQHDy_k0d_@google.com>
Subject: Re: [PATCH v5 5/9] KVM: selftests: Make kvm_create_max_vcpus tolerate ENOMEM
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
> diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> index 59ddc3757943..45a9d8b369b5 100644
> --- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> +++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> @@ -20,16 +20,29 @@
>  void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
>  {
>  	struct kvm_vm *vm;
> -	int i;
> +	struct kvm_vcpu *vcpu;
> +	int i, created = 0;
>  
>  	pr_info("Testing creating %d vCPUs, with IDs %d...%d.\n",
>  		num_vcpus, first_vcpu_id, first_vcpu_id + num_vcpus - 1);
>  
>  	vm = vm_create_barebones();
>  
> -	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
> -		/* This asserts that the vCPU was created. */
> -		__vm_vcpu_add(vm, i);
> +	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++) {
> +		vcpu = __vm_vcpu_try_add(vm, i);
> +		if (vcpu) {
> +			created++;
> +			continue;
> +		}

Oof.  I dislike this, to put it very mildly.  Is this the KVM_CAP_PPC_SMT thing
again, or something else?

Assuming it's KVM_CAP_PPC_SMT, is there really no way userspace can pre-probe the
"real" limit?  Or modify the test to enable KVM_CAP_PPC_SMT and do the proper
striding?  Eating -ENOMEM is all kinds of gross, and I really don't want to add
__vm_vcpu_try_add().

