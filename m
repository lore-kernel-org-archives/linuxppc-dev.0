Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDC606A8A4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mAhoLSSG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQz9F73rpz2xP9;
	Sat, 14 Nov 2026 00:48:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::446"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794577681;
	cv=none; b=DqyWQfNukWuLt5BCE0KIxkkpYdsnUhKQvTkuRIltodS+L4PFDhVgGePvYL+bVzDeXWfNCSN6Cc4eEMiqEqxVhyTtTIn8fYxNuJeksFtWzUrQ3Vk4dF8Fp8tqqMZDfr9E3+RRksy7M4zy7KNJY6v0RO7Cax3af/X5PlZ0A2A985FQrkBHPcXjIg6e6QIAhO/Mjcg2T/8rCH8Co2yq9br3/Rb2En1bR8p/HGoa63ysZKVBEiTFOXA8MxHVkr5Cm1CFsaQixHFM20hrAQs0N810K9yQWZDJkxB2LLnLOEzzfxSw8mFJq5NZhTKC21wCUDUYOS0mCFcsX4ELh+wV/e3qpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794577681; c=relaxed/relaxed;
	bh=1Ihy3Y1Ag1S58REu5bFFliNMMA5gpdpH88jS//LlU0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iG3SZrPv0e0wNd69XO+d2fbalAxHEYmbcnLC9Dnq96hJShMXrgYdDAP29xiomHmNy0uzySveDPyBIn+KDJJ1Vgzpxpw7zibKsI9GShhHFBDmj8VjqoaExG2HtykwMDaIK89sUE9fEkK1yMudS+dKoj/BDB9b3Sz3iZOTfQ9373tRYmGhM9isHVYtzs813pFGht7AUwo6gU2N0LipSgaGlv1BP8cI9MoBKJnpC0fcwqOHKuvMOAyFYSaQTC1QQDiICQF6+3QyPOdYOQkcAqWBbTHQAnzmYmJGQGW2+p1Xl53ju1UmY2GzR/VlUTCQw0g4zF229fma+l3jrhAm/hGybg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mAhoLSSG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::446; helo=mail-pf1-x446.google.com; envelope-from=3dbx3agykdhehtpcyrvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mAhoLSSG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::446; helo=mail-pf1-x446.google.com; envelope-from=3dbx3agykdhehtpcyrvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x446.google.com (mail-pf1-x446.google.com [IPv6:2607:f8b0:4864:20::446])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQz9D1KKSz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 00:47:59 +1100 (AEDT)
Received: by mail-pf1-x446.google.com with SMTP id d2e1a72fcca58-8a073778890so777346b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 05:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577676; x=1795182476; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Ihy3Y1Ag1S58REu5bFFliNMMA5gpdpH88jS//LlU0Y=;
        b=mAhoLSSGkcb1u3xRaNQvy7HQo3X0VtYwEZ21pAaGmwAOl/g1ETsE+3NKbk2gFhzf6E
         WW9qhApMr0OpCQY1kuHUAGlzYuV1ji9FfnuCII68kQwA6bfo3vBYrzm/WVaSR97Rtl54
         bE7ZZFG3IOpkxd7hTU++LaE+Q61hmqXUk+sxTnpDsPJfD6IXZvVOmj3tcNOJbdssGTLu
         rVmhqG5H2MwrhKzTOhFRufzS157LJKC4iLDAbWJZxejzMkAwCi/YzRrtYstXBNm1j8b/
         DbAlw4NG6v/rrczF3yvipRn5R3QoUssX8TWQhbQ65gpJ2VIP6M9hjXLfta5dPzyCK/xo
         x/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577676; x=1795182476;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Ihy3Y1Ag1S58REu5bFFliNMMA5gpdpH88jS//LlU0Y=;
        b=thxG27PK2yVM+1g20JEExdzI0UNS1yV7YZDWwqpoFlVqBEJetzKya521DPEaGnAMgW
         9dhp/zhqblc+OML1QtTC2wyDoyTr6A8IYQhWs69HRpc2fkyGl66j1ZaOOnNuBthZNvQO
         DyKzN12261z7K+hsaXimHKy6r2xBVZfnrKmsUADoxhoe+qgtTKLel8s2uf2GNATh1Dzk
         RUi7jvh+bOemgfePWllrNfKXqqpzjzufoeXy+88H5+jbbhVKFUXE98CWhgcl5/l4jlWZ
         NDCuneKUZ4y9vBjxfZzsLgfy0GT7JwbSlESDE4YroZ99h+dzUjqNplYWoVa1PWnmRYBN
         VArA==
X-Forwarded-Encrypted: i=1; AL+hErHi2Wm29dJ/jvkK4vEjgqw8Vhq4lMHB+X+icDQHQzssA5DIO7Qf3N3uIvGtMdECzXyQtJaPCfZEgL8OrhE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+oT5K06VcAlCOGaCmplY2gzo0PZFjLrgliI9AKMez4WIButjE8
	5QZVZb9OlVYmQr2y14A5kZ0KeQGlDdxq0bR0dNxQJ9VH+dOg5cvPFk63lhgbI6XFuomuViXZMja
	OH7Su+g==
X-Received: from pgbda11.prod.google.com ([2002:a05:6a02:238b:b0:cd6:1a09:f41d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e212:b0:3e1:c6e6:d101
 with SMTP id adf61e73a8af0-3f7a76c2160mr2595125637.29.1794577676197; Fri, 13
 Nov 2026 05:47:56 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:18 -0800
In-Reply-To: <20261028190259.1819571-1-seanjc@google.com>
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
References: <20261028190259.1819571-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441821375.80587.11807540842100479305.b4-ty@b4>
Subject: Re: [PATCH 0/7] KVM: Ensure WAIT requests actually wait
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 12:02:52 -0700, Sean Christopherson wrote:
> Fix a bug in where kvm_make_request_and_kick() won't actually wait if the
> kick races without another non-waiting kick.  The issue is that all of the
> conditional kvm_arch_vcpu_should_kick() implementations are missing this code:
> 
> 	if (req & KVM_REQUEST_WAIT)
> 		return mode != OUTSIDE_GUEST_MODE;
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/7] KVM: s390: Drop unused and unreachable kvm_arch_vcpu_should_kick()
      https://github.com/kvm-x86/linux/commit/20cf5e54a1bc
[2/7] KVM: Add a @force param to __kvm_vcpu_kick() for PPC backwards compatibility
      https://github.com/kvm-x86/linux/commit/0ee75a9dee9c
[3/7] KVM: PPC: Explicitly force IPIs when directly kicking vCPUs
      https://github.com/kvm-x86/linux/commit/2530231b023e
[4/7] KVM: MIPS: Rework kvm_arch_vcpu_should_kick() to use standard implementation
      https://github.com/kvm-x86/linux/commit/a8dabc687ddb
[5/7] KVM: Move kvm_arch_vcpu_should_kick() to common code as kvm_vcpu_should_kick()
      https://github.com/kvm-x86/linux/commit/7e52636d9c37
[6/7] KVM: Plumb the full request into __kvm_vcpu_kick()
      https://github.com/kvm-x86/linux/commit/5c430e211f4d
[7/7] KVM: Drop kvm_vcpu_should_kick() and use kvm_request_needs_ipi()
      https://github.com/kvm-x86/linux/commit/fd3dd4d9c186

--
https://github.com/kvm-x86/linux/tree/next

