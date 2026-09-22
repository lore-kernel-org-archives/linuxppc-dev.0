Return-Path: <linuxppc-dev+bounces-27943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1596C98302
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:30:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq7tT67FFz2yr0;
	Wed, 23 Sep 2026 04:29:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790101793;
	cv=none; b=PpMr5kQfHmX3U6uV/cx3nl40Z2Z2MMVlpSsuQtRq4fOqpDoHftg8yc6c7UStNStJ4GcNqVuZ0NPAsUX0hwbm6UV0tIBdKlTeEE0nDWYaAkyxO1G1yUwSQK/DGQjq3h6d4sRxAuIAGEkxRDL2KjQxenWeAzSnVMYEXwqumV3XxtAYvTQrh+dxK3h9iKc+yOHYV85701oBMVDYLtAN068guie/VhqcutNkNzjlDAZ3sylECzqzeWbC3Aey0kxMJhM+6WCFvKi8Rc6o8bC8ADQV4J/T+avENj43eLCV1gSsG/cXDsxYexmYN03CICYIGz7dpKlMaQKh6X7gwrT7TGpe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790101793; c=relaxed/relaxed;
	bh=+EizYOfATJ2ZpuBFIvbNSn2bZp6dnoqHuB3tFHvlG54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnk7VTeVMNS2FxGfl0sQqSRYI/SBoXOgzKCNoJ49v8L+I2RQKLkFr4PrPfTNmqFt3NDIA4fToLmnLs9sUapDIc+NpA06fW38gBITLV4/9hWqHw2/MH3GYaHif8Cc4ZmUD8TRCIcbuSfDOnV3oCkAv0RgrIvovlXO2IUliW6kuZtpZtcz4IFEuw7+QNc72L33xtJxBahci1oDc7COXQoSj57pGo4a5nuowbGcqtgGJJnm7QjGUYyZcnwiQBcPTCvZiyMP28DnggaaF8TRbBzxCU/rbcCb2zRXP6pSYivQNNDYNZh+LSfbfDfL2mekw7JbzSPyWeBFmmrLB0/Au3XkpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QAIDgQE8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QAIDgQE8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x10.google.com (mail-dy2-x10.google.com [IPv6:2607:f8b0:4864:36::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq7tT0CbXz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 04:29:53 +1000 (AEST)
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-328664e051fso108641eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101791; x=1790706591; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+EizYOfATJ2ZpuBFIvbNSn2bZp6dnoqHuB3tFHvlG54=;
        b=QAIDgQE8l4kzwKPy4niWrKiZEk3Cn6CEtbz2dhLMRjWVu2MYVM+I00lbL1G3nJoARV
         gKFWkduuj1xQJbOyzTAB/oyKW7RBbGMqeKwrlcN281Y937WQDcdph9ArqireZDQn5pNN
         gmtByRNz6s4Bz71140XfUbksesnaAn6bTcQ1A5QdVTfTE8rfK6xBjScFuBRSf5UH9Wck
         Xj2qMq9phAya5yNA26dKytkA9xXNbFVjSfZZWcGUK48iOSMx83As5W9brhZaY/hTeWPL
         d0hl3AXWK8u4asy2RNgTuqgYmrVm8TNCD1K64pozN4904K3WDfbglkcAcxpiWNbsNvWO
         vghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101791; x=1790706591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+EizYOfATJ2ZpuBFIvbNSn2bZp6dnoqHuB3tFHvlG54=;
        b=my3P0qfjFQLYloDnjouKeQqcThE+MExYwH4htPdNwQ9unzzYx3P6wjcDN1p+KoVJKS
         4kWF8zyOV1CapBUqbcy2G1/euxRLNrnLN8pSf/XV2IPKjhSy049Lm/dKiuKFqpvD+Gzu
         4lv7Kvy3UmWOebxLk06EUL+eSOlililqQ5Q3vmp2Wo4qRZGwmO/av+yET/C9cwLMrAtb
         DWgJ/9UyqomMuEShytJKhLcED32eKmAm6/j+ELwPT9AgMSlYJj8u+GEhD84CmguCmyoQ
         2tQgRGlnwLgLScfuD0C9/Y7BS60EBG5/pyqp6WjQ8nwzb+5TBcR/M4qs6I9Fesbhqeng
         iRfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVFFOMdsnwuOVLESMr7a0+0Z+4cM3Fp3LVWtfbSHTrI/gTTsdsr5+jEW55lG9V0KGVKLpAd3gBxw0BLLc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lh3T0gzY1jW/jkY1aMMd8ESTL9crtZdYc6LmlkwXuO69JJ2izV
	ctl47XFad/8Lhg+0pwql7KTpCk9irm33Uz+wWw4Vwq+7o7p74DTssEtC
X-Gm-Gg: AYBFou2b+9Oxc0X2jBpF3Q6yYdYhUYT3btaIpJbH72wwRI0ZTPAO8zDrDAIZRSsMtQg
	afU4/shi9oQSSy+Nb6y/r97HwKJ705G+Nc62WRjqJHB6nyXU6mFpjqM31RJ84JC8YZmVy0dz45L
	Pbw+d1NzV/FtwBtUwNFs90Eddrs6lmEw6dg+ip8h+HNG2nppW64kfYMBkns+yHuiKoy7qB6nMcu
	6BwtIwzaRJoVYVUj8FoCw9wKIrJ6k5nBVIVBDc6Zk/dVjKSsUFpblAiPiM7epxORhYs0v+Gszkv
	QxecZLw7Gq8DASf5S4I80h4m7Dwuif7b4/6sdFrGnpg2gMg0XRqKdC+1vvbcRAwFkp+GW2s7vb0
	hxBrZZpPaMbUhQlxV2hi/dtN57DcvZ0XgbXu3JFU1VlRjT5U9DKDXJPuAu67SQ1F+NR3/OKSTl3
	gMZcyTAZK3HqZfNB4j04H0Nu+L2KMaiJnTgT3OYIEizwG2N2sn0xXxu7eL42CCxglZbhSzEm8EO
	AgEFshFnMcHoXAZiMVUY5fiOCcx2YChwhyphjw2Y23T1AwQkYnh7oSBsEcd
X-Received: by 2002:a05:7300:fb15:b0:334:2bee:348e with SMTP id 5a478bee46e88-33e8dbc413amr139604eec.22.1790101791075;
        Tue, 22 Sep 2026 11:29:51 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:50 -0700 (PDT)
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
Subject: [PATCH v5 7/9] KVM: PPC: selftests: Make nested case on pseries LPARs as resource constrained
Date: Tue, 22 Sep 2026 23:58:51 +0530
Message-Id: <39f4b13c66955df3fd75f3ea3aa48aa5b2da3840.1790101179.git.ritesh.list@gmail.com>
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

For nested guest case (L1 as pseries LPAR), L0 may fail with -44
(H_NOT_ENOUGH_RESOURCES) during vm or vcpu creation, causing enomem
due to limited resource/quotas.
This adds the necessary arch hooks for the same so that it can survive
hardware_disable_test and kvm_create_max_vcpus test cases.

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/powerpc/processor.h  |  7 +++++++
 tools/testing/selftests/kvm/lib/powerpc/processor.c    | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index f0ee21a8e2d4..a46f6828991c 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -6,6 +6,8 @@
 #define SELFTEST_KVM_PROCESSOR_H
 
 #include <linux/compiler.h>
+#include <unistd.h>
+
 #include "ppc_asm.h"
 #include "kvm_util_types.h"
 
@@ -36,4 +38,9 @@ static inline void cpu_relax(void)
 	asm volatile("" ::: "memory");
 }
 
+static inline bool is_pseries_lpar(void)
+{
+	return !access("/proc/device-tree/rtas/ibm,hypertas-functions", F_OK);
+}
+
 #endif
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 301455024571..e5d84f6d82f2 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -23,6 +23,16 @@ bool kvm_arch_needs_naturally_aligned_page_tables(void)
 	return true;
 }
 
+/*
+ * For nested guest case (L1 as pseries LPAR), L0 may fail with -44
+ * (H_NOT_ENOUGH_RESOURCES) during vm or vcpu creation, causing enomem
+ * due to limited resource/quotas.
+ */
+bool kvm_arch_vm_create_may_enomem(void)
+{
+	return is_pseries_lpar();
+}
+
 static void set_proc_table(struct kvm_vm *vm, int pid, u64 dw0, u64 dw1)
 {
 	u64 *proc_table;
-- 
2.39.5


