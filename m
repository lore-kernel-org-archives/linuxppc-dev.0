Return-Path: <SRS0=n4RZ=OS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473BFC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Sep 2021 07:17:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3F8611CA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Sep 2021 07:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F3F8611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJW736kJsz2yqC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Sep 2021 17:17:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJW5H1hvSz2yw0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2021 17:16:19 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HJW4z0rbjz9sY3;
 Tue, 28 Sep 2021 09:16:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NzRtLB4124gI; Tue, 28 Sep 2021 09:16:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HJW4w14HDz9sY1;
 Tue, 28 Sep 2021 09:16:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B9B48B774;
 Tue, 28 Sep 2021 09:16:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id BewMGGJ0kGtE; Tue, 28 Sep 2021 09:15:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.48])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A5BD48B770;
 Tue, 28 Sep 2021 09:15:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18S7Fnqa1452313
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Sep 2021 09:15:49 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18S7Fn3u1452312;
 Tue, 28 Sep 2021 09:15:49 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>, arnd@arndb.de
Subject: [PATCH v2 2/4] mm: Make generic arch_is_kernel_initmem_freed() do
 what it says
Date: Tue, 28 Sep 2021 09:15:35 +0200
Message-Id: <ec69cc95a98548c862c22b742936244fdb0c7984.1632813331.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <ffa99e8e91e756b081427b27e408f275b7d43df7.1632813331.git.christophe.leroy@csgroup.eu>
References: <ffa99e8e91e756b081427b27e408f275b7d43df7.1632813331.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 7a5da02de8d6 ("locking/lockdep: check for freed initmem in
static_obj()") added arch_is_kernel_initmem_freed() which is supposed
to report whether an object is part of already freed init memory.

For the time being, the generic version of arch_is_kernel_initmem_freed()
always reports 'false', allthough free_initmem() is generically called
on all architectures.

Therefore, change the generic version of arch_is_kernel_initmem_freed()
to check whether free_initmem() has been called. If so, then check
if a given address falls into init memory.

In order to use function init_section_contains(), the fonction is
moved at the end of asm-generic/section.h

Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Change to using the new SYSTEM_FREEING_INITMEM state
---
 include/asm-generic/sections.h | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d16302d3eb59..13f301239007 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -80,20 +80,6 @@ static inline int arch_is_kernel_data(unsigned long addr)
 }
 #endif
 
-/*
- * Check if an address is part of freed initmem. This is needed on architectures
- * with virt == phys kernel mapping, for code that wants to check if an address
- * is part of a static object within [_stext, _end]. After initmem is freed,
- * memory can be allocated from it, and such allocations would then have
- * addresses within the range [_stext, _end].
- */
-#ifndef arch_is_kernel_initmem_freed
-static inline int arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	return 0;
-}
-#endif
-
 /**
  * memory_contains - checks if an object is contained within a memory region
  * @begin: virtual address of the beginning of the memory region
@@ -172,4 +158,21 @@ static inline bool is_kernel_rodata(unsigned long addr)
 	       addr < (unsigned long)__end_rodata;
 }
 
+/*
+ * Check if an address is part of freed initmem. This is needed on architectures
+ * with virt == phys kernel mapping, for code that wants to check if an address
+ * is part of a static object within [_stext, _end]. After initmem is freed,
+ * memory can be allocated from it, and such allocations would then have
+ * addresses within the range [_stext, _end].
+ */
+#ifndef arch_is_kernel_initmem_freed
+static inline int arch_is_kernel_initmem_freed(unsigned long addr)
+{
+	if (system_state < SYSTEM_FREEING_INITMEM)
+		return 0;
+
+	return init_section_contains((void *)addr, 1);
+}
+#endif
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
-- 
2.31.1

