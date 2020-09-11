Return-Path: <SRS0=VWG1=CU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BAAC43461
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 17:29:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA7C221E5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 17:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7FQMxc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA7C221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bp2fY278MzDr0p
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2020 03:23:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::743;
 helo=mail-qk1-x743.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Q7FQMxc5; dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bp2P72KWdzDqsG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2020 03:12:11 +1000 (AEST)
Received: by mail-qk1-x743.google.com with SMTP id f142so10538022qke.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2020 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L+FVoRQONMvbu4AQAX/4SHLVmGHv0hK8cFz4kSjRKDQ=;
 b=Q7FQMxc5+27RYREYc7GPgId9EB7hH/hsiMEQhDyiJ0Y6lU0vDUnpgbTNFtgdnVECog
 ERdUdMtaA+UadZ9pK+pmOz2iUsE2XceE5OQnT8qaMyKBppyKiWl4UMN9hFmTWqHdUSxv
 Nt73GJwyKNmlqn6zLWY/C9yPdlZhdx3aqFG3EIMAVus2bZqsVdp7rPAGSjQBku460y4H
 A11lYF6Tn/WxK9uP8Y9uRFCODuIMFXr6eLOVrSt0opGd/zrI33Hv/XzgkVN7GQk53jxM
 McxP26JAuGpIOK0+tgUT5iazJELrl+z0be1l6dZAE3vnOv2rBbDEaY1oJRpTqrTkJoHU
 aBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L+FVoRQONMvbu4AQAX/4SHLVmGHv0hK8cFz4kSjRKDQ=;
 b=YvRqS5VEEGAPo7LaHkK3Rc5ebWKBFncLgJu0N2pVXfD4qJkoxDS6iGImcdNgv+a1D/
 GHe/nOsIZj9AOa8T3MzPGOzFEEzZy1bYN7utqUywQcIt531Uk6x8DWx9+Ad6mb84oOtv
 R0sGvdJPGEIavoNuF1hbhAEYDewv8yN7bmoJo0Oo4meieUX4H7sn4NjcwDMFXUkDesVd
 djhKCqVL0ClmfHb52MgcBmqP8srQUrqYsGFtVpvlabN2cA8kyx5jRKvw1ooHxRdx716l
 jCnfM3XT5hgMY4ClXJdo2BCyWndPQeLsFjZLmivIgw92LoFfDsJCm2OIKtzL89Nl3q2C
 DejQ==
X-Gm-Message-State: AOAM531hKV++1BtUWJuxYbQatFahj8fusc0b0Zp/WuAAEwAe6sPBfzic
 Sp5cV0ly0t78ZBIQixiH62o=
X-Google-Smtp-Source: ABdhPJzraDeqepND2McHhr8MzlAfKhWxVLPPXEJH4y7ZajHDaTIanw9n5IjZSz9NDtpEc9+L6kPqnA==
X-Received: by 2002:a37:9d57:: with SMTP id g84mr2325729qke.111.1599844329153; 
 Fri, 11 Sep 2020 10:12:09 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-254-96.dynamic.desktop.com.br.
 [179.125.254.96])
 by smtp.gmail.com with ESMTPSA id l5sm3533330qtc.28.2020.09.11.10.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 10:12:08 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Leonardo Bras <leobras.c@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, Brian King <brking@linux.vnet.ibm.com>,
 Murilo Fossa Vicentini <muvic@linux.ibm.com>,
 David Dai <zdai@linux.vnet.ibm.com>
Subject: [PATCH v2 04/14] powerpc/kernel/iommu: Use largepool as a last resort
 when !largealloc
Date: Fri, 11 Sep 2020 14:07:29 -0300
Message-Id: <20200911170738.82818-5-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200911170738.82818-1-leobras.c@gmail.com>
References: <20200911170738.82818-1-leobras.c@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 

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
index 7961645a6980..ffb2637dc82b 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -261,6 +261,15 @@ static unsigned long iommu_range_alloc(struct device *dev,
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
2.25.4

