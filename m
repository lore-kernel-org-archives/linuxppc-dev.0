Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDD9C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 16:21:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FDB60E9B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 16:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64FDB60E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GlFRy6znTz3fx8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 02:21:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=hSIw1Uer;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636;
 helo=mail-pl1-x636.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hSIw1Uer; dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GlF3C2Xbcz3d7d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Aug 2021 02:03:03 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d17so3259982plr.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Aug 2021 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YG43b2W+WoOa/mX7jhMUWZGR+grphI4ggOCmMv7FBAk=;
 b=hSIw1UerUdjTWk5TlQspyucFFJ7sfWEWHYe2rpzn7bFT6wos1pT94pr7kBjamtyrrr
 XfjceckV3iOU71r5CJ4muwZbxfDR9hPDvtYzmd4PFqHGiojsQkq0t5KlMv0aNwyMj6Ko
 7iMHvVuIRTywrqtHTuTsmZLa7nqcEvRfhpGBejnVKVoMKyScGBuSl1TQ3aeFl6PVScdu
 YcaGCVvztOij/RKZ0Jsd0tZuG/Jz4Sec8Ow/1SkdYRMpOXJA7jy0K90Wj47fEF3lKMPb
 wBuO0KmKN94M9/z/pX58jgLrD1ffc+DCVkx5jTtTYkzCaNkkhGnoMYpMkXYPNrz5Nm1D
 eJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YG43b2W+WoOa/mX7jhMUWZGR+grphI4ggOCmMv7FBAk=;
 b=gjYNdNS9flpST1JLjVIxar5ZkcCvVpLu9PQve1e2kqaUxgN50aVCcuMqwryGC6H+Cv
 6AEq2zSbt7YEGrJIVEO9CC5in0FYeUBx52RBvoJ6qTocDqVf6K4mE7hpyCtgVXvZihb1
 x3PYCZqXq/zq0MTCLqyeDJ3AALjo2AdYOgmh2h4C67tCtcZsLC+SgaYhVZsEohBOLK6P
 GzL9EY9EYg+UfO0myf147z0E3mGRFqsaQb2Xovm9igx1OcLV4jO609amtc1YPlRlhsE+
 dWlOyfGerUjbxUr+jehES8XqM7cXQyxvqknvRhEyTtZBEhObmxGCTukisHjTzAIFSJYw
 PDcw==
X-Gm-Message-State: AOAM533UYWZBcUnFKDE3pqM1OFJIlzLJWFua8RBuJmuF7+BtCCluTE+D
 nHqeKoEF8m2pRRWc9SQ9gfo=
X-Google-Smtp-Source: ABdhPJzJYNPIqFkRKx0725GrTNxMOhNWPKDF8yupEL2kKHem8uRusSiWI92yY6h2mOTEeZMGuZr+Pg==
X-Received: by 2002:a65:448a:: with SMTP id l10mr718362pgq.313.1628697781369; 
 Wed, 11 Aug 2021 09:03:01 -0700 (PDT)
Received: from bobo.ibm.com ([118.210.97.79])
 by smtp.gmail.com with ESMTPSA id k19sm6596494pff.28.2021.08.11.09.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 09:03:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 29/60] KVM: PPC: Book3S HV P9: Add kvmppc_stop_thread to
 match kvmppc_start_thread
Date: Thu, 12 Aug 2021 02:01:03 +1000
Message-Id: <20210811160134.904987-30-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210811160134.904987-1-npiggin@gmail.com>
References: <20210811160134.904987-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Small cleanup makes it a bit easier to match up entry and exit
operations.

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 376687286fef..e25eccfe1501 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3073,6 +3073,13 @@ static void kvmppc_start_thread(struct kvm_vcpu *vcpu, struct kvmppc_vcore *vc)
 		kvmppc_ipi_thread(cpu);
 }
 
+/* Old path does this in asm */
+static void kvmppc_stop_thread(struct kvm_vcpu *vcpu)
+{
+	vcpu->cpu = -1;
+	vcpu->arch.thread_cpu = -1;
+}
+
 static void kvmppc_wait_for_nap(int n_threads)
 {
 	int cpu = smp_processor_id();
@@ -4296,8 +4303,6 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 		dec = (s32) dec;
 	tb = mftb();
 	vcpu->arch.dec_expires = dec + tb;
-	vcpu->cpu = -1;
-	vcpu->arch.thread_cpu = -1;
 
 	store_spr_state(vcpu);
 
@@ -4769,6 +4774,8 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	guest_exit_irqoff();
 
+	kvmppc_stop_thread(vcpu);
+
 	powerpc_local_irq_pmu_restore(flags);
 
 	cpumask_clear_cpu(pcpu, &kvm->arch.cpu_in_guest);
-- 
2.23.0

