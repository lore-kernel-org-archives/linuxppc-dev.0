Return-Path: <linuxppc-dev+bounces-18397-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F820107761C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 20:52:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbgy20Tn5z2ynC;
	Thu, 19 Mar 2026 07:52:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773867161;
	cv=none; b=EXatBHk/I4FkIQhviTvG59kQlp0MjgbF4c1s4ancuwvpxncYznj6aiVBQ0zmn/nhfCVLvIbE8eXuYmSRfhOtf80VwCM/3qhjPPyYsOGNQEU3EgdS6ZvPrFogpqjAgcFh/lxOJ4GownXhIXP1fhsOyWYrukoTZjeWKu74H+8e14I9VbSKWi02U4b/DcZnGip5I3x5oUmilkY0hQlVWdBPmvBhgs2IfDLEksznNKenZSMSe6XRV+tciiTVjVbNx2tRdJmKhZVTfLT5r8MMrirI0C5CkuU0kk9RVvpE1ySRLZpkV9tZSddEwje1Dc+lERVouIT4ecwWqTHk1xOlZ48A0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773867161; c=relaxed/relaxed;
	bh=v0KbAbSrDD+LwNPPQOnmwucCZsjcovNfZ7tqg9JQnkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqWRAz82kLohdUik5M4R+V4fEcv6mTBclkOAdATeSi+rBUXBJIv6Vle5ucSCakEzUGcerOPgW+iMz/dEoi6/GgTo86tZvJM2p9iuymFbLCfHaQO94b51+dVYnkjyTraY3dRicJ7G7x+eTHd2NUoGAnI5T6uh5oCUq5X82v58gvGI7my030TcldHETjxap01i8HtaeH6z8Kke58bPRTL5hYfEpTjZs/pL0eVK/zVtmyDcDc0U8GvwHLQlQwnIPfn3iSsHI3/K+MJJ6wp1gewxIx3OuxedDwK7f/7INsgQMDYECJqa4yccsriXlJdi7hYjc9LYa+WwkYPZsJ7CxAU5nQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k7zvu5MI; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k7zvu5MI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbgy06HSZz2ykf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 07:52:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D39D6011F;
	Wed, 18 Mar 2026 20:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF7BC19421;
	Wed, 18 Mar 2026 20:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773867157;
	bh=kbGM3c4xh2xtlPKItuu8b0plWdnAptUOEmkS13CYnz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7zvu5MIc5CYIGmjWx+P+mS8/hs2GooJWHfXhDPqFeWyum4sz6NQ2neYQyXlUtlCv
	 SOoz9lLS4EQYDGViVf0oRa8oUQ4wZWHCy5DjVMkrRZlzhDZfSxX8btIRC6pKKcZtqq
	 HqFvYKZdPu6NZcu/RPV8yxBpMtnFC8Ki3vcf/rOBJrcG5AcAzdMR2gnTomxyf7IP8H
	 zHZMPsz/wlq4Amx6dQtpM7EHwIuIilXwCtH35+nfGyIdYuPry8qYRVdyy1g3sS3ITk
	 esmcmpAq0Qm7xqoPTPtpTIaBIFFTr4xbzEGttviQsDf6G2SgDxhQSQi5C5yhB9KCwG
	 yOFQuYZFuGWzw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Larsson <andreas@gaisler.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Jackman <jackmanb@google.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rob Herring <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 9/8] memblock tests: add stubs required for free_reserved_area()
Date: Wed, 18 Mar 2026 22:52:21 +0200
Message-ID: <20260318205221.1402161-1-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318105827.1358927-1-rppt@kernel.org>
References: <20260318105827.1358927-1-rppt@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

After moving free_reserved_area() function to mm/memblock.c memblock
tests lack stubs for several functions and macros this function calls.

Add them.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 tools/include/linux/mm.h          |  1 +
 tools/testing/memblock/internal.h | 28 +++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index 028f3faf46e7..4407d8396108 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -17,6 +17,7 @@
 
 #define __va(x) ((void *)((unsigned long)(x)))
 #define __pa(x) ((unsigned long)(x))
+#define __pa_symbol(x) ((unsigned long)(x))
 
 #define pfn_to_page(pfn) ((void *)((pfn) * PAGE_SIZE))
 
diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index 009b97bbdd22..7ff61172ab24 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -11,9 +11,16 @@ static int memblock_debug = 1;
 
 #define pr_warn_ratelimited(fmt, ...)    printf(fmt, ##__VA_ARGS__)
 
+#define K(x) ((x) << (PAGE_SHIFT-10))
+
 bool mirrored_kernelcore = false;
 
 struct page {};
+static inline void *page_address(struct page *page)
+{
+	BUG();
+	return page;
+}
 
 void memblock_free_pages(unsigned long pfn, unsigned int order)
 {
@@ -23,10 +30,25 @@ static inline void accept_memory(phys_addr_t start, unsigned long size)
 {
 }
 
-static inline unsigned long free_reserved_area(void *start, void *end,
-					       int poison, const char *s)
+unsigned long free_reserved_area(void *start, void *end, int poison, const char *s);
+void free_reserved_page(struct page *page);
+
+static inline bool deferred_pages_enabled(void)
+{
+	return false;
+}
+
+#define for_each_valid_pfn(pfn, start_pfn, end_pfn)			 \
+	for ((pfn) = (start_pfn); (pfn) < (end_pfn); (pfn)++)
+
+static inline void *kasan_reset_tag(const void *addr)
+{
+	return (void *)addr;
+}
+
+static inline bool __is_kernel(unsigned long addr)
 {
-	return 0;
+	return false;
 }
 
 #endif
-- 
2.51.0


