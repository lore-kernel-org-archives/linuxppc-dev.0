Return-Path: <linuxppc-dev+bounces-27092-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F271C88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:03:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2WN20qwz2yqs;
	Fri, 11 Sep 2026 15:03:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103024;
	cv=none; b=AV+fxS+5x4thonDiormoi4nVMqP8gN0E/3D6GqjRYWnM24E32b27cjlhonm+k284wWgf9OBnhRWJig0mJOvuZZZkjfIQKD3s1mT4TfwYmExYp+wappw09zcjbrwFJQjFs1SLIdgJ9dF9qKLEwtoBuR7bsek2qP7l15F5Y+ZZmnwdvTtnrTrqa8er1QQr8IYfINJpBXXGKKt2t4ujpwP62oeUPeT40Lc/q/RVHDxrirpPTbeX2tKP2rvgYn+Z8a4G5QzXuXeH9SWT2o6vLV11cBB8236MQWY3PxVpajYjQb4VKHh8fNmVoFQtx/qT3a587EjzRGqb7u+fQu9pcZCqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103024; c=relaxed/relaxed;
	bh=otJyn0+LhJb8oZRc2DA2ivaMEPoP7qIjxigOuUE5KLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc5algwABSQdsCZk2ODQbcVB8s8Me1IsyHjoqyEnSjg19HXT+avloby76gqZtNEokv8PBMuqEthJSVdhpULTgr1nfJL7CMkdcpOadxttAiufgcQ6AzTCiJ/1n/o8bgvoXTMJSBlceGJVoAxHhDRgLpAJls2/LH9M2SvFfLnIf4rIS7upWnlp4NKYlUF4Cq9/gRrCv9uNVxWPtlLlAWfpjF8VpZ8Say8kcA082CcG022ByITFJ12+5ck7FOLegDUeEuhHn/2jsZSVIhQEh9xNU0+hVrbN95AO1HzuwRBNT8G35iD6P7zB9pZdfPOD0Y5Ig2p/zG5Qn5uLT60sz6h8bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eF/u9iRF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=eF/u9iRF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2WM49smz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:03:43 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so456042a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789103021; x=1789707821; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=otJyn0+LhJb8oZRc2DA2ivaMEPoP7qIjxigOuUE5KLU=;
        b=eF/u9iRFs7k5uWA7S7r5uhd6A3IzUy4+NFznShGpcmOPR/wBcSqhjxIhKrsX7xuJd3
         ePXPj/TQf3Mc3iMJ6rK02g1XJjsYlW3Lc1WCMQDVmuoip5leJfC52eB6pCqmSLQHA/Zf
         BG6TcCKeQcHM6nmOYmcWIA0TQMsgdfqxxwBwCdTuGbvOv3XBl/pe2jM4Mn+Rev06sCAc
         jaIgDvOaWurj1f8tUGhOPH7MCZVf2Crd124cYYprRpujOBEFLChAbdAXWn3xc7bwv/zA
         TKl82NQ+AnAU9zgVx/uOS+NpuHN5JJlWNeJ7ygFQJdk+pH+RM6SpXGn/ew70bwjtRVyz
         Tpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103021; x=1789707821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=otJyn0+LhJb8oZRc2DA2ivaMEPoP7qIjxigOuUE5KLU=;
        b=eIHxnGeEUHZlCpvXL8RadFjVbQdSkJpXgbI9Rtuf3za/yDnVdax7jdxAEgolulhZVb
         moq7uxmWG44EBQ5tGTGO2rhng1D3dYzm/HGEz8wIE4IRJvLsfBbu2MahQA+kiVh1FbHN
         How93XKeLZcx+/vyKiFSwjB+sDVpmg9ETpRAqucNPpG9D6PsqxhElJe0AQOCg3GGEjS7
         9O1lvTPEMol0KUGR+3+R9A/NBpCxQPOxDqRWl11wyVYluAoeJGg4ePQKpb+U0c4yaK9x
         S2k2JHlOmYgmmKYhMx9oluKwjRnJ5FfoWkbtWBCgjwiKOWrjX+T0MNxAq3vRuVT/7ib7
         /FZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXuWyuRLh4EIRM7i3wynOp2MqubJbj7LAmEGyt6/BYMg2BqHO/AiKWpyzNi6mTTnO9Pp9lQpjfkrQ2M4s=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ldQ+C3O6CNAUKrAK+/MleMLkg2+DHTRqcvp6urbzp7AIrc4yQE
	kR90SEEkeN/R8EAhL5TDsW+o1ksn2cHixkPtI2W06rbttUx2la59eHA28iJ/y23ncwA=
