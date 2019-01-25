Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4882EC282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 13:07:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CA0218DE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 13:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="L3oGX9x5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CA0218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mK7Y2lfkzDqQm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 00:07:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="L3oGX9x5"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mJPD0DrjzDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 23:34:24 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43mJP750WHz9tyxw;
 Fri, 25 Jan 2019 13:34:19 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=L3oGX9x5; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ndNutyRyUHjv; Fri, 25 Jan 2019 13:34:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43mJP73yShz9tyxr;
 Fri, 25 Jan 2019 13:34:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548419659; bh=CrPkdK3q39TRGA/9Zt6xxGfth4BhEd3bTlrfCJDrkIk=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=L3oGX9x5ZkZeBwTFV8YU9G6OkfWD7FhZgsdz6Isv7EMPRIm6jKh6sYz3WanPuHxqS
 l5akjY+3DovmJs8AGFG3cU5AfvlZZInB9BDCNSGeV2CC04EsY2Nl5JRqg7DSxzI8el
 mJl6B1uPj/5a1zdzJuUYIq3BNSpYQyNpKmczVubQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D23478B87A;
 Fri, 25 Jan 2019 13:34:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GplIh6kJRcU9; Fri, 25 Jan 2019 13:34:20 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A5AAF8B761;
 Fri, 25 Jan 2019 13:34:20 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 819FA72DA9; Fri, 25 Jan 2019 12:34:20 +0000 (UTC)
Message-Id: <a96a221fb2ce681076b86c27d28ba4ec6b9bbb8d.1548419273.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548419273.git.christophe.leroy@c-s.fr>
References: <cover.1548419273.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 10/10] powerpc/book3s32: Reorder _PAGE_XXX flags to simplify
 TLB handling
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 joakim.tjernlund@infinera.com
Date: Fri, 25 Jan 2019 12:34:20 +0000 (UTC)
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

For pages without _PAGE_USER, PP field is 00
For pages with _PAGE_USER, PP field is 10 for RW and 11 for RO.

This patch sets _PAGE_USER to 0x002 and _PAGE_RW to 0x001
is order to simplify TLB handling by reducing amount of shifts.

The location of _PAGE_PRESENT and _PAGE_HASHPTE doesn't matter
as they are only SW related flags.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/hash.h | 8 ++++----
 arch/powerpc/kernel/head_32.S             | 5 +----
 arch/powerpc/mm/hash_low_32.S             | 6 ++----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/hash.h b/arch/powerpc/include/asm/book3s/32/hash.h
index 2a0a467d2985..a5907ea4fb40 100644
--- a/arch/powerpc/include/asm/book3s/32/hash.h
+++ b/arch/powerpc/include/asm/book3s/32/hash.h
@@ -17,9 +17,9 @@
  * updating the accessed and modified bits in the page table tree.
  */
 
-#define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
-#define _PAGE_HASHPTE	0x002	/* hash_page has made an HPTE for this pte */
-#define _PAGE_USER	0x004	/* usermode access allowed */
+#define _PAGE_RW	0x001	/* PP = x1: user write access allowed */
+#define _PAGE_USER	0x002	/* PP = 1x: usermode access allowed */
+#define _PAGE_HASHPTE	0x004	/* software: hash_page has made an HPTE for this pte */
 #define _PAGE_GUARDED	0x008	/* G: prohibit speculative access */
 #define _PAGE_COHERENT	0x010	/* M: enforce memory coherence (SMP systems) */
 #define _PAGE_NO_CACHE	0x020	/* I: cache inhibit */
@@ -27,7 +27,7 @@
 #define _PAGE_DIRTY	0x080	/* C: page changed */
 #define _PAGE_ACCESSED	0x100	/* R: page referenced */
 #define _PAGE_EXEC	0x200	/* software: exec allowed */
-#define _PAGE_RW	0x400	/* software: user write access allowed */
+#define _PAGE_PRESENT	0x400	/* software: pte contains a translation */
 #define _PAGE_SPECIAL	0x800	/* software: Special page */
 
 #ifdef CONFIG_PTE_64BIT
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 9f25f44b6448..3131fbd9e7f5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -524,7 +524,6 @@ InstructionTLBMiss:
 	andc.	r1,r1,r0		/* check access & ~permission */
 	bne-	InstructionAddressInvalid /* return if access not permitted */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
 	ori	r1, r1, 0xe05		/* clear out reserved bits */
 	andc	r1, r0, r1		/* PP = user? 2 : 0 */
 BEGIN_FTR_SECTION
@@ -592,8 +591,7 @@ DataLoadTLBMiss:
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwinm	r1,r0,32-10,31,31	/* _PAGE_RW -> PP lsb */
-	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
+	rlwinm	r1, r0, 0, 31, 31	/* _PAGE_RW -> PP lsb */
 	rlwimi	r0,r0,32-1,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r1,r1,0xe04		/* clear out reserved bits */
 	andc	r1,r0,r1		/* PP = user? rw? 2: 3: 0 */
@@ -672,7 +670,6 @@ DataStoreTLBMiss:
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
 	li	r1,0xe05		/* clear out reserved bits & PP lsb */
 	andc	r1,r0,r1		/* PP = user? 2: 0 */
 BEGIN_FTR_SECTION
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 2afd0dce6d6a..ab60f541c4d2 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -311,11 +311,9 @@ Hash_msk = (((1 << Hash_bits) - 1) * 64)
 
 _GLOBAL(create_hpte)
 	/* Convert linux-style PTE (r5) to low word of PPC-style PTE (r8) */
-	rlwinm	r8,r5,32-10,31,31	/* _PAGE_RW -> PP lsb */
 	rlwinm	r0,r5,32-7,31,31	/* _PAGE_DIRTY -> PP lsb */
-	and	r8,r8,r0		/* writable if _RW & _DIRTY */
-	rlwimi	r5,r5,32-1,30,30	/* _PAGE_USER -> PP msb */
-	rlwimi	r5,r5,32-2,31,31	/* _PAGE_USER -> PP lsb */
+	and	r8, r5, r0		/* writable if _RW & _DIRTY */
+	rlwimi	r5, r5, 32 - 1, 31, 31	/* _PAGE_USER -> PP lsb */
 	ori	r8,r8,0xe04		/* clear out reserved bits */
 	andc	r8,r5,r8		/* PP = user? (rw&dirty? 2: 3): 0 */
 BEGIN_FTR_SECTION
-- 
2.13.3

