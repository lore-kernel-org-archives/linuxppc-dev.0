Return-Path: <linuxppc-dev+bounces-20990-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4DACD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 16:05:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHBqF0gwhz2yZ6;
	Sat, 16 May 2026 02:04:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778861097;
	cv=none; b=k0PbsgKAesRum8O9UG2pbyGYIJ+0RHrLnutiXix+YXFEDi1YQG7usmxO8lOe51YcfB4YH8yfpb4gdFsMjp7OYK4pALGtkiHx2h1YpOZt+gmroaELTzOPyvD2mqxe+EV0upegiLIVCGel60xWK2X+jxHZIEXweu5Au6A/ezkSkZlKurapfxpYi4Xbeu6qrswbE1rP/TVE27Yiy1gaYrkfdwDPKGgGLLcYe+M3x++3U9Lyv97b/gPCOVpClTXgqOf4AML/4LECU1uiQ7rGdRp8BwNGlXdgjBiLIKyLZPHa3HmBqVX6df5RKvncfPjnA6nu0IiFQd5HNapnZUycTpy8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778861097; c=relaxed/relaxed;
	bh=CWSTcJ0lUIenOrMKgCBsi4dMZXBhfxtLdXUWtU/7JTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFNaXzfsUp7oqIyz1KY3LXVmPKlBRYjiiI/oaT4ASStz49eu5xFJD+eDa7GJvmcteuz1knVFi5nIcfiB3VApHQYs9IzPJbbap6kNlXEN14Gq9kv9kjQ9f9RjjXnNdOfRXwOlqFvjXSou6Zn6vnNrnCGEwliwDS6++zv7zJkjml6J0ghtuVMyOYiirx0zf80VeLudL6iMitqmhshjeV0ymkOQhpBoaDmWRsoQTgJYfX1PlcEw7xdG3JvO9UkTVYJmDU7Zhmt3sZ0JEcllxQ0Wti7tArtrkoiAF8WwhjZLGSM9o6CBaskOQoxTYtyNSLDpiVS1eVHUNYg3L4t8/omQ7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rzGEGyVM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rzGEGyVM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHBqD2h4Tz2yYy
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 02:04:56 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso647898b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861094; x=1779465894; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWSTcJ0lUIenOrMKgCBsi4dMZXBhfxtLdXUWtU/7JTQ=;
        b=rzGEGyVMaseQFAgiPDdzlaLXQ/JT0g+MhZ4e9ZA0jHv/mwFKSBHgO3erw8htP2L5fz
         tRhpwSTQQFhgGWKJXxQGkxvMKX2UAuH0S0+g0tQ84+/EzJcrr6rWc1ON3vpLLI2Eoajd
         xYGts4MioduQ+dgnbwj5SJiv3YEkXNUC9LMDnX0JPmp9GKBptg0DE2y28CzWI7YUGYg7
         MgWr5yqBDvE/aDtJWaTme8RaIDRbQquc2CK/Dhu/PWMbTQC6tAxmO8AFon4mK48C4oSh
         XMaiRB/pbWXVFoaG6MkD3VRZGRu1Z5vTVBT7qs8iGPZF6iXgyYTjcalahiJgls5AZ4j4
         74WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861094; x=1779465894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CWSTcJ0lUIenOrMKgCBsi4dMZXBhfxtLdXUWtU/7JTQ=;
        b=MFtO/MfQnZQvlCnFDcImTjiLSN8+OCA1GJQF7uAoJeCa6+M2YXe12N5oPyaVH6Nxvt
         I0IsYIBwQ7iCZF1ImqySKpw4cD35Zl5rMCrev21oZ5VPT1S9Y799K8MLslqx8UwetWhv
         hALj9czF9NqR8XPoxL/yFiF95SWQm1bGnPvCit/XY4prxbxX7RfgJsoq0TqhhAlWmMH3
         QZLW71OXw3AiTUHJs2N78vIAqx6mJg+yaArV8BsdZLsUc8FVX7ZeAHQb6PjUeEz4n8r2
         gKkELOmj2hSKyTKVAMGRNF3GTRuJob3oshxKjFM125E7mSPGRMLePvML6Y2irQLmWapV
         eQ+g==
X-Gm-Message-State: AOJu0YxUc2X4o/2mOKii7j/ybJ4dFQ0Ts9TWLLClsKE1VFP/D75RsrPJ
	VsOwm61b95U+cnMSavceYhbJbOmw0wIaDcV466Hxcd2nwmJfyWTbvqV1
X-Gm-Gg: Acq92OGZBknmTHX80dboOE3+uM2yianwE5K1TAozv1Y7fr/wfgn/VL4lETQCt0uypnJ
	5b4f7owD1k6Hkvr1hpH4QeCUEu1JD9qDheyfc03g4UKOHtzFdQ9q81IFkKiq4/oS1WDKquHQO85
	X+FPZVqthAWh+z4mj9UKZOEQvI0vSWl+9BTQNkoufiI0HPR5MgGkVwl/DaUqsqE19gY+67NDs7P
	3puk3IToDPtd4mK3IbWASxVlbMONWMYfdDaWZ/1wGfHKmK1ZhfFL4RPRo+za8fDjYGed+u648hq
	+1BTkSLEfwismCS/Mlk5hyqyl2OF8ztCsiu1VTIsRzUiPfc8lrJ5Q7mVqGatptdMjDHhxZRFbYL
	EM3kjJwpBZzYqyQGhZHg8ShYMdtjT1XtBEXRJbt/dXn9V7cWr4UIHgMKvtKAKBg8RX5n6Z0QBXL
	v1l0rAh7W6j9eGJesoPJ5wEzRmEaraWG2Q/vHFmFH6CcfZshUuLVyd
X-Received: by 2002:a05:6a00:39a0:b0:829:8083:472b with SMTP id d2e1a72fcca58-83f33ada10cmr4070840b3a.4.1778861094440;
        Fri, 15 May 2026 09:04:54 -0700 (PDT)
Received: from localhost.localdomain ([171.76.86.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm7920262b3a.49.2026.05.15.09.04.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 09:04:53 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 4/4] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
Date: Fri, 15 May 2026 21:34:23 +0530
Message-ID: <0050c451633ae8e22ac80368587aca70e96457d0.1778857539.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1778857539.git.ritesh.list@gmail.com>
References: <cover.1778857539.git.ritesh.list@gmail.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
VM's limit.

The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
to the kvm_create_max_vcpus test case to limit vCPU IDs to
KVM_CAP_MAX_VCPUS on powerpc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to laest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index c5310736ed06..a82c13d6cdf5 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -56,6 +56,15 @@ int main(int argc, char *argv[])
 		    "KVM_MAX_VCPU_IDS (%d) must be at least as large as KVM_MAX_VCPUS (%d).",
 		    kvm_max_vcpu_id, kvm_max_vcpus);
 
+#ifdef __powerpc64__
+	/*
+	 * powerpc has a particular format for the vcpu ID that depends on
+	 * the guest SMT mode, and the max ID cap is too large for non-SMT
+	 * modes, where the maximum ID is the same as the maximum vCPUs.
+	 */
+	kvm_max_vcpu_id = kvm_max_vcpus;
+#endif
+
 	test_vcpu_creation(0, kvm_max_vcpus);
 
 	if (kvm_max_vcpu_id > kvm_max_vcpus)
-- 
2.39.5


