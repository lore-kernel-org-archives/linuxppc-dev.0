Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09683C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:24:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7898D2146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WEERk3BI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7898D2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PQy32w8DzDqD9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:24:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="WEERk3BI"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZ05F0CzDqK6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:06:48 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQYw35xMz9vC08;
 Wed, 20 Mar 2019 11:06:44 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=WEERk3BI; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id IhHOa7War9FV; Wed, 20 Mar 2019 11:06:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYw1YR5z9vByx;
 Wed, 20 Mar 2019 11:06:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076404; bh=G6Vm/3quih74L835clIz7+C2d4LubKm1kUwxVvftonk=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=WEERk3BIZxygxDK9j3MgygRPyy4S9ln9RgO8mISuv9HDLu9EbUu38cxSiyimX73VQ
 sXScJIX9wNxCUhPgvRoH7F1Tha04KoprV9GZI1BBRF/V7r9wupjeuDENFEBTHOOelm
 mn7a/Q3sAPk7QWiINuqCSEq0b2hVB/s4E05XB768=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 526FD8B918;
 Wed, 20 Mar 2019 11:06:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MkCT2cVLQ8dw; Wed, 20 Mar 2019 11:06:45 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B36D8B911;
 Wed, 20 Mar 2019 11:06:45 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 148E963AEF; Wed, 20 Mar 2019 10:06:45 +0000 (UTC)
Message-Id: <46d3ca037a741f2278289f4b8c7ff74a4b20e361.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 09/27] powerpc/mm: make hugetlbpage.c depend on
 CONFIG_HUGETLB_PAGE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:45 +0000 (UTC)
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

The only function in hugetlbpage.c which doesn't depend on
CONFIG_HUGETLB_PAGE is gup_hugepte(), and this function is
only called from gup_huge_pd() which depends on
CONFIG_HUGETLB_PAGE so all the content of hugetlbpage.c
depends on CONFIG_HUGETLB_PAGE.

This patch modifies Makefile to only compile hugetlbpage.c
when CONFIG_HUGETLB_PAGE is set.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile      | 2 +-
 arch/powerpc/mm/hugetlbpage.c | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 2c23d1ece034..20b900537fc9 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -33,7 +33,7 @@ obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke_mmu.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
-obj-y				+= hugetlbpage.o
+obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 ifdef CONFIG_HUGETLB_PAGE
 obj-$(CONFIG_PPC_BOOK3S_64)	+= hugetlbpage-hash64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= hugetlbpage-radix.o
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 202ae006aa39..6d9751b188c1 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -26,9 +26,6 @@
 #include <asm/hugetlb.h>
 #include <asm/pte-walk.h>
 
-
-#ifdef CONFIG_HUGETLB_PAGE
-
 #define PAGE_SHIFT_64K	16
 #define PAGE_SHIFT_512K	19
 #define PAGE_SHIFT_8M	23
@@ -757,8 +754,6 @@ void flush_dcache_icache_hugepage(struct page *page)
 	}
 }
 
-#endif /* CONFIG_HUGETLB_PAGE */
-
 int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		unsigned long end, int write, struct page **pages, int *nr)
 {
-- 
2.13.3

