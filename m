Return-Path: <linuxppc-dev+bounces-22965-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ACACDB47F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 18:47:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glrX42QJFz2xwM;
	Thu, 25 Jun 2026 04:47:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782305861;
	cv=none; b=fwy4cPm1WbJb/JZeI9CpwSX+OePJ03lWacudf+L9J/5xjIREiqpWtoGe2BvwXC/Q8j2U8ADdHpW+UGZZB19ilXcp5nS/texir+eHAoYVllQebJd1B0FvIV99WOQGNJkiXuAuLxf1t7fa3mjARhWKxq804QNyZXNeUHifEY6YcFOrkKPr0O3sUbvwzblbgX7LlptboCKNgI2pI0PdCH2DUizEGaSPXOeGhmuG2ngQpjOwV+guydBRHLyBuVFL2/rGs8GpNMaVwk8d45eqm62bi3QVdYXezux2RIYTcklfYFONMEWIqhCjcyWwGkLdU2NYGLdoySXGQT0yZUAfOtTIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782305861; c=relaxed/relaxed;
	bh=Jh2aOctLsnI5i+h4KVRH/eJmrU3O056UvIXksYMRQS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KF4ZDfixqaWLum0ZYlNjTfAyN0zM4mo5Do9WrtoQYRGCTgPgN1kDxETJdqNRJGpUF6Ugm6vlKcblnsLi0OTJDWBlfDlZiitE2wQVjc40sk4Ymm74Ljbz/isAk6KIOlKde+xAXFowexzVuqiW0/PfZh04yFpPPbXmxQ9lVFIaFLmKtzDl+X1l9257/kdgklp46VNm+ErllwKjFwAV/5XbJPZqFD957F+VsTVpFLAgp+g+VieABQBTKL2RKjNUdPL1PyCz9hDjtfjOQUh5n8ALliNNCFiBRCHfKYz+s3yu56dbKAf8P1Wj+xo2TUlcSqy75mbiiVqx4jRP7PLYDYsitQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DaG3DbyT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=alhouseenyousef@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DaG3DbyT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=alhouseenyousef@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com [IPv6:2607:f8b0:4864:20::b12d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glhmh2r09z2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 22:57:39 +1000 (AEST)
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-662c360aa73so1005576d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782305857; x=1782910657; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh2aOctLsnI5i+h4KVRH/eJmrU3O056UvIXksYMRQS8=;
        b=DaG3DbyT7D1aMDnlvH+MWWadDcgHk+8bq/JDmQlZVMLl0KKHqyQvmAF9Y3TxPspBWK
         J/UHKhQyuJijHvG2k7NNRp+ADlRRUmqpvDbjPYGDNPn/5sT/m6ZTOYlAFZlZWoUA10Hu
         KJ8i1N5Xr+LkpJVN4qJ/7ItWlq40s/WlbAhvLz36Tm8SGCkD4fwqfgtYfsWmYunZuOs8
         hLOgVscnMxg7QdEr6blRJgpnGDBlvr86kNAd3EG3vIUscvr7onTn48PpN6jw2UCLT3Tm
         w7UT6nWqyTD65dyaMjpwMFB/a4xFwx1VBx584/LXauMVWFC+w4YnUIVJE3iVcBk6395e
         lJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305857; x=1782910657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh2aOctLsnI5i+h4KVRH/eJmrU3O056UvIXksYMRQS8=;
        b=DkT+YnUfDNeOvGBeWDoC+Ynz64tp7ghIZ4+9Km5EFjR/TK9Le8t9NaN7MEv+StV3sZ
         liWRI76PQ/BPOJUHwSPgZVRxoV1Tt1DjsVkJuaGz/FmQUr4sHWoPt1uwIRA9NKNHDAd7
         zfCWPRGbHy7ZKOMN5T7inyhtp10k/C6AqMNfB+00NNe/htr5CEqnETPbXvbMVM3qXK6v
         dWa/SrSACH5wW8oxBrNJS9BuTQlhX6hQR/Orls52wg6ynrKgQy7/WQxK2h6eiCfVerZF
         pDSn35Vom5BjPOdOC0WKaqa3lwsPoFGSLIOotehYLGaZBdiyNtNJHzoEeGa1L3sDaioR
         IdRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr74A1jw/bMgHkDTqV+MYm3QuSBmkFRplj79q+9HR1C4SmyghmAoFgBwJ4o5oDPSp7NtWLoACQjo2f0NV4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2Nw4HAs3UJVuVVHMNuG3BNfGNhyU4ki4Y8kWYVZ/blv8AOk/F
	raCzBugjrYtQTtCYSm4eg6Vxwh57nA1bT4XKgbMig4txP0lLss5gnhHE
X-Gm-Gg: AfdE7ckvNrnkoKm8WeknL0ld0LsVjWwJI5zlL5/jmLwAjq3qroHBJLzpkPJXDdCu8Ir
	vsNIGLGDbJGTmusJSQwPjNnjMKbGFIdfrBYo1z7UuUjn8kMolvkj3V2LUkUT+cdjWV+eLsFQGcW
	qwj/d/XZEzYg2g29J/YK+8vurtOcWSEebzlIsxh71D8M9vRP4GUW4OhLa4p7HFY9Ly0T6ImH9ab
	bFhmLj5tCPFiMDjtr+ZeTufA6THqQ+kbdwvaBWzP6GpAcCHRkxEoFAuBTmLPLeL9Ofi75hNHY7d
	sfXj2OSQpN7Uivu5LyFjNBSCejM9/zd1dYBqV1CAu1UynManxlE/GrDO7GxO3lBsZzElPRgOP0L
	5wKhR+VncVY72x3jT6PnqYeMeDzvL3vGvLf4M2ij4ivjVhKHIbsNMyiws9LlIs041EU8Kf3f25K
	dwHIIYLiRFfmIKF266JMS9Rgv1Ysz9bD7oUC9B
X-Received: by 2002:a05:690e:d45:b0:65e:5aa3:9640 with SMTP id 956f58d0204a3-6636e302758mr2501984d50.25.1782305857422;
        Wed, 24 Jun 2026 05:57:37 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66314e1210fsm6659023d50.21.2026.06.24.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:57:37 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Scott Wood <oss@buserror.net>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] virt: fsl_hypervisor: bound memcpy ioctl ranges
