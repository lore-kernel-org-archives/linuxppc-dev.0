Return-Path: <linuxppc-dev+bounces-27941-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778F1C98302
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:30:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq7tH5TPcz3bRp;
	Wed, 23 Sep 2026 04:29:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790101783;
	cv=none; b=g4U5Fcmy1Bez3H6nNiiiI9cL4dW9vjJra8DEQ5KZoRcadW26DmYebMvi4QTFfRwmMN3D03z+VdT/oD+XnTASa85LUCCLz4JY64CgI/DcutpLF2hStjzOTUqiWyS05RwQvKtPPh0KVtdVabh1fL/hnX5zgKBJqDCtU/46muh5VP5TZLm9qUkpbMBQqyx+l92tApSOqE6CJym7Gr0FyfC3TFqwnuNBSUbY0zaHg8kNn11SJh7HGE4v6Ji+CRV3V44y+6dL7qMfPBWbapNUrFI7HJlCAdbh+IFDdkwx8gXfEOuSMKft19hJlT4qXYEGHOM0JkVQ9xejhVd/X4A8DHd6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790101783; c=relaxed/relaxed;
	bh=dSFKUXBkZGZNQnOO0S3ETacf8WntsJLIZhJqM465+7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEhdgzcS3CsooZWGkys8ErqlWvQDJ0foJdp2ckAsLPh10zDeS5KojXRpY971hXVY9fc2/9LGU+5To3nlhe1+ohrEIB7IzAgKYISP5nAP1rnDfSwq3580W5V2+nns78LO+gwUvened/w8TAYp+f53cajAu9zNLV5aVn13kfC2H8bpxTXoXr/MU+ceSgymYq4OMA4dwYvJvba50vmPXxohX8IYZTS4kZm8ozgaqwv0u7wRSXbWA/EA96cR2jOmfLhT8CO9uDHH0yvNXyMwP0KBC0n+FoSFxr6+bBKwczS9IvrhFrUoGMUIKH+9XyIHJDfm+n6FFF7s1VPrkEINTtAzTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WMF1mNqT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WMF1mNqT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq7tH064Mz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 04:29:42 +1000 (AEST)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33e46a156f4so64438eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101781; x=1790706581; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dSFKUXBkZGZNQnOO0S3ETacf8WntsJLIZhJqM465+7c=;
        b=WMF1mNqTK/zdqRq91CZhNBEqUxcJgzq7hBXw4dsIfZWJKMCNOHp+qphWRrJ54bZAxf
         v59kDIUdzAw5OcCJ4MOE/Ne2uENERlmWY6xHaCuTmGB8ZrFf8bcvaCjov7H8XU9AjH+E
         xIEq/UeELq4rgdNnBC15tzHVbuKab5ZBl0cuNh5MM/m3yn4eH8Qa+ZOlk2ggwEVyVJYk
         81al2Tl3wESiOc90y7+OFlOWjkXP8JcOqqiVqLXBYjL/qzGB+HKYYpxrjlrn2U2i2uOm
         hwxu3SmKoJo8Grr2f3X0XnWdgHbLrMF3+3HVxH5sz/HSThrGiylDGwBziHbbm0T8crIO
         2xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101781; x=1790706581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dSFKUXBkZGZNQnOO0S3ETacf8WntsJLIZhJqM465+7c=;
        b=muNOt3XeXTmq/u+G6VZId6C+WPyAX+C5f29m3bdlT3Bhw4d8bHhzewj6vFYxk51P4+
         +iTdotlmii9ycAeIcL3MlIsoXpVB8hnwhrCIzviAzXy+HStEA3xXm/XDIhJFw7jduHhB
         ZE7YLNhvvYDynQP93OPfLx3+fFJQScsjQteOrXV1ONUU175j8wSW1WsI1GMLZXIB1cxN
         CVrcyUanAqdxfXfWc739vu0BJhNEDx3lXIqMqbNvYFyD5Nf9RceW1CzQaS15yrAqKOls
         FBGE+cPA5EuXerQb0OcQdlUoY2M34QHw3xIR9IgLCh7s/oMq8fynJnUa4dUNQDlmwct3
         ENnw==
X-Forwarded-Encrypted: i=1; AKwUvBzMxXOZznMF0s0y3DStoJE1qbgdldN9LuDRZKKNdq4Wsi4S/Q/g+fJyax6ANXSvWCYelsxSaPh8gDKIVDE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k8ajHtnx1Cl6ama2RDc0nwkjRwXPLPSzbsuBn5kVH/rZYA8fRR
	ZnfWcRT6wwVOQqGvIY42lD104vo7DYm3h1P2VZTD15JBkfXlvqBLVVMs
