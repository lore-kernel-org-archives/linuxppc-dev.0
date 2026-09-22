Return-Path: <linuxppc-dev+bounces-27938-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2F9C98302
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:29:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq7sz5wlVz30VT;
	Wed, 23 Sep 2026 04:29:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790101767;
	cv=none; b=ldMUTG2tjysDtnQEalT9vQd1D4umoMHMyZjiX7l5Eq82HuXH+opayhSrOezBm9VT3QtP9riACpPtNOS7QfrwOJ3bxUSbSLFyjdkoa/MsDfzBvCStJs+mok3/Cv7vZcnKNFSN9jbKYa6x9Y9m2yo957R6AMq3Vy8Y4GanpInb63JcMRxy2ngPoGcCraEPO8/es+i6BgqaEUGqfres6dSycKJYCNgn6O49lwHQjnWm5+vKjca2RViA+kLZXpFmDGE8xVNNV3HQNvrO1v3FdTFO8w1unptefxW6vMOWJ74ufEe36IYTdCWkST9DmqACC3hGdgxZdCYwXPwLeYUuJDBe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790101767; c=relaxed/relaxed;
	bh=ShzPxubAIgCFioqA8zTb5jVlls4ez8Ik0Yod6CKj41U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNi+zh3fLCkAQyopKKC6SrvfCPNXxU+Y1pVhA7+XE6yco9wSnpc0DHEg+hoLdvf9om/hAOwqH6J/9QNwyx0DLirCXZGSJzKXQf87Wh3F9z1/4HUILxiAiF1EWNR6ZObwLTOzeTzp8TB/KJDsEyWB3/GQy5LLU5UYUtKX2brHeSAhVvCbFJaNCIAu40ug93pwLadGErns1FwuKRBQutwpp3bcBRRwhVlatLHG+m/7RrScyeiklE7rjtfgrH6ap1UPzuBGiejTOXI2EMM6PK5KcpY+e3k3do9Pb1HYFYiCyCLtlF+8O+URIJne9t/w1un7mNE5zUtX7brEeatNd6ZgRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GftBWIsu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GftBWIsu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x10.google.com (mail-dy2-x10.google.com [IPv6:2607:f8b0:4864:36::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq7sz0mzlz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 04:29:26 +1000 (AEST)
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-328664d3421so59055eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101765; x=1790706565; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ShzPxubAIgCFioqA8zTb5jVlls4ez8Ik0Yod6CKj41U=;
        b=GftBWIsuVK2oFxzDkINj0zyX3D16eTTcFS+Z9mmBcwxoYHTDrhZr69rP7R2Hw7tmAb
         l4ZbqCZgUrlkO6e4d+mpmCqbKbM8+I0aZDuWt/OVTls6x6yjus7ZJL071U1yiZp+u7ce
         eCz8FJZpmTA/tVkSPRZXx0vcoVWv0ixsbo/H3UFpXAguobUykwmPqzL0u6vGPpqY3iSp
         LGbysdODzO7mM5baIVN/z/F3pVSJNJof/C90VsKfvJr1BlK1yX3+vklFTEGVfJbVd02T
         hJm0Wu3T02omE0TqkDBEtyKRvgnUP3dmyNGRJGGkzRZP2HMYrLggk8mN14k+Z3z05Epi
         LNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101765; x=1790706565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ShzPxubAIgCFioqA8zTb5jVlls4ez8Ik0Yod6CKj41U=;
        b=nYLg7tgtDpF4BiVR67QZhbchhBW6CFy7wGPMR5OXXW7fbODfF3mq0HxYw3t4J9p58g
         ugNM6h5eETUMfU8rJ827fRUvmU4qdHchg7tFOz2HMt40yZzX1Nk1CqP0mTMmAsP8kU5J
         ikdG60oduvX3OJxYW4NjH/IKRoFEOTvsDg2F7Rparjp+xTaJKjrGSjapSIgkViBSon2Q
         Ncca/Vl2weKpuo7/qQC8eaxN+MmYJkiN3jbAmEfAOyyjx9b0gHkVHZWmp6javda/GD8X
         EOcgsGr8O6CWVmgbkn62yxpxkU/b6rhZxpUfearq9fXzGWkAoYxD0Jrc9uf1GweQxLia
         R33w==
X-Forwarded-Encrypted: i=1; AKwUvBwuqL3TLYXfnpeOLqBmLDm8O5oA1PULdl1FTuz2/Z37m9/jTfP+kbv9JHuyXgZICXFB2onPBHbbOnRmTG8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mmmbkjxuHq+bEjXmAT7sVDdm87ZTUOnodKkSX3aiAru7gA4Mgl
	h0sYjeYdFIAJXM068PwnrOTE10k7FSQXeic+Nfw3NesDufCd1RGHh4ER
X-Gm-Gg: AYBFou1r/Jyvl4GtTJuB5EGknBHYfGA7XUZpgGNYQcBLzGt1n8MHE2yZxGnzkFSFQ+q
	fcadO8HUWMoNcE6NRKlkx12GXoNvLNE/QBS8fSo4LoR9swLB81dk1u5nO/l8TkODj9ARwMw32B6
	JAXXVIyvLimr6nmxG0gOMv0hXP8WUQi+7x6DGI4Utb9kZmP/OrVHCJ5WdKyiyyL0iBD0NO9u/WT
	216Jva9BbSn1dq8Ha8EeNk0UNoHQ3ZR2wIGNGAYatRGu8zw1TfnHxejCLYkw4ulHgL9AfdlTudF
	laGfD3F5U+WkZS3qnsgaIkuPSjf1NLLnZ4rf+mnQXdf2Emb4eUMHd8+h0fHdn9C3L2l6ugb9+9v
	A4YEicxgi4h18mh5lfrWOVGDRUXqflImps9RQWHTFksq+8CEaOqyoeXBSWbIiK+zAVsvGKxxYwL
	2W726dtZFwKbzAV4L3bqbgxypbR4rcx8EnAV58L2Ad03Yz45R73LAqxX+BAnq0xU8a8XdUco2eH
	QM4pexwvToZ+AKyA7zZ6kknmfKHMigGw5Z1JdMtEGDTBWX55tYlwoPOqNOYjMrl/6zyDvnbcUwG
	1FmkGg==
X-Received: by 2002:a05:7300:c72a:b0:33b:dc33:7f98 with SMTP id 5a478bee46e88-33e8c24feabmr158640eec.14.1790101764641;
        Tue, 22 Sep 2026 11:29:24 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:24 -0700 (PDT)
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
Subject: [PATCH v5 2/9] KVM: selftests: Enable kvm_create_max_vcpus test for powerpc
Date: Tue, 22 Sep 2026 23:58:46 +0530
Message-Id: <3f876f362466177e8c826e1ff656cd02d96b7069.1790101179.git.ritesh.list@gmail.com>
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


