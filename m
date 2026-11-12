Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402E606A880
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JETWMfWj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQJ3r0zJGz3bZR;
	Thu, 12 Nov 2026 22:26:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794482760;
	cv=none; b=FtDsWUsIuiTFptncdOPW5p3ybqLZJ+8/Pby+E8H/8oJ3sDahLOG5w0QoGXXqvyzZEfa71vC4T1hhTeOSeSOmYKi/M2t/MFjTxmIG0/JkCkURBcM5M8SE6IXl9HJBq49N8e0XFxe9KNubB7zG8hziNAQA1Z2WiubWtwMb/Re3b/XSdj8Eqq0g3IQP44y5wZ+WB9Q6fQQsyyVs7R/tlBJdM8mym1mwsl2g57ZPvIMo3WTSPLugVYsjDt3UxpjW/0SwFQp5bixGZ02LUMJrRQB16RxzJWSgegLZcnRG/D607cOozao4VcN3Fn8curMdkyyobUrCo6q2izq96chpobPH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794482760; c=relaxed/relaxed;
	bh=FD/V4+e8O0iqTKVI3Ylc4RORwqMbtboEEa/TKhMeE7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNq9P5nfkcam484jK2R5mH43ER3r4pEcnnWEz8UnOBUcGl8ImW9VVrADVvZenG61CDwezrnrNjhDzENCkQBNvWnSUFLuOuEMhq9BpICZeB8d83vtWe+7UWteeOomp2oTNG0Yh0xpPrr68zx5PKy7jOZ9VX6KPdWSZaPNV+xS8iSWdu3qEGTpoZ7Qxc+TN1Ife2VLowlEE2wV8ghxqEsVbXsUWd/poVgDZLSB08zBp+Mh47QjSe9hpGSC8i07JmKyWVXRUBSbNhNL7kMenTF5fBdDMF7lkJ9a3pmTvXRQ8vfQS2N1Ql8IHe2IGCt+O+G/qBU9CU4prNYSxdmQmm692Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JETWMfWj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JETWMfWj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQJ3q2lJJz2ynW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 22:25:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1D21247A1E;
	Thu, 12 Nov 2026 11:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662A91F00A05;
	Thu, 12 Nov 2026 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482757;
	bh=FD/V4+e8O0iqTKVI3Ylc4RORwqMbtboEEa/TKhMeE7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JETWMfWjkKeINJWiPkhAD/QsItp30dH2rFFfUxvvsc0JyhM1taj1AERUtJ/N3Cjs3
	 AwYVFzZ/m6zQ7KYBU+YiTIl9hTHpftthT74h5Nr4oeuYEHYYSiIf3AXVs+RKZKKHrV
	 mIOmMwkG2K3nP1x7rGrbfTQKpZOVBqfxi9f/LcxqS5J0K6eBwmu7A8mogUZQyc4cgy
	 znPGEVxp9AgLlfDVNExZSLItcLclY123hZKVh9JoHVE3H6OQiccRm+Ibc4Tk7V2+rw
	 AM4h3/ZJfG+Yk80QegP3t50LRsE3vQEfEM9YcerbVpZJF++E9cU7QgrbnSemDfJFmG
	 qhJVBLKkuZ+CQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH v2 3/6] ARM: drop CONFIG_HIGHPTE support
Date: Thu, 12 Nov 2026 12:25:25 +0100
Message-ID: <20261112112528.1116405-4-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112528.1116405-1-arnd@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent a patch to drop HIGHPTE support on x86 today, see
https://lore.kernel.org/lkml/20241210144945.2325330-9-arnd@kernel.org/T/#u

If that one gets merged, we can merge this one instead of the one
that makes HIGHPTE depend on !PREEMPT_RT, but if we decide against
the x86 change, then we probably don't want this one either.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig               | 11 -----------
 arch/arm/include/asm/pgalloc.h |  8 +-------
 2 files changed, 1 insertion(+), 18 deletions(-)

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
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a17f01235c29..ef6cb3e6d179 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -85,18 +85,12 @@ pte_alloc_one_kernel(struct mm_struct *mm)
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
+	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
 	if (!pte)
 		return NULL;
 	if (!PageHighMem(pte))
-- 
2.53.0


