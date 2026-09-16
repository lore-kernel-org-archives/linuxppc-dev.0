Return-Path: <linuxppc-dev+bounces-27460-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FE3C88E5C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:44:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8Vw1rD6z30V6;
	Wed, 16 Sep 2026 16:44:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::1c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541048;
	cv=none; b=FZa4+mXRC2JS9x80QnJnp8nZ8SYAhwO/EYvzLB1rRhYhbpOpVZ7ayRYqDfEh0aM5BpkXY3ZP9WClWLir171v4gntcDApE2QV6Y1l2kUQrdNJdVlPisihCL/baD9MVoEXOxX8VfWCBthjpWq7jg/2HlubRw2YrcLg5YWS5IGEgNbvaOyRTpRXNGIuUrfJClej8u5f5oUtlqm27K8y+XcL9v6etQG5ZIal2HzrupCuW9BEOBvslgHLBdX8gFFerhYNuptS08UoSc0DiAj48K4vznltt5RwoZIAnBzIdRZnAJ4c3G+E9kM5yrIlCMMHwbfPLwqVRESrZts2x9W9KSVOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541048; c=relaxed/relaxed;
	bh=PDFzpc+a9bATnmd50P4M+vPlS8YdthhE8ho3W/sX1lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2G6FkGybKSRo3n9bEZp7xzt/k1BmxcHx65fFaulnVihfIsmctvJw/JHxzw8TtCYd1p1/hKLRF5WrLv77clbHYB8j3yFEWF6WVceqWsyO8jfHQX6RNfuVGJp5MpqjPnbCyUTTyqXOXH0j+GxfreaoCQf7nYCDWVjakd4ShGyH21AAigQv2kO6CZh7NtUAmjXyi2eH+pG8oTEZAy/VqRBcWU+itWHMddC89URDwxGfdwltWlV6K9h0VJjb74la5z8xsyMhawtThc+WkrETKrEEYpZyGGy56KPacgv+6uATEh5U8KkY/fqY0ZdtIFrHmaJ05Wkaj0K5QBkTmsnlTiVDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=j5WvjEvQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::1c; helo=mail-pj2-x1c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=j5WvjEvQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::1c; helo=mail-pj2-x1c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x1c.google.com (mail-pj2-x1c.google.com [IPv6:2607:f8b0:4864:39::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8Vv3JSBz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:44:07 +1000 (AEST)
Received: by mail-pj2-x1c.google.com with SMTP id d9443c01a7336-2dd77300816so1465735ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541045; x=1790145845; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PDFzpc+a9bATnmd50P4M+vPlS8YdthhE8ho3W/sX1lQ=;
        b=j5WvjEvQXiA6z9RvU9GLl4uHo2j+I7QEF+Hsukb2RoZD1YkanDhrvJjRC1kuAO2yfF
         zSIWDw3kSfAu8oqBF92+D6SADWa4YARe6GV6891k6AKQrecZttJGor3XktFBUs9w/14C
         yl6z8VhibRlK90Sqv61eftcGfVmrKRQsxw+PVtQtgmK9vW1HBjERgglPNyN3H+WkakUY
         uinPZzUxUeAm8FbFsmoac9XcuaqQODJhXUVjm0XbmHhuW1srmLiGvmtUFoYO1WvZBUSj
         iJqzaXcV8nNtKF41UzoNh0p9yVi4OqVIQ4zrjdkkgFbOMeG9kon6OV4FN/Gr6oCtg1M7
         MQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541045; x=1790145845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PDFzpc+a9bATnmd50P4M+vPlS8YdthhE8ho3W/sX1lQ=;
        b=mYvoeNZiwn2s/zxd7W94c95Z73oKis7w5Xg9G9CVavtjwWUPXunTZ2zrWov9hpLk8v
         9scj46f1eAJpW46Wn0stsKUD548XYkG8EB7i+Tmn29sXuLApeGmcYjCZLm0n4+Rdb3Jb
         F9P4ulzmULJcaITJk2tGskT8jbbMIXti2kXq2tnliHWJ2kfQNch8/hcvhYn+2Ras+ief
         dsSS2THSX0D0oGx/qKiDD+dMdM5Ql8phtwTXfZ0pTAKr2phXYTj2Nl2Bgn0dx6O3u57m
         WOTZVRxm3K2tPWefZ4z0RXlSlBL86weqRA89QzCrub1mg57hTuPRx/ShYsCk4aSQ+9iW
         LPxg==
X-Forwarded-Encrypted: i=1; AKwUvByqu1oxinSe1ucaI1/7nCvCNgsoKvzcUSKOHj5t/pc10AojMzRKl/Y4LCeHZgXrh4/A0pJUCWyDAxWHiH4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kux5gphoMo7Hji9PPVAVjrBg4QB4aKeUoxWrGUyjXX5KpgJhBC
	EzgUXX5IRRtK3qAUY0OKMY1M8YkVD7LdkDSdAnTRlH5lltU11E3kWRchRDBUfvmjYHY=
X-Gm-Gg: AYBFou2de4r1o74mHOmFmrSlsIL7h/qsdCYKxbe+70UblCQ8HQRQtlEMcDC5p43AUo3
	iTfiHlYYWcWbsIkRBBD4fU7jI9RaOZmAQ1SOdlkEm0Ews3tYGtzIv5PeAwm4XdShWH0x0CkNB00
	qKttfDBBOg+gNh2ygU41eZphdqL2i0+dYilxWAUTztGnAfV29SwJuOn1sBHh8YJ2OfoMXl0lXiq
	Ef+44osT6Kqsp2RSn8ZYJPHzu5+3HMyLysQ7fQMkRM2Vz6HtHpmRwm2LTMxeaPRNTHzFGC+B/Z6
	4xGyaAGO40H/6Pn9pxPV648fmXSx2A591zAa66cxRg0l9toC/sb1ngzatxBySsvgQAoNLKYN765
	QWbi/mgzyPleaaUEkEuWHC1p17D43ffhnvCYVB4qM4Hrl62/zVvtmyMv4Or1y7yI14tWhKFPyGy
	6HhwSxiChGXtVKoD3nHIuaL0mLsFpfDCmiOgTw0jWNXENToYplx1JgeWGn998jqofeKCm/KRLvm
	q9cfVwht2+3HEiziV8=
X-Received: by 2002:a17:903:3b8f:b0:2d7:4bc8:41a4 with SMTP id d9443c01a7336-2dd8ea1cd1dmr17328145ad.10.1789541045356;
        Tue, 15 Sep 2026 23:44:05 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:44:05 -0700 (PDT)
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
Subject: [PATCH v4 03/11] mm/sparse-vmemmap: open-code init_compound_tail()
Date: Wed, 16 Sep 2026 14:43:33 +0800
Message-ID: <20260916064341.1825793-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916064341.1825793-1-songmuchun@bytedance.com>
References: <20260916064341.1825793-1-songmuchun@bytedance.com>
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v4:
- Collect Acked-by from Mike Rapoport

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


