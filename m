Return-Path: <SRS0=FJcg=WK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89121C433FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 22:12:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0075220665
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 22:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTIl/9Tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0075220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4683jD2szRzDqNb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 08:12:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=robdclark@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BTIl/9Tk"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4683fl4y5RzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 08:10:07 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id e11so294058pga.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2019 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EgMxpqnDCUKKSviaeDfqej3uE+25ke/kBD5EQ8QhSvk=;
 b=BTIl/9TkKL1+c9ssk34W7XBCbm+8s/A7Aw49hrbdu/fvCvAhPq7IzZM6LQxNWC2QoE
 43Fy8M+wBoAaew0rOCWEYQwW7hi4OWCZw6V6ljV8i60R6zk3xV1oqtX+5OAjikb7TOo1
 euYSXyToMva4nrJeLoOG98FDCZPQBFYfVuK757KSMnKyMdqqDJ7hJn9O82GWwbVWL9Va
 YaafGnFOnoXjFAO3qaf7hnVlz6fUzZ9nRvXAT9cifyZdFjtDpGNfVhryES6wHppUEFRl
 N8nXSFKxcF2k8iMc+4q6OzgcKiepinofnK8FF77cgrT+mIe6oir15Gjrwq/AEM4yw+XV
 l75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EgMxpqnDCUKKSviaeDfqej3uE+25ke/kBD5EQ8QhSvk=;
 b=PZ0JRc4JXelVu53Z8dSJ3AQDBrcMWQ6CGmNr8PjpFawh5z9nR9e1E+0ekjySf8gZcm
 r2EeiJj03XdZELrj5Em1BM0m5HgzmkVMAjri67StxVLDY0ejxYyxyTP8ixw2AasuVqSs
 l4syTR3PXdoD9DFaEof19lrojBs9fhR+6pVbeP+rR+3547rQJXIIG8H5pIiQtOnbA/uH
 CdlvtT9fA9wWdVi3xbaPKvwwYEs9ClTesYGcmUasmF+51DlhF7r6rfWB7ulKkAhX5XEI
 UxuNMY/2QzAOGq9x/1oHR46KbUEVZtrvSsX9F4qTzdw9UGwWo+wFkl7p3gvWO7Mcrv+O
 sWXA==
X-Gm-Message-State: APjAAAXwh2+21PzbMM8rDpU3ProQPIZti4bJO+dHWPo/Ofj/21N1sMpn
 c6favsEDx7i5dEyTJddaV5I=
X-Google-Smtp-Source: APXvYqxT0bYRzWmURPra22SeQuhBS+23yZe3pSx10q32MZ/PWreU7JH+YXqDftobAJdodjbhda6e0Q==
X-Received: by 2002:a63:de4c:: with SMTP id y12mr1125128pgi.264.1565820604373; 
 Wed, 14 Aug 2019 15:10:04 -0700 (PDT)
Received: from localhost ([100.118.89.196])
 by smtp.gmail.com with ESMTPSA id a189sm929015pfa.60.2019.08.14.15.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 15:10:03 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 3/6] powerpc: export arch_sync_dma_for_*()
Date: Wed, 14 Aug 2019 14:59:58 -0700
Message-Id: <20190814220011.26934-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814220011.26934-1-robdclark@gmail.com>
References: <20190814220011.26934-1-robdclark@gmail.com>
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
Cc: Rob Clark <robdclark@chromium.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Enrico Weigelt <info@metux.net>,
 Christoph Hellwig <hch@lst.de>, Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 arch/powerpc/mm/dma-noncoherent.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index c617282d5b2a..80d53b950821 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -401,12 +401,14 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 {
 	__dma_sync_page(paddr, size, dir);
 }
+EXPORT_SYMBOL_GPL(arch_sync_dma_for_device);
 
 void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
 	__dma_sync_page(paddr, size, dir);
 }
+EXPORT_SYMBOL_GPL(arch_sync_dma_for_cpu);
 
 /*
  * Return the PFN for a given cpu virtual address returned by arch_dma_alloc.
-- 
2.21.0

