Return-Path: <linuxppc-dev+bounces-18343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5563103E163
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 10:58:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbQmy3nWXz2ygd;
	Wed, 18 Mar 2026 21:58:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773831538;
	cv=none; b=eBHOnjIZih3eZRTMmtt/es9QP+dHKcGzbTznbXigTc8BIGmrScfaN1TgjwQnY5VYRxlEOMkO3N5p9yG0mIutXyXnUC3SlIW7r4KNMeuqFPmriLuww9cvAEAGjTXCaAYF1ZM7WfR8OCfDoIizkgd1DIrCMfH9aaLOZTHvx7lKYGL7Ce8I9bvNCV16m6i9Zf/F0DOr7H/MuVhIFNuj44o7fjPOO/D933qZtxlG+erSqum5ODZC9ydMAQz1pj0Ah2ULIOV5JIL5Pg2BKcqT5DuqxqFJ9lngCBqvM/CdDk1yTglUDHknuqqP0nx+KtwEs0D718fUnU/Qx1cQm6eGUKvxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773831538; c=relaxed/relaxed;
	bh=UCYUk5kHzwVrneMFO2DR59QD+1jmDCykkPv1b8HhVv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkVK3CEqcKGXblDclqxsJSLNP7LQdmjMUypWWbw7c9MoCjRdcnThQscwMTyA8kI/3XWpMcj5wDuBSfI3d++nOIwdvzx7UgY4fnwjqJFyRtF/rzOPCAFDJBXvVD7wQLBL7CzmmWbIpRdcitgAADiE6naYQcMTdnEDm1pmMJpJ8IEZhXMKmc9kcXJmL5AQcxyh7B5pXa1GYL53bw8mVkNX0zpy8+4XJO3DnNQYcSeBtY6xGuNR8yPaCoBichQayAeKrvV5G2R/JwTtEB3RBnkGCY4sacqbKYjyfQ0tH2RGU3CeHAGtxWPmEEgfmnh/BMTNC8kRyJt5TNVuauaB0Km4DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pcCtAXo9; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pcCtAXo9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbQmx52MDz2xlx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 21:58:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A06A4474E;
	Wed, 18 Mar 2026 10:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C28CC19424;
	Wed, 18 Mar 2026 10:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773831532;
	bh=Xt2trVGOu+O7P4h2C+N66P7rMFK2F5qGGY0Nx9maAnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pcCtAXo9HFjeLmxxQDz1bWFGhGz3cgAlZqqVZqUib3biO4lA09lDRUAnvR7VPd8xK
	 xud5VSvoOVpP/uusVxy/mEj9ZPuFa9FBiEZXenJRIhcJDaFVEfdONJUF/a5DeLxg/6
	 9eJWF8V9iJtWLHumgV17GT6fy0gRDiS3mfXFa5ikPxnCcIM5ggnEsU6yokHlyO3U1v
	 z1M3PIiEZAT6J/8aMQ7R2ZMjIU13s+SJp+4B5zRJ5Z2M0LcqXMaYHaFCkfTXOiu6r5
	 wdkBq5ZN/Uu4ADC4SCCEps0JuPHvaJpv8CueQ5TFX51Ua5WHxeubzTq7aqhN6Hf77n
	 s2wD6ho9PQsRQ==
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
Subject: [PATCH 1/8] powerpc: fadump: pair alloc_pages_exact() with free_pages_exact()
Date: Wed, 18 Mar 2026 12:58:20 +0200
Message-ID: <20260318105827.1358927-2-rppt@kernel.org>
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

fadump allocates buffers with alloc_pages_exact(), but then marks them
as reserved and frees using free_reserved_area().

This is completely unnecessary and the pages allocated with
alloc_pages_exact() can be naturally freed with free_pages_exact().

Replace freeing of memory in fadump_free_buffer() with
free_pages_exact() and simplify allocation code so that it won't mark
allocated pages as reserved.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/powerpc/kernel/fadump.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4ebc333dd786..501d43bf18f3 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -775,24 +775,12 @@ void __init fadump_update_elfcore_header(char *bufp)
 
 static void *__init fadump_alloc_buffer(unsigned long size)
 {
-	unsigned long count, i;
-	struct page *page;
-	void *vaddr;
-
-	vaddr = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
-	if (!vaddr)
-		return NULL;
-
-	count = PAGE_ALIGN(size) / PAGE_SIZE;
-	page = virt_to_page(vaddr);
-	for (i = 0; i < count; i++)
-		mark_page_reserved(page + i);
-	return vaddr;
+	return  alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
 }
 
 static void fadump_free_buffer(unsigned long vaddr, unsigned long size)
 {
-	free_reserved_area((void *)vaddr, (void *)(vaddr + size), -1, NULL);
+	free_pages_exact((void *)vaddr, size);
 }
 
 s32 __init fadump_setup_cpu_notes_buf(u32 num_cpus)
-- 
2.51.0


