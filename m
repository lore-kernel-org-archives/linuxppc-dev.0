Return-Path: <linuxppc-dev+bounces-18604-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84366EC01A0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:49:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQLP1ms1z2ygp;
	Mon, 23 Mar 2026 18:49:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252189;
	cv=none; b=kigUJt2QMyk7rkmT/Rf4ShYMA+kRDIqK3c0S2ZafC79MOHwTjZrhwuEhHu9ikJeeD14rkfaFOGmkhC8t66LsMOHCTlJfx4f+CptZJPCMiC3mu9ML0ZkMsxVeHdjaRvx5tM0WqqCLZTGi8uKHUS+A2in31lH3Roq5aoFlXf4E2PM0FFYQzGybDZI3KHYAbTF0DqqVTHC+HXPl5E1gg4Qg2LfzzJi8DT4Yh9Q4dx7ilHzxco9cdTTS+NVXWDKagMZBtmVuPZH0jfJEa4Yv/XMYM7V5Fwpnm4NeRPNNW8G1rsNqt3Bm3ag4UBKzwrgniw+e3Diwi5c5bDijXOH+oTm/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252189; c=relaxed/relaxed;
	bh=y36mYnn//4FrI2ubOkjWYg4TmngNW6rB3lI2di8xzT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niedrZJVCPx7oxx1CJ4GNqcfalHqfYwHT2VD8a2M2rhSm+iW3tsDnX1nSc5JDZ6wJpqH+NBGYPwbfRYI7RzGLEhthndOSfvn1azm2UZpclv0DkUvL00tHB3bCq8q6mni9otY5tP7fYaWeWlB+zilbeT+Fsw6gzyOsJE8vw7sb3OFUn/6d06tBWC2ODHB8l+b+967cbj5zf5gFbkNds6mVFeo88Hdu68VWtnvYxogqA2fhB/7Uxgx6ZyHM/MgFOcowMxpGZN6BPYtTyuu2K+pALQFGLB0N8llkCXzKrhSY6Ne6lIReKjLGmHVJrJ/ZeAPeTtw9NKA/HfoBBEnsln5jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ApW+Ttb+; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ApW+Ttb+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQLN3N5Hz2ygd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:49:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 68329600C4;
	Mon, 23 Mar 2026 07:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A752C4CEF7;
	Mon, 23 Mar 2026 07:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252186;
	bh=oTjYKF2HzgnTzfVt/T4KR/aYoXu0jvREAeLPVzJjchU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApW+Ttb+jFMzL2PVxO2byAuk+A4fmPJnMaO15oJq2IHN6Zecm4hgjhBgwx8npbKST
	 TGIhzz69K5K4pqQrfkuVb111Ir4KwV9TblQWUzh9dnGHx88hKymgGX1Jv2l7vvSHbM
	 eeOwB1tP4IvmYQA/ieHNVxEm4eqUCFiuavhCV8w4JZLIDlqV+RrBsQ6RutKPB1KiCx
	 CTJ9HkxBlgZ4IexKCBXnmCd9iYf4bnQmxV5OCKwv84oMEH+prH6i6fEMCUVPImpnIq
	 IFbjWI+qGUrIe7+ITN828go5miiQUt8iDKr+D1nvEix/c2fD9Fsz6E0RBqR/E2a1+7
	 j3bxw4hqbLsrw==
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
Subject: [PATCH v2 5/9] memblock: make free_reserved_area() more robust
Date: Mon, 23 Mar 2026 09:48:32 +0200
Message-ID: <20260323074836.3653702-6-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323074836.3653702-1-rppt@kernel.org>
References: <20260323074836.3653702-1-rppt@kernel.org>
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
index c0896efbee97..eb086724802a 100644
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
+	 * Use the address included in the range for the conversion and add
+	 * back 1 afterwards.
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
2.53.0


