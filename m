Return-Path: <linuxppc-dev+bounces-19308-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F22E88D66
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 09:40:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnrDY3VFhz2yYJ;
	Sat, 04 Apr 2026 20:40:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775295629;
	cv=none; b=kwd4t+9pRDq418CU6bmYZG+zUqYlBfS8I4IleMTfAU7HplXxRyqt8JiePjjlJtH3gDdHsURtUut7gNWY/pFUju+Rwgy3wTNmdzBBVy4C3vLTZfsZc2LDQ++3huQpTNXQ/9OgeGbw/QgcYinhU8wl8qiycKdsYKCGXQ7wCTignsiUR/JZuOgGEPzMSobbsbFCTKt9BMKk36KXCd2tNIbBnG1gGhe/uDcS/UOGAHlTKK4JoTrAiRd5BXgbSgQWoplkxb/bND5+iQAOCW8wehH7/LV03DiexPNWt4jp+tgpxWcfFIGkzYcn0dSk3NiT5OjtwkvXNXF4kFXrs5tvA+RihA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775295629; c=relaxed/relaxed;
	bh=rOaxQXfX6SiiuBlcP8X1nQXWObPEsgiGGDciqZtKDLA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=dnITImGiCv9jmYdQ9FU6QLfR2uVByTZTIBZmnchzXXywujb+JTUkxZiJDOX6WAcH3OwqchmUpRJe8WtQP76gqgNi8D3SZwq68fNqrfZAZcAP+MnCvp8eN/SnRLX2R2PR/yMlh46z5I4Fjyzcw94WApmBeROnSz3r9k1fb/Ej/4JgSgFZqPSBizmgxQ/xPJWJpNdoXrzh9vxcyR9ht0NsIE0nYY3uHdAUIlGs8/dXJexHO5EYqi5PxH9PJewd16Ku5FkGR5EXNG/fkqyqW0rJQrgDwGVw+yCmL7B4RzLggagxcJnwwfNLo0AZYG1RZKNZFedB1wx+nW0Qt7fWnytDWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gO3lj+KM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gO3lj+KM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnrDW72r1z2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 20:40:26 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-824c9da9928so1662015b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775295619; x=1775900419; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOaxQXfX6SiiuBlcP8X1nQXWObPEsgiGGDciqZtKDLA=;
        b=gO3lj+KM4Z1mxkST0ABtrcw4/mV6kfAjtQEWZJEY/EavnKJJ7ffvKcf6g6O6VbHlIF
         UZ2ZuyHNuniR2FGiRBZRYO/dq8XgX2GFzIQ+JUhhA2QxrKaSBxMCu+TwKJ1/5TVyiOZO
         Qi27WLkP222sQu5uw7t1vLW3YuOvm1OpnIXIUgrK3mBz/gXHHmyxymyqRWADvowP5BvG
         fd5wKQKvILtmA4n8wGVRL2NyuaXen5TH2NW4VG7Q8i2PYsJ+MFnp+uy45+u42Cn0T/Q2
         65ERJWaWIHBjW/+a6/KarC7kaiglgpNi2MUPVM6kycg/vMXLoqZrh2TREzGQ8g7cWZCm
         YsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775295619; x=1775900419;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOaxQXfX6SiiuBlcP8X1nQXWObPEsgiGGDciqZtKDLA=;
        b=P56AZT+iAmHWEOJWv/C6KV5slomEfPrMr1uDbxBS/xLCe5znxAsHECPWVVWpT/eHEO
         iIvCUMWoeJQWnRDwPUzXDeUTc9DieEC17VyM4HQDz5QiQw1lxR5gWBGBfvUJJvz3YWKH
         CJnrec3VfeGoxnm3dd7LZfXpSIPaS7ZiODYxfvtcuqZ3XJ5e0fu5aWRbYp7BAWa7Qdlb
         hQIP1H38ZU/bFkcVQR78It3xXilodNMXm1vMW4SLsJJVzXxG2NKje12aEtgUMtUBnMsT
         LYFhkdTNhXmdT+tc+tobJBykqJPnh+ck4p5FXfpEkjY2PS7jblocGWBsP2FDFrbLlygG
         cJMw==
