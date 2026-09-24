Return-Path: <linuxppc-dev+bounces-28103-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6281FC98314
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:58:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr5n81Sq6z30V1;
	Thu, 24 Sep 2026 17:58:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790236716;
	cv=none; b=XlQrhoxuBf2+6k1jr1RqgQZ5Y8/ktaxwxf6I9w3/tQ/Yq7oJdfVdt33sLmNrFubZKMlhUe6CVEQRIOw2zT+NEUyMXwqD8nr3yhZspupvDKOQWZBfExvQu1bxGoT6FxbT+oBWAP+FogF4SpLToyLT4mxYAOAx8wHxBuwjfNdfBSu1G7w8btZpnN6ak62K7fVFdze7DcSw+GMi8y/NfShhEHEtjUhROgswKaDVxfX7I5R1eUJff5RLDGnCwv9Nxjr+UrLdEPy2FMtf2Faep9AZMxewZ3Ht4EZe+IFzfcgUVw6JyOc0bYAYb5eAJPA3KC055EVO9FeBGYKMGqxOF3Mriw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790236716; c=relaxed/relaxed;
	bh=8r910VhEWgy1eIdXLPcYAHanh/sXYvzfGYAge0OSfUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKAYsms6WksbszMKN8vUna3hMHhZFQf4FYrIIUQzrpYS+ZznVXjWc+dQd+keGS07ZS41OeVEnSND7bP5ONKRQI7AkvT4hw+qegUjXS786TvQae3TYE/KGwuRmJIc6mbEKDkBx4CNVz+queEBzTyx0juRqnhDex/unahMG3imThngqqDFRgZ0j9/51BUDUMriB1D48iSbs2ojoBGUAhCuPjjLExxJZNjvwq5HPQRE5JzeN/4o48kcRGdwHkwTDjgVLYulYzpvRcCwtbN5nRkv5vgcAQzotroRHVM8BR9Sha5wPS85Fm+FQUoFnbcxX7vJOcteR3LcCLBh9fjDvmskAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dupU4XS4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dupU4XS4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr5n73Tmqz30Tf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:58:35 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-398a147688bso1292054a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790236714; x=1790841514; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8r910VhEWgy1eIdXLPcYAHanh/sXYvzfGYAge0OSfUc=;
        b=dupU4XS45/tUf05Ia6uTymMkSTC17LVevYYHBCx/yMuLnZDfUmKjMnHRS4hIUMv/Pf
         dZhaQ/ZS9s9r9VjqxdfszkF76S7BQbSdzJkFYTUfSNmMZecwXb2bBnauJZH8t4zcSYK9
         fxjFnqeqNxfW8rBtTPScUgZ/dionolxQqYP1SNLJHMkoqqgY6KOM/QSILd6u+kNoAyR/
         mY09SKCkff/Jipayt4XjSj8BzLvhzU/55gmHrc4iy0/1En7BD9Vd+BI6ivAVAzGMzB00
         7exCK76J503qf+a8YLD/bppoZvfsxMAcT5ki5jRloI1+8eVZ/ZQS0HavQWOG2euLyGqT
         bCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236714; x=1790841514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8r910VhEWgy1eIdXLPcYAHanh/sXYvzfGYAge0OSfUc=;
        b=t/+rfCS0ERZnilVzN2361rB67ZXnXa/JquQ25uDKNP4/92FDVecXA1m61zuf/uC2an
         WMQoFyam4d51PsSFEPqvN/UWVsLXb9jg2EBNZdtgHfK9C6k2sjMRYkqPWLQDV8Vwqo9N
         RV/XLvPNg9PmKPR3UOBBVXesvXa9cDi/GCW5ixhxdDovvScUwUqX2N6DAgseRnIYG5YJ
         oe4H/zLeTbes4CRb8XHBfpneFck4GCE3LiIBYCMOZ5IpWCupdbGfoR3MRbexPMFvQGfI
         2bGHpRgIMa+QulHmQwIsCWMfc2LPW8z26bIzb864SQ+IrQpbIR7tWgXnUyjlJWuVx8kO
         hg5A==
X-Forwarded-Encrypted: i=1; AKwUvBy7UY2HNgTpSKBd/lA6PGdQd8YQJ0ir739oVnpsc6Zj1aWxALoELygCIRORcVIu3d6Yaovd+CjpbFnUsJg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mU2D6GBv+gHVdeIwKoacfc1BFmj2igx67C3bqLc+kcs1VDZiOY
	eN7qVohDwN/nVyYVSt2AW+7EcBXSNJ1/bLhx2pfAAVEPjauJ2Tb360U7ZEPnjx3iRkDIILmsZfL
	N7SkXuOU=
X-Gm-Gg: AYBFou0VThIDo9xh2paSaVIhvxotBTRYbinRb/RHAu2iZ1Fj0o6seJDCOfrIKMLb3dJ
	qrFeS9RpHO7xAbFqeGtI60naWy10zz/qmQNMse6g7vFriEcsZq1fkzEyDC26QLy6B2abPc+BFwH
	wrb1v2+8WdFoB2MBChRSQdysYDMI71Nrqkdb1eP6diuuhhwzJGDxtzwMivrjlGV29momH9twvXm
	oCclkfvt3Rq5mI1i/DwUT3Gkx6XMd4Mk6JlZ9lRpySoGhBHNwR+qgPCq5elrkYKyw04qKzPPm3P
	yIcECLcWz0ChWylNHsHSjuqEg16p4SdqSDq/kWCMF5op3VT8diJLtVbGSjyXHslFEG6jL3W3BnP
	ygk6tn8KBjbUi/dz/rzoFsOLEe/98n5zmSEuODlnlYnCDeep0ZawsMDhkf0juqruDMA2S03IwY4
	zdfrg6JSUxOTFKZQkngL8DYJvXzhsyTRTiJTa8WsUCGr6hFLLHcigcaTfroGrpK6w93TcLHxM/b
	/02l9WCjaJzkOXLR7Y=
X-Received: by 2002:a17:90b:4fca:b0:3a0:910e:84aa with SMTP id 98e67ed59e1d1-3a098d45437mr1424739a91.12.1790236713758;
        Thu, 24 Sep 2026 00:58:33 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm3575622a91.7.2026.09.24.00.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:58:33 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v2 6/6] mm/mm_init: add zone mismatch warning during page init
Date: Thu, 24 Sep 2026 15:52:59 +0800
Message-ID: <20260924075259.2013039-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924075259.2013039-1-songmuchun@bytedance.com>
References: <20260924075259.2013039-1-songmuchun@bytedance.com>
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

For vmemmap-optimized sections, tail struct pages may be backed by
shared vmemmap pages. Those shared pages must carry the same page zone
ID as the struct pages initialized for the section.

Warn in __init_single_page() if the shared tail page has a different
page_zone_id(), which would indicate inconsistent initialization.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- New patch.
---
 mm/mm_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1650d6bc1211..bd02e8d06965 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -609,6 +609,9 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	if (!is_highmem_idx(zone))
 		set_page_address(page, __va(pfn << PAGE_SHIFT));
 #endif
+	VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)) &&
+			page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=
+			page_zone_id(page));
 }
 
 #ifdef CONFIG_NUMA
-- 
2.54.0


