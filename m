Return-Path: <linuxppc-dev+bounces-22408-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF78DCD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:48:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5Dc6kwJz3br2;
	Wed, 10 Jun 2026 22:48:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095712;
	cv=none; b=CF5wuxERFGMCaFMNlPSICMYiXeMrqPaY4t7VU9Cxz6M8ib7IG9HivBKHNAMQ5HufrbpSds9vBA8nIwnNXvU4RXliN2eCzDBOhVdsWJAMGh5oz9oy6cn5D0j0Mh826mQ4ewNFLjxnisXUYiSTXXk2dcMhQss3xdbizRr7MZ5elTidkj88kih9fJvcitk7gtao7bRUS568XBl1du7aV7L1avoDisl5xRzNtL3wSsrWMLq0qwjiMPZsm6/glsPcBwDLSMdxO+bL3fuxeHdSKAH++4Dw4sKzGQBmY/OMUxIVF5La1HaiXUUO7D6GeX9N8cWCNHEa5p0WrP9BiFmdDSuxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095712; c=relaxed/relaxed;
	bh=1Wu2cAS+swkyn63SBvPObMrfOQMzmMC7OlLgl4oESrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKtbhaNuYYWQp/pk3tm0ybRnFoWuI+sDj2eFt9LeMRrTAPHthx6qIkVNxNFj8R9RQV11nWRswY1vTDOF4ZQNE1EOMQza652UthjBxiyIJLvWbvjvRRpeGhl3mcrNfflFaCf+9o0o98nEN1H3ATsVjy51cKyKKx9Rz54YXSdEnrguDvYYbmz5sOGgBf/zwcw8gXDFYMKlcFZwCHDT8mkdeYt8ge0+x3ryUJyBBFMSe3C/OZPVXcY/3TTH6YX9RF+BrxQ8dMxt7Vyx9d5r8ZwdTXE0ny7gnJEdMjDKNV0oWF2fBks2k/+4KY6E9zAqGAmeJpMmBx6PyYk/0WALA+QVMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ld4z6a30; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ld4z6a30;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5Dc2JTGz3bpm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:48:32 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso4290789a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095710; x=1781700510; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wu2cAS+swkyn63SBvPObMrfOQMzmMC7OlLgl4oESrE=;
        b=ld4z6a30zNtFI3Y1TfFPYOZyn3+gHHa9jjsL15TdJ8GzApGtEWkXCQy651HQSTMebt
         307iVny1o9MkeFYcUZRQx/+jaXQ0BG5dDpjw68moyVsb1LuhOw9Q59X6xoeYtkrTkLrq
         lGyAaINlLSFCseTpKPZStNGC/JlZKUUVPV//qvm0PY7CeEcVUd2idZTP0DdlSo12TqfI
         7ncGW3T1ip91A8Pa6FM/YhNrN6hA1ujHCAqrHSnUJFzEzhhwWy5iuUuGH/0bR9wXeWFW
         1/M3buCc+dZ1iL2MR6Pv3WLY2DrgfGwbaNM5bW8+1gp/UILkbgCPcZ0fFEXqDdR83vm5
         r1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095710; x=1781700510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Wu2cAS+swkyn63SBvPObMrfOQMzmMC7OlLgl4oESrE=;
        b=BVFkAWcEUvmUqtWHOg7PhcS8XeigAq/sFW5gyP2eni7EVru5+f+F/VI6WjtS+CljOa
         ZTZozWmi3n2w3is6PDgoAr5XU/kpI3qb6oyUJg+AAJvwuk9b8GNrFtmS69WjWL8BF2Sj
         laDrulRBY8Jzf9nLm4gIZHSbAebQch3fXLmKNVmxwqcZ2cChQduBdkEG4bOCDa3UgcNq
         PXG9SyJfZfqNixQfYrOv0l8QRHYNm0+p8VvKt7bjnhaegMG7LFx/VSZc4GUk3FFfiquA
         iETMDKUTfnRp7QFjIGHnM55+FX3bRGjk3HUA/r/9w4616gxdbkNOuPaOBFYVA0+frFAh
         ttvw==
X-Gm-Message-State: AOJu0Yzz8zLjMHESNKk7wBUrL3ht1kR6t3JK9rixEqKrqpVetWI0m5p6
	VI89ZdM3otkifETKcXIU1JLWqTrnT6CBIg7LUmmm++cOJEwYb/Qu9jZC
X-Gm-Gg: Acq92OGtOSjNMewu+hB/oTNtYwOM4s/Rk7NCn1JEmSmBe2bGjDd4KRFldzQ3u7OUVs/
	QIdmMnYbcLeCqENoeEaFwFScgEZl/faMhyd8j1GWM9X0C3BcdXFtNYBVqmXuS9jK6xvdOAVFuZK
	Txy0Jlh6nTYXbvcwtszjQRyF0LAmDYCt6xi4W7bTcJCRffK17BvfX0wa2LQ5e401orU+YFJ9LhZ
	l2slpBCowQayY4x3p0Ku/i6vSjEE27XgjorY5P4WvKHtmoGwzkDVNz/P6d6wV53A0etJ2ue0252
	BY/AydrIoimV/3uFLm55PmXKZCbjz8IXIG3ZgjFsBVltWVZqRX12UdIoHCsXG3kBT5jxCA1YRzM
	1gVc05WwG3hDTbQyHw1EP/qgbuoc+PCzy5tjnK0pv05le2UWyYWSWlIHMSY5vT3UeBlOgYX7bgP
	9OVjnc2jgXc7s1+WI/BQy+Zh6ah3Z7PYahHs5k0kfg4a15KjA41ItnLVJaJQvt2Q==
X-Received: by 2002:a17:90b:554c:b0:36b:9512:871b with SMTP id 98e67ed59e1d1-370eed0b682mr27885509a91.11.1781095710200;
        Wed, 10 Jun 2026 05:48:30 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:29 -0700 (PDT)
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
Subject: [PATCH v3 RESEND 09/10] KVM: PPC: selftests: Use u8 instead of uint8_t
Date: Wed, 10 Jun 2026 18:17:25 +0530
Message-ID: <9bbb88d55320ca04608787e05222a865c141d713.1781093720.git.ritesh.list@gmail.com>
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

commit 6ec982b5a2c7c ("KVM: selftests: Use u8 instead of uint8_t")
made this change from uint32_t -> u32 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.

It uses the same method described in above commit.
      git ls-files tools/testing/selftests/kvm | xargs sed -i 's/uint8_t/u8/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/lib/powerpc/processor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 0a65fc3a8d9a..2c1e95c8aa9c 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -256,7 +256,7 @@ gpa_t addr_arch_gva2gpa(struct kvm_vm *vm, gva_t gva)
 }
 
 static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
-			 gva_t va, int level, uint8_t indent)
+			 gva_t va, int level, u8 indent)
 {
 	int size, idx;
 
@@ -283,7 +283,7 @@ static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
 
 }
 
-void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+void virt_arch_dump(FILE *stream, struct kvm_vm *vm, u8 indent)
 {
 	gpa_t pt = vm->mmu.pgd;
 
@@ -380,7 +380,7 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 	va_end(ap);
 }
 
-void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, u8 indent)
 {
 	struct kvm_regs regs;
 
-- 
2.50.1 (Apple Git-155)


