Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7B2C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 18:01:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1ECA20672
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 18:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ECA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438V6d5mJ3zDqP0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 05:01:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438V495cc6zDqMT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 04:59:21 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 438V422wnbz9v1Yw;
 Tue,  4 Dec 2018 18:59:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qeA9z__LMyWg; Tue,  4 Dec 2018 18:59:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 438V422RVrz9v1Yl;
 Tue,  4 Dec 2018 18:59:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 08DE98B823;
 Tue,  4 Dec 2018 18:59:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id HgzQme1QY8cS; Tue,  4 Dec 2018 18:59:15 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C4CCB8B800;
 Tue,  4 Dec 2018 18:59:15 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6AEFE6BF63; Tue,  4 Dec 2018 17:59:15 +0000 (UTC)
Message-Id: <b5b092b3ed537d9d71e0f8763ccd045da05ef40e.1543912653.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: remove remaining bits from CONFIG_APUS
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  4 Dec 2018 17:59:15 +0000 (UTC)
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

commit f21f49ea639a ("[POWERPC] Remove the dregs of APUS support from
arch/powerpc") removed CONFIG_APUS, but forgot to remove the logic
which adapts tophys() and tovirt() for it.

This patch removes the last stale pieces.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ppc_asm.h | 19 ++-----------------
 arch/powerpc/kernel/vmlinux.lds.S  |  6 ------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index b5d023680801..378432995eb7 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -480,26 +480,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	ori	rd,rd,((KERNELBASE>>48)&0xFFFF);\
 	rotldi	rd,rd,48
 #else
-/*
- * On APUS (Amiga PowerPC cpu upgrade board), we don't know the
- * physical base address of RAM at compile time.
- */
 #define toreal(rd)	tophys(rd,rd)
 #define fromreal(rd)	tovirt(rd,rd)
 
-#define tophys(rd,rs)				\
-0:	addis	rd,rs,-PAGE_OFFSET@h;		\
-	.section ".vtop_fixup","aw";		\
-	.align  1;				\
-	.long   0b;				\
-	.previous
-
-#define tovirt(rd,rs)				\
-0:	addis	rd,rs,PAGE_OFFSET@h;		\
-	.section ".ptov_fixup","aw";		\
-	.align  1;				\
-	.long   0b;				\
-	.previous
+#define tophys(rd, rs)	addis	rd, rs, -PAGE_OFFSET@h
+#define tovirt(rd, rs)	addis	rd, rs, PAGE_OFFSET@h
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index d210dcfe915a..c133732e529a 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -203,12 +203,6 @@ SECTIONS
 
 	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
 		INIT_DATA
-		__vtop_table_begin = .;
-		KEEP(*(.vtop_fixup));
-		__vtop_table_end = .;
-		__ptov_table_begin = .;
-		KEEP(*(.ptov_fixup));
-		__ptov_table_end = .;
 	}
 
 	.init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
-- 
2.13.3

