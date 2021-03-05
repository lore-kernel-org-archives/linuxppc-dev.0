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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AF2C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 15:08:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A2A65011
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 15:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A2A65011
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsWMF61msz3dXx
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Mar 2021 02:08:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=AAYgT6Y1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c;
 helo=mail-pf1-x42c.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=AAYgT6Y1; dkim-atps=neutral
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsWKq27MPz3dFW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Mar 2021 02:06:55 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id q204so2229349pfq.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Mar 2021 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tPv7vttF4qjq/q76q1ncSjpRj4ayfKA2hIREWD2yQso=;
 b=AAYgT6Y1yrTgHS4UjzaoiCGxMA5GRGdgy7eoodbELMyQTUoEL/WxY8srajk4Kf7Kee
 GgnOtmP/X2bC3VDn4jE9xEh1FzTyMinUCnO41tAyeWda4Wc5vZwH1AAw5Phx3YkN6Amk
 /dJW5O5Tv3p6nFSz63chb61bbq1OjU+Nb7ANz6EH+V0Ow3KRgwsLwMctiY0Ea00+NSUz
 SbFz8u7JyUO8T8OPi38vkQ7A5GmPneG0yc5fp1qxwg5tYqjpB0IWoK2OMVGfo4Zu2Zow
 KiiAxF73uM5SzzzVxWbaJKuzgWdxzHC3cpq9y2v0FJvdH4hBdX/7wekiY9PfQuAfcgMe
 9cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tPv7vttF4qjq/q76q1ncSjpRj4ayfKA2hIREWD2yQso=;
 b=je+tAY3fbvD3UTqaw54vZuls+MOq03XoBIgxodTAljQzdyV07cBD9ip9nSnJUaELy2
 qwy96Mft11LybXbL1xjZVEeylzCz4J/vrv+BJEKVRcYbF6lvhCCJxdS0O1AzkBEWBOOF
 3s3EI79qLR4R80CPobsJjTbnhWOUd+ZTflmaNEe6cyCtDwqJa5Ar3STc0RPXjUocVXZc
 o07vTwxlQq8lbFR62v627eSVEInfBCzeDg3jPoTRJOLXqNUBxQWY0ysX20fUWiQIfpag
 xLQi3FhmdED1/aDlbYh/nRjYW9Y6ksEYwMyRnpQqu3Gak0yCsooktb9+j9tqx95VMUB4
 6l7Q==
X-Gm-Message-State: AOAM530Xhyif3ufZBCbenD5n9hnSJaK8sTZEgfsKaJOVdxYncz8mr0nc
 sLB/7ynP5qWbReoPEl9Bx1P71fUBGxY=
X-Google-Smtp-Source: ABdhPJz45DHinj6rvq2JLWECHgH3+iSKAQdU0pPPSgTP3QzvRJtiiNNIY9lv4Jv5Gy1Y+/BWBV1CVQ==
X-Received: by 2002:a05:6a00:886:b029:1ed:b546:6d1f with SMTP id
 q6-20020a056a000886b02901edb5466d1fmr9685346pfj.22.1614956812962; 
 Fri, 05 Mar 2021 07:06:52 -0800 (PST)
Received: from bobo.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id m5sm1348982pfd.96.2021.03.05.07.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 07:06:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 02/41] KVM: PPC: Book3S HV: Prevent radix guests from
 setting LPCR[TC]
Date: Sat,  6 Mar 2021 01:05:59 +1000
Message-Id: <20210305150638.2675513-3-npiggin@gmail.com>
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

This bit only applies to hash partitions.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c        | 6 ++++--
 arch/powerpc/kvm/book3s_hv_nested.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index c40eeb20be39..2e29b96ef775 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1666,10 +1666,12 @@ static void kvmppc_set_lpcr(struct kvm_vcpu *vcpu, u64 new_lpcr,
 
 	/*
 	 * Userspace can only modify DPFD (default prefetch depth),
-	 * ILE (interrupt little-endian) and TC (translation control).
+	 * ILE (interrupt little-endian) and TC (translation control) if HPT.
 	 * On POWER8 and POWER9 userspace can also modify AIL (alt. interrupt loc.).
 	 */
-	mask = LPCR_DPFD | LPCR_ILE | LPCR_TC;
+	mask = LPCR_DPFD | LPCR_ILE;
+	if (!kvm_is_radix(kvm))
+		mask |= LPCR_TC;
 	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
 		mask |= LPCR_AIL;
 		/* LPCR[AIL]=1/2 is disallowed */
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index b496079e02f7..0e6cf650cbfe 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -141,7 +141,7 @@ static void sanitise_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 	 * Don't let L1 change LPCR bits for the L2 except these:
 	 * Keep this in sync with kvmppc_set_lpcr.
 	 */
-	mask = LPCR_DPFD | LPCR_ILE | LPCR_TC | LPCR_LD | LPCR_LPES | LPCR_MER;
+	mask = LPCR_DPFD | LPCR_ILE | LPCR_LD | LPCR_LPES | LPCR_MER;
 	/* LPCR[AIL]=1/2 is disallowed */
 	if ((hr->lpcr & LPCR_AIL) && (hr->lpcr & LPCR_AIL) != LPCR_AIL_3)
 		hr->lpcr &= ~LPCR_AIL;
-- 
2.23.0

