Return-Path: <linuxppc-dev+bounces-28296-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2656EC98328
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:55:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspvl2lHZz30Vs;
	Sun, 27 Sep 2026 12:55:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477715;
	cv=none; b=SX9tHlM+5l2UfpyzmoSYMbMdqq2bwdoXNjUfdFJ/HKP4TzmtYu6fI4rhVSJNT5pjfIsJNqOyIoi8yZjNXIJO8G0hJoRg/0reK468x61/oiAnhSr4PA3k/gZoRgvxGF1Z4ddZG3ehKIwmVyIENkGoXWcvM3mt1OI+TFD2939hosPViKOGrhwpDOV0IQZbpkJptSHiJpsAu9oVqfQcK7DbxwtnSqSrhreKvqo6SCh5YJN9ghxQSvXLt7eEtC6qMF5VAnA2X1x208Jz/7ctXd1eGePJ9ucEYHdBb+ojKUBN2Lvx4gycm1kuW3q0nTOvPPTquiMcnJUc8xOop99yKwxwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477715; c=relaxed/relaxed;
	bh=oPILxKtLMatcdEGLhusrMdFPdqn1uhqgdU3ISddJAJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3EMas5D3ooZhLKC0TI0WdxMqu9HSZMjiElQTqfTn0Qnyw4jueLnPUJNHqizg1jG0CUGM2EHyYGjQt7Si8CUPwVvItKtn4r/+8rGxyA5CgIO/fdAATs46Ux4X3NjjLRDLEFFqLa/a5W0vqTzzRHmPp8cvt7gFdBZGlTNOwI9iOXYFUmFlC0yNKoIK4+Wezn0kox+Xo5MhmaR6hKfTQFn7Cbexa7iQNw0atN3xoHlB1DlvwrX9VoWFhaYXNy5w7k3sO6fJCrk1FDSSVS3hTlmdfpPNI1Q08KrFRrC5CCmKj6la1tfYpKOT6N5a4DrB67pUiSwIagHhc1uCrTSm+Bu8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=k+JkDdCD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=k+JkDdCD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspvj0zRdz30Vr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:13 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so892028a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477711; x=1791082511; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPILxKtLMatcdEGLhusrMdFPdqn1uhqgdU3ISddJAJk=;
        b=k+JkDdCDsoB3j1MtsQpRZEuY1fhsJlQob2OwToh5icCAA1pgst9OxOZL5PItKBHLTr
         gs2kRG2dpN6gBAT7e5In0AUWiTZ0KXI4bidhyJVX5jy8WPmO+bFd857dUS1CKSj14VWe
         N8lMTCQULmKsAyTy+P/2vOyMtzrPyfm4OGJl+P/Abhak6Wl+b9o42oxlAz919NVI9bvZ
         9fJ38CWLEpWcDnRaoxiMczHtS0Nl08sncubWmWgOazNaINCrgk+MKwnY+xVQkmPl3UDa
         5CTlcVGoBjqLtDLd/fqezV2B4v+xGOjW5hdyvNvLRUcTKSs544ALiKSncmxDSD1Kv9fs
         XBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477711; x=1791082511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPILxKtLMatcdEGLhusrMdFPdqn1uhqgdU3ISddJAJk=;
        b=Nr3KocRy5da/cvqDhZmN+THY7RRYt85Yb7ZlULGWRoZ2ygSXZezZz+mvnYRwFeg6Zh
         AnalCLjvsOpFWW/Rt6j5mxl7QID8f9TOLVWwVV7eYbYH7i0SmdWYkgNJUapgNaA2FaZV
         XzWRCjcdlU8mlbWXttJZhE8Az+ieebf20gNk6ydQkocblF/T5bcZeW3ojfW02DjwtObV
         6f27K/JKYmDCpw6SmeoOhNOejVa2G6fUJeFdumqUFgxPiWQ2Ll3/CnC1DX+1hDDJl02s
         nYbucICbydKzirK/K4hd+eW/nzw42WtPQM7oh81VsCaG615BdNInWmbY1sNUQFF/6kUQ
         RU2Q==
X-Forwarded-Encrypted: i=1; AKwUvByUU2WrMbk7LJJ3naE4EGSRZGN/V51P3cDDS0gpRUIIzLf5MxHVvMk4qAGrtHEdYhrjFyZV+vPdJqbBa+4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKUfisnwn/rJHxki1E8cA+P1ePJzrfhyzRF0Tf61oRfNVg7taBM
	vAuJf6z2WGJpQY8tmanJvPB8CMbtuYCgR1BelHj8bEdjaSfnEjkWpPOLJ/d7MXKnsLg=
X-Gm-Gg: AYBFou3XOPs08q9eeCUyqtucHAw23MMhdop/5mafJeBWib/1ZcN5hXO8AFhGY/P3KD4
	BGCpaGRObFESETnA4JjkqnvRRUxyLSFdW70Hema2zgRhV5t6HpqS4HEAd1kYVM0xAbe2gj6IfxK
	vL03ggYmL4bjkQRc8TT39cen0yca46fRpL3rA3dnt0sYQT1nT32WA1CMM0whz5C0b5tU0Lsurvg
	JC/QRhx+JOkmq0+mLLsvE6rElY5UN/yfoZMMsjnUGQXlGrY1KXWnPATxUA3BaQ4V5MYr2kOQ9m/
	e3L+SpdoXwRsyvXw6p2pnQ9juvC9nxokNLOa/Q2TqvLe4XKdOEvAb0eytA/wQi3HStsoLv1js4m
	R2D6R4wBUsiQH8abH6E+JzK82Ra2M0+YgG8s1p9R2yBH1sQFPGuiVYE8fgscL+1CIyD/n3z3GyE
	WGX7d1YK0RuxEED1ZBY25B4hRuGnkYBm6i4VQxnYeyd4JjOzYpY+Ii5MperZ4fsepGJP7WRAiah
	mdCMJ34f1qhWZWRejBI
X-Received: by 2002:a17:90b:1807:b0:3a0:c8be:3227 with SMTP id 98e67ed59e1d1-3a0c8be4232mr4636947a91.13.1790477710866;
        Sat, 26 Sep 2026 19:55:10 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:10 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 04/12] mm/sparse-vmemmap: open-code init_compound_tail()
Date: Sun, 27 Sep 2026 10:54:33 +0800
Message-ID: <20260927025441.741633-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
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
index 38c36399f53e..e4dae98ba7f8 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -217,7 +217,10 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
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


