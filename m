Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21D0C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 03:53:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4785B60C41
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 03:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4785B60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY5cl4Ntpz3dTV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 13:53:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=l/PcRICZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632;
 helo=mail-pl1-x632.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=l/PcRICZ; dkim-atps=neutral
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY5Yv00TTz30LD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2021 13:50:58 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d17so9978039plh.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jul 2021 20:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wNummKPcVaVmiGYV9E4Z8BF0hMfr2KcTst4lEXRe9HM=;
 b=l/PcRICZkHQrE8/9m4QNi6nXKBBLHuoIBRevXCd+e7PEBXKLDhVibNhTQhIN67ap9s
 5uI/ro1xKX8jVrrFm/TwOCcUKXZcQYUWzBV7TjzCNfuD3gqAEzb/LOdF45sc9muFhZq8
 Fld6Cxf9VqhBC+i68T49k0jTt96K0ynqR94mWbkpBsw6YVx8YY1MPx3Cpwt80y5x+N+0
 a8P8QyzT2wuQZjoIS76VmK6aoXGUCec2Az+rMCyOqcDuzgfLqQ6fZg7nKKnefTQVRfI2
 s1o2jWbZA+2rQOHQAPyYc7HNIRn1IBOHYOJxkZdfd3NDJKnP+ov2FYLRwFy51CBThSB8
 nMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wNummKPcVaVmiGYV9E4Z8BF0hMfr2KcTst4lEXRe9HM=;
 b=RxFvTWuIvnZ1pHWxwEUEjIECxer+rBROFTf58ZGAE7ST8QJudjXN9vB592Bd1h3FY8
 i9z+OWQFC+AWiv/ktuaYoGAzshYtrEoM5OaICVuALPbeknbGEsaV5oyHjarAvG8H3S62
 Ry3yjfCSCfdNvPHtiy8h4XceY+EqTOnifRIPFTqjYYzCDPLeWTYEdOxRfCXZfQ5AbXCU
 in5w+RUxTLBKGglvzDVzgw7HxNS1OBOJItEwufICmeL4jkO4WYcIU0MLBl9N+qDsi06G
 1/GsIFThB4APPKv8X1GJOA5LeoLciS676y8OJWgBRHPQpCTK8TQxjR4ocHiOoGPVKCMF
 AGQg==
X-Gm-Message-State: AOAM530ULxplW8avYv9KKKfxUJHh6bSmGn2qOvq8xgDGolH+bHwPAfoj
 8OIdILBzufzyJCzTOW2azXM=
X-Google-Smtp-Source: ABdhPJxoiy+p1LoDS1VZilzKAgEuYia2n5b0397IJnz73YHJROVKs0FbtfxMxEwkOpLQ7w9zU7TpzQ==
X-Received: by 2002:a17:902:e54f:b029:12b:55c9:3b48 with SMTP id
 n15-20020a170902e54fb029012b55c93b48mr13016745plf.45.1627271456537; 
 Sun, 25 Jul 2021 20:50:56 -0700 (PDT)
Received: from bobo.ibm.com (220-244-190-123.tpgi.com.au. [220.244.190.123])
 by smtp.gmail.com with ESMTPSA id p33sm41140341pfw.40.2021.07.25.20.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 20:50:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 05/55] KVM: PPC: Book3S HV Nested: Reflect guest PMU in-use
 to L0 when guest SPRs are live
Date: Mon, 26 Jul 2021 13:49:46 +1000
Message-Id: <20210726035036.739609-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210726035036.739609-1-npiggin@gmail.com>
References: <20210726035036.739609-1-npiggin@gmail.com>
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

After the L1 saves its PMU SPRs but before loading the L2's PMU SPRs,
switch the pmcregs_in_use field in the L1 lppaca to the value advertised
by the L2 in its VPA. On the way out of the L2, set it back after saving
the L2 PMU registers (if they were in-use).

This transfers the PMU liveness indication between the L1 and L2 at the
points where the registers are not live.

This fixes the nested HV bug for which a workaround was added to the L0
HV by commit 63279eeb7f93a ("KVM: PPC: Book3S HV: Always save guest pmu
for guest capable of nesting"), which explains the problem in detail.
That workaround is no longer required for guests that include this bug
fix.

Fixes: 360cae313702 ("KVM: PPC: Book3S HV: Nested guest entry via hypercall")
Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/pmc.h |  7 +++++++
 arch/powerpc/kvm/book3s_hv.c   | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/powerpc/include/asm/pmc.h b/arch/powerpc/include/asm/pmc.h
index c6bbe9778d3c..3c09109e708e 100644
--- a/arch/powerpc/include/asm/pmc.h
+++ b/arch/powerpc/include/asm/pmc.h
@@ -34,6 +34,13 @@ static inline void ppc_set_pmu_inuse(int inuse)
 #endif
 }
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+static inline int ppc_get_pmu_inuse(void)
+{
+	return get_paca()->pmcregs_in_use;
+}
+#endif
+
 extern void power4_enable_pmcs(void);
 
 #else /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index adac1a6431a0..c743020837e7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -59,6 +59,7 @@
 #include <asm/kvm_book3s.h>
 #include <asm/mmu_context.h>
 #include <asm/lppaca.h>
+#include <asm/pmc.h>
 #include <asm/processor.h>
 #include <asm/cputhreads.h>
 #include <asm/page.h>
@@ -3864,6 +3865,18 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	    cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
 		kvmppc_restore_tm_hv(vcpu, vcpu->arch.shregs.msr, true);
 
+#ifdef CONFIG_PPC_PSERIES
+	if (kvmhv_on_pseries()) {
+		barrier();
+		if (vcpu->arch.vpa.pinned_addr) {
+			struct lppaca *lp = vcpu->arch.vpa.pinned_addr;
+			get_lppaca()->pmcregs_in_use = lp->pmcregs_in_use;
+		} else {
+			get_lppaca()->pmcregs_in_use = 1;
+		}
+		barrier();
+	}
+#endif
 	kvmhv_load_guest_pmu(vcpu);
 
 	msr_check_and_set(MSR_FP | MSR_VEC | MSR_VSX);
@@ -3998,6 +4011,13 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	save_pmu |= nesting_enabled(vcpu->kvm);
 
 	kvmhv_save_guest_pmu(vcpu, save_pmu);
+#ifdef CONFIG_PPC_PSERIES
+	if (kvmhv_on_pseries()) {
+		barrier();
+		get_lppaca()->pmcregs_in_use = ppc_get_pmu_inuse();
+		barrier();
+	}
+#endif
 
 	vc->entry_exit_map = 0x101;
 	vc->in_guest = 0;
-- 
2.23.0

