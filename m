Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2860A2616
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nPESLjuk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFGwF5p8tz30FP;
	Thu, 29 Oct 2026 06:03:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793214189;
	cv=none; b=bTes+pgFOhFb4eWwjz3cH5Hr1fn1uFZw6KoWnzLdrpEXPtE0VaL5S04HbbEfEJNmKxmbpnJ7o7cE4vn7c5PbGOQQYijHd7YSE4FUFuqeA1K9bv8SQna/uRUkxtzMF6Ri/gw8jfD9sIFgaBwlKriYeDR5tEzMfogJVnToMDp0UTM/A+AF6DYaeYod+yZKagZSTx+FyOPA9zrmSU9/LA0fTl/f8MxY1WmKwo+TK1UeR663G7w9X5faetZOhDzXjLKC2duS7d6WkzyafBr2MMKT7o4K40PYXdSV8QI12c1aEGqYrVcouVcxc+O3g/e0peUpcmKWdVWrEMhPTK1EcKkO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793214189; c=relaxed/relaxed;
	bh=RloCiG6ktfajfft7oZXWWlUR2yO2W/arq16CEWx06hk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S67GUCcEp4CZmxSDtyfuF0fBvDZMpzo0uLGOkNrdMbGkXDNpdHVVGFurhJ1cXp5ijMjHSu10+vg9qJPrw2qptlt8n5s7gVSL3u0Z7A8M6Ohjp3eeqIGlQhgBbR7kHedEgKCGAdCgDjD8y0XDlNS/N8wGQou9A04CrC0Gu1MZ5Qxz7AwI/jyq5yQuX/T5V0YDSNCjqKFE2RLGiRsJ8/72knlB3tKBR2w7QXd4JqI9SzDNB3zuURmWaLNJyis/DjqJnKEXNKLDsme2VWs9us4Nn87zFQ5cbFbxZt/iKccfj3qLOsT6zPs7kz9XBSFu+Op5dIeiXLOI6suXxT9PABAHnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nPESLjuk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=36kbiagykdf8pb7kg9dlldib.9ljifkrumm9-absifpqp.lwi78p.lod@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nPESLjuk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=36kbiagykdf8pb7kg9dlldib.9ljifkrumm9-absifpqp.lwi78p.lod@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com [IPv6:2607:f8b0:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFGwF14Rsz30T9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 06:03:09 +1100 (AEDT)
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2dfb24dfedfso11935085ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214187; x=1793818987; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RloCiG6ktfajfft7oZXWWlUR2yO2W/arq16CEWx06hk=;
        b=nPESLjukOmIgjwYoZ29QqcjXOpAV+X3LT3p0Thy78WkS3hH5yY5QRy3CNO19YHZ9m3
         6ya1pq7MulEdMBLSZ4tigzyM72dDe6ZsfMfov7pDafYMZ0F0d+x2OXSw2QYRYSvoOp4L
         Zhv8BS6bQX+vHSBcN6trAleD/X/2YWRui3wv4MNsaeLdPrfukS8gXNlThllZj0JjjA0M
         PKCyZnCn/cJdMHKYlDPhmc9XMS7z9LYRnEvFq0JAHYGlEnLQ4RGiUzLTDrkZCsUd5VvH
         XYDU7fxq1RdreWRV8GDiJjgqE5B8OjbNFjcQ+1I+zqGV4DSaBp6g/g26LYGl0DeTchr1
         +x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214187; x=1793818987;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RloCiG6ktfajfft7oZXWWlUR2yO2W/arq16CEWx06hk=;
        b=q5HFIsFpHic9n7Yy9zubHsFxaerlf152ZYWhPEQKDPXA1mxSKoORdVO4V8uAEjoz6D
         Ueu4QaYaIWlGYS2lxSEjVLGq59ZCiFjZhqbLq89pYzxV725K09vhDApatgJ5S2ZoPmKU
         QvutvrxGnT4jbWY2/FwnEjyDfukezHnZdgUCkhkQ3NROiUWy6tsro+jHNUJo6GCUipS+
         2iHXY3q7mDPPdEmUqqBhhYacmDY51VYzxAmdg1qO9H+HAVAqgA0RlqYOMc7/k4IB9qlb
         E43pwlAuqHQ75UEwIvgE4cDaqaEpOfiPOuv/glmYayLluKveXNZvj5PbRORMkpvNG5Ef
         clcg==
X-Forwarded-Encrypted: i=1; AKwUvByEeDb1FuCeuxW1INe1RIYGKdpiELj/BMlmbhB8GSUVDDTe2xen19TpHom+uBEJOhp7mvW62IEej/g4Pk0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKc3ftKSgrrgFl9cwjNdi+WCzKrKVpo2eBp5B3gcSi1B7ehz642
	3il12+W/3JNggE+bcoFSYg9NniT7ecisLtgKsss5pMbnmTwOdE+yqc+nVdmShSNpYJ3pRnVF4uE
	+bOIi5g==
X-Received: from plma18.prod.google.com ([2002:a17:902:7d92:b0:2e9:73da:58d6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d504:b0:2e8:3d48:4d92
 with SMTP id d9443c01a7336-2eb003bf1dfmr27738995ad.33.1793214186739; Wed, 28
 Oct 2026 12:03:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:56 -0700
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
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190259.1819571-5-seanjc@google.com>
Subject: [PATCH 4/7] KVM: MIPS: Rework kvm_arch_vcpu_should_kick() to use
 standard implementation
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rework MIPS' kvm_arch_vcpu_should_kick() to use the "standard" arch
implementation so that the arch hook can be dropped (MIPS is the only
arch other than PPC that implements a non-standard hook, and PPC uses the
recently added @force param when invoking __kvm_vcpu_kick() instead of
relying on kvm_arch_vcpu_should_kick()).

Convert MIPS to the standard implementation even though the code should be
unreachable (neither kvm_vcpu_kick() nor kvm_make_request_and_kick() are
used by MIPS or common KVM), so that there is a bisection point if the
code is somehow reachable.

No functional change intended (because the code is currently unreachable).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/mips/kvm/mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a53abbba43ea..c37e212bc0a3 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -122,7 +122,7 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
-	return 1;
+	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
 }
 
 int kvm_arch_enable_virtualization_cpu(void)
-- 
2.56.0.313.g2479322e68-goog