X-Gm-Gg: AYBFou3IjagFl9uuPnmEywd2Jj3uZ9TI3kMNJxkhgSW5pywLdCd8GaBPF/MJxK4FQfo
	yDSiiEk3/9SGwTB8sUqKmi3VmefEFVsGLXXRCS429gBI2wUU6H8P3lsH4/bK82b7wQzl+Odwg1g
	/ERh0+NfFXYcjbt0iNJ0SOHSE7qZGspbwBDD0mgTU9Cdffto2qvz3+LgURdHROphAgvrzHGevjT
	YXOE6FaHvSo4yJgaYELSpXIKGJsOVgKp4W7SLxZymxpPyWVKCks+No4SHI7GvmG6Y9M+a/VaJgq
	eBQ1sS/H3WiLrHyCUYV2pEWoQP/DhWVmmR9DzviatmreNuv4PmzG5Qrwa8dMhOBquJifEqTX4VW
	sEZTG+fwPoASKjxcaxqdKB1U8afovahde4VEo3NlF70XxUgW2t/+iDC+O0FMJBODPj1YJItRF+7
	JZhygK5zOPFs6oxsXtsu2M1YTPfy80VYws8Sy7HCjy2IPRCUEhw1uDxYN+8XZGo9pIjQ0zgtP1t
	yhAH7Pkd1kxxNoF6Pzc1QPZR+k/ToHjbO5h9a1oUA2x2G+W5IeyupLsoJNi
X-Received: by 2002:a05:7301:700d:b0:33b:eadd:9006 with SMTP id 5a478bee46e88-33e8dcc70damr130602eec.23.1790101780602;
        Tue, 22 Sep 2026 11:29:40 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:40 -0700 (PDT)
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
Subject: [PATCH v5 5/9] KVM: selftests: Make kvm_create_max_vcpus tolerate ENOMEM
Date: Tue, 22 Sep 2026 23:58:49 +0530
Message-Id: <25cdef9c45a1270dcad7e9c4140e56b6953eb27b.1790101179.git.ritesh.list@gmail.com>
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

Some hosts (like in case of nested guest the hypervisor L0 might have
quotas/limited resources for L1 guest) can run out of hypervisor
resources before hitting KVM_CAP_MAX_VCPUS.

This patch make use of the helper we introduced in the previous patch
(__vm_vcpu_try_add()) to tolerate such scenarios where an ENOMEM can
occur.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  3 +++
 .../selftests/kvm/kvm_create_max_vcpus.c      | 21 +++++++++++++++----
 tools/testing/selftests/kvm/lib/kvm_util.c    |  5 +++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index aa521b383abe..576bbebe0679 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1064,6 +1064,9 @@ const char *exit_reason_str(unsigned int exit_reason);
 
 bool kvm_arch_needs_naturally_aligned_page_tables(void);
 
+/* True if KVM_CREATE_VM / KVM_CREATE_VCPU may return ENOMEM. */
+bool kvm_arch_vm_create_may_enomem(void);
+
 gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 			     u32 memslot, bool protected, bool naturally_aligned);
 gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index 59ddc3757943..45a9d8b369b5 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -20,16 +20,29 @@
 void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
 {
 	struct kvm_vm *vm;
-	int i;
+	struct kvm_vcpu *vcpu;
+	int i, created = 0;
 
 	pr_info("Testing creating %d vCPUs, with IDs %d...%d.\n",
 		num_vcpus, first_vcpu_id, first_vcpu_id + num_vcpus - 1);
 
 	vm = vm_create_barebones();
 
-	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
-		/* This asserts that the vCPU was created. */
-		__vm_vcpu_add(vm, i);
+	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++) {
+		vcpu = __vm_vcpu_try_add(vm, i);
+		if (vcpu) {
+			created++;
+			continue;
+		}
+
+		TEST_ASSERT(errno == ENOMEM && kvm_arch_vm_create_may_enomem(),
+			    "KVM_CREATE_VCPU failed for id %d, errno: %d (%s)",
+			    i, errno, strerror(errno));
+		TEST_ASSERT(created > 0,
+			    "KVM_CREATE_VCPU failed with ENOMEM before creating any vCPUs");
+		pr_info("Created %d vCPUs before ENOMEM at id %d\n", created, i);
+		break;
+	}
 
 	kvm_vm_free(vm);
 }
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7084ed90e4cc..b4d6b8167466 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2112,6 +2112,11 @@ __weak bool kvm_arch_needs_naturally_aligned_page_tables(void)
 	return false;
 }
 
+__weak bool kvm_arch_vm_create_may_enomem(void)
+{
+	return false;
+}
+
 gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
 			   enum kvm_mem_region_type type, bool protected)
 {
-- 
2.39.5


