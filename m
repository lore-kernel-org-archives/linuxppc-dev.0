Return-Path: <linuxppc-dev+bounces-27940-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BBCC98302
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:30:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq7tB2gYKz2yvy;
	Wed, 23 Sep 2026 04:29:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790101778;
	cv=none; b=SqmP2UltkVJhish5zmjTbPqO3HhxWow0cotEyzsAaRenkT3Um6FFWsQl07xsf6ZkMNs7mtIPNREzagpbtF4+SC6/bUOQqpNhDJS5I64MwjgJtq1gXKVIhOxnq0AN3f+bq56HzqZ9tKlrcxSFBdFm2dZ9gSecrT7FLHg3pI0BYz+yrNCBw5VUJTl3uELfX14HMSOrGIQjQi4iH+FffI9cQln/wb4XF5JJxJGiucv/N5o65ZPv2UvunWZQkDO28L8aPBRkKA7r41lOSBv9mnvHVYCReVl95xwROV6CBB+dWHW+YocPIFMC5YCM+TYYIbP4RRGvxRTbQ74nJaM8mSRrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790101778; c=relaxed/relaxed;
	bh=pjvCz/V+hHRF2vZEcQUC+5VRgYkjP2X2UGtP/7PKl2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SR+OJBz11bU7lS7rOL0muDcJihKOLtZVNK1sdpfBZwMwogfi/+/HsHtdCD1gtMSDDy/RZxrBnAsc7kTqb0LG4mw/fRs+gsowttzkm6xXH6esgjYVfvRJ+ofEiRYPk3T/tnYfNNx7RCpncjJkC02ZjoTW+iuvzZ3tiYFwgJJ9bC7C5JKRLGPKd5tx8A9GBrXuwr9Bm5STdpDSSDlKWy35Z4J4avZhG99rS6tMVDP9t74CLSksAa59exNgquGk6YYzLDSYDVdybXIgc1hFBjtoazLHVPbIOp9eZoprx3cy0y5eUxjD6ZvVCuSMy8uQgG/RJjj6+MSixGdZ++RnZIuUlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=On9NqTGu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=On9NqTGu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x10.google.com (mail-dy2-x10.google.com [IPv6:2607:f8b0:4864:36::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq7t94D5Bz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 04:29:37 +1000 (AEST)
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-328664c2da6so57645eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101776; x=1790706576; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjvCz/V+hHRF2vZEcQUC+5VRgYkjP2X2UGtP/7PKl2I=;
        b=On9NqTGu3DuejgjqlF5QEuXUJJuBl/L+q4a7LQOLMHOHl35FVDQ8Y0/XJM1RyMvkv9
         bpM1mMp+PXLvo+cS8PdCt+TFhaBHSbBXO6Cgqsb0NsG7GBUq0jciFnsVXyqcXsU5eeZZ
         4Twu5fzfbbwWyWeiN7azmbBRkNM11qmnhDtWFtUQLg+60/MDarmbJbozfpSB/+9SIqiW
         Ew3idavtWjQn94FnUrPXYqIgS9tZbCo+4EeCMX0xQOoU42Ph9UP0M/BPIZ8BXzBrxUIl
         I3tqkOPQdU//jXaSVau3Z3a8jdxfyavTZyOsRSxq3oYSOi+1j93BCOPja/AseiK+GR+h
         SahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101776; x=1790706576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjvCz/V+hHRF2vZEcQUC+5VRgYkjP2X2UGtP/7PKl2I=;
        b=zT3oVGCx/g7ajPIA2ImhB73eok2dYQfhZkcPtuAROtSMi0Rw2lIkmQFywQzFbCF9i8
         W5/E9zutmHahxXGgESjvU92khmvtB06vvpCnKveb5qH7UfGIjnz8Y1sXJx2kJSOw5PJ3
         HRttB4KEvIPG+YPQYeWzD7+htrIbUbUxXEDs9jvyTVndUZiAGVyNnMguqUtP0THQUZaf
         arsldnCfRw6HZqw5ISqY0sHPHsWO3ezLcYwYN1ITwf2cc2677fz8m8/tY/dNpCS7EX57
         rzDWm7HTYSPf4hqrs1ZyzWI/WJNpFHMb06jsEjGexhabwovH9IaLKcFqpf4rc8vRmjRa
         tkNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxv9Lmlb7X18IrhP7U6BKLfSmGWwSnUwt7XwSE8hOK3XzrxADjC3pgQmLh8cPzcQ46qkGHJf/l25xEOJhs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mfAp3DWw4RKvVKSf8aw0SUXFJOldr8a7nXa6JumUBSsbury38H
	rdiOGa1f5+yN+9IQ2egxtHTyzz/zAIXu2aaP4ig29s5KC8T+w33pQm9R
X-Gm-Gg: AYBFou3GdpmIx3P6/W0WU48eN0fyQtL9mJfbgL8Zq/PxKbpNcuf/aMqm98SddhYEHAb
	Ecj7bgI5xe1Vi4MwqzffXSTWz443OFCjCcrNbJx02u81zEUgthadPKihpzpUE3z7TD87iJq2SbH
	ME+Cn2qS9UL7SyD9Y+GsqkIxFucFcNB8e+sl7Uh1REVV2RHvj9fNEJXEb2sy5kQimKXVQ3fR724
	cmJMdDGmGViUDdZRwGBqilDBd5sevtvupXB5qfKEKwcHazevO4Ki7i/A2bs3eNOiQxPYzy8bKLY
	2NoAvtC6QSdX0sSYlCeGSwp5sEvr+ssVg1EQfVssdytOAiOKhbRC05QVYt/PFM+ml/vCtZ7wG6b
	FytKn94wxYe12HYOhNVRXkpYMcQi4hHACnRIlSIRCGkn1NVLowBHgIHNaTlNfxBnZ+zQrh8ddxn
	C6ERB2Ovx/NaIgUOIVi/e5SeDPnXD6BcGRB/QNKXH+lc8qk1QTCGlEwiWfoKAW9Xyhd6lHT0d4i
	iwYUjuEkRc9AmW4vXm1qIEpETytbwWGjxT83LMiojBeFCRvRMqmTRVBVI16tEphDfJ4vDFVsKFs
	qyf9ZA==
X-Received: by 2002:a05:7301:d597:b0:33c:1521:89aa with SMTP id 5a478bee46e88-33e8d2ebdafmr126981eec.24.1790101775482;
        Tue, 22 Sep 2026 11:29:35 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:34 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 4/9] KVM: selftests: Split out a KVM_CREATE_VCPU helper that can fail
Date: Tue, 22 Sep 2026 23:58:48 +0530
Message-Id: <ea46f5af08bec1e6c4c3124a6a02c785983519a0.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
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

__vm_vcpu_add() currently asserts on KVM_CREATE_VCPU, which is what most
callers want. But sometimes a test may want to handle ENOMEM without
dropping all that other setup that __vm_vcpu_add() has.

This patch adds a helper __vm_vcpu_try_add() for such test cases and
make __vm_vcpu_add() a wrapper around that.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 26 ++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 9df16c8dc82a..aa521b383abe 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -784,6 +784,7 @@ void vm_mem_region_set_flags(struct kvm_vm *vm, u32 slot, u32 flags);
 void vm_mem_region_reload(struct kvm_vm *vm, u32 slot);
 void vm_mem_region_move(struct kvm_vm *vm, u32 slot, u64 new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, u32 slot);
+struct kvm_vcpu *__vm_vcpu_try_add(struct kvm_vm *vm, u32 vcpu_id);
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id);
 void vm_populate_gva_bitmap(struct kvm_vm *vm);
 gva_t vm_unused_gva_gap(struct kvm_vm *vm, size_t sz, gva_t min_gva);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2be79c240ebf..7084ed90e4cc 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1367,11 +1367,7 @@ static bool vcpu_exists(struct kvm_vm *vm, u32 vcpu_id)
 	return false;
 }
 
