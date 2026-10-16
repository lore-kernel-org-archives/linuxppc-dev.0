Return-Path: <linuxppc-dev+bounces-29575-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2169CCA462
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 01:50:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5SYf5jXDz2y2B;
	Fri, 16 Oct 2026 12:49:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792115398;
	cv=none; b=gYKfKD9D7J1KAmw82rzrt76g6y0+lpvbNSddtcwttUJNykNUgucp0on3N5gOOkkJshsbH5FscL99XR9zbPxNY24Sx4fAp3gusZntgLck1SaD/n44xKGnRQVA5p5JDCBL5JVf8i9/esUrWxqZZGGkRMCG01cis9YFeu8N5pQQx4D3f5BKP3bqJtcECBeD4FKV2P0m1VwlfHf3EZhHYQvrzd9FyTmewSJ+gDn6/EYZknuGg7xvicWWxXGCD/5nF44eKQmZA8NrT8GFrJZf5xW6eKAXaAXR+pmqlikAkWgXuBraPJ+8ikXD2ghhpyeatM2nFmNmyUj/lkpCa5FPOJfbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792115398; c=relaxed/relaxed;
	bh=ux01STCnGtDsKdixMlXVkH5njmEmFXWxx+GxqnnoxD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WVh6KksqAMBIh3L8NqrqX0BjdF4jzLT3l+09sOa3ary2zKS10iBTMUL29I07uVO3z1oR11Zy34BnGjp7glPW4IqMmxhOZsB3j5O60ZV4OBrJoccyCUE8JkR2dijSipDMRoSUV+4poXobC96/b5AZJdNVyi4icx2CTt4cKEtsliqF7uMgkWHnPshELE+JMQJVycs5qP6nKMggnVeaDBVh0OY9bNnbmKkyy4Da2oVPgD5R498DUQxiMcZMHj85OhR/+2mQleou7afdSinzBhqfOPUbj/0x12v5jKihvUpt5YfKlHTzUCuLHrwbX5X1w7wnVjDzXlkz+sqA0iPH/Rin+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KkoDbGKa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com; envelope-from=3wylragykdgoamivrkowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KkoDbGKa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com; envelope-from=3wylragykdgoamivrkowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com [IPv6:2607:f8b0:4864:20::648])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5SYd0bNSz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 12:49:56 +1100 (AEDT)
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2df8d1e91c9so111889215ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 18:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792115394; x=1792720194; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ux01STCnGtDsKdixMlXVkH5njmEmFXWxx+GxqnnoxD4=;
        b=KkoDbGKaMsj6fj+n4sk1BblBWB93NMWZivf/yKsPtbErOUIBAZXe8PTzZ6XriGJBYD
         T1LuM0CuT+/4zlrDRN5eCRY1GOtcT25OhsgJKB35CzhhKzAJoRBVKI2ZMn1Lz7uzg6KD
         32aEbANQhIGThr5lA8aQK3dU7N7uK31+LptIvqkjjF7L0HzlhC1w/+dZtbtMtZnGQ0JR
         MKgQG/WNuesGfquywSMA1ka85s1bN+PwO4CVfn2YI3JCXdhIYsOJsKzHj2jbaMb4CdLj
         YFwELkIBfTKws+GR4H1rG8W6QQdQ5FfSGKyWn7houGVGeItUSoCHF8sqTV7LQbJI34h5
         jkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792115394; x=1792720194;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ux01STCnGtDsKdixMlXVkH5njmEmFXWxx+GxqnnoxD4=;
        b=iO0EosiSsAtgoGq1FnB2r45Zi+rIASfQ9JeZy40J6vk538ZKStPZPT0FAHotfTqTeH
         UxC8Sa28CgbFu4Q/ifXs/1XeHSCZ+a+K/qLO+eMN8YKNr1h9pFFpmSDPDCFg1TUYpcAU
         Hqth403MrSgj2c9dURUW3jNcjuUiVTccWiKW+3gUnW8BHtbWNAknm0mJIYsAfR3tsQ4K
         qPFcOk38zj75QXh6M1VQ6Qq/CEWvmkEXZyoSQs27bVtgWxkU5JaRb/INKFb4X85UyLbB
         xoyp7jFo4JQCyM6Ot/5pRTX3C8KYbh861yADoLW3VCDp8xiJ90ol7lAbzNWZulyj8smr
         LRMA==
X-Forwarded-Encrypted: i=1; AKwUvBxZJ6LeHoHKocimacM7dgHibhpoHsRo0Dfu9SXkaTdIxc6EqcdVqe7b7H5bd6v+XCgwXUrTWCla22dQOGo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJvqi5u6I8jG8XOIotIUJWwn6NZfPOXPQ+Ofmh8TvcUcmo28BuB
	G69oxnN40sSimMm8unQyes9Ppc4QTQAKhSje7xT/pyhuVDyKLjB+kM3ctquHBLGrAy+IM/RsIp4
	HrKIgdA==
X-Received: from pglk7-n1.prod.google.com ([2002:a05:6a02:6b87:10b0:cc7:cb66:8df9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5681:b0:3e0:f4a9:3615
 with SMTP id adf61e73a8af0-3e16beb288dmr17279273637.54.1792115393764; Thu, 15
 Oct 2026 18:49:53 -0700 (PDT)
Date: Thu, 15 Oct 2026 18:49:50 -0700
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
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
References: <cover.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <179211526968.809012.4905747914183363587.b4-ty@b4>
Subject: Re: [PATCH v7 0/8] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 06 Oct 2026 15:58:34 +0530, Ritesh Harjani (IBM) wrote:
> Patch v5 -> v7:
> ================
> (Suggestions from Sean):
> 1. Added kvm_is_ppc_pseries_lpar() helper in kvm_util.h to avoid sprinkling
>    multiple #ifdef __powerpc64__ checks.
> 2. Enable all tests via TEST_GEN_PROGS_COMMON for powerpc
> 3. Enable hardware_disable_test and skip when running on powerpc pseries LPAR
>    (nested).
> 4. Re-arranged the fixes in appropriate order.
> 
> [...]

Applied to kvm-x86 ppc_selftests.  I swapped the order of 5 and 6 so that there
wouldn't ever be a window where the kvm_create_max_vcpus test could fail on LPAR
setups.  I also massaged the shortlog+changelog for 7 and 8, to explicitly call
state the tests are being enabled (saying only "skip on LPAR" suggests the tests
were already enabled, which they were not).

[1/8] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
      https://github.com/kvm-x86/linux/commit/ab1d40006720
[2/8] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
      https://github.com/kvm-x86/linux/commit/f51639c0ee7a
[3/8] KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
      https://github.com/kvm-x86/linux/commit/2bc2c4a8105f
[4/8] KVM: selftests: Add helper for checking if running on powerpc pseries LPAR
      https://github.com/kvm-x86/linux/commit/5527310b4d19
[5/8] KVM: selftests: Skip kvm_create_max_vcpus on powerpc pseries LPAR
      https://github.com/kvm-x86/linux/commit/9de211597e81
[6/8] KVM: PPC: selftests: add support for powerpc
      https://github.com/kvm-x86/linux/commit/1b53b581d4e8
[7/8] KVM: selftests: Enable access tracking perf test for PPC (with LPAR clause)
      https://github.com/kvm-x86/linux/commit/e5983ef19a6a
[8/8] KVM: selftests: Enable hardware disable test PPC (without pSeries LPAR)
      https://github.com/kvm-x86/linux/commit/23140d6e54ac

--
https://github.com/kvm-x86/linux/tree/next

