Return-Path: <linuxppc-dev+bounces-18606-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DF9EC01A2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:50:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQLp6gVpz2yds;
	Mon, 23 Mar 2026 18:50:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252210;
	cv=none; b=NfIiWdggaPuAa1JuvtnlrZ6nWOf2D7IJBH3oserAN1MZNEZrHR4bLGqEbHBbfC3+daq8dsgL5FCa88l4qIVc57aHfEfnCw3WXCQfxJi2OF42RH+hBhyHA2ZihNzRuTaWWOvIyAufNCo2axMDdO23LPKYzQLe7BgfkuPM9R7CCF5uktxwdTrZLcuh5NE0oyjVI1hO/+rNJWsRlA6f04Pf+4mee/h7Jv02D1eyJGxjua5RsD483FQW0QrBIIS9mwGkUHhCsmRlZh67OBvVzaBN/Pr8zpNlpxQFL3GC4c8IiRS2OPx+Tt+XU879eKvWJ98QKTjxbkwrmT/YORzgnioFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252210; c=relaxed/relaxed;
	bh=FSrRbHdXi/ESSIllWcfDoe6S0Vd63YGulx1PIV/SCp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+q7bKJGHUAYsa5A16EMVPzyVgrCPSdNoVXfR/mHzeorei0F7LFl5IMRNlzyy3Yo1vECHhAdq3sT0xbCBr4dV5fc43Lf100ufD987EW3SX6VZGSM530qXvB2xZJy0UVb3l29FmRxXAkhqq3UODaIeFmrr+PzGM7rqs5AQ8Tbkh9Nn8jyrUJijOQUVZn1HXVGJ5d3EY5sFxc2MDOGhbCYI+X3lw8mhUMj5QDdyKNm6O7DBqasOc6dzaZRq5Gd3SyYr5UNto/NGYWyr6U6wuHOyv/OU36PKwchymLRtjJEgqjKPqJzQD6Z/EzJqRToLhwVSywAb7JV8BRI4vuyPXcgOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aWVLvFut; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aWVLvFut;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQLp1ZJpz2yfl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:50:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 857DB4061E;
	Mon, 23 Mar 2026 07:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBAEC4CEF7;
	Mon, 23 Mar 2026 07:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252208;
	bh=JX9RHWZi5vuFIJLodu0lHA5nrZZIkASHjFmUizN2RBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWVLvFut4f6MYN3wwvVgBsvFdFfwPxFVLIxEnZF2GAp0JQd7HON8/QxygCU2ypG3q
	 85RF6aLIrLIQls+Z9PC1N5+z9V63pBv8iSd7N325b75nqcJrfzheijh13oNYSPPUHF
	 7H4UTJH2FCWdxQJdQJ0moQ/robJ3B0VZTNpPoyjWFkZEoeQUN2laq6KQhmOmXfYL+r
	 ATjY+R2jtWYZYg2H6wmqiRgYcaDRVxYkBHUXg6eZ2dnlzyU+afaaq90pMJbntP0NXj
	 8kFILSXJOVGHQNzneF/T6HYv7O2tYy9lrUVFuGHfpzFLaD+zWwYbsaZr6rNdr5t1Nb
	 oKdXVBglapLiQ==
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
Subject: [PATCH v2 7/9] memblock: make free_reserved_area() update memblock if ARCH_KEEP_MEMBLOCK=y
Date: Mon, 23 Mar 2026 09:48:34 +0200
Message-ID: <20260323074836.3653702-8-rppt@kernel.org>
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

On architectures that keep memblock after boot, freeing of reserved memory
with free_reserved_area() is paired with an update of memblock arrays,
usually by a call to memblock_free().

Make free_reserved_area() directly update memblock.reserved when
ARCH_KEEP_MEMBLOCK is enabled.

Remove the now-redundant explicit memblock_free() call from
arm64::free_initmem() and the #ifdef CONFIG_ARCH_KEEP_MEMBLOCK block
from the generic free_initrd_mem().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/mm/init.c | 3 ---
 init/initramfs.c     | 7 -------
 mm/memblock.c        | 6 ++++++
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 96711b8578fd..07b17c708702 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -385,9 +385,6 @@ void free_initmem(void)
 	WARN_ON(!IS_ALIGNED((unsigned long)lm_init_begin, PAGE_SIZE));
 	WARN_ON(!IS_ALIGNED((unsigned long)lm_init_end, PAGE_SIZE));
 
-	/* Delete __init region from memblock.reserved. */
-	memblock_free(lm_init_begin, lm_init_end - lm_init_begin);
-
 	free_reserved_area(lm_init_begin, lm_init_end,
 			   POISON_FREE_INITMEM, "unused kernel");
 	/*
diff --git a/init/initramfs.c b/init/initramfs.c
index 139baed06589..bca0922b2850 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -652,13 +652,6 @@ void __init reserve_initrd_mem(void)
 
 void __weak __init free_initrd_mem(unsigned long start, unsigned long end)
 {
-#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
-	unsigned long aligned_start = ALIGN_DOWN(start, PAGE_SIZE);
-	unsigned long aligned_end = ALIGN(end, PAGE_SIZE);
-
-	memblock_free((void *)aligned_start, aligned_end - aligned_start);
-#endif
-
 	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
 			"initrd");
 }
diff --git a/mm/memblock.c b/mm/memblock.c
index ccdf3d225626..0ad968c2f2e8 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -942,6 +942,12 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 		end_pa = __pa(end - 1) + 1;
 	}
 
+	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
+		if (start_pa < end_pa)
+			memblock_remove_range(&memblock.reserved,
+					      start_pa, end_pa - start_pa);
+	}
+
 	pages = __free_reserved_area(start_pa, end_pa, poison);
 	if (pages && s)
 		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
-- 
2.53.0


