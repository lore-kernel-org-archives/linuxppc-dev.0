Return-Path: <linuxppc-dev+bounces-21582-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69898CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:51:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQTxR2GFmz302l;
	Wed, 27 May 2026 22:50:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779886235;
	cv=none; b=d7kiTQvaFDOM1pbWxGFIZm8SRsr03LVei29+aDtzCXUX5I3zTDiTQBK9jfvphkbIqvf/lZMBUO3usHS7JNKhSVWlq7otBVUxE7yygYdJv0pH3/bQp4R4/NWDJpEUlzQCAKOaWr1uo8z+JtwGrxUerv1rrnf15W4zEzlNzj7aGTkY4MsM+Sr+XYumyhgxeL4O+8ve5xhh23VVWFqwf8CwzM3IFZ0NEZD5oeyR0o43+mnXkJxcTtxFkoYmNvEwLTIsFTHNZnmLQNtNgpzrtHxlp5Rp3qJQ6OP/sBQLM5ojivXOKpRsHJMPpU9mg0tTBaY1vp/rMT/0/ZT59bU3VmVvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779886235; c=relaxed/relaxed;
	bh=WHUxe7lnPztFxDQVjPCLiqbcKDb3U3X7b1X5k1GLWTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h32ZK/vdZU4ISzfJwh7qbfxwFjfFDUXNexkIkR9qv7+8/kz898raofFyvmINuYK1+wROFv3B8JkfDTs6Joqmz7RamLBWLPfvmzFu/1q+HfwSwrvW4aOuwy9qVpIUsMxE+LRpzzeytIzyl9t0K/BSommr+jMut/fhcHm45Q03KE623UGFZMuIcQoedi8t7+MQzceIzSDBEx5a24fBXaZlTb82xU+uBZkyYy8o6Gllk2ZnPD5nhy/4Q531nc2iPQXpG9CX0gc4JWrJXPb5JUJWvHQosKKC4kffekHnAdzgq8CRT+2ZxDT2br4T7KKzudL+H41nICS7S1EdYz5K4OgiwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SioYrdbu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SioYrdbu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQTxP6yWvz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 22:50:33 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2bd9c3b550aso81100475ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886232; x=1780491032; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHUxe7lnPztFxDQVjPCLiqbcKDb3U3X7b1X5k1GLWTA=;
        b=SioYrdbucj/On3VA7AaHts+aNhJ2joV6Rhns5wzQ2Ae2ZRZ3e20Y/+dpEsTeeu746V
         mA0oixobLGL3TDSJdgM3gSgP0roqFLsmonMMDIGYcQSfk4gL1XbXxFf/Iu6aW2gbIath
         lXmsYiGluzq5qAdflFB8BWfggHt1KLCgGj+35PEaXV5QTcLkgr9S8R90X5kUmuShRkY/
         RHHpbcyUbkfbvrhuMJu8sMDCiI67j5o+ips8owleFwaiR6z+6Fx7G7K2Zp7zi/VPPpCD
         QINQH9b8ZgYOx2EjnmOlq04VzcQeuqGM5xrMrEV+exD2mDfaAEyzJoQA3zuZEAuePNYn
         9pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886232; x=1780491032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHUxe7lnPztFxDQVjPCLiqbcKDb3U3X7b1X5k1GLWTA=;
        b=FO9hBabrUjPQA8MqnneLDb1gdbpRRMqyTUcvwMIlU2h8/5uAWSEE/gNYQwPwogY3oQ
         05lK2WB5Vt9X3uo7YHL5E9Ov2S7ekz+QKSg3x3uwSERgIezvu0doly8+FN8rQsVq6Z5A
         MvUzPzZJa6nj1SiHpm0SvREOk2quQN++70iHguFqtvmvHsNMJ9c2NOsRt9kGp2mOrjCr
         fUsS8Eb0zBLTMu+CDwpTd1OX5gcQ4CS7IJZnbiQMFnCvjiC6j/cR2jsmUe9AB1LCvar4
         8CaIa6K8wrVVaL3V8KXIgVuS/x9Lw3UQU5j2iGrMPMUFDikF0UFZJPpkhWadcy0vLSa2
         184w==
X-Gm-Message-State: AOJu0YyfifTXSNcEkRHT5fm/Ww6FnqoqqVur7sIHb3sR9ZZSbow+IWNH
	lGAxF3WQpHiWtYPkYjsOxOTXxlymQnicYRZ5aqv4gZFrzZBKpWJU2B4Bx5C46Q==
X-Gm-Gg: Acq92OEZGf7HfQqFC2bOmSPKOImwdNKJqIyIbcJBvOg2o4sfkcbx+YuuVzfTKnFuWX1
	AqI8XpE8TlMqmgPJwWu87SPKONkLlD7vM7kV8TCyi+LbSoQdySxVlhpHk1QNowuljeDnvgMMl4g
	gnhnbh7qrORzfJQXeB3lidl5Srg+/43ftBgK1CEeCNtBLKKc3TIdAQ71BTh4w2EJe4KktIUsdas
	UTo79KYMBRZT55KX7QBN5k4EJsXoRlIwMHSix4Rjz1y4TZCBZc0Wr6Sp9n4jiNSWait+MPerVAX
	nKZk8uEIDtev+LBjrPuPrtUM9QmwUA/7iWbbW868pf+UlLvMNcIGBM5UWdfMYByrxRy7CQJ/uA8
	d6QTYBVRGMtbjWWMI2DnxixaOHCsjS71TataZqIrVg/jiNVBh16mEjQXm1kpPu3JwUquPlEwuQ8
	aR0PNnNCvruN3V9oNDJa3FDkJ48Jb1x8mf9DHx7QBXDFLj7a+2cA==
X-Received: by 2002:a17:902:f70e:b0:2bc:8ebd:af76 with SMTP id d9443c01a7336-2beb03466afmr244325935ad.0.1779886231867;
        Wed, 27 May 2026 05:50:31 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:31 -0700 (PDT)
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
Subject: [RFC v3 04/10] KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
Date: Wed, 27 May 2026 18:19:53 +0530
Message-ID: <5233755b872c4b97ca5a8aa06f06ee9fc73b4c40.1779885589.git.ritesh.list@gmail.com>
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
2.39.5


