Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47390C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Oct 2021 13:07:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A751560E8F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Oct 2021 13:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A751560E8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hg5Sq1hMRz3c7f
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Oct 2021 00:07:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hg5SL42VKz2xtR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Oct 2021 00:07:12 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Hg5SF3GNPz9sSx;
 Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tvGwtnYp-lih; Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Hg5SF2TNVz9sSg;
 Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 419078B787;
 Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id eqfnO5qTU4i5; Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.217])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1353C8B763;
 Thu, 28 Oct 2021 15:07:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19SCxHHx195803
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Oct 2021 14:59:17 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19SCxFn5195802;
 Thu, 28 Oct 2021 14:59:15 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Don't provide __kernel_map_pages() without
 ARCH_SUPPORTS_DEBUG_PAGEALLOC
Date: Thu, 28 Oct 2021 14:59:15 +0200
Message-Id: <971b69739ff4746252e711a9845210465c023a9e.1635425947.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1635425954; l=1115; s=20211009;
 h=from:subject:message-id; bh=LxlwKSgR4iWA1DQx6k6WwBk3KZkX6hJQqb0HjweCiQg=;
 b=QFpxsaYfvyxKVMiy03gV7TAuhARS2grI6N6AL6sMRvnBlfWWD5yDEpCh4M+QgTXfhuhYFmhli2GY
 EG/egSvOAmreQ8Me0DTPHFr3LZqLYD7MLCsEX+PXLKdhmCafXxWs
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519;
 pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When ARCH_SUPPORTS_DEBUG_PAGEALLOC is not selected, the user can
still select CONFIG_DEBUG_PAGEALLOC in which case __kernel_map_pages()
is provided by mm/page_poison.c

So only define __kernel_map_pages() when both
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC and CONFIG_DEBUG_PAGEALLOC
are defined.

Fixes: 68b44f94d637 ("powerpc/booke: Disable STRICT_KERNEL_RWX, DEBUG_PAGEALLOC and KFENCE")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/pgtable_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index dcf5ecca19d9..fde1ed445ca4 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -173,7 +173,7 @@ void mark_rodata_ro(void)
 }
 #endif
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
+#if defined(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) && defined(CONFIG_DEBUG_PAGEALLOC)
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	unsigned long addr = (unsigned long)page_address(page);
-- 
2.31.1

