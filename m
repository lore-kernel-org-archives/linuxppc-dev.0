Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61764606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYpj+ngS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvBd0rfMz30dj;
	Thu, 26 Nov 2026 22:16:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691801;
	cv=none; b=VGfMBQfNYYZQcJRpz0YhHaPnykWEHYtHEs5xO8p334t8vn9WtckR8K14nvUtuIndWxchhnFUM1vP+w0ioA7vuUn9ZA9nH9aVCEv616u1abr/jIa1Epn7mUjxlpBvvwZoeXqDgXVSctL6PUg9t46N40BmfHurMdUL8sB+2LPeY6/HG73eADpaesmVKzwp7esOHHaBY6CADL9qA8yxtoIEz0z3z4LOA3sUTt5p80YEn9i6b3/ErLuvd5nM5iy/ZsEQu4MOVVCPRjTcuWl2x/y5XQgsCzkPwm/LIVkwDMb1tzoub2mDXGbll2HQNS8bnJdw2+hXaQdzSZNYay0Oserwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691801; c=relaxed/relaxed;
	bh=JWC/vBALKCjgB3Vp7e+Dp/3jppLyPAzKiZgZB+giSqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AV/ZY/vJttDTIeiXhMnGibMcFWh9yPUEjUPDGqd/ZjOJnVipmU8Osw4X4wyPTqCuUW5pIHfrJ+VR2m+sfUn7z9/9UbZ8Dwdzjr5aYkjZoCwMSg/DWcfdljYUzOGJzPybEhLsx+a2tT8Kidj8sZTFjINRBFxc/I+hOt/PSOu8Vr3eouTa3Q6xxdiX1dYYQ+37IwLq0t7B67ppG/ArJvwQ6xp3Cl6kKkyfQbhpAJhSVG1mKwfbzQkqqZ9AI9RJnt25WhQJpdOi8sNR0KPjYyuNK0bG60B91cC2aUNVzLUkWqPk1vtsglh/ci4tUbcjnJqvejtyOvj4fFLZ1KmTnkVwpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYpj+ngS; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYpj+ngS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvBc286zz30Wg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:16:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5BFA643B55;
	Thu, 26 Nov 2026 11:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733D71F000C4;
	Thu, 26 Nov 2026 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691797;
	bh=JWC/vBALKCjgB3Vp7e+Dp/3jppLyPAzKiZgZB+giSqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aYpj+ngSiVFqOgPwkjKWlL43cMwZ+c5qm9pyvtLBv6pRVxFQz/EnGMvT3cqG60CKV
	 gp17gvtMKi2AUU8TijAS5yNkCTOTjH2Hcpzo5zl5CqJX4AX6FkoKmRtDnCuSFqV1Me
	 F5l2AWld4jnr12BgoJ/0hRgE9SX3p1+lkLsNAfVFhqEKgJ6rZL/qR7qp6M7cgLZYkA
	 cajyHtUCZrnpDkX20HptjbPShYFK0PskDHvCpXjIeQQYNmZuANQV5dGi67AmHknFT9
	 b0dh9ehw25xnd7VAFSRbYHeAn3Icdmn02VTQRbc8OoQpSYOJECww1+H2cR7XMAw8q2
	 JUPAaB2anngGA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:26 +0200
Subject: [PATCH RFC v2 13/54] x86/mm/pat: make the direct map counters
 atomic
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-13-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In update_page_count() pgd_lock protects only the direct map counters. The
splits and collapses in CPA update the counters under pgd_lock that they
hold for other reasons.

Make the counters atomic_long_t, like s390 and powerpc do, so that updating
them does not need pgd_lock.

A split checks that the counter of the large pages is not zero before it
decrements it. Use atomic_long_dec_if_positive() so that a concurrent
update cannot drive the counter below zero between the two.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 5e3c1152d202..8076d29a2931 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -84,56 +84,58 @@ static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 }
 
 #ifdef CONFIG_PROC_FS
-static unsigned long direct_pages_count[PG_LEVEL_NUM];
+static atomic_long_t direct_pages_count[PG_LEVEL_NUM];
 
 void update_page_count(int level, unsigned long pages)
 {
-	/* Protect against CPA */
-	guard(spinlock)(&pgd_lock);
-	direct_pages_count[level] += pages;
+	atomic_long_add(pages, &direct_pages_count[level]);
 }
 
 static void split_page_count(int level)
 {
-	if (direct_pages_count[level] == 0)
+	if (atomic_long_dec_if_positive(&direct_pages_count[level]) < 0)
 		return;
 
-	direct_pages_count[level]--;
 	if (system_state == SYSTEM_RUNNING) {
 		if (level == PG_LEVEL_2M)
 			count_vm_event(DIRECT_MAP_LEVEL2_SPLIT);
 		else if (level == PG_LEVEL_1G)
 			count_vm_event(DIRECT_MAP_LEVEL3_SPLIT);
 	}
-	direct_pages_count[level - 1] += PTRS_PER_PTE;
+	atomic_long_add(PTRS_PER_PTE, &direct_pages_count[level - 1]);
 }
 
 static void collapse_page_count(int level)
 {
-	direct_pages_count[level]++;
+	atomic_long_inc(&direct_pages_count[level]);
 	if (system_state == SYSTEM_RUNNING) {
 		if (level == PG_LEVEL_2M)
 			count_vm_event(DIRECT_MAP_LEVEL2_COLLAPSE);
 		else if (level == PG_LEVEL_1G)
 			count_vm_event(DIRECT_MAP_LEVEL3_COLLAPSE);
 	}
-	direct_pages_count[level - 1] -= PTRS_PER_PTE;
+	atomic_long_sub(PTRS_PER_PTE, &direct_pages_count[level - 1]);
+}
+
+static unsigned long direct_pages(int level)
+{
+	return atomic_long_read(&direct_pages_count[level]);
 }
 
 void arch_report_meminfo(struct seq_file *m)
 {
 	seq_printf(m, "DirectMap4k:    %8lu kB\n",
-			direct_pages_count[PG_LEVEL_4K] << 2);
+		   direct_pages(PG_LEVEL_4K) << 2);
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 	seq_printf(m, "DirectMap2M:    %8lu kB\n",
-			direct_pages_count[PG_LEVEL_2M] << 11);
+		   direct_pages(PG_LEVEL_2M) << 11);
 #else
 	seq_printf(m, "DirectMap4M:    %8lu kB\n",
-			direct_pages_count[PG_LEVEL_2M] << 12);
+		   direct_pages(PG_LEVEL_2M) << 12);
 #endif
 	if (direct_gbpages)
 		seq_printf(m, "DirectMap1G:    %8lu kB\n",
-			direct_pages_count[PG_LEVEL_1G] << 20);
+			   direct_pages(PG_LEVEL_1G) << 20);
 }
 #else
 static inline void split_page_count(int level) { }

-- 
2.53.0


