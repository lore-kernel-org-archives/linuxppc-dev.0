Return-Path: <linuxppc-dev+bounces-27868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2E8C982FC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:45:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpVx24R5mz30Vb;
	Tue, 22 Sep 2026 03:44:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::545"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790012694;
	cv=none; b=YRb4bb5SW3/1faYHkvrFZZkowKGPWAbyhIqpbhDiNGf9JTm70kBfytK4+yhD3tCZnZob4KyrGH6S0Vk1Z326keBXSPsBCOnHsaSPIYDLGMYdj5p0rWq7MAHkhgjb1LZNeh3/f9BIh31sx5jXltwuNjKR+C8ZBQMOU1uee/qzbn54EwbaoUUY3dVQA96MY4O7IRzM1B/+JsbG0/inuELQ+cGRK/mL37tQdFnkyKJrihoG/9lyrbkZpwJEqkE6vzr8o7Jd7y7i70XsxKFevvobxouKY9WYT8c5R0vRGwCTvAqT7plrxoxvtt67etxxw9P2tMwR3p7prlpNmOBwaVQv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790012694; c=relaxed/relaxed;
	bh=y4bAp3nBUO90ZQn1u2Z0gOxXpoxTWghtyWO5GBrBpXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a2TANgyppZqwcrfgaulwrUhAAjlWvnAsVnZIGtrO4YafGkWlH4Wu3wYAHuu5r1fcqWUwvHzLGQ8j0FwMM77sJIRrSSnRpZxOC+o2pK0PhCyMA/zT61pzi5GrMHncoASjKzZUgh+dcfnFE7OZRs14nEq8p205fASfnr5fPTmxoP/BMArdBjVMVi5k3gsiqAGDPFo5evdSC/FSSPc32TQafp/R6vqSMDdaaXXu45jO0TzOdJg6n3/k09iCmHDTrOJuTYM7cQPPVIn8DRHbdCQt1DryhmPu3UDO5ZKIaIsU/bT4yXEjxHbfQu71V6qa06sTTlpfbI0vWfI8AbllH7sNWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=n5BmBcRL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3em2xagykda87tp2yrv33v0t.r310x29c44r-sta0x787.3e0pq7.36v@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=n5BmBcRL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=3em2xagykda87tp2yrv33v0t.r310x29c44r-sta0x787.3e0pq7.36v@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com [IPv6:2607:f8b0:4864:20::545])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpVx15XTvz30RN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 03:44:53 +1000 (AEST)
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-cc1b8088203so2826476a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012691; x=1790617491; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y4bAp3nBUO90ZQn1u2Z0gOxXpoxTWghtyWO5GBrBpXE=;
        b=n5BmBcRL8NzVxdJN5aHJ9iTSqvUmIKpru5SM1nuBiwKr+XUxVdtRIWmLmMM5uSwbAd
         FMKwQtk+snE5FJ9kHE4RM7rb/dUngtWItm8lu64zpaEpALLPJMhPrtDA4bx55mWRMN8y
         XA3I3pQUJhe1XxwnJOnm8NrVeWI24gSWbd+Zz/KXe3PM7KSM7gXvKTUEzn0JxUo4J1Ey
         z8qnNZz+gqmQwnOE/2/V5PTzCWsEiXVQZPZZOPJImoeuKZhyRxeqLE8Zwzrs6w2XRmFo
         Ofw2vpW4zzFApd0ydOZDmCan/MWM4+h3OpXSLIRpK9FvkSpzsJxCxhpoB9J17MV5pCSZ
         0p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012691; x=1790617491;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4bAp3nBUO90ZQn1u2Z0gOxXpoxTWghtyWO5GBrBpXE=;
        b=tlSnjZbrKZjHEi05ulNVNuPOvkxINLLUAC7jbOezCPxzQ+8vuaKLLhLWbugLFX2NXe
         0HOlvK2erFGQppyiM72FUp5RmdJvvugmYX44xS5APy7zklUm3ZVyyu+2L9I1kdMuTzQw
         apdxwuvjhwPK5cwknB0AHG46Uo7fkqe/5deHIfpGEnkwcVIlsy6iCoPoMg4AuSLEXeqm
         p061ERQm7TpT7r3pB1NF/Ddv7w8E8//di8/Rrc2aC5fuMU4Ez6OPcduHoAtdWqy1rpmm
         o7angoXZXferRSwN4A/qfPWShjnh3X65TwhQoxSC1ol+1Xolt89h7WL/D9obd7CV/G8U
         43yg==
X-Forwarded-Encrypted: i=1; AKwUvByUYOI2HKrvS+7qNrGEn/YH6XJyaCF6n5/9QzJfNPrdzr2KjzxMjHTVjOxbJHOvfox3CA+umcPYRNTeov4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kEnwfs4wDzLw73gGLc/rtazbktmFIIWFHTEWJf6jow4vMMMJMc
	vB4cqQgJdObnesNCh0DptDZQF7VwemUQSXXHf1l5CnzpjjGcy48CGQZOnAX127kblhJucEIYQQI
	k4+9bxA==
X-Received: from pgvn10.prod.google.com ([2002:a65:63ca:0:b0:cc4:5907:21e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1b81:b0:3cd:8bba:824f
 with SMTP id adf61e73a8af0-3dd8c3d3acfmr19085095637.4.1790012690700; Mon, 21
 Sep 2026 10:44:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:41 -0700
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
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
References: <20260921174445.911676-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-4-seanjc@google.com>
Subject: [PATCH v2 3/7] KVM: RISC-V: Use kvm_is_vcpu_creation_in_progress()
 instead of open-coded equivalent
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use kvm_is_vcpu_creation_in_progress() instead of an open-coded equivalent
during AIA initialization.  Unlike similar vGIC code in arm64, the relevant
RISC-V code runs under kvm->lock, i.e. can use the standard API without
hitting lockdep false positive.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/riscv/kvm/aia_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index efc7c0bcfba9..97833a04268a 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -237,7 +237,7 @@ static int aia_init(struct kvm *kvm)
 		return -EBUSY;
 
 	/* We might be in the middle of creating a VCPU? */
-	if (kvm->created_vcpus != atomic_read(&kvm->online_vcpus))
+	if (kvm_is_vcpu_creation_in_progress(kvm))
 		return -EBUSY;
 
 	/* Number of sources should be less than or equals number of IDs */
-- 
2.55.0.1082.g2b9226bbc0-goog


