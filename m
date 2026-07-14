Return-Path: <linuxppc-dev+bounces-24234-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0537C4450B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Mv2GJlz30BJ;
	Wed, 15 Jul 2026 00:07:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038043;
	cv=none; b=I6rRRErQpInUuQ6FW691rdiIZkzuvzg9e2GotxgEqQ+pmTPk19evKYxBbnbgW9Q4aG3YzIwSDv4XWiEKYHXqCFM68cX6H+OQvlCSIe+72Cfph3pdC+oNO0cIQDWGXcNabceRylOK8am6T03ssxEvJDIQYvK5KI9YXKUgqveLwNCDzQl4EP/IOZ90sJQegEsd+m1D/JG/rgylCeYYBGIr5ae2hQuUIJ4JZPtMS99RbUTzW3ndQenbWfUhJCBZdm0sEdPLw/4qVk7rkWWBuzsswWdaNbKuo4egBHo3GCLriFk0d3jplrqBzFUkFAZcAdC6sAdXdVvaDDT3HdsIOIanEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038043; c=relaxed/relaxed;
	bh=q94qKUmqqfiS4paWyf1M/XhTiz69R/ac7pRDBBb2HYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcAi85oF3qqqx2K049DkHO4BKYETQZJVP5NcxPsNdqA/hwRfK47I5DI1juYZV7lCqSmR7c+X47OwsA0W/USlfsqYtmaatScINIqOzxRLD+C1NzBgOR6SRHfos/OEX5sB3S0avsxqQDicj+MqHQcKi8XlaojqnejjKBvkjZgSPChk4QaQ/dk/DC2hwCLzApLBsfERJH817W6VyBMPfUHftVG7XEA9AiOd4sraJetGgPb2p656stbMTIz1xNONd5cvstgcfomzh9vZS7urA/uJ6Bdns/HteLDRcLlXfz8SjS8z5nL/FnIUwdpx7VeX1QrtCTuBmJhr98yrtc/9mTbutA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GMJ+Mweg; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GMJ+Mweg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Mt0PBnz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:07:22 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 648F91C01;
	Tue, 14 Jul 2026 07:06:46 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3991D3F7B4;
	Tue, 14 Jul 2026 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038010; bh=xWTuMpf6qcthpUhdZ9Vhm6UlW2cWk5z6914Plajhwho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GMJ+Mweg4iK/hY2NAgr6zHJe6LPOAI5rsbTNiAYQyxWefiCu+6VoxAQ21IJMDkVx+
	 ivh2GnjSQemn2gdz2SposUZ6wFQonR0LDcZWwnq1rZX1jAwRhXlTvacd46t1gd3VoM
	 7DeK6ToDs/ry10Z8LOV9mjtgQLtlBMud0j8fDq/U=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:02 +0100
Subject: [PATCH 13/22] mm: account page table pages when allocated
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-13-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>, 
 x86@kernel.org, tboot-devel@lists.sourceforge.net, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
 Vishal Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=2350;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=xWTuMpf6qcthpUhdZ9Vhm6UlW2cWk5z6914Plajhwho=;
 b=Xnk+oBg7ELc/ZeSLJzK7tAUlR2bpnh9Zc229tTiVuKMeFbivMucrP27RTRDStMzPBnxxJrXcn
 geH5EZLthaDBgWisWH5/sH0N2po6PG3n0k30stRCmsudF2ar5ckSV8d
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

As a step towards removing pagetable ctor/dtor calls for kernel
mm's, move the memory accounting from the ctor/dtor to
pagetable_{alloc,free}.

The ctor is normally called after pagetable_alloc() (and dtor before
pagetable_free()) so this patch should have no functional effect in
most cases. Where calls to ctor/dtor are currently missing (e.g.
x86's split_large_page()), this patch should improve the accounting.

This patch is based on Matthew's earlier implementation linked
below, with the difference that when freeing the accounting is
updated in __pagetable_free(), meaning that the update is delayed
until the pages are actually freed in the
CONFIG_ASYNC_KERNEL_PGTABLE_FREE case. This shouldn't matter in
practice.

Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Link: https://lore.kernel.org/r/20251113140448.1814860-3-willy@infradead.org
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b336eb32faa0..361a0d7b74c5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3681,6 +3681,11 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
 {
 	struct page *page = alloc_pages_noprof(gfp | __GFP_COMP, order);
 
+	if (!page)
+		return NULL;
+
+	lruvec_stat_add_folio(page_folio(page), NR_PAGETABLE);
+
 	return page_ptdesc(page);
 }
 #define pagetable_alloc(...)	alloc_hooks(pagetable_alloc_noprof(__VA_ARGS__))
@@ -3689,6 +3694,8 @@ static inline void __pagetable_free(struct ptdesc *pt)
 {
 	struct page *page = ptdesc_page(pt);
 
+	lruvec_stat_sub_folio(page_folio(page), NR_PAGETABLE);
+
 	__free_pages(page, compound_order(page));
 }
 
@@ -3797,7 +3804,6 @@ static inline void __pagetable_ctor(struct ptdesc *ptdesc)
 	struct folio *folio = ptdesc_folio(ptdesc);
 
 	__folio_set_pgtable(folio);
-	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 }
 
 static inline void pagetable_dtor(struct ptdesc *ptdesc)
@@ -3806,7 +3812,6 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
 
 	ptlock_free(ptdesc);
 	__folio_clear_pgtable(folio);
-	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
 static inline void pagetable_dtor_free(struct ptdesc *ptdesc)

-- 
2.51.2