Date: Wed, 24 Jun 2026 14:56:25 +0200
Message-ID: <20260624125625.11676-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FSL_HV_IOCTL_MEMCPY takes the byte count from userspace as a u64, but
ioctl_memcpy() stored the derived page count in an unsigned int and the
remaining byte count in a uint32_t.

Large ranges can therefore wrap the page count before the pages and S/G
arrays are allocated. A wrapped zero page count can leave only the
alignment padding allocated for the S/G list before the function writes
sg_list[0]. The get_user_pages_fast() page-count argument is an int, so
larger values cannot be passed to it safely in any case.

Reject local addresses that cannot fit in unsigned long, calculate the
page count in 64 bits, cap it to INT_MAX, and allocate the aligned S/G
list with saturated size helpers. Keep the remaining byte count as u64 so
accepted ranges are described consistently.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/virt/fsl_hypervisor.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index f472c9480..bb01f9daf 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -153,13 +153,15 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 	struct fh_sg_list *sg_list = NULL;
 
 	unsigned int num_pages;
+	u64 num_pages64;
 	unsigned long lb_offset; /* Offset within a page of the local buffer */
+	size_t sg_size;
 
 	unsigned int i;
 	long ret = 0;
 	int num_pinned = 0; /* return value from get_user_pages_fast() */
 	phys_addr_t remote_paddr; /* The next address in the remote buffer */
-	uint32_t count; /* The number of bytes left to copy */
+	u64 count; /* The number of bytes left to copy */
 
 	/* Get the parameters from the user */
 	if (copy_from_user(&param, p, sizeof(struct fsl_hv_ioctl_memcpy)))
@@ -214,11 +216,22 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 	 * equal to the number of entries in the S/G list that we give to the
 	 * hypervisor.
 	 */
+	if (param.local_vaddr > ULONG_MAX)
+		return -EINVAL;
+
 	lb_offset = param.local_vaddr & (PAGE_SIZE - 1);
 	if (param.count == 0 ||
 	    param.count > U64_MAX - lb_offset - PAGE_SIZE + 1)
 		return -EINVAL;
-	num_pages = (param.count + lb_offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	num_pages64 = (param.count + lb_offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (num_pages64 > INT_MAX)
+		return -EINVAL;
+	num_pages = num_pages64;
+
+	sg_size = size_add(array_size(num_pages, sizeof(*sg_list)),
+			   sizeof(*sg_list) - 1);
+	if (sg_size == SIZE_MAX)
+		return -EINVAL;
 
 	/* Allocate the buffers we need */
 
@@ -236,8 +249,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 	 * sg_list is the list of fh_sg_list objects that we pass to the
 	 * hypervisor.
 	 */
-	sg_list_unaligned = kmalloc(num_pages * sizeof(struct fh_sg_list) +
-		sizeof(struct fh_sg_list) - 1, GFP_KERNEL);
+	sg_list_unaligned = kmalloc(sg_size, GFP_KERNEL);
 	if (!sg_list_unaligned) {
 		pr_debug("fsl-hv: could not allocate S/G list\n");
 		ret = -ENOMEM;
-- 
2.54.0


