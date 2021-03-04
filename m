Return-Path: <SRS0=6LlZ=IC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA330C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 03:28:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DD464EE9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 03:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DD464EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DrbtX1R3Mz3cZ2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 14:28:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=BCLF6YU2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=menglong8.dong@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=BCLF6YU2; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Drbt41zv8z30N8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Mar 2021 14:28:11 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id g4so18000494pgj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Mar 2021 19:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e3xu91cRIV/SXfMyzyfPmU5Jq21le4tYtNrxuGRlo1c=;
 b=BCLF6YU2zW5PPWyFmF0GQDr6gns9w0aOJf7Xoua98gHCgVFIvHrI0u3EPCqZaQX+qx
 rzxjIwNB9PpSnMbpdBLDl6QOhwp3TCzIzJKnJeL1mdx3i5MgtWph0mkQR4d0SzFd9RIH
 TM5GFUcCr3nb6yyjsehw7PoCJrSZE9vz8xvbkM6xVsVJNt70fMnMhJf0rvPy+eprRiRO
 Ty8PojI+HXP+87++2mkO7S0BuUWG/HTGlgF+0DB6TkLtmX1DcNO4Nzv7MQOH7Duy2ybV
 FxlLc1Yq9h94HVB1LjkL+9TeNDVE79JZpTMk/TMHnB/ECflauMR9BwOOgbZNzhiX4wde
 fMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e3xu91cRIV/SXfMyzyfPmU5Jq21le4tYtNrxuGRlo1c=;
 b=ZbA3XpSnsjhLPBykI/F5iIQ4eAgEouhXXXQ6vtee4Ld1HsXRDjHK45R3odQny5u3Av
 fkziGQz43X6hMA8j38SBdjYo/QbxKD4nCr1/NOMhfirYFP/yG/uWsIt3iDyDuMMAGfPa
 vfmNCAWnRqNYksNG/0tiec/t6IGFtbOntg/IHGQ7wF3LFdMdqU6IVQH7jVsGSVRQtYkm
 IxGnBMd1FZ7K0GVsq1Sw2qudHgfN/9cWMTAYKRewcU+NVTs05JhHs4spJuURw/vKwEk1
 k8kRqMJeED4ILbFVZUV41iRJFrTHXoQii+6xVU64hC0c3j9deiJg+22WrcMUSVbN5DLO
 j2/Q==
X-Gm-Message-State: AOAM533y2J+h6LNq7jbPP/xPdp5pekABu3eYcTrAw0KPnOpKYud5s1wF
 ERY2EjA/p/9Wsu4M5sOgUZ4=
X-Google-Smtp-Source: ABdhPJwgYvRgivD5INlHAqEJru61CzqBgBKpvNe5pZRxIE1sR7fqfZ2c9IEjdQKnv+x0UClZ8IJX5g==
X-Received: by 2002:a63:fe12:: with SMTP id p18mr1945747pgh.147.1614828487729; 
 Wed, 03 Mar 2021 19:28:07 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
 by smtp.gmail.com with ESMTPSA id g15sm25683091pfb.30.2021.03.03.19.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 19:28:07 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To: mpe@ellerman.id.au
Subject: [PATCH] arch/powerpc/include: remove duplicate include in pgtable.h
Date: Wed,  3 Mar 2021 19:28:00 -0800
Message-Id: <20210304032800.188897-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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
Cc: linux-kernel@vger.kernel.org, zhang.yunkai@zte.com.cn, paulus@samba.org,
 clg@kaod.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 rppt@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm/tlbflush.h' included in 'arch/powerpc/include/asm/pgtable.h'
is duplicated.It is also included in the 11th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/powerpc/include/asm/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 4eed82172e33..c6a676714f04 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -41,8 +41,6 @@ struct mm_struct;
 
 #ifndef __ASSEMBLY__
 
-#include <asm/tlbflush.h>
-
 /* Keep these as a macros to avoid include dependency mess */
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-- 
2.25.1

