Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706DF608B068
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R2n+Hqqi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJG3J1PLlz3f6s;
	Tue, 03 Nov 2026 02:34:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1045"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633676;
	cv=none; b=AwyR6hWQTibaBRDnFWW1lqrgbEjkr5dfdd98yO+UuKg02DOuYlo1tHXivAhJ9g2KIpngyliLWZUp/oXkESr3UuwAbgFz972R7CB3UWkPv9DtF1t7U0OPlfuS2EjuvznLbPSRd0JHN0nOb5JIdMzyKcbCsdML8ujwBmaW1iQD3W5qpTHZjHoNM1E0sfamLGm/fYgdAz9IEbBeISqMbf2TU2LtWNpUHLBwbPPBMEEMQWWlcr+1/F2DWw2jidEiaWY4kEipIbeoaP8JEaWze5+i6Rh/9mkH0O5FsfFULX3Kz5mcRkzb/eHqRMm/nvOjCkQZtDa1O2s9Gy1yIJONpad/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633676; c=relaxed/relaxed;
	bh=s4vRCplgEoCQN3eUv6q9zSWbIbV1TXU7YJjG5+iZQYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B1NTi2YY5wWwx4d3zDibC7g99GFAUw6k528jJAOi64l+F3hYQGNP5lg5HdN5mnNsyyXOJxS/JbbzUAMwfhAw4oZqwautcuBXSt4c/jOmE7MctgB/Dbu+8MQ481+Y4z722aEWurz7dQPXecdZUmH0uUlpdS6PVYRdnmTGLklx8dTIV8UyvhQfIDbC6Vkhb9GzZd3EV8kDJHxufzNyiEENpXUjXLMfhNNWhY3UFRkO6FxbrB0N/fpxPYMe5DE/7dZ2zYHCd1EQztgLAIbc+YqeQYUeapkR1anfOyd3ZU9/Trx0QK6Kz1fTgm1gUPZhfkr3Ty/Sf1V0UMok22ZX359BTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R2n+Hqqi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3ia3oagykdoqykgtpimuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R2n+Hqqi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3ia3oagykdoqykgtpimuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com [IPv6:2607:f8b0:4864:20::1045])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJG3H3FdJz3dPs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:34:35 +1100 (AEDT)
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-3ac8f449d1bso2537074a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 07:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633673; x=1794238473; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4vRCplgEoCQN3eUv6q9zSWbIbV1TXU7YJjG5+iZQYY=;
        b=R2n+HqqiCqTM7X37a1PgE/+wAgUjBeKHsHTmaSkXBA5nKRTqjrlNyiX9ERBto6Ka+3
         yG1bLKNx3Rw2SjHb+ZTCftWcrxJuT/p24RbBsLCG82PMcPnPeJO+0oRf0dGNQMGtCyws
         abT+DdxLKQjUpAzcPn3+YUOjEIsHUDYEiYgZqMEm3pTcsEahiFr67xa3F72KnUSdeSWE
         W+tYjRzQNLZqfGWugnoDWV/VueR0QzVOW+xTg6GXXQIBiQqHmrI8I3HcZucDQuPZutA5
         uWxAnLXJ1243yKGEli3yk0Kjwq2rNSn9PNaTJUHN8m2Jx+g1KObMD2AJi6Uv6V0qQwT2
         tbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633673; x=1794238473;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4vRCplgEoCQN3eUv6q9zSWbIbV1TXU7YJjG5+iZQYY=;
        b=cb1oBzfSurlSC74GyctoUVH0TqNklQ+XFMGe2a72JLd1AGhzuoOS6HA6bmPN2Ycezg
         BYu5oYVEc9P9ReZEeab6PK1fjqEdIhshPH4NL5R0oMkAlb6ibvuB3mWr743n9/xIgvCC
         5vk5SfMHaWmoNSoWNTwosjSdDOTL0fco2StCcXIVIlnPXPvNfe4DgGOIXoe2iYUmEZEo
         OBHvNho5+s3hniZHZamcaFrVnQ8+sCwcuMv+vSFWE42wpuiUXVTdJ1VFgWZes5L1IwJD
         9AG8I9/Bs33EDnnzf3Y4yFj+3E+UbrvKmV3v0XASLa5PuthM8moWhh28N7NbC3t8UMJL
         czmA==
X-Forwarded-Encrypted: i=1; AKwUvByB/MT1yGoBeJjex/CedZIpH7UH9OnJKYv+cC9O3McqW+1r+mfCm1hfljXVPn8Ans8XcuOBFHnM7esDeqs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8kMR7nyLqo82M3rXXg3cp5e1mSQC7ZkaRyGHJEO4vlxx3pX9gm
	MklPnP23esBe/TZwv75neVj+rdO5Wdh2Qb1yehoOWEOTSevom2Yhglmx5sTQCINV8sJOYH/Rllr
	t1IRepA==
X-Received: from pjso1.prod.google.com ([2002:a17:90a:c081:b0:3a8:211b:6c8b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2749:b0:3ad:43c1:7d41
 with SMTP id 98e67ed59e1d1-3ae897429b9mr7590262a91.33.1793633673063; Mon, 02
 Nov 2026 07:34:33 -0800 (PST)
Date: Mon, 2 Nov 2026 07:34:32 -0800
In-Reply-To: <20261102153228.240804-H-seiden@linux.ibm.com>
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
References: <20261028190259.1819571-1-seanjc@google.com> <20261028190259.1819571-2-seanjc@google.com>
 <20261102153228.240804-H-seiden@linux.ibm.com>
Message-ID: <auitiPKnFueBJzPA@google.com>
Subject: Re: [PATCH 1/7] KVM: s390: Drop unused and unreachable kvm_arch_vcpu_should_kick()
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026, Steffen Eiden wrote:
> On Wed, Oct 28, 2026 at 12:02:53PM -0700, Sean Christopherson wrote:
> > Drop s390's kvm_arch_vcpu_should_kick() stub as the one and only call site
> > is wrapped with "#ifndef CONFIG_S390".
> 
> In the somehow near future I'll remove those #ifdefs and use the kick
> stuff for kvm_arm64. The native s390 KVM then must at least keep an
> (unused) symbol at hand. It seems that the compiler could not optimize
> those calls away. So let's keep it there so I do not have to re-add it
> soon.

Please read the rest of the series.  kvm_arch_vcpu_should_kick() goes away
entirely.

