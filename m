Return-Path: <SRS0=L/Xq=JC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3253DC433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 01:39:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A5761242
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 01:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A5761242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDCxG3KCTz3hPJ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 11:38:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=t7RQa1AA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f;
 helo=mail-pf1-x42f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=t7RQa1AA; dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDCZ843Vgz3cc1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Apr 2021 11:22:24 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id x126so2205100pfc.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Apr 2021 18:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vFMMQgThsUAc2S0LaT7h9p9PH0nf5CHdrn+oC6qHpCo=;
 b=t7RQa1AAPbICBHtL8E70gqsHEBscLP9xgAq9L4rDfPNtEPV/RQgBJ9S/DH4OmSdp1+
 PFyah3EPxGggyNqvxja+hPRdFokmnWm/yVj4+gOOoyQHwNut/JxFa0dYq1tU7PTA4x2u
 D7L5vAy+m7IroXLg4/GHcw7zDPvKdG3Q+QQR9Um+H1LB4DceerKeucxt8FthR60FiYk1
 I2A0L3/E9wD8Jl4OePJ7G/X6dfwxEkLi9zLNZfNbSAqE4vJ5lOzsvbJuvoY1fpd6CjsZ
 mSEq1mygCHkNZW/W18HAsvGd+zd8HunASvkcReeradGU37kHChRyfg9i1KMhyJK+vVAm
 +IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vFMMQgThsUAc2S0LaT7h9p9PH0nf5CHdrn+oC6qHpCo=;
 b=IQALhj5OifSD7nG0JusVSOhBtH/NR/wdjxBV/FSFAliZJvXKfQ2UYGTpYpvPc0UyfX
 DG1tVrtFJWDSnUhlQ70tZe7avjvC2iDxz+Rt6YzA5y/BEh4CC5HaMO3tqOpuIImak7H1
 1fCFxUT6EKyxIJWg0DOVtWsNAkzDfy9Lh6dJtzV6bM8f/mQSSDmgD1gSn2MKA4qyQcvu
 rmciiBtGf/3TfnoyLPak5rVn9E5dEE+QBpf4KY+TOTdDoaTsrGinH90pJz28pi43skRt
 TzZQA+f52brs2nD3/07WmlyyB623tVdg9xhfFbAlUZnHYHyOyjoMXqPoyYdt89t3cUvk
 ppgQ==
X-Gm-Message-State: AOAM531oVzt/Qmpf2RHsfcC2NkvmHKmW2diDqfEDqlRixEl0sVzVW1eI
 iBGQwy07ajA//hog+98236c=
X-Google-Smtp-Source: ABdhPJw8R1k5TWI9uLfaH0DflPKY0792pji+A58QORsoUYVY/k19haFzvL7nlhHgJF/feZXhIgIMbA==
X-Received: by 2002:a65:610f:: with SMTP id z15mr20974993pgu.360.1617585742986; 
 Sun, 04 Apr 2021 18:22:22 -0700 (PDT)
Received: from bobo.ibm.com ([1.132.215.134])
 by smtp.gmail.com with ESMTPSA id e3sm14062536pfm.43.2021.04.04.18.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Apr 2021 18:22:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v6 42/48] KVM: PPC: Book3S HV P9: Allow all P9 processors to
 enable nested HV
Date: Mon,  5 Apr 2021 11:19:42 +1000
Message-Id: <20210405011948.675354-43-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210405011948.675354-1-npiggin@gmail.com>
References: <20210405011948.675354-1-npiggin@gmail.com>
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

All radix guests go via the P9 path now, so there is no need to limit
nested HV to processors that support "mixed mode" MMU. Remove the
restriction.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 20ced6c5edfd..5ef43d9b19bc 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5443,7 +5443,7 @@ static int kvmhv_enable_nested(struct kvm *kvm)
 {
 	if (!nested)
 		return -EPERM;
-	if (!cpu_has_feature(CPU_FTR_ARCH_300) || no_mixing_hpt_and_radix)
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
 		return -ENODEV;
 
 	/* kvm == NULL means the caller is testing if the capability exists */
-- 
2.23.0

