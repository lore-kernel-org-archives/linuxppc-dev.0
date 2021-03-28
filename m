Return-Path: <SRS0=+9Gk=I2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EE0C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Mar 2021 23:57:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F6361948
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Mar 2021 23:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F6361948
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7t1B6x3Dz3c07
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 10:57:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=MHcOVXxw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f29;
 helo=mail-qv1-xf29.google.com; envelope-from=unixbhaskar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=MHcOVXxw; dkim-atps=neutral
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7szt1p2zz302Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 10:56:10 +1100 (AEDT)
Received: by mail-qv1-xf29.google.com with SMTP id cx5so5681142qvb.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Mar 2021 16:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cGEIwK2mIWlt0praWPVjHqx3787sD2c2+ZgIrWeWC10=;
 b=MHcOVXxwuQq9uqXkVVuBX0gJCRJ7glGGeVEfFXw0gIUK0eSzsVxe1AZARAhuSRj3YZ
 fN0P0USAorbIlhKL+tBir5YICqCcUJgAHIdtl7kbbjsKMDY4jYibPNUn3NaaV7Q8EWoo
 SLCd3+axdfEe2JQgQ0IA5JDtmlwwY/78RnCy1OD6/3OYMG9Pi0P4Td5hpINwGDG0ZVHP
 /wwa+3iDJ6RBYE1AEyFziDbGBYl8YxN7l4N0Nj3tZs04HUgSpxd0XYTb+bpMd7rAFOv/
 Ka2nQ91BkVfuIiwh7j5oP5m22bSKTwFZz8/56aHeupoIJtY5Q6H7slSTKfgf7lJTmOyP
 yQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cGEIwK2mIWlt0praWPVjHqx3787sD2c2+ZgIrWeWC10=;
 b=ZgmL+dPW5fQaCBpesbV7C5pjOnNpIVCVIaDE/eLggu1Z7/7xk1j/S9HHGQgNUeMyOM
 nPxLcil5x8ZV76PyLh5VyRgyQeEMawRrr0FlS1Y5iQx4BToTy+QGUfId/M2K/Lcndy+m
 e0YIdgWNXOZfxWI+Hu/ZzVHFD2DDCe1bk3VV8OAb5QNXqdddbTJbd43fXhNlpReu979u
 SqgW+0ROujA1yJjJ713mFBHRortiU0xlXcUxxM5UM8HgXHK79XWPZvnn2qfSVdffLMEY
 BBJgFSsKN9R9w/BZtDCNc/NfrZg4ONptGYqyfcmqRI7N9GtakTX1J+RFkeGfamm5D1C2
 qsWQ==
X-Gm-Message-State: AOAM533fhIZQ8gcyFEqe+eaNNfDMRft57sXdZ3h4ZE0+G1EbxFFed1W5
 z8Pa1m2W2kyQywuFQwNMSeA=
X-Google-Smtp-Source: ABdhPJzupTYmpyqK8HSRMpnyKZA7fy0qU0f4/K+gj2k9q8PjKZlDEA4s8A98+bzdSWZWkwnQeq1lbQ==
X-Received: by 2002:a0c:ea81:: with SMTP id d1mr23183110qvp.57.1616975767611; 
 Sun, 28 Mar 2021 16:56:07 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:07 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 02/30] altera-msgdma.c: Couple of typos fixed
Date: Mon, 29 Mar 2021 05:22:58 +0530
Message-Id: <c9dc34e16508c7444d3407d775eb6f921ff81f06.1616971780.git.unixbhaskar@gmail.com>
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

s/assosiated/associated/
s/oder/order/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/altera-msgdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 9a841ce5f0c5..c3483bf2aaa7 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -152,7 +152,7 @@ struct msgdma_extended_desc {
 /**
  * struct msgdma_sw_desc - implements a sw descriptor
  * @async_tx: support for the async_tx api
- * @hw_desc: assosiated HW descriptor
+ * @hw_desc: associated HW descriptor
  * @node: node to move from the free list to the tx list
  * @tx_list: transmit list node
  */
@@ -510,7 +510,7 @@ static void msgdma_copy_one(struct msgdma_device *mdev,
 	 * of the DMA controller. The descriptor will get flushed to the
 	 * FIFO, once the last word (control word) is written. Since we
 	 * are not 100% sure that memcpy() writes all word in the "correct"
-	 * oder (address from low to high) on all architectures, we make
+	 * order (address from low to high) on all architectures, we make
 	 * sure this control word is written last by single coding it and
 	 * adding some write-barriers here.
 	 */
--
2.26.3

