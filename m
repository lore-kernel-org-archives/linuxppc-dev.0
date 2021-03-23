Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0A1C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 01:05:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D48D61920
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 01:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D48D61920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4Cp83FGPz3br1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 12:05:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=N37jRf32;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b;
 helo=mail-pg1-x52b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=N37jRf32; dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4CmK3MmZz30BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 12:03:29 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id r17so10053688pgi.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 18:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kb34vWpXzgWUzoINnJbe4T3qARQM/1MOi4byEufbLGk=;
 b=N37jRf32sH+nM4T5mCFVIebh7kiOsFRboJjmJBOb6Qh214ZpzGu7vSUydn/3DwdGS0
 1LAF3b/kA7Ispthu5NxeIPm6a393TKiq2DOBSbXUCBio6eQFkcJIEHlrzJA7CWGrKW+y
 OudhzKoFqn5UCY//cG/SkOCSJhK6uKSeGWZeFy1QYj82zHUD5rMis91JHTDGBhX0/Bxw
 nmVvdvzYGWODHOuDcOhRgvIy4SP/c/D2LLXvA/RUkhp9sWUhQYtPKI4ax/yStWHnRuJ+
 X22LC0NW19iq49sUaoObJbGiHX5ojbNY40LyzuZr4YqN4iIMuFZlocSGsPQV83h6OIMA
 P7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kb34vWpXzgWUzoINnJbe4T3qARQM/1MOi4byEufbLGk=;
 b=tkJS01GfgueZ7kmFSsUG6rEstOMG2ASzemR2Qgh+HCpuNJ25vAQSmkEvzsf3PqUmbx
 peDokjfI5+RuqO5gGnK0LjZjitOhEX7yVRImFw2KYlHP+hq7oJkLy/4HA2o4W3cWookj
 iXcCnyFcNaVgcCpHyaRbpn4ljiOQS3y/KH//vvm3ZgZlXEEnBIwD3Jzb9VSIbAoxwRsa
 ohOg/nDRDcp2tqvm2qp7K6zF7SVV8s0lyIHKU2HcVW+ujmVTOXJjOFqC/HUoXX4ibFS1
 GNaf6XLBzPAKD+XCUKXYJuilmxuU2rkxgKjI8rqer3Zlk4fPaYoPKYOOcrn48UmD2UbI
 CXjA==
X-Gm-Message-State: AOAM533m+mQqR90nl32Mg9dPi4lB4AhN1vUTZKAmVWiKF8M6gGCSH0jh
 cpHz4hBryyg3fwbIpIxQMYc=
X-Google-Smtp-Source: ABdhPJw0jC7eGSE+tizBJpsnpVKghO7RDXRyMrrhaMy7VyPtiTOpOreBXVh6VamK/ZHR9pFkWMeWgw==
X-Received: by 2002:a17:902:d341:b029:e6:9a9f:5614 with SMTP id
 l1-20020a170902d341b02900e69a9f5614mr2276114plk.48.1616461406873; 
 Mon, 22 Mar 2021 18:03:26 -0700 (PDT)
Received: from bobo.ibm.com ([58.84.78.96])
 by smtp.gmail.com with ESMTPSA id e7sm14491894pfc.88.2021.03.22.18.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 18:03:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v4 03/46] KVM: PPC: Book3S HV: Disallow LPCR[AIL] to be set to
 1 or 2
Date: Tue, 23 Mar 2021 11:02:22 +1000
Message-Id: <20210323010305.1045293-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210323010305.1045293-1-npiggin@gmail.com>
References: <20210323010305.1045293-1-npiggin@gmail.com>
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

Suggested-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index c4539c38c639..c5de7e3f22b6 100644
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
@@ -1645,6 +1648,8 @@ unsigned long kvmppc_filter_lpcr_hv(struct kvmppc_vcore *vc, unsigned long lpcr)
 	/* On POWER8 and above, userspace can modify AIL */
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		lpcr &= ~LPCR_AIL;
+	if ((lpcr & LPCR_AIL) != LPCR_AIL_3)
+		lpcr &= ~LPCR_AIL; /* LPCR[AIL]=1/2 is disallowed */
 
 	/*
 	 * On POWER9, allow userspace to enable large decrementer for the
-- 
2.23.0

