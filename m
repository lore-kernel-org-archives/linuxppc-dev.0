Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09560A2639
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qp09jDNp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFGwB0CY2z2yY0;
	Thu, 29 Oct 2026 06:03:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::448"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793214185;
	cv=none; b=NwB8CMv5u3eY9lN2KJC6L4PTyDBpNWNG0u65uvOhJvOJF4/6T40jBFDGL8Pw7LFs1jcU2fvVPNYTaw6xdUztDfVRf/fdAeyn3LPL9uj7bVi6dV61eRuOmOEC6NZmGoLlM98UsPXj9vECBHVTETBailBSwnRfMTb1+zCKS8LbAVn3ApJh/dTnNyhh1qb6PBR3VTFhSBFKe9QsgwaeQDeQl57tpBO7MJblKj5rkBWXOpoL041iD+hvnFrYNF7Fy9iht1vfXRqOxwOts+KiOkpNxFjpz17Xa7Q+P72sCOqFVj0VPrIrxxx9kpGYnAP6uQ0rseK2Nx/jsLWSZLG/4KAcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793214185; c=relaxed/relaxed;
	bh=HbuVr5an123e2WdNsh7qTkraPx2QUzUAuDpOvbvX5g4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gB+I9+Ugb239ly0jjXQ8kXgFDLewwvz9TyQmNCxpppj7QwtRboxyKN9FSo6lV5+FJ2Gt2yTFm7G0Xc5uvDq912KK0QDKa5BlpeEEB04YNHR243m/gk3yGdKCELCVt2Q5GpA/jRsg0jDG7lBVphVKZWArXeRRgvFAqbvnVlG35HzukSw/PlFSHgyaghpsXySa81zmz+2vqhYosjbdFL4E7Kv/SAH1yDV8U9tdIdgLQFbjth0jqs+fULL/XpRsHcpl1tWwobmof0Womm+L4J8a734UNqEuFl8ylvtoOHaBBMU9brr0ej+ttWCCSytfayXfgbBWfHTz3QUKldTd1C0bOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qp09jDNp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::448; helo=mail-pf1-x448.google.com; envelope-from=35ubiagykdfok62fb48gg8d6.4gedafmphh4-56ndaklk.grd23k.gj8@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qp09jDNp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::448; helo=mail-pf1-x448.google.com; envelope-from=35ubiagykdfok62fb48gg8d6.4gedafmphh4-56ndaklk.grd23k.gj8@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x448.google.com (mail-pf1-x448.google.com [IPv6:2607:f8b0:4864:20::448])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFGw84SZ7z2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 06:03:04 +1100 (AEDT)
Received: by mail-pf1-x448.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so1719937b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214182; x=1793818982; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbuVr5an123e2WdNsh7qTkraPx2QUzUAuDpOvbvX5g4=;
        b=Qp09jDNpW3ArIPSbYlONsOCnidRDoE/pfCKRqdTJN/HDHBjBeNhrCtrF+ZC12jTyzs
         4UEQ4OrXLkTDaDIqUks7OyLhiLsEtFqrggQaSRZJCCC6uLhcm3kvZqq3mgHCIgUsjuj4
         sRtLyD1CeGq6Jwoa0t5z96CAdlJQBURNxZah8LtrLyC04SpIsqT3FZLd/yNN9qZrp41z
         VeUSZLjjmHPeJuHshhtTRbKAMD6lNyoPGRAwm5IaeIMNjJn7uLdfUwbRCNofjjcTU4J9
         enlPlzXCgJvrWE+18gK2uUqqvfIeq/FSuX6hpTf/G8PDFSYNK2nkj3eguOt9xq+pVFB3
         PBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214182; x=1793818982;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HbuVr5an123e2WdNsh7qTkraPx2QUzUAuDpOvbvX5g4=;
        b=Fo9NnWPZK6it5kRg3ADZA0hHTr+y8oQ+w3HRss1mMjsT17CWf4+hRI+PRrXSfkDFCI
         53OUF9SDCtssOQfne3CHwjdquPes7MYf1NAzBveBooSFBY4jM/S3xK98KIMYpoIzTQTZ
         BDVYa8n4db0EwcLn7Tb/nMIEhNw2YmhmbWqg0fm683RXVkvwzpLLzLPkCmfc3IG3NS4Y
         vv8iOAh4BFk2ze+XOW7I6m6jGHas6CfW1efsJsdtPRWc2rRIfX1fmtHszxcNW/jMyhi1
         WusJTrw8kDQ3dUpu/zVwt4gKD1hotmTVBiH03QgiP3JXM3abld/bCZFnAxt2aVQxeoH1
         bVHg==
