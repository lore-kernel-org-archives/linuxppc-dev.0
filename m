Return-Path: <linuxppc-dev+bounces-27187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A655CC88E56
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Sep 2026 08:40:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjMDk1JRqz2xft;
	Sun, 13 Sep 2026 18:40:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789288838;
	cv=none; b=Z8HHXWsV5tzC/6mIeYY2P7jGfDRx1CQbgaSTAI9x1UYIiJ0fcghEQ29ydfVXBEHXqgC9JnBxjkgd6Zl8v8EOukGEWB69DWPhgPVjGj0DalROzXHHHl3adjABmivqAGa+w5qTaCnTSM+HmLKtDemg7KUj3DaczAA7myYx2B1DwL+ksF9/39g87y7Juung1kC/enDveQANRTDCtK86VpDDNy1+HF9Ck4ABCKrRf82uYSy5S2uqZiYXjXxs9ALz//CDrzLyntIxQ3hAz264DQy7HurQNHX5Gj6zl2AYvl9H9t+pSuCENZtk8hAAyxZbT+VthYWr6vvKAIDp2zR1y2vYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789288838; c=relaxed/relaxed;
	bh=ZbLBsQvqBa0OuqffzZ60qrRN9YSSPX5HFZkA81JtLUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/DMlmg6y/ndtlrcBA0+prBWdIU32dMtNeAgHuJ+Ai3DpxToQPNZKYL6RfSuhuWQZ/phWHHlTWQfnzF3w70Bp3ySMLxedke1bP2db8uu1XHDyeaHXRXV8L2alarNG3fwWF6OTjfPcFbOsEw+XBLkac3EoqAxmjZzEXuOt3Qxobi2l7iVPf+FcTYPmtjy8k1Lr/QtsUm5SI3g55rlvxhgcyOff/I4g6eCHq1sqJdjWoUNeCebD5G/C+sSOqzWzW/6H+eb0fDJ3ccWvj7XAeW05ZIieAsdxKNm9T25T7byy0E3XyXCIRH+VNVivv2k2YtV/s4b3rH1H+2h8+grlllq9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Lx3d0jNC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Lx3d0jNC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0f.google.com (mail-pz2-x0f.google.com [IPv6:2607:f8b0:4864:3b::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjMDj2hzkz2xkr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 18:40:37 +1000 (AEST)
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-85469b2e1d7so971496b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789288835; x=1789893635; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZbLBsQvqBa0OuqffzZ60qrRN9YSSPX5HFZkA81JtLUU=;
        b=Lx3d0jNCn6KqB72j8AnGcYqQG7HWTuwv5JenDwAbGYY2dKf+irQxvG27SNpWECWhnv
         MnSrDu5J9arbqJ1A/DDrMrect4qoUZSnQkRxOmFDD0e660/9bDufj3BYs0KS2nWjyxeg
         b7SDGNsEgHGZ+JFcKhHyOkOocqAP3Z1M9pOR1RWjAIbjpX3pZMQIJIabUbKz95ri5/C4
         IphLsXivmnTQxpScsGZpFZKhkp1uxwV1nPWu0YVxVAL6Lvvr5sLsHF32SCyY7XzeoJdc
         g7FG+zW3kG8nggjvp7B++oNOKPTuWGE+iiSEdpbLoHWQ69m9duE+NLmN+mbpl+/adGaR
         08Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789288835; x=1789893635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZbLBsQvqBa0OuqffzZ60qrRN9YSSPX5HFZkA81JtLUU=;
        b=SoTwbTeZkN4eRMuj+JxmzyBOaPsVphlZ2pbl9ZxZAX1WUSFYWa7I2IUFVL4TzqD01e
         3lFcRwEdyFyGrJH33LYbUwGBwfLXlthvnwb8wdpFId72j5xJxHO9yxVChDIOCScTeJ9r
         ObqK2NOaU+i3MfDos5MwiLUcrVM9hv2RpbEPPfpqxl1Fa/Z0GB/oTW6ldXb0ctxTXWvV
         QNMF7n9e0vFJX2UQTYEMwiziyvHKQKj/STVlrV3MxCF8msBohWlbE//26HrlYp7TbTAL
         E4ZKppigc3MRB7LhcTPSk2y2q8uuTJIoZA2JZEwCWJ50ewx7UpGkRF+mHINihDCXwuJO
         f8rQ==
X-Forwarded-Encrypted: i=1; AKwUvBxq9ACnOrc7v86bbAxAdX7oISNliW3rPDpBM4L3+YoDi/on77A7dwztWPY/u0WNe2dZRnplTDp3XIJZDQE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nNJynKtzZYn82jWuLGjpbyUV8Hj7sB/B5Tgf+w86R74axPFCYm
	SOgaJ1Q5HTM+R85/GbnCuSPDYPXZgpcbJJTUjsk3hpNnyFsPELv9ou8/iOX8Djn8iYI=
X-Gm-Gg: AYBFou0LQrlrf/VqZa3gKooRxR4IyPla1qJ5yR7+AU2FdUFo2Uw+LdGnB4XVNRLzdtG
	O13V1cc+0awjDZAekhMZQ/ZlKeyBNVdZ7+22ChDh8sFx4ejMSG9Oy+AHdn96bXsoqjRGeXuHbrg
	vSsspVL5Dn0vgbenfzZ3riWPVZ93Ynifsd9SnHYUS+IyszH30sUoPltAzhSBB7TtBQnIMwVEHa7
	91PLOdvZNKrz8ZEnCmVo/EF+WYc5ThbaBwxH4bsqe4v6yZBXH6saU9GTP5H6LqixzVGVbk4uSTG
	5RvX1A4m8LL43MKkXFdK0eUEF6bIrX3LJYnUe0Q3CTXfWh460ms/cdPhWGBKxG4gIXXLmbawa97
	6m28CUZHxQxSe1nrxESwt7OH0CDXlE+X0RlpRRSdm+Wyvn+bp4Lui04VaAjwQfz1aZx5U9bWnMN
	okYsKEPAGZtfepNE0nxqMdb6JIKqBvppF3IqeLxhAQ7QCyUjsvLC5nXOb2AJHZolejUGJgLcrSa
	do8DFCoIra2LbIpZdrm0EfFg40l5mvW3Y0SwA==
X-Received: by 2002:a05:6a00:2d9f:b0:857:72ba:ff11 with SMTP id d2e1a72fcca58-86b34f095b3mr19117087b3a.25.1789288835163;
        Sun, 13 Sep 2026 01:40:35 -0700 (PDT)
Received: from G6L4RL2QG9 ([2409:8a00:1832:cf0:5137:990:100e:cc7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29cbb0d3sm3070531b3a.42.2026.09.13.01.40.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 01:40:34 -0700 (PDT)
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
Subject: [PATCH 2/6] mm/sparse-vmemmap: support device DAX in common vmemmap path
Date: Sun, 13 Sep 2026 16:37:30 +0800
Message-ID: <20260913083734.86802-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260913083734.86802-1-songmuchun@bytedance.com>
References: <20260913083734.86802-1-songmuchun@bytedance.com>
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

The common vmemmap population path cannot yet handle optimized Device DAX
mappings on its own. It uses pfn_to_zone() to find the shared tail page,
but Device DAX populates its vmemmap at runtime before the ZONE_DEVICE span
is initialized.

Teach the common path to use device_zone() for runtime optimized vmemmap
population while retaining pfn_to_zone() for early boot. This allows the
same path to support both early boot mappings and Device DAX.

The backing PFN supplied by the Device DAX-specific population path is no
longer used, allowing the redundant lookup and population code to be
removed later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 878d29a4e862..e83821768c12 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -208,18 +208,27 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
 	struct page *page;
 	const unsigned int order = pfn_to_section_compound_order(pfn);
 
-	/*
-	 * Device DAX still relies on vmemmap_populate_compound_pages() for
-	 * head/first-tail allocation and tail-page reuse.
-	 */
 	if (!vmemmap_optimizable_pfn(pfn))
 		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 
-	zone = pfn_to_zone(pfn, node);
+	/*
+	 * At runtime (slab available), only ZONE_DEVICE pages trigger vmemmap
+	 * optimization, so device_zone() suffices. Note that pfn_to_zone()
+	 * cannot be used at runtime because the zone span is not set up now.
+	 */
+	zone = slab_is_available() ? device_zone(node) : pfn_to_zone(pfn, node);
 	page = vmemmap_shared_tail_page(order, zone);
 	if (!page)
 		return NULL;
 
+	/*
+	 * When a PTE entry is freed, a free_pages() call occurs. This get_page()
+	 * pairs with put_page_testzero() on the freeing path. This can only occur
+	 * when slab is available.
+	 */
+	if (slab_is_available())
+		get_page(page);
+
 	return page_address(page);
 }
 
@@ -231,27 +240,12 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 
 	if (pte_none(ptep_get(pte))) {
 		pte_t entry;
+		void *p = vmemmap_alloc_pte(pfn, node, altmap);
 
-		if (ptpfn == (unsigned long)-1) {
-			void *p = vmemmap_alloc_pte(pfn, node, altmap);
-
-			if (!p)
-				return NULL;
-			ptpfn = PHYS_PFN(__pa(p));
-		} else {
-			/*
-			 * When a PTE/PMD entry is freed from the init_mm
-			 * there's a free_pages() call to this page allocated
-			 * above. Thus this get_page() is paired with the
-			 * put_page_testzero() on the freeing path.
-			 * This can only called by certain ZONE_DEVICE path,
-			 * and through vmemmap_populate_compound_pages() when
-			 * slab is available.
-			 */
-			if (slab_is_available())
-				get_page(pfn_to_page(ptpfn));
-		}
-		entry = pfn_pte(ptpfn, PAGE_KERNEL);
+		if (!p)
+			return NULL;
+
+		entry = pfn_pte(PHYS_PFN(__pa(p)), PAGE_KERNEL);
 		set_pte_at(&init_mm, addr, pte, entry);
 	} else if (WARN_ON_ONCE(vmemmap_optimizable_pfn(pfn)))
 		return NULL;
-- 
2.54.0


