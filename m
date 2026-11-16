Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A0606A330
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFzBs088
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSnjj0pJgz2yYY;
	Mon, 16 Nov 2026 23:48:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794833337;
	cv=none; b=gQfMP0UiQ11KwnIbkOa2qeTgGdv9Nz0UY6F4FQwc5DD60ek2rrdyvhnBEZal/cB7v02SSBI+kR7YIs6MabbdVgYnsggNtKNgIMewXWpaWpHZyZu9i4fqEk1wjIj/w8cDflUYrdkUOUVzIf3czlQdtSGw/8YxLcnGJ1mLndqSVDm/NR8CXrGSgLI3uv745/0d5lIwK3Lx5jl8JGBlCmqHBF0VxZq/sgVthNbE36Yqcj2csICOJ5qQcKD0zv081iugITBL2RR/rsUV7IGoutDXWorYJMBrhDdWHYQQKOc3AtIxGCE9aGVyspLGZT8WyaRlr/pD7SO/1qmGUQzwyFl/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794833337; c=relaxed/relaxed;
	bh=D3qZ4d2EoZJBj/rnIT9ZqfnQg+sRwjETd54Rn6zh5+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFBVWOeVGlnruPn82zZPx8h0yQBcHqC5gi/OuNeRqzzf/AL5g83LlGyhjkGYUIOxP9VlxBSn8d6tZPH7i/1N/8hYi1RzHNH7vv1Vy1/8T40C8aVMsGpD0/ySnlgNUxJUipSHtcojf84puWsIYq9858eDqs3c4VTKRrcPHJ/8D6u09k58DPItKYHp3V3L3UM/Qd6/gy2KkualKyXCyx8r0BjxITfsVkbw/qbBqe1yMMuAyhFo6Bp3E/DUWWecI5zgQoKWb3E/Kjd8HnyesLSBwkt27zF3Gzvhd6WJHGxG9RLg9CTsbZoRVhNnHEgWlTheK+FvKcvmUD/kH9CqlNLekw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFzBs088; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFzBs088;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSnjh2333z2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 23:48:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C114A6232C;
	Mon, 16 Nov 2026 12:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC6A1F000CB;
	Mon, 16 Nov 2026 12:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833333;
	bh=D3qZ4d2EoZJBj/rnIT9ZqfnQg+sRwjETd54Rn6zh5+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fFzBs088shoTy3rQRvERnUcPbLSDcUJs3516Kbm99pGIrHAGI+mzI+Fjroy1FZoRR
	 SLSxvUR24Ur9ZMnFUaeM6262CXVoWN+NN6FX3EIesA4PFthJY3GJ963+oBQQcnI5+X
	 CxF7nKZzUvWmnMkXLlJ9xJTVUsMKwtlsaRKBJYfJqHGajc8KhKS8Zw151NxBITLk11
	 3f3u+37vYLIpx96RN2dwX3SMGSQ8S06BuVxY5BqJzeFXIzW4GspoVOEMp6v36vSW7x
	 txORGSJshkejNfxqwzDAw5iWblqJrgB37F54/PpRUDzR1w8ESpUpWt/STu40kxByij
	 vtGN4WXjhlbeQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linusw@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH v3 02/10] ARM: drop CONFIG_HIGHPTE support
Date: Mon, 16 Nov 2026 13:48:24 +0100
Message-ID: <20261116124832.662455-3-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116124832.662455-1-arnd@kernel.org>
References: <20261116124832.662455-1-arnd@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
support. At the time it made sense, as the CONFIG_ARM_LPAE option allowed
systems with 16GB of memory that made lowmem a particularly scarce
resource, and the HIGHPTE implementation gave feature parity with 32-bit
x86 and frv machines.

Since Arm is the last architecture remaining that uses this, and almost
no 32-bit machines support more than 4GB of RAM, the cost of continuing
to maintain HIGHPTE seems unjustified, so remove it here to allow
simplifying the generic page table handling.

Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kernel.org/T/#u
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                        | 11 -----------
 arch/arm/configs/vt8500_v6_v7_defconfig |  1 -
 arch/arm/include/asm/pgalloc.h          | 13 +++----------
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fd01ccab9c12..fc66d52d847e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1225,17 +1225,6 @@ config HIGHMEM
 
 	  If unsure, say n.
 
-config HIGHPTE
-	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
-	depends on HIGHMEM && !PREEMPT_RT
-	default y
-	help
-	  The VM uses one page of physical memory for each page table.
-	  For systems with a lot of processes, this can use a lot of
-	  precious low memory, eventually leading to low memory being
-	  consumed by page tables.  Setting this option will allow
-	  user-space 2nd level page tables to reside in high memory.
-
 config ARM_PAN
 	bool "Enable privileged no-access"
 	depends on MMU
diff --git a/arch/arm/configs/vt8500_v6_v7_defconfig b/arch/arm/configs/vt8500_v6_v7_defconfig
index 2925a1f1dbb6..33a81c5a84d0 100644
--- a/arch/arm/configs/vt8500_v6_v7_defconfig
+++ b/arch/arm/configs/vt8500_v6_v7_defconfig
@@ -9,7 +9,6 @@ CONFIG_ARM_ERRATA_754322=y
 CONFIG_ARM_ERRATA_775420=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_HIGHMEM=y
-CONFIG_HIGHPTE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a17f01235c29..b01d817fecf3 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -85,22 +85,15 @@ pte_alloc_one_kernel(struct mm_struct *mm)
 	return pte;
 }
 
-#ifdef CONFIG_HIGHPTE
-#define PGTABLE_HIGHMEM __GFP_HIGHMEM
-#else
-#define PGTABLE_HIGHMEM 0
-#endif
-
 static inline pgtable_t
 pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
 
-	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
-	if (!pte)
-		return NULL;
-	if (!PageHighMem(pte))
+	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
+	if (pte)
 		clean_pte_table(page_address(pte));
+
 	return pte;
 }
 
-- 
2.53.0


