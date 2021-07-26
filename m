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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AE2C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:00:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3DB60E78
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 04:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C3DB60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY5n20GB5z3dby
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 14:00:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=g+HajHr1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034;
 helo=mail-pj1-x1034.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=g+HajHr1; dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY5Zg5Z9hz30F4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2021 13:51:39 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id
 o44-20020a17090a0a2fb0290176ca3e5a2fso5067236pjo.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jul 2021 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TlyaSEq0t+PRD6ftzOjtBOST1TcfxMZ4B/R2htdQQDg=;
 b=g+HajHr1SO9Bsn/F4YCZmiWqX6zSkdUF1UemGJUPQoZqwW0CMXOzECMOG5Xq89mtGM
 9XDq3crVgP8t3JwF+1RlJQWBph82iwHg3E+KAQvy6DfiHm+KnCqKe/aL+GsDXV9sxCiZ
 DXmkQAdY2JKrJZyuHD9BngEPY3aBKJpL9gv8swydw7i9pqEbHnsUJbUuGWN7ESGVmNtu
 3m9IZU9BII2G25kuXl7ap56cWYqmYHEJGsqV6K+cBAeayglVb//oQ7Y7gzDhiRrQJpqQ
 VBh2rGBWNNLNhHiAmoofkBs4lBxmGAZI3qJOXUrqbQNKiYzQWpu6BoOwW+1Eh8iT9TXK
 E7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TlyaSEq0t+PRD6ftzOjtBOST1TcfxMZ4B/R2htdQQDg=;
 b=GPpiI9kx9dVi/S+T+cCIPEAZRVfjpnsK9HpAItA9vVQSv4EpVuxx0aIL2E1EqYtXyn
 LvkKqK3hCdyzcynmn+6N3OfLy36UUwWjfd+8F/2itLS2zmig7NQCTOZjDOTI/6w+euIS
 7qxgiqhUZhhuAKD8Gq5lGv76W2tShr8niHxq5G/WEcqqD4Br3vVtczkM/tZnFvrula8n
 3HuNigjDdQpXqvdr8Zqpp2YS+hc8oy3HxCIjlpeCIlAjee+ukXhXaMtncQgS3NYVMy3Y
 Afb2sHDwsVmaAflSg0xjJv0Nqe9SCYc4wt92osrqziY7U1BqqS3GjMMSaNohlcizYyA1
 zNFw==
X-Gm-Message-State: AOAM533FfbRvTrq7MwY2wkkipxaqlO+RVW8PWTWAVjgEnJoo6n+aibUn
 1lrx9/kQfqJrZRRltqmKn4k=
X-Google-Smtp-Source: ABdhPJzDx+e6KcW+rc1cBJfLlZ9+HLdDjj/ZOf3LfPcyJbtU7eVuwRkC9WAFWEqtFw5wkpez6U4NcA==
X-Received: by 2002:a17:902:a9c1:b029:12b:8ae3:e077 with SMTP id
 b1-20020a170902a9c1b029012b8ae3e077mr12921049plr.75.1627271497200; 
 Sun, 25 Jul 2021 20:51:37 -0700 (PDT)
Received: from bobo.ibm.com (220-244-190-123.tpgi.com.au. [220.244.190.123])
 by smtp.gmail.com with ESMTPSA id p33sm41140341pfw.40.2021.07.25.20.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 20:51:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 22/55] KVM: PPC: Book3S HV P9: Move SPRG restore to
 restore_p9_host_os_sprs
Date: Mon, 26 Jul 2021 13:50:03 +1000
Message-Id: <20210726035036.739609-23-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Move the SPR update into its relevant helper function. This will
help with SPR scheduling improvements in later changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index f212d5013622..2e966d62a583 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4057,6 +4057,8 @@ static void save_p9_host_os_sprs(struct p9_host_os_sprs *host_os_sprs)
 static void restore_p9_host_os_sprs(struct kvm_vcpu *vcpu,
 				    struct p9_host_os_sprs *host_os_sprs)
 {
+	mtspr(SPRN_SPRG_VDSO_WRITE, local_paca->sprg_vdso);
+
 	mtspr(SPRN_PSPB, 0);
 	mtspr(SPRN_UAMOR, 0);
 
@@ -4256,8 +4258,6 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	timer_rearm_host_dec(tb);
 
-	mtspr(SPRN_SPRG_VDSO_WRITE, local_paca->sprg_vdso);
-
 	kvmppc_subcore_exit_guest();
 
 	return trap;
-- 
2.23.0

