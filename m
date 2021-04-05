Return-Path: <SRS0=L/Xq=JC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B733C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 01:32:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C20D6138E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 01:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C20D6138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDCny6zjRz3gD3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 11:32:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=tTgscvMk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f;
 helo=mail-pg1-x52f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tTgscvMk; dkim-atps=neutral
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDCYK4r69z3cHC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Apr 2021 11:21:41 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id g35so2419481pgg.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Apr 2021 18:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+yz3nCHgncTH1iYxogo/O0czpRYa7H+0gjI15C0SIns=;
 b=tTgscvMkNalSwwTNq71/3p8BkL40aWAK/vQgyTG0WMQCn5gWjt9K6vG0CmxuIDZr/e
 1etwZED7jEAYE7P5CChqkKaLiEYM+Jn+990O4da6mdvImhCuvSMu+pMjDGq9CX6LNzxy
 urBXqWrP5l43MRHkctsoxSPuFKRKk617Bo0WfySnBQLK8IJ0b1X9oZO/zvV7v7OkUF4q
 rZCwKXPlmDony8iIiegr9MmEO129bxBlpQxW08twke97y1uEUGd7+XB+zh/ysKGCOI+p
 fq4iV+GhdPk/C1oX/ySjB13HfTilsZS2ZISqv+FoAfM1lqBMwrU47TXYneKvUloeHUz+
 ZFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+yz3nCHgncTH1iYxogo/O0czpRYa7H+0gjI15C0SIns=;
 b=LFno1BKy89EhxxeSrVMr3YOg5pYXrgdsQ5G2E3DjFkJoDEtiojrSbI5YYpanmu6rj7
 B3a2i7kJ5kDtw0e0jRwZZ5moLR56sOnCwc5fnVrUCq++TqrZiPXlfUAJPrzbXrCzON+q
 OdkQO1G6OuGwKAPlXnm673wEhwF6JQyooixmr5jjuwc/W8rWWzEruQJIwtUspDrZ0nA9
 bAD6gOaz9RE/XHDE7v6Wpo9zplIbajK2bl+LKbVSCrxUC4/EqXsI6BPtAXDncvRK6VfU
 K3mrkZI1mHiKwXYfzKNb3p9W7g32/nVCcg6dKUHh9OEzatYyktsi6OsVDGTRmQiBqRow
 xuig==
X-Gm-Message-State: AOAM5310RzBELwfE+3m3NnKbyeGicrf4aahKAyDxofy7rf1RhacQkPIB
 iLdVIvoOiaV8Lc4wMDCTWB0=
X-Google-Smtp-Source: ABdhPJxG/XX78xpw1PSF9I438oh7eHsSm3t8WDghRmuYLmmb29ptdu+WOVjzBD9Zt2FgGGlgszJo1Q==
X-Received: by 2002:a62:8f4a:0:b029:20a:448e:7018 with SMTP id
 n71-20020a628f4a0000b029020a448e7018mr21215419pfd.62.1617585699303; 
 Sun, 04 Apr 2021 18:21:39 -0700 (PDT)
Received: from bobo.ibm.com ([1.132.215.134])
 by smtp.gmail.com with ESMTPSA id e3sm14062536pfm.43.2021.04.04.18.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Apr 2021 18:21:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v6 28/48] KMV: PPC: Book3S HV: Use set_dec to set decrementer
 to host
Date: Mon,  5 Apr 2021 11:19:28 +1000
Message-Id: <20210405011948.675354-29-npiggin@gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The host Linux timer code arms the decrementer with the value
'decrementers_next_tb - current_tb' using set_dec(), which stores
val - 1 on Book3S-64, which is not quite the same as what KVM does
to re-arm the host decrementer when exiting the guest.

This shouldn't be a significant change, but it makes the logic match
and avoids this small extra change being brought into the next patch.

Suggested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index dae59f05ef50..65ddae3958ab 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3908,7 +3908,7 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	vc->in_guest = 0;
 
 	next_timer = timer_get_next_tb();
-	mtspr(SPRN_DEC, next_timer - tb);
+	set_dec(next_timer - tb);
 	/* We may have raced with new irq work */
 	if (test_irq_work_pending())
 		set_dec(1);
-- 
2.23.0

