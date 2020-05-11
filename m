Return-Path: <SRS0=5PiN=6Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EEDC47255
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 12:31:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18EF20746
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 12:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18EF20746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49LL096jvJzDqGP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 22:31:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49LJXH6P2PzDqg7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2020 21:25:51 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49LJX41QrHz9ty3r;
 Mon, 11 May 2020 13:25:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Qyr-asFCFjKa; Mon, 11 May 2020 13:25:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49LJX40Y9qz9ty3g;
 Mon, 11 May 2020 13:25:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BE7968B7AE;
 Mon, 11 May 2020 13:25:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id DpgetcLSuEKw; Mon, 11 May 2020 13:25:46 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 89A808B7AD;
 Mon, 11 May 2020 13:25:46 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6F42D65A09; Mon, 11 May 2020 11:25:46 +0000 (UTC)
Message-Id: <5151bcdba974774738b9073c57d5ece1e75d7f71.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 20/45] powerpc/mm: Standardise
 __ptep_test_and_clear_young() params between PPC32 and PPC64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 11 May 2020 11:25:46 +0000 (UTC)
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

On PPC32, __ptep_test_and_clear_young() takes the mm->context.id

In preparation of standardising pte_update() params between PPC32 and
PPC64, __ptep_test_and_clear_young() need mm instead of mm->context.id

Replace context param by mm.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 7 ++++---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index d1108d25e2e5..8122f0b55d21 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -288,18 +288,19 @@ static inline pte_basic_t pte_update(pte_t *p, unsigned long clr, unsigned long
  * for our hash-based implementation, we fix that up here.
  */
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int __ptep_test_and_clear_young(unsigned int context, unsigned long addr, pte_t *ptep)
+static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 	old = pte_update(ptep, _PAGE_ACCESSED, 0);
 	if (old & _PAGE_HASHPTE) {
 		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
-		flush_hash_pages(context, addr, ptephys, 1);
+		flush_hash_pages(mm->context.id, addr, ptephys, 1);
 	}
 	return (old & _PAGE_ACCESSED) != 0;
 }
 #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
-	__ptep_test_and_clear_young((__vma)->vm_mm->context.id, __addr, __ptep)
+	__ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep)
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 9eaf386a747b..ddf681ceb860 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -256,14 +256,15 @@ static inline pte_basic_t pte_update(pte_t *p, unsigned long clr, unsigned long
 }
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int __ptep_test_and_clear_young(unsigned int context, unsigned long addr, pte_t *ptep)
+static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pte_t *ptep)
 {
 	unsigned long old;
 	old = pte_update(ptep, _PAGE_ACCESSED, 0);
 	return (old & _PAGE_ACCESSED) != 0;
 }
 #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
-	__ptep_test_and_clear_young((__vma)->vm_mm->context.id, __addr, __ptep)
+	__ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep)
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-- 
2.25.0

