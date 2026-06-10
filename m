Return-Path: <linuxppc-dev+bounces-22427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74676CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 17:59:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbD7J4lpcz2ysW;
	Thu, 11 Jun 2026 03:59:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::54a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781114364;
	cv=none; b=hMU6FQL+0n3PmwH5raqNFDRbimymW0vaO/FXiXj78aaF6L5QsQOJMo1eVxb4FgvvWXHDAVETjmznwVJv87iPaliqeaNR6IMR0lxMDNVVuOwikaqd3yvB1qV2z1S4Unb+rl2Azi+uJmRm8tVsBFgZf2l3MuqbZjDkYGrc9sEhtywlOlR82+E2j4QPVVNQXjS1CUorKaxppUUiidpuQ/bi481MWiDXNNSfM0eUsvdYCkdogbMKowUGy5IBnKIbswtq3WF5hjBYubquorY2mLPZHFgRlHcTbykSmA6jn12z5M7+ppSOuDmH2zFZ5rJbDJON2D1lf1gS/xqzWX6cldhsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781114364; c=relaxed/relaxed;
	bh=eUrC+jAn2iYzK3cyoAqLDZt/8SWBUONJdIH1jABrZ7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cMqtHQ0fFnZz6hPdwQ3zxVZJj/YfPuSMhbHnXA2ag3bUbrtBvJnM+5s636y83a9t481i9zx6dC+ySys17n92YHIbfeeHvq3RwaLqUbhc2vktFde5IIcsIPMtxu2Kze5Ho8ylN8nPP/MEytidIgQYEt6XWvkCJpDLtBZQBTAjVRr9KrOfNb9InRps2yFJQWYxyG9WDk0IRiDqyB2DktpotSzohVWyp5y5GivWM+JSNgbvNL21bR+7i6g5zY4JS7OmlCIjulYi7gP13p+50g0s1mZ/7qOhbT8hKg5pIjHImlgbOvaOMJeU1eeHlYI7dhyskfqMVuWZsEMq0DIHLVw/9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Kq/N3IUU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=396upagykdeiwierngksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Kq/N3IUU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=396upagykdeiwierngksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbD7G6wYtz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 03:59:22 +1000 (AEST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c8611b27631so65977a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781114360; x=1781719160; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUrC+jAn2iYzK3cyoAqLDZt/8SWBUONJdIH1jABrZ7Y=;
        b=Kq/N3IUUnZr0CwkZumrL6+Mgdkct5KxUE9bNiuv1+SChu2f5PMbTcY32B+pP/qV6N2
         VvP/sGAND7pK/zKwHHnXUMJg5pBcGS+8z1ziB5kvzzb6gH45PKa8wa1K5KJF26/+3I87
         Lx/FBQhtGDl9Ru8WuRTGCisx1zU8GTZ7Lr1JXBqiMis1UDpYq3+5s188iL7Aw13nVfGN
         aiQVneFC77KR0D2Ke2Onr1UtAQKGNnajS/x7E1UFBfEYBrz/XHpvAo5+mzCRMuO7l5NW
         EwFOSxWJw2TxU6Ed6jtmO8ToMgHNqSpuZz88kCHGhID0Co1tj7HuGcKliK7Yi6wXs23b
         bkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114360; x=1781719160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUrC+jAn2iYzK3cyoAqLDZt/8SWBUONJdIH1jABrZ7Y=;
        b=Nfqttkr3QgxusnRu3JR+Rz9Gl+cleeROWH3oLwlZF4ONAWOE7oRQJCh3nACvVpi2AA
         G65h3hZE3ygTzn6P6011iIWpMlFefI6mqlURZOkaYXT8df9NGeyKVxHPMyhoxB1F6bQR
         L+EMFyHPHh3WvnK3uhO7Us0XqSfHfep5t5VQAmKyLeIoBcjJL311Mx5OlDxa/MUHmtfu
         3mNYaO94kf913N4tnejKp1YXARVM/WYeJzrpGPXG5oY9yLXmJA0OPAxfk5TSPf/uwM4c
         Z1skpdIuCFoyAaeSDUjW3BqVHIFOIt/stdY6h9uQpf3LGvGXIz0/rUs5S1dOiG9HUUg7
         AQ9g==
X-Forwarded-Encrypted: i=1; AFNElJ/CIA3QdKbjXMw1J1LDdqTmMU6+SS3SMh5PXs6dJ+JptsHEBPKTpw897Fw1+nvrLf8KcmQccJpvvLMkgA4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyqb6kvx7h8QixXhaq+wCUoKWMvoCrzoDApvrwzRYL8/pj6hCWw
	MSePQoe+S3u6+wSldqMCXcFUsqRRXlUPSKjYD/8zQJo/a6nB7oRAHc6z7/CXSQCrMWq/FfQ3bAc
	DW+nBTg==
X-Received: from pjut3.prod.google.com ([2002:a17:90a:d503:b0:36b:bc13:f5a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f46:b0:35f:b9f1:fded
 with SMTP id 98e67ed59e1d1-3713336f91fmr19807082a91.12.1781114359586; Wed, 10
 Jun 2026 10:59:19 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:59:18 -0700
In-Reply-To: <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com>
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
Message-ID: <aiml9iB_vUASRRQV@google.com>
Subject: Re: [PATCH v3 RESEND 04/10] KVM: PPC: selftests: powerpc enable
 kvm_create_max_vcpus test
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
> the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
> VM's limit.
> 
> The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
> to the kvm_create_max_vcpus test case to limit vCPU IDs to
> KVM_CAP_MAX_VCPUS on powerpc.

How is this not a KVM bug?  Literally the reason this test exists is to validate
KVM's advertised KVM_CAP_MAX_VCPU_ID and KVM_CAP_MAX_VCPUS.

