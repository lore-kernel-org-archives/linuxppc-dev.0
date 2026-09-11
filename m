Return-Path: <linuxppc-dev+bounces-27083-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3723C79FA1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 04:49:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Bp37kKz2yd7;
	Fri, 11 Sep 2026 14:49:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789102162;
	cv=none; b=bpC9bGtWNHkDDYdW/My9cdtayc0Yk1ZejMQa6crd+ZTLQ16ac6KeLsEQwI+HldF4BqdpqlJbz23Zzxr9orwIe5uaE4j1sXJWV2+3sAH2CfyqtSIZmECkCrQkNat6zI6RaS2uHyX4fhDpdSy6X4n+LHPZKYG4G6GOXukCSDfPD6AvIiQc+nD9xIPnr9u/UUal4GXEGoxTaCfZBzkS1yDRJwvzibykZIVM5XK4sqq7S1XeF7tw7RgPpo5E1WzBJD0vb1n/Rh4N9J8lb1WF7zaSE5wdP73KWnz0qg/xvqTcivEgre6Chg3HcFO4bjwsy//nh9x7LmK7EftoN9QA3I5nig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789102162; c=relaxed/relaxed;
	bh=ShzPxubAIgCFioqA8zTb5jVlls4ez8Ik0Yod6CKj41U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGYjXXmIUp9kQ2Y2WFrkX0VRbU++nDsrIrq+vv0D4FU7vDWHtVoDOBG9gCpbXbrD6BH7tiQyzN6A9mdNRxzNjlTnPF4fHgtlYIHw6/vGCa01RJfYMZZ+H8Qv/ZzXfWL3iIT8PFVWFEK69YRSIhADlfH/+G6tuo5zGKarH6fCJ3nYL+PVNuR2FbLldXty0ZO7+yLK3oU78AeIVJiGLh4kf19hOFRvi8jC7IYps4OH93q6J+dF1d7M2cZ9Zm2kW44VhanDaGf+s2KOk++Ob8LhISHv0CXrr1Vg/8clcImzyGduIaVU6tNF00rfydhjwfNddhsQeWbdEWLK8ShNglTWvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecHnRXkk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecHnRXkk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Bn4pFgz2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 14:49:21 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2caced6038eso5784045ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 21:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102159; x=1789706959; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ShzPxubAIgCFioqA8zTb5jVlls4ez8Ik0Yod6CKj41U=;
        b=ecHnRXkkNU/cPyB/mms+RBdw1F7JrRtWW6weMPsKq8wE4rpAQzTIR/dI4DmrKCgEqj
         Sb2mSe2+1yZsSV2+IjgHOfTsNxuzN8r0QHdVsi9ALMMYjQiSvqpjZSAF+9vsUhTiLg8H
         mqMacYP4g0fb/gRT9bhO8RDrnn7FiWgzCE1yWJkeEWDIo7bUcCaHXuRFF3ahGRuSytA7
         Mzll3uUO7tWRKVtqtzPXwc9NocEbfxr/giY+ezrBV4FNTJmTZidBWx2V14TWW56HctQF
         Wlx5Lzw/3qSUs5caumyI6CYOAQr70W9EThKZyWSaUohov6DGJ2nFxpA4s1qiESmnj414
         rTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102159; x=1789706959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ShzPxubAIgCFioqA8zTb5jVlls4ez8Ik0Yod6CKj41U=;
        b=JQx+b47hySGHqGgE+qyPKYYhq5xe0Qh8Vj6cclsN/HQOYXNg0YfgS/E7HXxn5ijaLe
         90LhL/9huGR2ef+A5Sam3O9Odxqu021xqVtdSNvGdQ48ipug1+1RpFPWLSN77r5aviOZ
         s2REO9lmSOaG6GJXaXvU9hnF8agFc9RXPYXwPM4SWZ1gb5EbkF6UyWNhh/+WIV9mHkT0
         71B83QohZ0om/4eRL4Vld3BXVzzdY2BGS2kYHfJiAsES4yyV3lieBOgnHbhod7PflLzF
         AnvNCMqicidXCsyBWSC90LBisRyc0CP5eqeYgF6+rYyRVkrXMP+/gyRTNPo+VcYfLrHy
         8wyg==
