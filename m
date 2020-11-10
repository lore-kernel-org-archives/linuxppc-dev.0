Return-Path: <SRS0=8kw5=EQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFAFC4741F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2020 02:58:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E525D207D3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2020 02:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWWeHTLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E525D207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CVXcD5tCSzDqfq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2020 13:58:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=xiakaixu1987@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=gWWeHTLi; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CVXYj579czDqZP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2020 13:56:09 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id e7so10042588pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2020 18:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=10dhqypAgXKLqnQc/Ojgnp2H1LV7b1aG71TKjLfXWtM=;
 b=gWWeHTLiHwPrViViLz3noob5AhWPsr8rnxg1oN48xMXTcobUuKzrbKSmRwVjJkXIpe
 0ZXs7RUVg3B9K1kPXx6iEs8emZdybNukF5xLe7bfd/FCTl5nZam+nn9SWZqmp0kUduce
 2FE5PCyHRb37ks+FHJrM1M0J2p3/4tLoSdX85tN9u6cH4YV2VbCKZG2opLoP3TomOgwC
 Ln6c+0eZ7S5LarN0D0eYP3WYOIzJ1AU/Fued4CB/8bxvbz0ZSnh/kG0QtJKddgctE6fT
 PHu9S/DbnoDfZM06IU6IKf8at8GBhB9ZPP32hgdEmcXFoJTAZ9ibLejWbtTI05mnj0CX
 PSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=10dhqypAgXKLqnQc/Ojgnp2H1LV7b1aG71TKjLfXWtM=;
 b=T4X6Wtepl1Uo9ybG2/39gQ3cKZSYBXnI1AsxNZEII0JpS8uZ/N2GnqwgN9QqtR5UkE
 Vb9QCPLhS/ArHF0BVCsa605kMDUomnMyPyJUjcILFzgd/lu+VrlG4S6CPuTQrPtFK1Xp
 RVjctXndiEAPOV3WK9RMN3cItnYKk5GdmYeC++HHxAI8pDb3xEJ25xw6Mqe0iRMHaz3p
 MQRdnPkWv+lAekF3JmDnknMa26bubuxyiNYo3IqOiuM0A5md6Qr8O8Cw5WClokFL/Fcl
 irh1tnoBqGq2Igu5MKlv9d8MJ1LyCDDSA+Sbqdn8huLt/3Tgj3TgWIbagLtYbxAx14aM
 cwJA==
X-Gm-Message-State: AOAM532w5KPCHRYJJ66O6hTnej7KQ3GVyVJadTJqpopTj4CTU+dClJgI
 b0fVX9eIG90bvNVnBId6jQ==
X-Google-Smtp-Source: ABdhPJxGLd96DmACzpGMPyv3gfQnc7fyfkF5dYrFJKuIMk9THqi9LLX9IXGDwl619kCYT6eodO/T5Q==
X-Received: by 2002:a17:90a:7784:: with SMTP id
 v4mr2582765pjk.60.1604976966173; 
 Mon, 09 Nov 2020 18:56:06 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com.
 [67.216.221.250])
 by smtp.gmail.com with ESMTPSA id t32sm11812552pgl.0.2020.11.09.18.56.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Nov 2020 18:56:05 -0800 (PST)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org,
	paulus@samba.org
Subject: [PATCH] powerpc/mm: Fix comparing pointer to 0 warning
Date: Tue, 10 Nov 2020 10:56:01 +0800
Message-Id: <1604976961-20441-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: Kaixu Xia <kaixuxia@tencent.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Kaixu Xia <kaixuxia@tencent.com>

Fixes coccicheck warning:

./arch/powerpc/mm/pgtable_32.c:87:11-12: WARNING comparing pointer to 0

Avoid pointer type value compared to 0.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 arch/powerpc/mm/pgtable_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 079159e97bca..888b9713a316 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -84,7 +84,7 @@ int __ref map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 		pg = pte_alloc_kernel(pd, va);
 	else
 		pg = early_pte_alloc_kernel(pd, va);
-	if (pg != 0) {
+	if (pg) {
 		err = 0;
 		/* The PTE should never be already set nor present in the
 		 * hash table
-- 
2.20.0

