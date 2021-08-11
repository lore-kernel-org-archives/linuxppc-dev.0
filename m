Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3874C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 16:02:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B716054F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 16:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45B716054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GlF2l6qNwz3cXT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Aug 2021 02:02:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=mV7UlH3D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=mV7UlH3D; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GlF1n4c6dz2yLJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Aug 2021 02:01:49 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 g12-20020a17090a7d0cb0290178f80de3d8so5613046pjl.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Aug 2021 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E8HC5KhjUlV41KsAAH26eBl3oXcWuvaOrNt60v4bxY0=;
 b=mV7UlH3DvLgMJ8Q4WElYlwvm7C5mdnCt9HgAQtZZc1cxirIowLROGpkT7TzbPvH0UD
 CvAWp7Dgg0cMgq4AUy2IdhTak631/ziDI7mUFyKWlsjMNySAUPZsSmrvt7YT5ec4alQk
 BbegHt3uvTJ2KPdlaCOROsSSths1BFcwXoiJI36BPx8pQNRW3u/xmN12tMHcYUDvf6i1
 36/WLAtiYuI0Jv2JjsylSemnD9f1S2+2h7imQ2DcDcUcnv+8N2+UdHjMwwdOOrhciBkK
 Tpn2bK5iv2c5aaWJriZlqvh6Fxa5T4necAZytQzY5qKko8ZuS6Cs7S6WljQdWr2ITefv
 yoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E8HC5KhjUlV41KsAAH26eBl3oXcWuvaOrNt60v4bxY0=;
 b=WH41OmQN0vA8bmqzLBnwsm565OKUtsMJyDtFwvVkBAOHVYQVWRPDUHQdcThz0M1v+P
 VaqgYRB68vegZBJyhbBSAA1kwkmLiYEWHNzD0fgqVH+jgFcl8XEuXRoSaVZESaSbC3qg
 Huymz7SjJKYigqBpmpypKHKlZy1G8+2map5QQUijH93+xp4LKXS1Wr/HmhyWymXyP7y1
 +JhrrZGN2iuNi9jd+PlF+3dEo9RQtGaPDS1jJSUyEOKlP8KOXWmPuirO66SiUj06m0Cu
 anOSyGjdWcx9SDZYplkDjO+ovwOZT20DHIw4lnuwdOjb3AUBVBI8r4Ke4zx7oyCDmjoZ
 SY4g==
X-Gm-Message-State: AOAM531UB93RpDoETftP9TABgDV+lStR1AxUHEGP9crwZiz1TD1K4bZL
 4203otjllNixpUiCzUkY9G4=
X-Google-Smtp-Source: ABdhPJw0X/yXTqy7uK6o1fGg2KjFOhZPsyVwTsz7rRc0h/CWcZzi2VpYHfToAVfUywkDOv99bl9JHw==
X-Received: by 2002:a63:4b53:: with SMTP id k19mr345448pgl.3.1628697707077;
 Wed, 11 Aug 2021 09:01:47 -0700 (PDT)
Received: from bobo.ibm.com ([118.210.97.79])
 by smtp.gmail.com with ESMTPSA id k19sm6596494pff.28.2021.08.11.09.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 09:01:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 01/60] KVM: PPC: Book3S HV: Initialise vcpu MSR with MSR_ME
Date: Thu, 12 Aug 2021 02:00:35 +1000
Message-Id: <20210811160134.904987-2-npiggin@gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It is possible to create a VCPU without setting the MSR before running
it, which results in a warning in kvmhv_vcpu_entry_p9() that MSR_ME is
not set. This is pretty harmless because the MSR_ME bit is added to
HSRR1 before HRFID to guest, and a normal qemu guest doesn't hit it.

Initialise the vcpu MSR with MSR_ME set.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ce7ff12cfc03..2afe7a95fc9c 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2687,6 +2687,7 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 	spin_lock_init(&vcpu->arch.vpa_update_lock);
 	spin_lock_init(&vcpu->arch.tbacct_lock);
 	vcpu->arch.busy_preempt = TB_NIL;
+	vcpu->arch.shregs.msr = MSR_ME;
 	vcpu->arch.intr_msr = MSR_SF | MSR_ME;
 
 	/*
-- 
2.23.0

