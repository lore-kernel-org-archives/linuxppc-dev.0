Return-Path: <linuxppc-dev+bounces-20858-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC76CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:08:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv0T0PJ8z2y2B;
	Wed, 13 May 2026 23:08:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677705;
	cv=none; b=JVHRzZvMNUO5eOEtQWz/ZEKfz5J/f7XIsaPL6yxHLRi0YF6TZxFseqvKbdvFPbm8qCwCvWdNSeRm+21HJvKWtdvkPERBELACXOJ2XtcVVxDadpzdxmZBiiYkC0igEyOh4c2tshF6CclxSUE9gntv4fBS6L/3QZRLc81rR67lFME3/Aq+AYIyUtmvjOA0a7vVOPh1eY7zRNGodoNOFOvrwFmWiEt2YKRAgupCTVOUpM4go4B46A4UcT3zTx1J+b5miPhyv1/uACDoSaYCtXmCYxOV0Scp749vvEtSpjfiZBGLKBIy/Bddmu/hXQ5P3FNKi49FMHjurMi2Ja5nl78stA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677705; c=relaxed/relaxed;
	bh=agVhcKOFJ9pAjcqZLpJ0s/37gKQkV6Sy+5Xwv4eBZ3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lT1nrWY8N2jksqOQ+yOi8/1ABDF+I/I7Ap4ldr4D+h1omf4CNLy4PVlu+URv2BNpzYxeAtnXeHYj4E3cUj2eXArWUROKLUyKPf9i7W2YRwNe38fyKPEqddk5+Rm/L7W81ZG/VXtPfUuyPMVY4k1FRWU2FqczPx6e5SUJS9fw9aEuOp0IdiT9S+JT/yzEEiRGMumvQf4w2tASOkBKpUPsF+Wke32JKVfnHQYr/N/u7SYFYkZx9YwfJM7EGAjGHPkMPPhkWZNoOE7iKLzAzS5freZy5pQqkxQdrpQrKC+rMiL/FYBLgD2+gXKU7xg2Iitg4cuA67x/wJrzTZLp55KKsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=De91V/AU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=De91V/AU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv0S2Xz5z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:08:24 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ba4efedbeaso47445155ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677702; x=1779282502; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agVhcKOFJ9pAjcqZLpJ0s/37gKQkV6Sy+5Xwv4eBZ3I=;
        b=De91V/AU9llw+DHQQKA34uh0J7za14EP03QRjxMNAtpX7rvRONXeqm+Rjv2IRfvjpK
         QN3DPNdZf50c8kRNmmUlOr1AJHR/o0xiNDl1W6LXpkRa76oGjPfOjTFaUa2Y5HIQSFvf
         0V6pWiwzR9Ws5DnAlvxHZXB7PaP4cZh3veJlc7V7dU8OqPDk8dHn3DNtxv6PP3QhYOyx
         yTB4kRDsSU9LgydmCM0xu79nhNBcu+5voJsOVezRp2T2/PgRaxIDlyX700FpcxbFImnX
         Vps5S0dWCCjudaRo1ZepFH3J/aG8oVwWiqRkHJW0+nmfUOnzL6LBPJP4n8/Apiwnl07l
         6HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677702; x=1779282502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=agVhcKOFJ9pAjcqZLpJ0s/37gKQkV6Sy+5Xwv4eBZ3I=;
        b=aPGpXyXATZwFLqqNneeEUnR0SRpKirSNXdlrABFjvWMcAN8DXSPHxQWxqyvSaHxibE
         MoPhdfJPRvy0+4J84aQNHFABECk+q6llmrDHX6ig4q41kwzHrIchvx9ixxHrFFONmzcr
         IfG/F3P3E6VF6nddCoOHg7ejDKefZ3ej/CKBs5b72UDH40N4n7sk0QDreDVEISqoOPP2
         8L+ix8ypbmsl6XWUmxZPpHWyyxsZKpJgRlF56HDqtZAhvy1R38IS25eUxV6WJ8RntJ+Z
         ee0PT58up9FusQokW9bc0d2tcFFzyneiGsMxRvzCGzvrDVNYqpoPt/H70IqE5vUMX2fR
         hsrg==
X-Forwarded-Encrypted: i=1; AFNElJ8hrBVsuYpbYhBdeDJGe2qb+VnDHwwJ4MvmBBgroAkIptqIpqaId8xHL2L61gN0mFkzJocgTdldXoTPoU8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwndvncEB6YHlrOA1o0t4IACqXP2Hs/luVnyv2xUXbWOPceLAnl
	r1LmANw1DG1CPPDIopxF7nE6/i9XYmtuZXvryIccXIPfDrsjzeasYEXyAJ0F68bQwR4=
X-Gm-Gg: Acq92OEJEHRUTQYk0BV4wEuHheB/WQNLibsvp65f7t0i3I0Wb6PYyDbX0FJgsnfHDQE
	74/m7HKPC/8WUJWtOz5aMhLkU8bl26lbJaEDYg30bd/zE0as48jl4tPFE9N6UCw5y4FNgOFJ6pd
	3Zuj4Kz4r5HzlpJ/3tz0yRs83te2j6MMHuHLjFWu6FscyvcULeil8iRz4/cqZLzEqQmICLQhx5D
	tvRLRRuVy8aB6UT5v+y2zENplgD4WwObagen8z6XrtnCX4nEkcIRYUS26n4/9AWFL+JmlfcTcO+
	pPbUPCD98npaq+ejCwMkrpqRuwX6t7SxgnfFcPxfRYmofZY5Z2zW1rLs4tvREevHSk6QtNardUn
	hUBvau4B7fovtAoCYx/oELNGvUZxpBte1yKP6J7ZcM/xm3BnVDXVsFjfVmlj23Y3DYMY3m67qd7
	PoxUe98oLPdLzSFhPob/ibwCFe0wz5P1i/9UOUCSIjU2hbGr+NBAGBOAmeJX8=
X-Received: by 2002:a17:903:120f:b0:2b2:eaec:c810 with SMTP id d9443c01a7336-2bd2f4f76c1mr29145735ad.8.1778677702439;
        Wed, 13 May 2026 06:08:22 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.08.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:08:22 -0700 (PDT)
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
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 09/69] mm/mm_init: Defer hugetlb reservation until after zone initialization
Date: Wed, 13 May 2026 21:04:37 +0800
Message-ID: <20260513130542.35604-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

hugetlb_cma_reserve() and hugetlb_bootmem_alloc() currently run before
free_area_init(), so HugeTLB reservation happens before zone state is
initialized.

Move the reservation step after free_area_init() so the relevant zone
information is available before HugeTLB reserves memory. This is needed
for later hugetlb changes that validate boot-time HugeTLB reservations
against zone boundaries.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mm_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index c14491c2dad3..75f98abfed97 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2688,11 +2688,11 @@ void __init mm_core_init_early(void)
 {
 	int nid;
 
+	free_area_init();
+
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 
-	free_area_init();
-
 	sparse_init();
 	for_each_node_state(nid, N_MEMORY)
 		sparse_vmemmap_init_nid_late(nid);
-- 
2.54.0


