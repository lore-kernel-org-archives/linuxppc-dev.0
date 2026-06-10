Return-Path: <linuxppc-dev+bounces-22407-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970B7CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:48:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5DW3Cffz3bqM;
	Wed, 10 Jun 2026 22:48:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095707;
	cv=none; b=J59xtLgH5y/c1wO1odr2waX7nq/Jfo1HTNO+tM51CSayiCL3o7FTOals6PvQN63Eogvxv94WiuFuOh+RdJ/lClIcKDMoVdmDZCFNjSk4y3UsLKGwO9mTrpTsypI6jswTWgLb9lAy84ZclGSGDNrzVhcrP+KP0Cid4k3i4y3sp9FRUOOjRYrHdZrSKcT5896jh425CWGZz/kl9UvRj6ve2FE+3RV658ZpUYyw/CCj6DVOeUURwd/peMO+USKNSQF97f/eMLxAjEiwyuaHNDsnkFQcCUDbv+wKQaNp35YeJ1R4+dUENsJM3ldzgu+lvIBUo1SclAn/UnA7ZHkQDU5WWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095707; c=relaxed/relaxed;
	bh=5AEmDg81pB30v/Br0Irm0sFgmM4aAhJYvvee5RH7rUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpvcThkMls83YtZC4gUE8QY1XQJPVmErdW8hJMpqGkbP85eA1afFgZek0+D0NA7Cm6lDYMkwznD3BRSb1CNWJK/3xBCJ1JLWevGA17vo14+3NqIJNdem17CQrRwQ0lZ3/lPWfzTzYtOzXcH8QW4EbkAQX1lwzBsXLi0j7XVbl79LHXExHBPzJVGa/8hXVHhR/c48yEUFx5bSMMONnHTuXC6AwdEcEA116QR67sq63lfaZokq8t9H8ecjgb7eOU77Wc9wN9XA/4vQIXvDxZYbcndJ9ibvwhH7v2Ew95mMyljWW9ngfGK6rkCRZp9q2fFrTepBWBxlixq2PrrtyGA3ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TeedWjDi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TeedWjDi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5DV5sfwz3bpm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:48:26 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso4353856a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095705; x=1781700505; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AEmDg81pB30v/Br0Irm0sFgmM4aAhJYvvee5RH7rUM=;
        b=TeedWjDirKlmpUXFIkYshwOvBzaSCdofv9vizkE3Cgww1HokgxqpNwqqUOpZ1gUbx0
         qUYc/W1zqQNDQaiZR0iSecQZEhX66mOrlufL8R9RiArevFulILNJT+ejJQ0eqDDzOrvZ
         Icx7htK3rKYdqd4oIbZkasaNDrcfPgVE/RQJccvjiuwVdY7n8YPKaGDWizi9L2WsZD6Z
         3usID6PTvVifTAurPpWI4Svm8b+Lt//BAsY12Uv1dbKed0Z3l9eSnjZOyYG9/V8T8QK/
         e/TASW8HHaMbEzLjP26zEvdx1+a1awA5CxS+jjMp+2HEB+Jp/IFKH3SWroFqCCGNI43+
         +jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095705; x=1781700505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5AEmDg81pB30v/Br0Irm0sFgmM4aAhJYvvee5RH7rUM=;
        b=an4RW16yXOE+fVafGGRwgo1+D2TJGkq/9E/OJM2OZPIjeHWTHNhw6FY3+mgI4+J1q/
         jsIliIVl+Le+Hr+XTDlyoTn5fAQsDj+hXP/GPC65hmJW5z6DnXqlaLFKTw89B7+xXc0H
         O58fSeaW0qfLR4/yiDlb4kwvhcYgwpFXkHpPm/uDMlGuqMJvW3ZaxwOiYfQlI9tCr/1w
         ZnVNrFXkURI0kuJcKtSiEnqTJrMzHEJlEtrwGS8NH5DYEn8mbeFSJ7ySew6yuDS/356M
         CsOomWEOLRKpJtc+vbaoY7X8k5Md0GPN1uHDukfVlH0p8PhC/uRRTgp1HXMHmvBniCE9
         Acqg==
X-Gm-Message-State: AOJu0Ywkzwit5Ri+OyMg+uISBwvq14XYp/G49NBz/D55k/P8R2uca5Ue
	b33EhA3SouhLzGokm63zOiHSb1Rjll2M5rMkVzNWFdmJFgOL+eHcpQgh
X-Gm-Gg: Acq92OEDeskbaU807KcRWc7b21cLmW9ziOFWtkBVxnmkqDNQ+YXh9XLYIn8+crX1+rv
	7fO4Xd1FqnVW7S9pyf0v6uZ8749rqakNJu54kTLeWpee+qLL0nMXwyAS4xxSHXLOhbp7uoHnqa2
	TaQhURq246H7PqRP6LiszlfuwEtwhJx2hh6wFlYxaW46Nb28FQXcncktzuXbcr6bsUH2Rk7da5k
	1EasZ4DEwRFjrwpjZrmeciSbOCDedekJpJ8QmBXRrZbThQF+0s9Z89cjCxGc8XgS7TG4sOCenIT
	GGfza+Imuw+m48eKHbetYOc8tZMorOtEjcxWl/MsStwiaphZ0yKxXI+vmek020o7yB11L++mxbF
	GLq8Ng7KgdUsNxrsCqgsAWzu3GYWc8K+TWfcIcTCCq5Pwu7wiV/cwd4Cr3SjZQSlDl/7v+5WP50
	vEBYPMft0EzXUIzbd6nCQGiPyQ2UHYrstoCGuOjH7VCjxAPfFAyr1T7aLv7n1OVw==
X-Received: by 2002:a17:90b:57c4:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-370ee64373dmr26186012a91.5.1781095704856;
        Wed, 10 Jun 2026 05:48:24 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:24 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 08/10] KVM: PPC: selftests: Use u32 instead of uint32_t
Date: Wed, 10 Jun 2026 18:17:24 +0530
Message-ID: <5b6a7a730a8a35fcd661eadcb3dc6687a6c75b84.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com>
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
2.50.1 (Apple Git-155)


