Return-Path: <linuxppc-dev+bounces-18601-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C4DEC01A2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:49:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQKl5Rt2z2yds;
	Mon, 23 Mar 2026 18:49:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252155;
	cv=none; b=LlbQmj51sUY3Qmk4xJjCbLy4HOp2tyrv+leGE+DOzesl90n4awGkQyLhAXwMYhDXlRGAtDrgLiod+UQQZorb2VtiQVQ2Nydn8FMQWJnJ4LZhHHHWzki/Nf1QoYMw1c5R874HdliNui4FeEBYzuHWgOzHvsl3G6BrWRw6YNFh0O/sEA5dVQ6bCT3yxnl0dwJkGUH2OF0ANGCyf2hw1Fp7PtjzkQa29N/tugxdOTR9I3Rv4ao6zE6A4sHWDaVc0bKzo/SUuPIro83ceix6c1c0oBXvwdFSkogUySz6KomUSNMCSiimlrC3lJXq8CdIOYLAtKCLRkH4lRq4lLaC9NpCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252155; c=relaxed/relaxed;
	bh=zXEwAxCB27G6g1WAOCaJemzlmGEpdOhhDvBG22lnTxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1xYZXePhkMqms29xMV+qMKzBL2JPAzMJCeax/5fYIWp5r3vBBW7qpHQ4ZKfNEkSFgVFw4rZGktm3wQh/QC4yVQJCosLXk+stwdRjE0TSZw8//qLkRXPcnTBd4FXe4YaQ+v2PgtBSm3oY1YmgjpqQihcHRLDbXj5mbVRhoeKMdUzCvvz7h0/p1sKMfAlTAv9/r71RJiZpFL12iGbowyGk8fzs2crU9k9mWLM4a/5SN3cYqvdoWyhTxXZ19VEzbMIp87uGM2i2vLP4TR9COB5xeZAEpE3vsjwBLM85CtDSoXPVE3PVULF7bx9XmYitN4XhnG0EN3RMHcYFxnU33pWxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mJkHNMOm; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mJkHNMOm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQKk60Pgz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:49:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 06A26600C4;
	Mon, 23 Mar 2026 07:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161B9C2BC9E;
	Mon, 23 Mar 2026 07:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252152;
	bh=IEszaCrFLo/Rs8yG7tIln7RmG7s5ArmJTUt7L+grDBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJkHNMOmwoIFLTcd31YucBrDfzfANQW+xkkREf7kQp1YDYI6vfV8/hVhcG3l8g/jK
	 sQngYeWtYhv0ZkW+8RpdtrXoti30446exi6Ju2/Ux3my4Q287Qpr4iWYaKli+PF0u9
	 vL/UiFYGZsmNZ4bQKMUXEy7AH5R6vF3zaUA3sbrcBu/WMLiPFtPcKLGomrzmqCTzqi
	 PwkOo9OAQEaeopupEyTaQ/a8bAo4WgnB6AuNb75FaxwKNBNMNqccFmqdvaop/ltQA0
	 aYjKEuyW1vof5rqfOJ6PkR20WHVtA+dub6QcUQQxq3ViDq6QsOyMq2uvJPowcDC5VL
	 AoERA5+OddeHw==
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
Subject: [PATCH v2 2/9] powerpc: fadump: pair alloc_pages_exact() with free_pages_exact()
Date: Mon, 23 Mar 2026 09:48:29 +0200
Message-ID: <20260323074836.3653702-3-rppt@kernel.org>
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
2.53.0