X-Forwarded-Encrypted: i=1; AKwUvBxyVIKEebqApUz3HrTpcJnlRYQhg/Z56H3ttsFfz8Tw1PH1bc/xw2DC7GkoMnPPe6lNwko6uDp7qgtI1ck=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLu0iVFT9WDeYclfxSbwbt/ea09hcKzLqFdvJ0yLF58+MeUwtU5
	knlxg3DUyvi3NkgLJDU0l1R+o0n6RlROR8PrmXbZyYYnKDaaZYJkB964kJZNRyQLZqNz6dwHVSf
	sVEOWBA==
X-Received: from pfog22.prod.google.com ([2002:aa7:8756:0:b0:8a0:7e84:9992])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:18a8:b0:899:55e9:880b
 with SMTP id d2e1a72fcca58-8a6e72dc7admr2727923b3a.14.1793214181492; Wed, 28
 Oct 2026 12:03:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:52 -0700
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
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190259.1819571-1-seanjc@google.com>
Subject: [PATCH 0/7] KVM: Ensure WAIT requests actually wait
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix a bug in where kvm_make_request_and_kick() won't actually wait if the
kick races without another non-waiting kick.  The issue is that all of the
conditional kvm_arch_vcpu_should_kick() implementations are missing this code:

	if (req & KVM_REQUEST_WAIT)
		return mode != OUTSIDE_GUEST_MODE;

Thankfully, kvm_request_needs_ipi() does the right thing, so this doesn't
affect kvm_make_all_cpus_request() or kvm_make_vcpus_request_mask(), i.e. it's
limited to x86 SNP's used of kvm_make_request_and_kick().

To fix, address this TODO:

  /* TODO: merge with kvm_arch_vcpu_should_kick */

and purge kvm_arch_vcpu_should_kick().  As usual, PPC makes that difficult
because it has wonky code that is poorly documented.  For reasons unknown,
kvm_vcpu_kick() unconditionally returns true on (most flavors of) PPC.  To
preserve that behavior, add a compatibility wrapper in PPC, along with a
@force param to __kvm_vcpu_kick().

This series would ideally go into 7.4, even though it's obviously not small,
as guest_memfd in-place conversion massively widens the window where a missed
kick+wait can lead to the host trying to reclaim an in-use VMSA page, which
is generally fatal to the host.

Sean Christopherson (7):
  KVM: s390: Drop unused and unreachable kvm_arch_vcpu_should_kick()
  KVM: Add a @force param to __kvm_vcpu_kick() for PPC backwards
    compatibility
  KVM: PPC: Explicitly force IPIs when directly kicking vCPUs
  KVM: MIPS: Rework kvm_arch_vcpu_should_kick() to use standard
    implementation
  KVM: Move kvm_arch_vcpu_should_kick() to common code as
    kvm_vcpu_should_kick()
  KVM: Plumb the full request into __kvm_vcpu_kick()
  KVM: Drop kvm_vcpu_should_kick() and use kvm_request_needs_ipi()

 arch/arm64/kvm/arm.c               |  5 -----
 arch/loongarch/kvm/vcpu.c          |  5 -----
 arch/mips/kvm/mips.c               |  5 -----
 arch/powerpc/include/asm/kvm_ppc.h | 13 ++++++++++++-
 arch/powerpc/kvm/book3s.c          |  4 ++--
 arch/powerpc/kvm/book3s_pr.c       |  2 +-
 arch/powerpc/kvm/booke.c           |  6 +++---
 arch/powerpc/kvm/e500_emulate.c    |  2 +-
 arch/powerpc/kvm/powerpc.c         |  7 +------
 arch/riscv/kvm/vcpu.c              |  5 -----
 arch/s390/kvm/s390/s390.c          |  7 -------
 arch/x86/kvm/x86.c                 |  5 -----
 include/linux/kvm_host.h           |  7 +++----
 virt/kvm/kvm_main.c                | 28 ++++++++++++++++------------
 14 files changed, 39 insertions(+), 62 deletions(-)


base-commit: 7e60162b16f9da0d2fa83da5c1723b6853a0ac1d
-- 
2.56.0.313.g2479322e68-goog


