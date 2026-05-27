Return-Path: <linuxppc-dev+bounces-21586-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09859CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:52:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQTxn0t1cz3bqs;
	Wed, 27 May 2026 22:50:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779886253;
	cv=none; b=YDZb9l+PSpa60ObYl4MPHToLwiWTFvur5C4y3ut18YdiIzunKbvKEToxfp0y6oJmyoxlSIJHMU1foWqS0x+ah0P2fYOqVPuHGAoauHfQn2fX0PtI8Clx1SyuhAOQJMqX3IRvUZX0q/QESe8Mn1JpQZjMDvIsf2DKWXCnACyK35x/+0COXUJ6Mjrq+vkZDHU57zSOkXVjQySx9fnfQV46vCFjSbdvHwMJpyy90AApjRalKtxWuGyCoP3NUu0gDLn9LrkjVfNzu+o1r8Q8WpWBpq7hhSMPhtr4mXPmXxv/zu/yyIK+bpxCO67rU09Vxukx8X6ATT5OdOVq7vpoY7xukw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779886253; c=relaxed/relaxed;
	bh=YMs/uXhPHvjv8tK0rG5PcV9J3YapP9N2N0Ynmb7Sr+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkw5JTFbhLZITdygvIO4+47vUcIzoL+FPN0TfHDKhAbHbnx7gjZ45OGYpiLPacylpgEicYhj4wiHDPqgcJkyt6JR6h7eB5u6YCswnbchqfdP1t3ooXkVFIDxIB8kxz1Sqj0g8sFeGqxQ3l2u5m/lA00djE95BQQ6Ypji/fQ7RRkh3Hu7HFkw4lRrdoJ33zVqXre51oeVNO4100FFZ+p8E9/y+l7r4bSHq/mscQfbbg9DFDEPk6SwpSz4XWn9AHsIOZmToHC2ecDDCs3otWtCluu4D8zcTSYOQBN3cGXWlM+pqOhW08uZAKcHKDMPr/Rk6RusJqVtttDq2PIC23A7Yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iBxCbRbf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iBxCbRbf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQTxm3htQz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 22:50:52 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2bd2c147abaso70630065ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886250; x=1780491050; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMs/uXhPHvjv8tK0rG5PcV9J3YapP9N2N0Ynmb7Sr+A=;
        b=iBxCbRbf2YFMKy4o11TNk87ipSq5oCmhgEnoMsnM2rxFNowraxKiksssec3y1wRr48
         XhT4QNkK9zNFhSy4QIURJDnPwsJXZNsvxyYJaxtmBcDygK2FW0ng4p5m2jeozGBITsRj
         TozvKd456LyBgPmV8bgY/rastAkNzHUFX0cduMdE0aEewCT4aRo76F1o1TTJ5Huxap9W
         FJu/29SLlz3HzDsbsdP9gW+j7pfFWILgG+c/L9tYDuIGVnJZ/h7NkqqkZX1Di4Qn3qjm
         Rel6IGZ76t9vhNLZ/X9ilfvvt3RQPuYZPtZZi1jL4FR6y6sROxOQmRu3BCXZFz8rLdEQ
         vG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886250; x=1780491050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YMs/uXhPHvjv8tK0rG5PcV9J3YapP9N2N0Ynmb7Sr+A=;
        b=EJfETybuPGkIsj9cylakdC3MCGhXGFq+sRs6cD5jmzm+4dkDR3GSzaqbKqXDZvEWUR
         xDge9jr9pRnT3MBeochedDiqJXGuLc27WvFqsez9vbeBFNBkPb80rDCZeytD6cFiba0N
         ESQRjBscLVRI6P+pAjp04X/6RoyqnACvjXBUgknBCUeXPSnusXPyt1irlUHM1PzYQjH8
         qdQZJ/Pa7digDMqXYXShnBUcB2qnk+i9Re7CxfBcTp018CbylE7RSCwLj7INrL4B1qg6
         IjoIwT6SaL6HnAFSKk6wfDS9x2+UozjTGDD6UydRkNeBege0wYj97VVNU/xXI5Kgl4lJ
         6rRA==
X-Gm-Message-State: AOJu0Yzg0hYJ77JFt2rDw16hrHpdomdy7M0mtWNfMeI5BYxjpLYUdMYY
	W1zAiaUFMqpddhM7hP1nxDkd6gw0oup/NLl9/3yKB3jOs7VB9r2v5uDk
X-Gm-Gg: Acq92OHNjmvFHcSji14VhHdDBqpz8pZr/hx88pa4AkuCgnUMNnGLBVRKOq5Cao/3uh4
	kaK9bhqt9sJe7FhuEpBZphynjL2V+G5J1m3x274HtGSuyHoPrUyvASSFCVjRPv2boiaTHOqv30T
	sMly5M17yqthhmSCsp/Osava1Ro9XQ8dp7t7vxHsY24MwyWyxCOULRmzGJyQeXINErtxmVhwwba
	ccyGTUQqO5Z1hwoZgoA1nqaXWmAbPQOczEXOamfqQGNXM7X5ZcGPk/igbUxKlT8MdMDXkn0KOKp
	kBFCOzPj+wR7ZvxDEN4pcY8BfbWq0XuvFAyUoM6bq3eoeDw8DMlqFjcyfZRGSjiqMHx9vKJDq4L
	pH9IMBC6HKs+ojfE1wL1vtggS9PykLKwo63BL5WzwO0bXOxLHi88SPWdZrf5bU5yDYWW6LTXnh+
	tMRjKk4vsEVqcMhmC5rvZRHq5HqtgbsAuRWXxuDoc=
X-Received: by 2002:a17:903:1b68:b0:2bd:9da9:a29b with SMTP id d9443c01a7336-2beb031a83fmr252499005ad.5.1779886250352;
        Wed, 27 May 2026 05:50:50 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:49 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 08/10] KVM: PPC: selftests: Use u32 instead of uint32_t
Date: Wed, 27 May 2026 18:19:57 +0530
Message-ID: <a7ad48d63d55a08e9d5bd3f63e5a5d2d14445932.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 0c3a8774692aa ("KVM: selftests: Use u32 instead of uint32_t")
made this change from uint32_t -> u32 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.

It uses the same method described in above commit.
  git ls-files tools/testing/selftests/kvm | xargs sed -i 's/uint32_t/u32/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/powerpc/processor.h | 4 ++--
 tools/testing/selftests/kvm/lib/powerpc/processor.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index cbbe390ae244..95ec3debc83c 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -22,8 +22,8 @@ struct ex_regs {
 	u64	lr;
 	u64	ctr;
 	u64	xer;
-	uint32_t	cr;
-	uint32_t	trap;
+	u32	cr;
+	u32	trap;
 	u64	vaddr; /* vaddr of this struct */
 };
 
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index ac5c3421ec81..0a65fc3a8d9a 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -312,7 +312,7 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 	vcpu_regs_set(vcpu, &regs);
 }
 
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 {
 	const size_t stack_size = SZ_64K;
 	gva_t stack_vaddr, ex_regs_vaddr;
-- 
2.39.5


