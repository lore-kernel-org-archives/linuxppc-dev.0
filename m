Return-Path: <linuxppc-dev+bounces-18346-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40580103E160
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 10:59:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbQnc6rDwz2ygd;
	Wed, 18 Mar 2026 21:59:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773831572;
	cv=none; b=aIUPfHiXVumSzWOY2o2AZQPuqmhDnVmP6oCwL755iJJ1oc/sfJooj1i9NPAEQi0G7nFn3Rg7dHghg0UhWo0RxBcEsqFHRUQXamUmxv34wIsKOtJJ1zXDeX03jhNlDFq6nITAxVIGfxVrIixHQZLywFJUncx8cmM8U7hcJ0C8VUno+GEMYBo5KsTI7+coMk+nMLbhCwuK2pyBIxP3KM0oqP1tucbE+qwRvfngM+LjFR9hZM1Wint/YnVLl/oHkuRxD2LO2Zo72kCwOp9ubjLuFvPAe22t1tAy/eCQf2cT9z9DZ2qyYVVGoWfvwk5nD022zlNUQc6/TNlT298lDoHobg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773831572; c=relaxed/relaxed;
	bh=tCxMaYBsBxXFKDoyhHps/O9S/t9DBe65sUTVzz1X8nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNVnAmlOAUnpt5hAgtS9byx/Sk2775O/EU/lenflF4a5crrnjXlZAmZYJgQvVvdWxrjWDVPiGBmC5R0UhuNqYyfwJqa/WEwVXIo0z+Biz7pI0JLE5BPt1hsjACH2H6rBZnDJIACKO6HROGTK4N3QNW4sA6430bhQLtVVJwIpO4JcbH+CNhCQA+3IUX4ghsY+xQz/ZFcgej5iO9coc5276KJqaSWD7PzLrIkAx7XhDcBgksJSAbC1yEW4ewEA6/ljxCgxz1gh2N5yXB0b6rvNTcgCfKvKdEeYLO0cIe8gIYUeAiUPjjSbtJ6lDLMRk9wTYBq/+crVqGBxUDhOiI3QUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tiqHuDff; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tiqHuDff;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbQnc1F3xz2yTH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 21:59:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C1F6643BDC;
	Wed, 18 Mar 2026 10:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39407C2BCB9;
	Wed, 18 Mar 2026 10:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773831565;
	bh=EMwQwmstIDHc8FNs0QO2SlPHAkcDkrQ193OPS3fBl+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiqHuDff+jDdjfstb/ZYgq2TD5ZpMwcm65UNdvRfRBe8PAN3icqQumgjGf0jjMwOP
	 j4nc/ZDV4yAotyjkmHE/A3sTeQSiHgk4XGbx+8PnfOEVuotW+6DjC+n8FzEn0N07ex
	 xwVTZRvNHJmzO1cKw+KDDsxpa6ivmiuE4M/gWBYWIPYVlHgBT4kKgBSZEAuXMBjlX5
	 77Iul3JgDJt2CbM/2QFqakDPRN1MY9jKIxjxmHZ2w5mk+/6blf8d902eLpySGRS5tT
	 qwiMpZ1OvhQHOtEQggRNLvjuWaF43Qy6zBz0ESnJrIw7OmrwuwmUImSs2W6tHshrk1
	 mMgjbGI9FPdTg==
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
Subject: [PATCH 4/8] memblock: make free_reserved_area() more robust
Date: Wed, 18 Mar 2026 12:58:23 +0200
Message-ID: <20260318105827.1358927-5-rppt@kernel.org>
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

There are two potential problems in free_reserved_area():
* it may free a page with not-existent buddy page
* it may be passed a virtual address from an alias mapping that won't
  be properly translated by virt_to_page(), for example a symbol on arm64

While first issue is quite theoretical and the second one does not manifest
itself because all the callers do the right thing, it is easy to make
free_reserved_area() robust enough to avoid these potential issues.

Replace the loop by virtual address with a loop by pfn that uses
for_each_valid_pfn() and use __pa() or __pa_symbol() depending on the
virtual mapping alias to correctly determine the loop boundaries.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/memblock.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 8f3010dddc58..27d4c9889b59 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -895,21 +895,32 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
 
 unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
 {
-	void *pos;
-	unsigned long pages = 0;
+	phys_addr_t start_pa, end_pa;
+	unsigned long pages = 0, pfn;
 
-	start = (void *)PAGE_ALIGN((unsigned long)start);
-	end = (void *)((unsigned long)end & PAGE_MASK);
-	for (pos = start; pos < end; pos += PAGE_SIZE, pages++) {
-		struct page *page = virt_to_page(pos);
+	/*
+	 * end is the first address past the region and it may be beyond what
+	 * __pa() or __pa_symbol() can handle.
+	 * Use the address included in the range for the cnversion and add back
+	 * 1 afterwards.
+	 */
+	if (__is_kernel((unsigned long)start)) {
+		start_pa = __pa_symbol(start);
+		end_pa = __pa_symbol(end - 1) + 1;
+	} else {
+		start_pa = __pa(start);
+		end_pa = __pa(end - 1) + 1;
+	}
+
+	for_each_valid_pfn(pfn, PFN_UP(start_pa), PFN_DOWN(end_pa)) {
+		struct page *page = pfn_to_page(pfn);
 		void *direct_map_addr;
 
 		/*
-		 * 'direct_map_addr' might be different from 'pos'
-		 * because some architectures' virt_to_page()
-		 * work with aliases.  Getting the direct map
-		 * address ensures that we get a _writeable_
-		 * alias for the memset().
+		 * 'direct_map_addr' might be different from the kernel virtual
+		 * address because some architectures use aliases.
+		 * Going via physical address, pfn_to_page() and page_address()
+		 * ensures that we get a _writeable_ alias for the memset().
 		 */
 		direct_map_addr = page_address(page);
 		/*
@@ -921,6 +932,7 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 			memset(direct_map_addr, poison, PAGE_SIZE);
 
 		free_reserved_page(page);
+		pages++;
 	}
 
 	if (pages && s)
-- 
2.51.0