X-Gm-Gg: AYBFou12Pp9MDSI+OamjnHW918+cCdTWoTJFkj0APK9Jq0d66fGdIGl/fvtH1wUT7gj
	VP/nfuwJ7ejZgolL1Lf8zhOzOXEpNSu+Vg3SbjHu3Gi6OkLQ/grOri8B53/43zzKEMdaxaVvcOH
	z9WQiAkhIvJDmpqsF/IxiEUgSlzN0vuXgRaWiADECkzsxvVYFNXGM0XO4/5WODGOzLsD7+72Yjh
	nwv+s0pTFGW1213HsyRbng1K1sd+uEwqGVkaEyYBpnmJ3UQL/lN2/yxvbP3lCGw5UrBseegj+nS
	K4rFp4hHlg2g9F3QnNl77FVGbeNTpYki6dSljrhwGlCK7qkyy62YAF5dsGful7xyjpDy5E9S2yb
	SSaBihP0A4ZxLEjEaSbbny5hdcR2Hu4hCNjLW88I1FIXES/QqQ3QeZeiC9Gu+Wype0R7IGq3BFZ
	1SPqViOTzt9oT8Eh8go65MVHLuXsJ1gIgmsuswZCc77/Gq0qZCTGj9c49D7Bl+PgRaNp7oOLYVe
	qdFeRcaQ/6FpGeEVdpU8qW87XF3vhaZ+xh1Sw==
X-Received: by 2002:a17:90b:588d:b0:399:1f8b:d255 with SMTP id 98e67ed59e1d1-39d9bbc823fmr4102685a91.5.1789103021399;
        Thu, 10 Sep 2026 22:03:41 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2651561a91.14.2026.09.10.22.03.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 22:03:41 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 03/11] mm/sparse-vmemmap: open-code init_compound_tail()
Date: Fri, 11 Sep 2026 13:02:20 +0800
Message-ID: <20260911050228.58884-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260911050228.58884-1-songmuchun@bytedance.com>
References: <20260911050228.58884-1-songmuchun@bytedance.com>
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

init_compound_tail() is only used by vmemmap_shared_tail_page(), where
the shared tail page setup intentionally passes NULL as the compound head.

Keeping this helper in mm/internal.h exposes that special case to the rest
of the MM code and can make the NULL head argument look generally valid.
Open-code the initialization at the only call site so the special-case use
stays local to sparse vmemmap optimization.

No functional change intended.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v3:
- Collect Acked-by from David Hildenbrand

v2:
- Collect Acked-by from Qi Zheng
---
 mm/internal.h       | 9 ---------
 mm/sparse-vmemmap.c | 5 ++++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index da14c56fb24e..0dca33db068f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -786,15 +786,6 @@ static inline void prep_compound_tail(struct page *tail,
 	VM_WARN_ON_ONCE(tail->private);
 }
 
-static inline void init_compound_tail(struct page *tail,
-		const struct page *head, unsigned int order, struct zone *zone)
-{
-	atomic_set(&tail->_mapcount, -1);
-	set_page_node(tail, zone_to_nid(zone));
-	set_page_zone(tail, zone_idx(zone));
-	prep_compound_tail(tail, head, order);
-}
-
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 7388a5b5cce3..861e09b2b096 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -189,7 +189,10 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++) {
 		page = (struct page *)addr + i;
 		mm_zero_struct_page(page);
-		init_compound_tail(page, NULL, order, zone);
+		atomic_set(&page->_mapcount, -1);
+		set_page_node(page, zone_to_nid(zone));
+		set_page_zone(page, zone_idx(zone));
+		prep_compound_tail(page, NULL, order);
 	}
 
 	page = virt_to_page(addr);
-- 
2.54.0


