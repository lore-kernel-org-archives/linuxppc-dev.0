Return-Path: <linuxppc-dev+bounces-19342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41386F3D5E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:54:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXVD61RQz2ypw;
	Sun, 05 Apr 2026 22:54:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393684;
	cv=none; b=Whe5UgGYF0UIpUaM9tzEWe8/t2yRmUUqRL/qoaZSS7SuJZBs51oNfSMP+UMXgMqJ4tnwN0uCkNoQMxI3ajSs5CJNGJhhaJRYFPyPl9ul1qpzgGzXilS71K9UtpsiT0MJYQrn2Ur9T+3nGb1F4dBeZVnJ66NyCaOuS9t7TKnz+9ynbJOE3SDs0OLHKMydjIWta8W7t6Lv0uGKP9mb2o2eFzsZItldZx2qGry+yXtGYOwULuAKsPtrGPo+jATMkjqMb8KBy478kVPt1gqnSDSU5x6jmhtfk3TUertGo17YR5RPHEY3pM4ign9fMW45eoL/cC1EigKjeoDYfAbX35q9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393684; c=relaxed/relaxed;
	bh=CpeyP/gKGQ3cmNpd3odA7JDcSLupYRRYiiUQtcwUonQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e0CWYgdp0XLP9smmkZRryV5TXkq4rHhrz9QR9L2LFEWEEswzvTrnJQL91QkZl4IfaRzXd0bblZKmZ+GoHAaijxVYKoegLswg7/wgUWfi08FcbRTpsA41JGx1x1SwvRN4dndj/NCBYvZ9XQPRs5RGQZ+v+4g+Zn5DlOMu6xkTLJx5ZGHDtiRNn4DsZyVRXVnhFBCNGmbabgzTQ3i+TH+FgWxuy/UKWoMBMG1srF5o507WXJzP4Pq1cdUxH7/QJtRe0S7I57QrJTIdQsO7FgHHRhgX3vtbkqBhdMY5AdQ4IQKc8tKK9TPL4PQvqUS9iOselIubZ0ltkWiHd3W6XTgMrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MFZccp+H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MFZccp+H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXVD0sXSz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:54:44 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso2357730a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393682; x=1775998482; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpeyP/gKGQ3cmNpd3odA7JDcSLupYRRYiiUQtcwUonQ=;
        b=MFZccp+HARwOPTMWDfU0otvcnHLxm46+foQ9KjvWUBD6tZK8G5L1pHNlGUYeJSCzAF
         YnZ7MCeqB49GLTTq8ddRlknxbsCCOX6qtgdpcKPYdCuRZUpdR9DXI0f6qkbM1nlN2DxC
         CXez3cn50AbjTcg2V1DqbJdCmJch78vNo42wkTVgRQdB5ha8fY9SNvBrB6v9hF0x0Rwm
         0UGyEGKWsEecIp5XsHwdcSMFgXasva7pKFYenr2CbwvL998ZSc22thSr74jUiDgHzQQw
         NiaxUzFiXHM0CeToL0ACWszp0M1JjyGtTUfhL2o1I3WKjjDpqBJZo0FbwUNYYeKfmQ7h
         wL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393682; x=1775998482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CpeyP/gKGQ3cmNpd3odA7JDcSLupYRRYiiUQtcwUonQ=;
        b=R056MeAmW1cidAL+YEoF/B+7jFc67JJJvUS2mcJh3AAOLiyf8BQfxMTOUj/X9FMOCP
         ld/SekKa6XCH/1GXRX1hTJRVRd8SMDjnWCP9yv531eHcvp53cOUyiG4AVG2xvPcAEvKq
         dChBl1kgcdFWFc6zzzLg88gsST2gAqVcPSBiUsgIDf5CFW1JWbLpZ6p0prbDGaTtExdb
         szuhr55+tCZI0DU6VtKIgVcRbArGKYCFAu0SAU/IwPHILQ3vFcYnd4E/nWdMe72hE3PP
         BqnHK7Ew5fX0nIi8pUxSLQ5OHtZncAlnr8C9kZWS5Bse4CZjQ+5ilsGBpiAhjCy0Co1/
         Kqug==
X-Forwarded-Encrypted: i=1; AJvYcCW0R5MBo554Z8ZWLboohgj8DXWWh9IhRjSuKjht0Hf7g750vRhP1+/dEenUf83iYY4g5AUIwUOM1kLQ+BU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyw6uc4717sTvrehwxlvLamFJ+B+bQueGzABvqjm7ElkwDliOOu
	Fq33nqmndUrvmVdtMIRWGy3vFlo0cje2CN+jSVm/anedjSqXP3QXLE+2RbM1jOZHb6A=
X-Gm-Gg: AeBDieugXnWSrAlIcg660BXrId6doTK1Y6nc2+R3/FyB7rBTacS2WRpT9UUPbfCtwsP
	mr52ZGohw1IOVHpDcQMByQIFCJX8H4zwvekmdr8KN/BNcU+pZ+8B0t4Zp2Ox5nMtd/NrA0ySl/A
	y/IonEIrjOVbQNHCmagYeqVsMAgKmwDH0Hie24w02b4CMHf3C4Xbpfx/pPyIlpyhvm32voL92dJ
	xQZ2pzJB9QJnJb4zbpTBBU1Ev6wvLVX1CfAba3MpGcYP71/vPQMY8IOS9L94c1gyMR8D6RfDznj
	HaFBvlWXE2gy/EYEpjx63Bmg00oCFKcibOPdS39XJ9iP2UpsgZxUdAdZM40CL5eOn4dPSfYEUbi
	nNwAFGZtFXVOSlauESZNEzvVWWn9ZG3R4/Tnc0JkxzTiDUAFFl/JY8Vh3MUuyh7VOo3qQBZv7mQ
	nYq+Bom4egx7n054fXK1USQeuUdvEJE5jMhKl0t27nY2g=
X-Received: by 2002:a17:90b:5583:b0:35c:d98:d684 with SMTP id 98e67ed59e1d1-35de67da865mr8258899a91.6.1775393682300;
        Sun, 05 Apr 2026 05:54:42 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:54:41 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 12/49] mm: make set_pageblock_order() static
Date: Sun,  5 Apr 2026 20:52:03 +0800
Message-Id: <20260405125240.2558577-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

Since set_pageblock_order() is only used in mm/mm_init.c now, make it
static and remove its declaration from mm/internal.h.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/internal.h | 1 -
 mm/mm_init.c  | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index d70075d0e788..8232084f0c5e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1437,7 +1437,6 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
         unsigned long, unsigned long);
 
-extern void set_pageblock_order(void);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 72604d02a853..64363f35ad0d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1489,7 +1489,7 @@ static inline void setup_usemap(struct zone *zone) {}
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
-void __init set_pageblock_order(void)
+static void __init set_pageblock_order(void)
 {
 	unsigned int order = PAGE_BLOCK_MAX_ORDER;
 
@@ -1515,7 +1515,7 @@ void __init set_pageblock_order(void)
  * include/linux/pageblock-flags.h for the values of pageblock_order based on
  * the kernel config
  */
-void __init set_pageblock_order(void)
+static inline void __init set_pageblock_order(void)
 {
 }
 
-- 
2.20.1


