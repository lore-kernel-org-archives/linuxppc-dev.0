Return-Path: <SRS0=Xl/Y=I3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96162C433C1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 00:08:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFA461606
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 00:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFA461606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7tG66L8fz3fyk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:08:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=IkSy4D1T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2d;
 helo=mail-qv1-xf2d.google.com; envelope-from=unixbhaskar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=IkSy4D1T; dkim-atps=neutral
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7t2M5KD8z3cFt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 10:58:19 +1100 (AEDT)
Received: by mail-qv1-xf2d.google.com with SMTP id by2so5684332qvb.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Mar 2021 16:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y32tInUapaLYbNEAI6jhNwCPrGHOxbt3T1h9KOpxef0=;
 b=IkSy4D1TkXi7lQMZ6smgafSA8mBcR9dJT0+IXc5N37pT9vxabM+SLMm50H4wvaA2Tp
 lk2+hXnLnaOUCms7sELVhOI/WPyeZdnXsdinIxZIuQnUF61PVACtUXO8CzQJmpUg/8F/
 kd/qUNl45u1Q/Z/y4MVvg7AMaZOTYLhOVHKm6Nt+ekWZZfILUbrp2yYgvZ/PqE0UZkxu
 yfiYNr5lsWA/xZeBftAd/5ys7cnmg2vNyOHsMfAKtVfKra3pkeqYar1Fa02kv/vB8uJB
 v4N4zgVPfp5L/JTA/n+36bVEt3mIlRbpaEf64PY4DjGrJu9ef2ZC8nn+a6/daLkbdFVL
 X/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y32tInUapaLYbNEAI6jhNwCPrGHOxbt3T1h9KOpxef0=;
 b=JnutYPRKOXvU+2z4d3ab6PsPL0JCIULI62W/Qk+XqelRXn0+HGhDvD+hKmSp5mE3R2
 KQBF0ec8haH2VhrBMluPAqNA/+hMt83rCHlud63sY7sv3GMc1QEbGKqq1Lx9WxraW5Li
 UIhQED0n0HD+4RPAoU+5E5RC9XFeYWbhbs+uJ/ltdnjakpYhmD0dmeRqwoAwH4rcKBrG
 /SjgVCJdMJz6+9sWUlI/yPkGhJajITEUzF+27Ba+jIP4zDItqIdLVW6pmP4FHjxXUSAP
 VxKW2ByLTRkrkvz/SCzoiY25n1EKjAbZwpBTM758rPUhQZz4bNpb5M2J3D7PfcLXitd9
 zz8A==
X-Gm-Message-State: AOAM532tn0shhXx3s0SffcWmsHJNWHSTWabgsCCGcpkb9rdoExgOpiql
 Sb5yhdSHWDnauNTR2FZU1MY=
X-Google-Smtp-Source: ABdhPJyWc3zpPzhGmj++XGZnoiKJeId7+5rJvoWlZFi+DgW1DNMSXYY/0RU9k5f3zIa31roOCCmQaw==
X-Received: by 2002:a0c:df02:: with SMTP id g2mr22816522qvl.40.1616975896740; 
 Sun, 28 Mar 2021 16:58:16 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:58:16 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 28/30] usb-dmac.c: Fix a typo
Date: Mon, 29 Mar 2021 05:23:24 +0530
Message-Id: <7458e5dc5058076cf2ebe15de57c94927dcffcca.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
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
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

s/descritpor/descriptor/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/sh/usb-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 8f7ceb698226..7092a657932b 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -301,7 +301,7 @@ static struct usb_dmac_desc *usb_dmac_desc_get(struct usb_dmac_chan *chan,
 	struct usb_dmac_desc *desc = NULL;
 	unsigned long flags;

-	/* Get a freed descritpor */
+	/* Get a freed descriptor */
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	list_for_each_entry(desc, &chan->desc_freed, node) {
 		if (sg_len <= desc->sg_allocated_len) {
--
2.26.3

