Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E607C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 13:49:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8393364F03
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 13:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8393364F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmZ070KQwz3dT1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 00:49:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=eDa097mP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434;
 helo=mail-pf1-x434.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=eDa097mP; dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmYxl4xTTz3cYQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 00:47:23 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id r5so3613886pfh.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 05:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OagdvsHRZnah4S5WUxjULUBGe/jVBE2xruZ6F/aPWm4=;
 b=eDa097mPBQ2HN5Wk6JrVBt8+mc8GSBtE/2ml74f0TmQVw5xhfZY3Do9HNUqn8rz7Oy
 FCWDL5OG79mQr9q8ho0/lM93W0xsPP9ZgXp6O4Z/67t3oSZVb8EVV/w+BbqcJzH1HOy0
 VL3c7uLbqzofxXGCv0Kqs0Ypq0OsHj9oAFRHbVOXDJDT04lI6enOnD0he1Y5nUXH0+zp
 Kzl6/6bHFyFcgzhzePL7UjpGWJY3YmNO0QSycY/Lh/kZNYWmc3WWI5nAax+gkmOiJFXz
 33pxbYlZyxz5v82Inqc8ig8xUAFVktR0KfPJfxzMcMF0peJG0YCezrnCIEnlkUgpbPi5
 8mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OagdvsHRZnah4S5WUxjULUBGe/jVBE2xruZ6F/aPWm4=;
 b=Y8I5feKm4XFfcuGi2PpO6LBSrxB8IAIZ4ubqd0VXNVM0S3/pnvruJIoZEI1INPlfH8
 4TvR7tvtiMM1eflgOIKAxVGb8C11n7iSrqGKBZe3uDMbmPqHaXWbGsjx866hzjWUqxod
 N/jA4hn7F8dlxybPKln0W8UjHHsAy+flipSKQORS8Qv0zsBQ+VfMCAg33+ct1Yz0MiX/
 D18qJu9k0S73WN020m6IgL/ivaDkLNSDtuHNVXOh4hYAzwDAH0+TeFYBWt5F7bT8hsj9
 JT//A9iE6I1nMcmL0RFVjCKtNUooGHXZ9m4S0K6GJJ+GtEtr3skoscXGEEst+2VslDKm
 werA==
X-Gm-Message-State: AOAM533MDJA+tPqmtXZwtxTJ8Gh/Ya9eYzCCW2NUAOW+KKRb1g3UulR5
 vgRMwAIm+AqIEg1DA2kBv2C0b11UkME=
X-Google-Smtp-Source: ABdhPJy8fbq/xLrcGgmcY7flvo9j52FHjYt9Qm3IAbEWt0os+CsKbepaRJ5n9rqP6jX4L8W97RCXYw==
X-Received: by 2002:a63:1c13:: with SMTP id c19mr2925019pgc.359.1614260841901; 
 Thu, 25 Feb 2021 05:47:21 -0800 (PST)
Received: from bobo.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id a9sm5925868pjq.17.2021.02.25.05.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 05:47:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 05/37] KVM: PPC: Book3S HV: Ensure MSR[ME] is always set in
 guest MSR
Date: Thu, 25 Feb 2021 23:46:20 +1000
Message-Id: <20210225134652.2127648-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210225134652.2127648-1-npiggin@gmail.com>
References: <20210225134652.2127648-1-npiggin@gmail.com>
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

Rather than add the ME bit to the MSR when the guest is entered, make
it clear that the hypervisor does not allow the guest to clear the bit.

The ME addition is kept in the code for now, but a future patch will
warn if it's not present.

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_builtin.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 158d309b42a3..1ca484160636 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -662,6 +662,13 @@ static void kvmppc_end_cede(struct kvm_vcpu *vcpu)
 
 void kvmppc_set_msr_hv(struct kvm_vcpu *vcpu, u64 msr)
 {
+	/*
+	 * Guest must always run with machine check interrupt
+	 * enabled.
+	 */
+	if (!(msr & MSR_ME))
+		msr |= MSR_ME;
+
 	/*
 	 * Check for illegal transactional state bit combination
 	 * and if we find it, force the TS field to a safe state.
-- 
2.23.0

