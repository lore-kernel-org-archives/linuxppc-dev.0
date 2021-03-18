Return-Path: <SRS0=ebT8=IQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E7AC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Mar 2021 17:46:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB7E64F1C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Mar 2021 17:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB7E64F1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F1ZFj63NDz3c5Q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 04:46:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=fDe73JUD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::830;
 helo=mail-qt1-x830.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=fDe73JUD; dkim-atps=neutral
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F1ZFF57RPz301y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 04:45:53 +1100 (AEDT)
Received: by mail-qt1-x830.google.com with SMTP id l13so4696148qtu.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Mar 2021 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eEthMhsVtKGTUyiAbeT/3DmcKa1q9L+Bg4NZOlr+SGA=;
 b=fDe73JUDydWWuzSreL/N3PtoZ9EbDr3/HtYRiSXJW57kHFqCr+OpHINmD23kkC8XZq
 QLszDkWqJNe/Qxo3RkoyWmLzVy2HmeMOc2qRAtmW6ba2EJP0btQJGYVUAOYTmDCvtYZB
 118gkXkoHoLAltaICS249Pzx9rhWM9usf1i3vwpPDz9oPr/UMsktITb8SntC85INpjiV
 +1uRwCUymnAApJvzTescfH2LpCojK50JnOidH1xoVURJXhMX82SETTaqY6vGIRxwbAsh
 vnsAmP0PrVT17OAFTgcvH0N5ADWceFaJY8ZxOr2vHSlEftu6jClDj0xY2ViRJD58rQ6O
 RTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eEthMhsVtKGTUyiAbeT/3DmcKa1q9L+Bg4NZOlr+SGA=;
 b=S18im6XPLchg+KgDEDjvwuNEF7SJdASWwe5qx/BEnA27WpG8Dw1zXLLw2CeRiQVbuh
 79ObjcihE/+PmaRMZQyOgHcPpTFlpm6fvSEoGWL36y0prmCVtWwhuyNCggRpJFtGH+XV
 +8oLQ0q3a21y17Pz9/Yo7pQAD95AJvm0VLbckFNqpHxDtnzRdFgHAgkYccLdhaQEnVqi
 uH3/EVKSx7IBCh68msE3kIRHRVgm0y8AZp3G3zO53ssMMR5RukYrF7lr2JiP/tF1vX1f
 pY0F0OVX8e32dbtBoHiZ/wFvXPfLbZYjhDrOgEgY9PlVMA3am2Ltw2mSlX432ecEZuRZ
 YrRg==
X-Gm-Message-State: AOAM53252ToRs6PCO8pyQdIKilQDcWi99MoV4ZDUSCWXmY0jtI5kaelC
 mZtIC33hib9FR0CYFs/clhg=
X-Google-Smtp-Source: ABdhPJzhkEyuUIjDSySV0uHjJqruUAB+zTPe1r0ANE0b5DNVCHXfg3ycsWq7RLBPShrObGQxF/t/fA==
X-Received: by 2002:a05:622a:216:: with SMTP id
 b22mr4822014qtx.263.1616089550116; 
 Thu, 18 Mar 2021 10:45:50 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com
 (179-125-249-210.dynamic.desktop.com.br. [179.125.249.210])
 by smtp.gmail.com with ESMTPSA id p8sm1940785qtu.8.2021.03.18.10.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 10:45:49 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Leonardo Bras <leobras.c@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 1/1] powerpc/kernel/iommu: Use largepool as a last resort when
 !largealloc
Date: Thu, 18 Mar 2021 14:44:17 -0300
Message-Id: <20210318174414.684630-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210318174414.684630-1-leobras.c@gmail.com>
References: <20210318174414.684630-1-leobras.c@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As of today, doing iommu_range_alloc() only for !largealloc (npages <= 15)
will only be able to use 3/4 of the available pages, given pages on
largepool  not being available for !largealloc.

This could mean some drivers not being able to fully use all the available
pages for the DMA window.

Add pages on largepool as a last resort for !largealloc, making all pages
of the DMA window available.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 3329ef045805..ae6ad8dca605 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -255,6 +255,15 @@ static unsigned long iommu_range_alloc(struct device *dev,
 			pass++;
 			goto again;
 
+		} else if (pass == tbl->nr_pools + 1) {
+			/* Last resort: try largepool */
+			spin_unlock(&pool->lock);
+			pool = &tbl->large_pool;
+			spin_lock(&pool->lock);
+			pool->hint = pool->start;
+			pass++;
+			goto again;
+
 		} else {
 			/* Give up */
 			spin_unlock_irqrestore(&(pool->lock), flags);
-- 
2.29.2

