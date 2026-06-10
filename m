Return-Path: <linuxppc-dev+bounces-22403-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40017CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:48:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5D43l3Qz2yrX;
	Wed, 10 Jun 2026 22:48:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095684;
	cv=none; b=H1e9P2J/G9wBTjayEdkBAUn+1b7w+vHK24mQ2MD5jgIZpfPECuQs283N1lLOMraffCE+n1dbB6CUq8Yr5/7c5/j0arSkZs4GYXhHgWzOkMzRKohtT8kN2k9OknJR36KR/xcryjaPfJFk29kEA2msrvvGHIkX3diC3oDSJstaIH+xWvrO/YNI0zH0hMojY+S6Akr7JksKVQO5ClcPbLcoiNGggBB1fpbmlC9+QOXn1TbY2n9dtKvBGxj566BUg6T2Xr8UiwWJJe+VDyh/w6sfvCxgY0z3qJ9SZ0i1OT7BW04vM3iFMQerwbcFElKtDgC36easKT+Do8a3at8LBPV5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095684; c=relaxed/relaxed;
	bh=YzUuGXzS98sIHXJvfaHc1K4ylZrcF6IomhXuLR53Dbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhYgEbaF9y/GseX/7KUQ38/Ck3SkNHzHJLHuc0JkjM9ZqJea+bCrpRiXGz5TSY+EMgNa3qxVlFryD0cOyelONJctG6gvtBmJJJEdfOlAXklOTbFCsOhtskM2G/ZSKDrB9CsqMZUe/A9/w8LaK3UFGDIqWw68u/+UXxakLD80PB2FcS3+ebmIu/Rh1zD9m9rP6cs8Ip5mZnxy4iOlPe5FxqN/n2qw0fXUm+wIHZ2wh1fR4O8bbizwXGpakrTEe5I7ZBydVx5BTQ2m2/o7bPtzk7JVZaV1cNWaK5woubZANE2BCVu3tz9oBg3/G/u6l5mzL72woPMlJrc4+1vb767UuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SrmceTxv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SrmceTxv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5D367dTz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:48:03 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so4334163a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095682; x=1781700482; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzUuGXzS98sIHXJvfaHc1K4ylZrcF6IomhXuLR53Dbo=;
        b=SrmceTxvf+LlY8m5bzO9MMV66/kwFnw5QXvKv7E4vLuq4eZXClGNvm/zHRv3OGcoWW
         tW7xxTjfwqL19oT3mFJjq6RPtMN0j/y2o4B5RDU1qqTNKToCHa2qxPaRHf/VdtTlC5wO
         GGl8QDbum/eJIrb2mpTPSyWvyllEOKYqEBusnVpS16bBTSA50AzgGnQsCHPixjZcwhAp
         QJhLpnA9p/CNnTQn0EvEg8xoWHSpoLdpu92Qr4B1a4KZWGzdqlB2xv8ddQluoTpJo5IZ
         ojAOanGlcL8lkmmmKZRhTOFpykwMteNI2fVmE+8KL2OLO9A7e9EaHhpHONMI6th5eRQg
         l5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095682; x=1781700482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzUuGXzS98sIHXJvfaHc1K4ylZrcF6IomhXuLR53Dbo=;
        b=drLS+9Q27FjuSIqENObpZnvnVr8HzaYjp5fD8T6HEWp26cSnSt/GT48iOChuaVAvrk
         b1BkjDmNhm7d4BHLlsFARlBQPd3AFz37nTNfyqUjF+oVVTIX4uldXZDoxEzsy3zAgakV
         98AtimgvS328m1nfo/oHC4hGv23/RF9U2HkHudysXosjueAYbkAkWE6xucm08gUEufyz
         2Ax+AcMRJyg4d2t56u0PXJ1UsqKfLk3usiMU816eawXZSAyu5L3f3Hf4nGnw6umNcplO
         PftKTxupgNoaegVm4GOxWH83pk9c/hL46soQUQelFgUxtC4gx/M58HQ9cKY9CR1Ynb/P
         qFTg==
X-Gm-Message-State: AOJu0YxCIp+ZRyoxzBSogzHWbViPI7agaL8UrvzJLWSjEcBE4r/AZpCw
	GoXHNQj9tczE/Pn2LX6nvZgl5LKuxRsGjFUcWNUVwTOa523BWSSZTxEh
X-Gm-Gg: Acq92OHrcfNYrDqIHGir7ZKrdqXRLNKqqXGedWtPIJb61gwpNU6mjZTIvkHLEweH6K6
	ggG0UiIR1dWGe4fvfUbMhYBGMb/nFEHWjXnr0J6dKA5jk2qxL9wggUB3fRZ1w5wQAMY6RexrD/x
	T2FAzSsRFh4NUMbwpFjWzav7TnB6HDkdOUX8RzBpnQO/mvvvlFlVW3eT5orLP+9oXxRreO4Ml57
	/bxKaEe6Rl2g3Ow34YVRazhSmJy3K2p1Jluht7ooN/XMKDLXWiUnBmkajyn4AMGCSl0II03dErJ
	UUdAhNCeVTbrcrDDzoYn8aP/r50ONm//rep+lA/RH17VuKOqhwHSO4Lz/ehoU9DENYuY4LbMwqo
	TX6yurfnNQKOECu4WY1vp7FIZ5ykuO2et33LC2v64zwffO4r6rIsLo4JdH1GlJhMl+cEgEoJxQ9
	rUkynxWs5KcKGOZuBTpcQzU7gXAgN7bkWecbSyOHWcEjAy6ljeMenkSUT88H3aBQ==
X-Received: by 2002:a17:90b:390e:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-370ee447eebmr24964447a91.5.1781095681671;
        Wed, 10 Jun 2026 05:48:01 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.47.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:01 -0700 (PDT)
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
	Nicholas Piggin <npiggin@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 04/10] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
Date: Wed, 10 Jun 2026 18:17:20 +0530
Message-ID: <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
VM's limit.

The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
to the kvm_create_max_vcpus test case to limit vCPU IDs to
KVM_CAP_MAX_VCPUS on powerpc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
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
2.50.1 (Apple Git-155)


