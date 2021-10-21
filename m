Return-Path: <SRS0=ebkI=PJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B7C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 22:37:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255BC6109F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 22:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 255BC6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hb2RW63f0z3dyg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Oct 2021 09:37:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=OaGfMMdc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629;
 helo=mail-pl1-x629.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=OaGfMMdc; dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hb2Hv49NNz3c8k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Oct 2021 09:30:51 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id i5so1405493pla.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Oct 2021 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XuRZuXMp4TxqU1SsXIYoSuXCGrcjNgo7TLmZp/yqIWg=;
 b=OaGfMMdcs15U/vPhzV/oarjwUMf5inZo0asUHa7lCsPgE32mPkxdN4nE7zqnn734T/
 o8PvatQwp7TnlIQSOGSUoRaSN7+Oo6neNUMehGNYfX9NA8K8x6FiPm3gSm5uraKAxCV0
 6J6dzL+gGYvmtv1aASQQjp4FY+qE2BmmGjRvMRh3QxffCkwx8HnB/eE5JG+ZgIUdRN//
 83O9KPjqm/TC417I8LwXQcaiOSYqOA0ulgYSR8RnX/oL9WfW/HVin+olTmC6HFBLtxg8
 fCzQRQSqy/Q9VUBwnA9sJfwQHzmP6XoOZbOn579Iq9ZDmKbLtN8L5w0m1DRFHfoLoxMf
 qhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XuRZuXMp4TxqU1SsXIYoSuXCGrcjNgo7TLmZp/yqIWg=;
 b=uWOTtcmvN7If4Lq3pzsahAx2qsNadikhCgz7pGBtoX4rbmdLtzl1ZcE6mpCnuKd+QP
 ZAzA2SKjkBQgB42YY5CUWIE15U4bbgSDFayHlz1B3NHMgIVl0y+lGVFKEfNbztIM81rP
 +drCrVGTXKDINFdCOpPxyka2cdlliqwlF1mf5jjoSsqSfI6hYM8LRqk8J7bgHpX6vYUA
 BQZQnFHVlDjw89oUXC9UJbeDLH1oj0MOo85ozlJv6BkhqrdTf18zYyIr9IHIoXl8HMDi
 qaE/C5gcu8eo5/orCUO0/2HmffpjKQ/3uUWTQiNwbKbn4uxupc429eNm840ExmkxPjEl
 +bpA==
X-Gm-Message-State: AOAM533/MioptNT+MSFNZujYUqwlzwCLp52gXfmlfXpFeWQ6ztWu+/fA
 MYm4eU6Xx8XAR3RG6mKxvuEpcttxP6M=
X-Google-Smtp-Source: ABdhPJxgEUML534YGD9mVIizawTg+88xBcupIjmd7NetZcIRodAafxYRSR0e6thUQZuJs0ByOrfu5Q==
X-Received: by 2002:a17:90b:3ecd:: with SMTP id
 rm13mr9820218pjb.189.1634855449071; 
 Thu, 21 Oct 2021 15:30:49 -0700 (PDT)
Received: from bobo.ibm.com (14-203-144-177.static.tpgi.com.au.
 [14.203.144.177])
 by smtp.gmail.com with ESMTPSA id e6sm7205716pfm.212.2021.10.21.15.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 15:30:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 10/18] powerpc/64s: Rename hash_hugetlbpage.c to
 hugetlbpage.c
Date: Fri, 22 Oct 2021 08:30:05 +1000
Message-Id: <20211021223013.2641952-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211021223013.2641952-1-npiggin@gmail.com>
References: <20211021223013.2641952-1-npiggin@gmail.com>
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