X-Forwarded-Encrypted: i=1; AJvYcCXg0Qeb/xoim3AcpbzHL/2DeVunupwI9bv+AB72zB/Lh/wH5Tu1wR/5CTY1gsz71uGxT1gc/lWGUkI8uZM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxcf/PAxSbl+r7bkUcOuk7t0jvlUYItWWAjjIgI5pmO1POy/S2O
	uh4GVDa1ce6/qTw5If4UF8sAMETBmnrFLxTdizX3taAqdWpknlChP7bJ
X-Gm-Gg: AeBDievj9OCkD20o9p7q0zqAXnDailMDE57SlQUs0v6cijlg6tMMqyPkEfrwmek7FxD
	KjRazy92m34raibnOdtxvUyTNAEflnFQmADFdJ+HkJeTnCeu+MfIBNDGKtxdmdXQQIJaPYhMpBU
	79v//fh/ZgZjadnabypQ/Ns1fn88WjfpGHpGpIKaIpJxKdqNYNBSepoeTCHQnmS0CiwX4WAykJ6
	1huQSXnKm8YBkR9fTeoSTzitm9pgx1niNPtl1ZsU5zNaz3oH2zewNF86HyHuYBLhR4CI4KQMtK4
	5yHfsR1yaI627zBb74aafX4GIxraUnb6S5DQa8wrn2OsvUzIYSksPfsOSSsGO3IDk+mnQk/l7dr
	ZMEcDbHQdGXBvV5+8a3YgPR+BVl0XiVfY3ZncCxSp9yhqy5qQNhcBnOgd+wDeViP8fsST8hS8au
	TaeK+rtnRcH2+lDGUUV4gEWA==
X-Received: by 2002:a05:6a20:430b:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-39f2ed8d9e7mr6111236637.19.1775295619301;
        Sat, 04 Apr 2026 02:40:19 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c647792bsm7698445a12.6.2026.04.04.02.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 02:40:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Yosry Ahmed <yosry@kernel.org>, Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
In-Reply-To: <acsvbxIdtlQzUw4q@google.com>
Date: Sat, 04 Apr 2026 15:07:01 +0530
Message-ID: <7bqnm5he.ritesh.list@gmail.com>
References: <20260325092001.613025-1-peter.fang@intel.com> <acsvbxIdtlQzUw4q@google.com>
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

Yosry Ahmed <yosry@kernel.org> writes:

> On Wed, Mar 25, 2026 at 02:15:11AM -0700, Peter Fang wrote:
>> kvm_vcpu_map() and kvm_vcpu_map_readonly() should take a gfn instead of
>> a gpa. This appears to be a result of the original kvm_vcpu_map() being
>> declared with the wrong function prototype in kvm_host.h, even though
>> it was correct in the actual implementation in kvm_main.c.
>> 
>> No actual harm has been done yet as all of the call sites are correctly
>> passing in a gfn. Plus, both gfn_t and gpa_t are typedef'd to u64 so
>> this change shouldn't have any functional impact.
>> 
>> Compile-tested on x86 and ppc, which are the current users of these
>> interfaces.

Mostly a mechanical change. I had looked at ppc call site and looks ok
to me.

>> 
>> Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
>> Cc: KarimAllah Ahmed <karahmed@amazon.de>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Signed-off-by: Peter Fang <peter.fang@intel.com>
>
> Most callers are converting a GPA to a GFN, I wonder if we should make
> the function take in a GPA instead? But then we'll need to the GPA not
> being aligned to a page boundary (either do gpa_to_gfn() in
> __kvm_vcpu_map() or fail if it's not aligned).
>
> Not sure if that's a net improvement, mostly thinking out loud here.

The suggestion from Yosry and Sean sounds good too. Instead of every
caller of kvm_vcpu_map() doing gpa_to_gfn(), we may as well make
kvm_vcpu_map() accept gpa_t instead and do the gpa_to_gfn() inside
kvm_vcpu_map() in the call to __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa),...),
or within __kvm_vcpu_map() which is fine too, however, the former is a
better approach, IMO.

-ritesh

