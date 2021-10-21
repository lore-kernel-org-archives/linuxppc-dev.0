Return-Path: <SRS0=ebkI=PJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4764AC433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 04:01:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B6C60F6E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 04:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70B6C60F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZYgl0mXQz3dtD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 15:01:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GR1DRtaA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=GR1DRtaA; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZYX671nTz303H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Oct 2021 14:54:46 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id
 q10-20020a17090a1b0a00b001a076a59640so4984712pjq.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Oct 2021 20:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XuRZuXMp4TxqU1SsXIYoSuXCGrcjNgo7TLmZp/yqIWg=;
 b=GR1DRtaAzTNbrAPGTevUciULiGubnqjtjbjVt1Nq3W9JxkkST9IhL07wCgx0wc0Ax7
 2r1glBs3NC/7n3hwM/n7lkGuHld/ArFuw7VT7UN5VcWg3XHKe60054QhFk+jDhhCELNG
 A05Y0Aj/yza9kPg6zAUso3xkkKPD2+mmJiIkPQ/94WJgryaURw+vDHJa1TOVr0qMiUfp
 vavhxsw0Ewk7pixXdglsPsRH19Ipo+vCKMlb0Y6PnSaI5brBjxtKSG0B9waoq3eMc1xq
 R6Ni09fpDX9eeWwz8lC1m+rXwr6xCw6ypGjZoHVKTh7p7Z28lzAlEIeLJ52eVOLmfJDn
 rOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XuRZuXMp4TxqU1SsXIYoSuXCGrcjNgo7TLmZp/yqIWg=;
 b=sZOdwet9BEmyavJcDbjopFQSQtHzzgFadI2yDGwIhak4GiFBPoYXVq4hFZSho66BW+
 0pVB9IKXBpK1OuR8JTHQ8/0XzK+sfoJA31Kkj07G1Tj1KY8Seya9DjFdYBGrXG4fsEEX
 zJuCFKUotQ5x59+18tsyfJ+GMV78n6eWvL5BvxCQoAnb54IwLtKo+xz42VcslwRmIRv/
 XRHAyb201SnJn2aQWTWpoIvptKHrp7sRWz/rA0Bquda4JLN4ydqoVayytIb1WC/XBWc1
 JYWIMJWTU7dySvPx8MTBZDDmJ9Thzlw6UWVg7VMs1oY2rp5rCvxwzIQvyjNbVZJp/kdL
 iPbA==
X-Gm-Message-State: AOAM5313cydQbREkyAnEnkSGZXghYB0527rqDkC2VzpmRiI1/OIt1YsA
 2Aoyki34/ltJ+RAouc7DRiyQatEu/d8=
X-Google-Smtp-Source: ABdhPJwvfPNlh+TKtCOk3vYcY4hqZW9/Js2bOSkgzg7Sgc42G3VcLHXiPh0y5XsjMGHFvWA1hzr1Hg==
X-Received: by 2002:a17:902:d50f:b0:13f:ac51:29b4 with SMTP id
 b15-20020a170902d50f00b0013fac5129b4mr2887501plg.51.1634788484684; 
 Wed, 20 Oct 2021 20:54:44 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-203-144-177.static.tpgi.com.au.
 [14.203.144.177])
 by smtp.gmail.com with ESMTPSA id t9sm7369249pjm.36.2021.10.20.20.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 20:54:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 10/16] powerpc/64s: Rename hash_hugetlbpage.c to
 hugetlbpage.c
Date: Thu, 21 Oct 2021 13:54:11 +1000
Message-Id: <20211021035417.2157804-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211021035417.2157804-1-npiggin@gmail.com>
References: <20211021035417.2157804-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This file contains functions and data common to radix, so rename it to
remove the hash_ prefix.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/book3s64/Makefile                              | 2 +-
 arch/powerpc/mm/book3s64/{hash_hugetlbpage.c => hugetlbpage.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/mm/book3s64/{hash_hugetlbpage.c => hugetlbpage.c} (100%)

diff --git a/arch/powerpc/mm/book3s64/Makefile b/arch/powerpc/mm/book3s64/Makefile
index 1579e18e098d..501efadb287f 100644
--- a/arch/powerpc/mm/book3s64/Makefile
+++ b/arch/powerpc/mm/book3s64/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_PPC_HASH_MMU_NATIVE)	+= hash_native.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= radix_pgtable.o radix_tlb.o
 obj-$(CONFIG_PPC_4K_PAGES)	+= hash_4k.o
 obj-$(CONFIG_PPC_64K_PAGES)	+= hash_64k.o
-obj-$(CONFIG_HUGETLB_PAGE)	+= hash_hugetlbpage.o
+obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 ifdef CONFIG_HUGETLB_PAGE
 obj-$(CONFIG_PPC_RADIX_MMU)	+= radix_hugetlbpage.o
 endif
diff --git a/arch/powerpc/mm/book3s64/hash_hugetlbpage.c b/arch/powerpc/mm/book3s64/hugetlbpage.c
similarity index 100%
rename from arch/powerpc/mm/book3s64/hash_hugetlbpage.c
rename to arch/powerpc/mm/book3s64/hugetlbpage.c
-- 
2.23.0