-/*
- * Adds a virtual CPU to the VM specified by vm with the ID given by vcpu_id.
- * No additional vCPU setup is done.  Returns the vCPU.
- */
-struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
+struct kvm_vcpu *__vm_vcpu_try_add(struct kvm_vm *vm, u32 vcpu_id)
 {
 	struct kvm_vcpu *vcpu;
 
@@ -1385,7 +1381,13 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	vcpu->vm = vm;
 	vcpu->id = vcpu_id;
 	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
-	TEST_ASSERT_VM_VCPU_IOCTL(vcpu->fd >= 0, KVM_CREATE_VCPU, vcpu->fd, vm);
+	if (vcpu->fd < 0) {
+		int __errno = errno;
+
+		free(vcpu);
+		errno = __errno;
+		return NULL;
+	}
 
 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
 		"smaller than expected, vcpu_mmap_sz: %zi expected_min: %zi",
@@ -1404,6 +1406,18 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	return vcpu;
 }
 
+/*
+ * Adds a virtual CPU to the VM specified by vm with the ID given by vcpu_id.
+ * No additional vCPU setup is done.  Returns the vCPU.
+ */
+struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
+{
+	struct kvm_vcpu *vcpu = __vm_vcpu_try_add(vm, vcpu_id);
+
+	TEST_ASSERT_VM_VCPU_IOCTL(vcpu, KVM_CREATE_VCPU, -1, vm);
+	return vcpu;
+}
+
 /*
  * Within the VM specified by @vm, locates the lowest starting guest virtual
  * address >= @min_gva, that has at least @sz unallocated bytes.  A
-- 
2.39.5


