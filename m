Return-Path: <SRS0=H68/=JM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D2C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Apr 2021 17:18:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9490A611AD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Apr 2021 17:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9490A611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FLmJy11b9z3bvm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Apr 2021 03:18:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FLmJb1XFdz2yRR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Apr 2021 03:18:20 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4FLmJV2HD4z9twp2;
 Thu, 15 Apr 2021 19:18:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id sbTtLwb0wT4h; Thu, 15 Apr 2021 19:18:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FLmJV1TDDz9twp0;
 Thu, 15 Apr 2021 19:18:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 080EE8B805;
 Thu, 15 Apr 2021 19:18:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0MknObgQkv_3; Thu, 15 Apr 2021 19:18:17 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B838C8B7F6;
 Thu, 15 Apr 2021 19:18:17 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 96B23679F6; Thu, 15 Apr 2021 17:18:17 +0000 (UTC)
Message-Id: <f41a177a0fd5a71db616e586a9ec5c51102c6656.1618506910.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1618506910.git.christophe.leroy@csgroup.eu>
References: <cover.1618506910.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 4/5] mm: ptdump: Support hugepd table entries
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Date: Thu, 15 Apr 2021 17:18:17 +0000 (UTC)
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Which hugepd, page table entries can be at any level
and can be of any size.

Add support for them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 mm/ptdump.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/ptdump.c b/mm/ptdump.c
index 61cd16afb1c8..6efdb8c15a7d 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -112,11 +112,24 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
 {
 	struct ptdump_state *st = walk->private;
 	pte_t val = ptep_get(pte);
+	unsigned long page_size = next - addr;
+	int level;
+
+	if (page_size >= PGDIR_SIZE)
+		level = 0;
+	else if (page_size >= P4D_SIZE)
+		level = 1;
+	else if (page_size >= PUD_SIZE)
+		level = 2;
+	else if (page_size >= PMD_SIZE)
+		level = 3;
+	else
+		level = 4;
 
 	if (st->effective_prot)
-		st->effective_prot(st, 4, pte_val(val));
+		st->effective_prot(st, level, pte_val(val));
 
-	st->note_page(st, addr, 4, pte_val(val), PAGE_SIZE);
+	st->note_page(st, addr, level, pte_val(val), page_size);
 
 	return 0;
 }
-- 
2.25.0

