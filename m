Return-Path: <SRS0=1zWh=L5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6BFC07E98
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Jul 2021 07:51:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCB86108B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Jul 2021 07:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCB86108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GJHth5Wn6z3bm2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Jul 2021 17:51:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GJHsw1sVyz301C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jul 2021 17:50:28 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4GJHsl0Px7z9tnN;
 Mon,  5 Jul 2021 09:50:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0sLBmX0R-WtU; Mon,  5 Jul 2021 09:50:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4GJHsh0jdTzBCfC;
 Mon,  5 Jul 2021 09:50:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BD7F58B77A;
 Mon,  5 Jul 2021 09:50:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GY_JyZTvt8Zw; Mon,  5 Jul 2021 09:50:15 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.103])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 99A248B763;
 Mon,  5 Jul 2021 09:50:15 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 94CD0663F7; Mon,  5 Jul 2021 07:50:15 +0000 (UTC)
Message-Id: <e2f80d052001155251bfe009c360d0c5d9242c6b.1625471053.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b864a92693ca8413ef0b19f0c12065c212899b6e.1625471053.git.christophe.leroy@csgroup.eu>
References: <b864a92693ca8413ef0b19f0c12065c212899b6e.1625471053.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 2/4] powerpc/ptdump: Remove unused 'page_size' parameter
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon,  5 Jul 2021 07:50:15 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

note_page_update_state() doesn't use page_size. Remove it.

Could also be removed to note_page() but as a following patch
will remove all current users of note_page(), just leave it as
is for now.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ptdump/ptdump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 349fd8fe173f..3eb8732641da 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -189,7 +189,7 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 }
 
 static void note_page_update_state(struct pg_state *st, unsigned long addr,
-				   unsigned int level, u64 val, unsigned long page_size)
+				   unsigned int level, u64 val)
 {
 	u64 flag = val & pg_level[level].mask;
 	u64 pa = val & PTE_RPN_MASK;
@@ -213,7 +213,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 	/* At first no level is set */
 	if (!st->level) {
 		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
-		note_page_update_state(st, addr, level, val, page_size);
+		note_page_update_state(st, addr, level, val);
 	/*
 	 * Dump the section of virtual memory when:
 	 *   - the PTE flags from one entry to the next differs.
@@ -242,7 +242,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		 * Address indicates we have passed the end of the
 		 * current section of virtual memory
 		 */
-		note_page_update_state(st, addr, level, val, page_size);
+		note_page_update_state(st, addr, level, val);
 	}
 }
 
-- 
2.25.0

