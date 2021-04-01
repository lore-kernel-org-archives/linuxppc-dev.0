Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AB1C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:05:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A496124A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A496124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FB61k2kvcz3cYw
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Apr 2021 02:05:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=tprXuQLg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530;
 helo=mail-pg1-x530.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tprXuQLg; dkim-atps=neutral
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB5zl63ypz3brX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Apr 2021 02:03:47 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id w10so111137pgh.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Apr 2021 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OfjZBYhIkDtimAOFPQqSOyFCP6WGylRgGDnOYsNsrRY=;
 b=tprXuQLgWDQklGD50nq7ZUDNKKLwZv0i+8AryyOQh6xyzb+tjU4kwjVdjhKRVy5gCr
 t5b+L4Cqf4TXkI6lYpyyBB9qa+7B4qJtnXGDG3GTPA40S2dccDRfsk1s05I1PBCRMPo4
 RJjkS5cAVfWzcbOZOqh3KvVUaVlKRodORrtrEtqRKF1NZPEfKivgjrjHG/nCRX80w07J
 j97j0BFueEPofKA9lYS9La1Rtx9po23576TiciLVZbnDcr3PxwwXiRbu/bvAfQAl+QLz
 YNvAtNIYz+ELpseCn3a4B/ByZLDR/7fzbJUvOdj5WUXbT9MbowqkqI4McN9clT38R9Mw
 VJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OfjZBYhIkDtimAOFPQqSOyFCP6WGylRgGDnOYsNsrRY=;
 b=tFf2XhWAtMAr3geYK2+6973TcEsigrJOfO+C1jlLquCiWzU5HMTeZt+CUa2qniH03G
 uE+O3phDt2sVlMXeYCa9ir7VnguqlARclAYZR6UiEmUWHPNJFNpA4IqtdM+azaW8y7IB
 /kkrm4oZgvDVBGxz0K9NbKEj8OVsbSN/kaln+x+Ezcpm1pNXxbpAHBuDNAgf4nDV7m6Y
 BPT59VDs+nTmr5f9silIWuyNkdCWkykcz4t6BXktvYIpPWAL/G32fBXtlUAeo/u4+D+C
 4toQh5oFyX5yr/bNVteVbNkQFbhCTRG93yS6+KZx67XUX9i+b+kSKZA/3DwAUZf88Ksm
 uPbw==
X-Gm-Message-State: AOAM533636wRDvW/eYKAG6iDqOeQMRJak+s+W0wtKqct24QIHZ2SL8Vp
 PM6nRIUC0SXzJXQUbj/yTXE=
X-Google-Smtp-Source: ABdhPJzs0UlyFwDFMt3FjD0G2fSEclhD0mxu6JjKz2Qgc4OR/aOkIg3t3i7Z3dYzutqwNo6anmlF1g==
X-Received: by 2002:a63:e906:: with SMTP id i6mr7811406pgh.132.1617289425060; 
 Thu, 01 Apr 2021 08:03:45 -0700 (PDT)
Received: from bobo.ibm.com ([1.128.218.207])
 by smtp.gmail.com with ESMTPSA id l3sm5599632pju.44.2021.04.01.08.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 08:03:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 03/48] KVM: PPC: Book3S HV: Disallow LPCR[AIL] to be set to
 1 or 2
Date: Fri,  2 Apr 2021 01:02:40 +1000
Message-Id: <20210401150325.442125-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210401150325.442125-1-npiggin@gmail.com>
References: <20210401150325.442125-1-npiggin@gmail.com>
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

These are already disallowed by H_SET_MODE from the guest, also disallow
these by updating LPCR directly.

AIL modes can affect the host interrupt behaviour while the guest LPCR
value is set, so filter it here too.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
Suggested-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d2c7626cb960..daded8949a39 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -803,7 +803,10 @@ static int kvmppc_h_set_mode(struct kvm_vcpu *vcpu, unsigned long mflags,
 		vcpu->arch.dawrx1 = value2;
 		return H_SUCCESS;
 	case H_SET_MODE_RESOURCE_ADDR_TRANS_MODE:
-		/* KVM does not support mflags=2 (AIL=2) */
+		/*
+		 * KVM does not support mflags=2 (AIL=2) and AIL=1 is reserved.
+		 * Keep this in synch with kvmppc_filter_guest_lpcr_hv.
+		 */
 		if (mflags != 0 && mflags != 3)
 			return H_UNSUPPORTED_FLAG_START;
 		return H_TOO_HARD;
@@ -1645,6 +1648,8 @@ unsigned long kvmppc_filter_lpcr_hv(struct kvm *kvm, unsigned long lpcr)
 	/* On POWER8 and above, userspace can modify AIL */
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		lpcr &= ~LPCR_AIL;
+	if ((lpcr & LPCR_AIL) != LPCR_AIL_3)
+		lpcr &= ~LPCR_AIL; /* LPCR[AIL]=1/2 is disallowed */
 
 	/*
 	 * On POWER9, allow userspace to enable large decrementer for the
-- 
2.23.0