X-Forwarded-Encrypted: i=1; AKwUvBxSgWZm4xbtwy4HeUq3kfh9TosbRxpClBWvN9o6LEPKbwaht7y5XUav2Bsj7spTPcUPA6EfvxSYY99W82s=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mNd2fNIe3SH8EzvGElMsCZLmM6lzaNV+4pRNs86/RGcz6tHWWV
	RR1iw1V/3ti2ZWj3wVb0Q+8TqKepOztInHDQSxqoJex2Xk6kLfCaBAat
X-Gm-Gg: AYBFou2ASK5CBMn5B5Dh4kvJEI8sA0whJ/zh2KLfQdgUhBaR3P5j7lZDWELnm7lhVBm
	5oE4rF8WbeIZRl6h9LEyrU3krEv/2tOBQLcL4M6xBoP7N0+l42K4PmaLbmMtSO+uTLI1uiiTAz0
	1Qd8msJIhcvEjYrQCu7QuEKIBzwHmm4xbSj8HH7Lb6MVclgdoL5Wno6/EuTFNs3lXv/JxMaPHpj
	2SZTjg/q/eOsnHoXWvtRpWoRY8R37ZdQ2Fr/p5AnJ62nsBwyy5LtjTD7emvUPXT4ve0cbdwTKcs
	rtwjQ/oD6LIz8G+bMtsLGcJzJW/iDMutXrJ90+lUxKEGIuPgwbdMSdNwrbsy6ZwKT5QKdG2zVjL
	2LuMtlU9s/5fi4BEDyxmzD8IHMzoub4ueOEdfoIOZzIXDd8mvijSYyIaXvqID7fD2lq2JlTgfFj
	AWvcrcNLz8721TbQw4p6FtV4mZAOeoeRvibdJA5/w9Fku0nEF9l2NvV7GAm4kIbLKwkRfx6nrYu
	Cdmfqocy5Wt8c2xW76vhpNZMR3Rdp6hmD6cl0TCmGNnxNy9wFFI1lijcklEwAQArHZlXmlp
X-Received: by 2002:a17:903:f83:b0:2d9:2ff6:246e with SMTP id d9443c01a7336-2dd0eecb344mr80244625ad.23.1789102159392;
        Thu, 10 Sep 2026 21:49:19 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f1e434sm2883077eec.22.2026.09.10.21.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:49:18 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 2/3] KVM: selftests: Enable kvm_create_max_vcpus test for powerpc
Date: Fri, 11 Sep 2026 10:18:53 +0530
Message-Id: <506a93b99fedcdeda87bb4a9dc520c358b7acebb.1789097569.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1789097569.git.ritesh.list@gmail.com>
References: <cover.1789097569.git.ritesh.list@gmail.com>
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

powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
VM's limit.

The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
to the kvm_create_max_vcpus test case to limit vCPU IDs to
KVM_CAP_MAX_VCPUS on powerpc.
This patch allows us to skip the vCPU ID test when running on PowerPC
with SMT support, in which case system topology is encoded into the vCPU
ID, and so a VM can't use the full advertised vCPU ID range without
crafting a valid platform specific topology.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index c5310736ed06..59ddc3757943 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -58,7 +58,13 @@ int main(int argc, char *argv[])

 	test_vcpu_creation(0, kvm_max_vcpus);

-	if (kvm_max_vcpu_id > kvm_max_vcpus)
+	/*
+	 * Skip the vCPU ID test when running on PowerPC with SMT support, in
+	 * which case system topology is encoded into the vCPU ID, and so a VM
+	 * can't use the full advertised vCPU ID range without crafting a valid
+	 * platform specific topology.
+	 */
+	if (kvm_max_vcpu_id > kvm_max_vcpus && !kvm_check_cap(KVM_CAP_PPC_SMT))
 		test_vcpu_creation(
 			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);

--
2.39.5


