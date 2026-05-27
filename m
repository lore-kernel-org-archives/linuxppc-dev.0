Return-Path: <linuxppc-dev+bounces-21583-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EBDCD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:51:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQTxX15dpz308g;
	Wed, 27 May 2026 22:50:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779886240;
	cv=none; b=Bf7tCvXA4FIN6xQolilRhMsUQzRWMb9qY28mZ8fUMDxE+6IjlrgbQfXY5SyPdCsU+0ajyh08FmrDHmnKYVcmAudJ4jsO6yPPKi+cOklfGUmDyn6n1J8iT1dS7ndKWGN3EyJemKPqckOQr/5JuN1sgfFgUHXll8BIgarUyoWsgz688xOXzmugIeCoB9YB49Z3huXcWS1shiYU+l2zKfSSGT+HBSeQd6zJmjHc3mihgRjR/BpjD1J+18Y9O/tDuzPsslXvf+705wnTKb/CmHkM03ZYEQB6v506eAXp+JLNBRnW5vRgqtEHGhSv23fTFa+gWew61bgTqud2zRaP4iz0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779886240; c=relaxed/relaxed;
	bh=cFfUfVdymceQ6sN/zEMi68S56nOfGcMVCqg5DL2077Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZUbi4pQxNAtWBhO3LABYAg02+u3mFzmoL23moSoZN79sXP1BSYA+aj7tn2br96qYaSG+DCs5s64zO8n1zFw/PZ2BK2WrKEFlJKLsh8oJG+rVeaDH4qDrheJCfv3kIWAOn7VnnGKnH0qfTFZfgyDxOvg/LDT2r2GWnCg+R3fPo1AdY0ax/pemDYSWwNs0KhevV2BweDr4wYXHRVPfM7c4p2pTErKcdshzmbA+zSo1E5dMWmaPkPjy8C6JLfyqe+yaPqff8M0p8KnyTwKQNTrklcxApogMqTkK0EdtDBW7nZJWxmudNN/NAbULEjP4baLZ8RnO41IYSTqPA4hefcucQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l0hd3oZw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l0hd3oZw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQTxV5GxQz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 22:50:38 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-36900945df5so5816123a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886237; x=1780491037; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFfUfVdymceQ6sN/zEMi68S56nOfGcMVCqg5DL2077Y=;
        b=l0hd3oZwPUgBeK1+L/mPK9EGT6RW99qDdwzZlYQaPwrWQCxbNG2dy7G7sRvmCfSL7i
         AzhuGa7bDtwtLGDKBir+n5Xzwd5ER84LiiczBUPGjh7ejcFs5C9zPSUcOZFIS/C0ebvK
         +26nSn3dzU01ko0o9Su5K4/guNgdUXY/WHyke7WNXWRGrNtEr7jPbvWPgCKTYBZQM5oY
         OL5Xs2EJtKt4YWqbbWAkg31TgVkRlG/kjjbVpMkp8RYPAu8RfjVKMH4wG1AAfCwGeXta
         UvHp7xQkbK3r78ymS6HsaSw/4UG1pdwaQ4gVNgOOq6gQ+VlJs+WyYFHp64SZZ8ZJMMIP
         4LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886237; x=1780491037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFfUfVdymceQ6sN/zEMi68S56nOfGcMVCqg5DL2077Y=;
        b=YHI98rl5Qy2lF7Vff0duN0W6rD7aJzEkVocRgUqHiFpzgMR7n8J4q1DmiFbBreaVST
         I8hYovKo4WxMRZN+T399q/pDIFjRkXKeSsRb2ziCCKh9IvzfVAl3bkc/TFpuR/ZTZ/3n
         3SjwlC6oNhyk1KPrHd9FRu9kCImCoN6BH1mwk5JjSPFK8Ad7O6OlZhboWE8/5uLOhA+w
         SNsCgBbrLLF+qGvUsxri8Av1uTs+1IRJz/2x8wysgFXqqVQQsKLdJU8RV3N5O4YaYJ38
         z7MdpH+F106s4C1KeiNL50XF5bjeXXVSTh02uNQNoDknMML8lcRufFO6QsHXnOD4zFAn
         VSKw==
X-Gm-Message-State: AOJu0YxE+19m1WNYdFsXnyS8yg3+LO5Hx2P78XCfOsYONFU9p5qbq3H0
	+liUW+dxsOWuCy7YSSUT5APy+XdSugXV8i3y9dytmI5PE8uQEQz+AJHm
X-Gm-Gg: Acq92OFnjlEWNrr6rbkCWReziQbTm3zEqO0oGjRKiH1JaXpQ/JV8vOG6ukmiXbf3Na7
	8My8yDrAr+YZDJWcnOwtEFCpIk436ZywKCAqfszGcGf9O6r/UVte/d0PkzlLOzfAh7S00EcRO/o
	oCqEm21u0LHnaW3jlPXShhtkhsLkUsc581VLOSc+/lowpWcivfxVtE7HAyzigz6DcrGQU3F6bTF
	UtzSLS3JWcyPKQXyur4pd6S8TEe1IXCZwtjpWh4C+tK8HJOPSs6QCQd5AgwavL+TyLHncK9x5K7
	hlwyYMLpYY7fc42ya46LCqTypGSJWhSHtXXdhwBoO5m4O+b70J0tYfhQuOmUbFitY01UnCgMQl+
	fhxK0xOpGYTaMkQ9/hDSptNK5FpvAVEhSuEHJjOHEx90c09iUCn4cZ1O0fqy+3MB/NfISN61NRY
	NVqgBoFVirc/g8xMoRJpGaNArLr1Mh26PErIDP2Q0=
X-Received: by 2002:a17:903:2f89:b0:2b0:ccad:de1a with SMTP id d9443c01a7336-2beb06bc100mr254327575ad.30.1779886236651;
        Wed, 27 May 2026 05:50:36 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:36 -0700 (PDT)
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
Subject: [RFC v3 05/10] KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
Date: Wed, 27 May 2026 18:19:54 +0530
Message-ID: <c99d0f7a08dd0ffff355d9a8a3cafbdb58ae646a.1779885589.git.ritesh.list@gmail.com>
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

Print the vcpu_id and errno when the KVM_CREATE_VCPU ioctl fails, for
debug purposes.
This helped in debugging an issue with KVM on PowerVM, where KVM_CREATE_VCPU
only supports max 2048 vcpus, because the PAPR_HCALL H_GUEST_CREATE_VCPU
("Documentation/arch/powerpc/kvm-nested.rst") supports only up to 0-2047
vcpu_id. However KVM_CAP_MAX_VCPUS capability extension always reports max_vcpus
as NR_CPUS of the host.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e00a25f59416..6319e2037882 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1354,6 +1354,13 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	vcpu->vm = vm;
 	vcpu->id = vcpu_id;
 	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
+	if (vcpu->fd < 0) {
+		int saved_errno = errno;
+
+		pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
+			vcpu_id, saved_errno);
+		errno = saved_errno;
+	}
 	TEST_ASSERT_VM_VCPU_IOCTL(vcpu->fd >= 0, KVM_CREATE_VCPU, vcpu->fd, vm);
 
 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
-- 
2.39.5


