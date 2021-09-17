Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DECC433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 10:54:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D423460F12
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 10:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D423460F12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H9rSW2hdYz308w
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 20:54:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H9rS20GBQz2xl7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2021 20:54:24 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4H9rRx4Styz9sTm;
 Fri, 17 Sep 2021 12:54:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zM-3TBaguqTq; Fri, 17 Sep 2021 12:54:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4H9rRw3X40z9sSm;
 Fri, 17 Sep 2021 12:54:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 680528B768;
 Fri, 17 Sep 2021 12:54:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id o3TWO0hfcv2n; Fri, 17 Sep 2021 12:54:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.36])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A2F68B799;
 Fri, 17 Sep 2021 12:54:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18HAs8cB629037
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Sep 2021 12:54:08 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18HAs7eY629036;
 Fri, 17 Sep 2021 12:54:07 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/32: Don't use a struct based type for pte_t
Date: Fri, 17 Sep 2021 12:54:07 +0200
Message-Id: <c5ff2f0918c042b1d93393ee9deb0066a110c132.1631876035.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Long time ago we had a config item called STRICT_MM_TYPECHECKS
to build the kernel with pte_t defined as a structure in order
to perform additional build checks or build it with pte_t
defined as a simple type in order to get simpler generated code.

Commit 670eea924198 ("powerpc/mm: Always use STRICT_MM_TYPECHECKS")
made the struct based definition the only one, considering that the
generated code was similar in both cases.

That's right on ppc64 because the ABI is such that the content of a
struct having a single simple type element is passed as register,
but on ppc32 such a structure is passed via the stack like any
structure.

Simple test function:

	pte_t test(pte_t pte)
	{
		return pte;
	}

Before this patch we get

	c00108ec <test>:
	c00108ec:	81 24 00 00 	lwz     r9,0(r4)
	c00108f0:	91 23 00 00 	stw     r9,0(r3)
	c00108f4:	4e 80 00 20 	blr

So, for PPC32, restore the simple type behaviour we got before
commit 670eea924198, but instead of adding a config option to
activate type check, do it when __CHECKER__ is set so that type
checking is performed by 'sparse' and provides feedback like:

	arch/powerpc/mm/pgtable.c:466:16: warning: incorrect type in return expression (different base types)
	arch/powerpc/mm/pgtable.c:466:16:    expected unsigned long
	arch/powerpc/mm/pgtable.c:466:16:    got struct pte_t [usertype] x

With this patch we now get

	c0010890 <test>:
	c0010890:	4e 80 00 20 	blr

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/pgtable-types.h     | 13 ++++++++++++-
 arch/powerpc/mm/pgtable.c                    |  2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index f06ae00f2a65..34ce50da1850 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -245,7 +245,7 @@ static int number_of_cells_per_pte(pmd_t *pmd, pte_basic_t val, int huge)
 static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
 				     unsigned long clr, unsigned long set, int huge)
 {
-	pte_basic_t *entry = &p->pte;
+	pte_basic_t *entry = (pte_basic_t *)p;
 	pte_basic_t old = pte_val(*p);
 	pte_basic_t new = (old & ~(pte_basic_t)clr) | set;
 	int num, i;
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index d11b4c61d686..e5ed4580a62c 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -5,14 +5,25 @@
 /* PTE level */
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
 typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
-#else
+#elif defined(__CHECKER__) || !defined(CONFIG_PPC32)
 typedef struct { pte_basic_t pte; } pte_t;
+#else
+typedef pte_basic_t pte_t;
 #endif
+
+#if defined(__CHECKER__) || !defined(CONFIG_PPC32)
 #define __pte(x)	((pte_t) { (x) })
 static inline pte_basic_t pte_val(pte_t x)
 {
 	return x.pte;
 }
+#else
+#define __pte(x)	((pte_t)(x))
+static inline pte_basic_t pte_val(pte_t x)
+{
+	return x;
+}
+#endif
 
 /* PMD level */
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index cd16b407f47e..ce9482383144 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -271,7 +271,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_
 {
 	pmd_t *pmd = pmd_off(mm, addr);
 	pte_basic_t val;
-	pte_basic_t *entry = &ptep->pte;
+	pte_basic_t *entry = (pte_basic_t *)ptep;
 	int num, i;
 
 	/*
-- 
2.31.1

