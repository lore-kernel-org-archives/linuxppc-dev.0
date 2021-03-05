Return-Path: <SRS0=c12Q=ID=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0112DC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 15:20:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC0464F27
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 15:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC0464F27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsWdl07wvz3hDp
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Mar 2021 02:20:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=oUdmbY8F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533;
 helo=mail-pg1-x533.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=oUdmbY8F; dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsWN10Wzsz3dkD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Mar 2021 02:08:48 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id t25so1565790pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Mar 2021 07:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S/DUE40RK4gU0/+NVZijbFIZ6kbSjf09QK2Bu2ltn+w=;
 b=oUdmbY8Fzor1N4SEFg41h8+9pu0Kr2PQCf605rR21tCsA+uLTwlmMQl2SYjGDLGfJ7
 94Y3PKd2xkjxwkB3+eW5fOiTz+/9mDIqxV1LxE2Mo9YroIsXRG9vokev2qR+9n9SjaQ5
 YDw+jOR9RXVtbdNNZ0euJkgOgKlo95DtTyRbo+prUro04j3vVSTfzD3wahJwzVMXK3BC
 4bFb1G3vaUL2iLjQox+EA/yiyAagNwjBR4dchE8YpQ5f0aLx2vtZ3w0cAXqW8bgfK3m8
 zc+K6e57V85jLp/3ocdmLRKMaVQC8M+P6JMUTtWlwWOt8JfpGftHW0qEu7BrLhfq/FPB
 899A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S/DUE40RK4gU0/+NVZijbFIZ6kbSjf09QK2Bu2ltn+w=;
 b=ev+XvDs0sfK8dtkMYUbjJpc0tG7tB3GnWTun4ccV6Ixwcpt4ThTpGEWYfcGep4J2le
 auGyndw5aoKujm8cZmLdoHsCSW+5LSzrq4EdyNiKcy79HlVBsLedhpE9W4IEB3mEN5HM
 WUzayCZyrps1LdRQ88PiQvAJTAoWL70vbs25Dq8lH4bXI/Si71pextFCrJQybIOO08d3
 DV0UYhzXBcyxlekA+TeZAY8edvXBDX+ai4qN3Vcg8D+IQzxVhycQH7bSMCbcw5jeE5uC
 lrIcq/TL/BeP4JrMWTELqSMlL7lUX3zxyJZP6xO6QpAOCVZ05Zt0H0EjJK74YEjz3IkF
 pKVg==
X-Gm-Message-State: AOAM531oxcZhgS2MoGQH1Q1Re7qLHgncm/ND4ypDrhuHB3yWiBTLOwU7
 ZLCkTll1+rQzv6oNBB6vbxg=
X-Google-Smtp-Source: ABdhPJzc9DRMywKc8PWIT5AaYjMv0CwZfqYKBDMFwZVs2iKnfSdC3ddIT2FmD2FEH55xhF3NUW+0hQ==
X-Received: by 2002:a05:6a00:1356:b029:1ca:9a78:b2ae with SMTP id
 k22-20020a056a001356b02901ca9a78b2aemr9231677pfu.64.1614956926879; 
 Fri, 05 Mar 2021 07:08:46 -0800 (PST)
Received: from bobo.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id m5sm1348982pfd.96.2021.03.05.07.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 07:08:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 32/41] KVM: PPC: Book3S HV P9: Switch to guest MMU context
 as late as possible
Date: Sat,  6 Mar 2021 01:06:29 +1000
Message-Id: <20210305150638.2675513-33-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210305150638.2675513-1-npiggin@gmail.com>
References: <20210305150638.2675513-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Move MMU context switch as late as reasonably possible to minimise code
running with guest context switched in. This becomes more important when
this code may run in real-mode, with later changes.

Move WARN_ON as early as possible so program check interrupts are less
likely to tangle everything up.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_interrupt.c | 40 +++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_interrupt.c b/arch/powerpc/kvm/book3s_hv_interrupt.c
index d81aef6c69d9..48e07cd1b46c 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupt.c
+++ b/arch/powerpc/kvm/book3s_hv_interrupt.c
@@ -143,8 +143,13 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 	if (hdec < 0)
 		return BOOK3S_INTERRUPT_HV_DECREMENTER;
 
+	WARN_ON_ONCE(vcpu->arch.shregs.msr & MSR_HV);
+	WARN_ON_ONCE(!(vcpu->arch.shregs.msr & MSR_ME));
+
 	start_timing(vcpu, &vcpu->arch.rm_entry);
 
+	vcpu->arch.ceded = 0;
+
 	if (vc->tb_offset) {
 		u64 new_tb = tb + vc->tb_offset;
 		mtspr(SPRN_TBU40, new_tb);
@@ -193,26 +198,6 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 
 	mtspr(SPRN_HFSCR, vcpu->arch.hfscr);
 
-	mtspr(SPRN_SPRG0, vcpu->arch.shregs.sprg0);
-	mtspr(SPRN_SPRG1, vcpu->arch.shregs.sprg1);
-	mtspr(SPRN_SPRG2, vcpu->arch.shregs.sprg2);
-	mtspr(SPRN_SPRG3, vcpu->arch.shregs.sprg3);
-
-	mtspr(SPRN_AMOR, ~0UL);
-
-	switch_mmu_to_guest_radix(kvm, vcpu, lpcr);
-
-	/*
-	 * P9 suppresses the HDEC exception when LPCR[HDICE] = 0,
-	 * so set guest LPCR (with HDICE) before writing HDEC.
-	 */
-	mtspr(SPRN_HDEC, hdec);
-
-	vcpu->arch.ceded = 0;
-
-	WARN_ON_ONCE(vcpu->arch.shregs.msr & MSR_HV);
-	WARN_ON_ONCE(!(vcpu->arch.shregs.msr & MSR_ME));
-
 	mtspr(SPRN_HSRR0, vcpu->arch.regs.nip);
 	mtspr(SPRN_HSRR1, (vcpu->arch.shregs.msr & ~MSR_HV) | MSR_ME);
 
@@ -231,6 +216,21 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 	 */
 	mtspr(SPRN_HDSISR, HDSISR_CANARY);
 
+	mtspr(SPRN_SPRG0, vcpu->arch.shregs.sprg0);
+	mtspr(SPRN_SPRG1, vcpu->arch.shregs.sprg1);
+	mtspr(SPRN_SPRG2, vcpu->arch.shregs.sprg2);
+	mtspr(SPRN_SPRG3, vcpu->arch.shregs.sprg3);
+
+	mtspr(SPRN_AMOR, ~0UL);
+
+	switch_mmu_to_guest_radix(kvm, vcpu, lpcr);
+
+	/*
+	 * P9 suppresses the HDEC exception when LPCR[HDICE] = 0,
+	 * so set guest LPCR (with HDICE) before writing HDEC.
+	 */
+	mtspr(SPRN_HDEC, hdec);
+
 	__mtmsrd(0, 1); /* clear RI */
 
 	mtspr(SPRN_DAR, vcpu->arch.shregs.dar);
-- 
2.23.0

