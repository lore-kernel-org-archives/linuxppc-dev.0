Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF895C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 07:57:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B86610A4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 07:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29B86610A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gv1fq4w7cz304v
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 17:57:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gv1f04XdQz2y8S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 17:56:40 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Gv1dw4Pnkz9sVj;
 Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uIG8z8ySajFn; Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Gv1dw39hBz9sTx;
 Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B31E8B7DA;
 Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MwG8-KYn4ZtM; Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B1BD8B7D1;
 Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D51B86BC7E; Tue, 24 Aug 2021 07:56:35 +0000 (UTC)
Message-Id: <c6eabb4fb6c156f75d56dcbcc6f243e5ac0fba42.1629791763.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] powerpc: Avoid link stack corruption in misc asm functions
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 24 Aug 2021 07:56:35 +0000 (UTC)
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

bl;mflr is used at several places to get code position.

Use bcl 20,31,+4 instead of bl in order to preserve link stack.

See commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
in __get_datapage()") for details.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Use $+4 instead of label ; squashed several commits together
---
 arch/powerpc/kernel/misc.S       |  2 +-
 arch/powerpc/kernel/misc_32.S    |  2 +-
 arch/powerpc/kernel/misc_64.S    |  2 +-
 arch/powerpc/kernel/reloc_32.S   |  2 +-
 arch/powerpc/kexec/relocate_32.S | 12 ++++++------
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 5be96feccb55..fb7de3543c03 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -29,7 +29,7 @@ _GLOBAL(reloc_offset)
 	li	r3, 0
 _GLOBAL(add_reloc_offset)
 	mflr	r0
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r5
 	PPC_LL	r4,(2f-1b)(r5)
 	subf	r5,r4,r5
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index d8645efff902..e5127b19fec2 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -67,7 +67,7 @@ _GLOBAL(reloc_got2)
 	srwi.	r8,r8,2
 	beqlr
 	mtctr	r8
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r0
 	lis	r4,1b@ha
 	addi	r4,r4,1b@l
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 4b761a18a74d..d38a019b38e1 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -255,7 +255,7 @@ _GLOBAL(scom970_write)
  * Physical (hardware) cpu id should be in r3.
  */
 _GLOBAL(kexec_wait)
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r5
 	addi	r5,r5,kexec_flag-1b
 
diff --git a/arch/powerpc/kernel/reloc_32.S b/arch/powerpc/kernel/reloc_32.S
index 10e96f3e22fe..0508c14b4c28 100644
--- a/arch/powerpc/kernel/reloc_32.S
+++ b/arch/powerpc/kernel/reloc_32.S
@@ -30,7 +30,7 @@ R_PPC_RELATIVE = 22
 _GLOBAL(relocate)
 
 	mflr	r0		/* Save our LR */
-	bl	0f		/* Find our current runtime address */
+	bcl	20,31,$+4	/* Find our current runtime address */
 0:	mflr	r12		/* Make it accessible */
 	mtlr	r0
 
diff --git a/arch/powerpc/kexec/relocate_32.S b/arch/powerpc/kexec/relocate_32.S
index 61946c19e07c..cf6e52bdf8d8 100644
--- a/arch/powerpc/kexec/relocate_32.S
+++ b/arch/powerpc/kexec/relocate_32.S
@@ -93,7 +93,7 @@ wmmucr:
 	 * Invalidate all the TLB entries except the current entry
 	 * where we are running from
 	 */
-	bl	0f				/* Find our address */
+	bcl	20,31,$+4			/* Find our address */
 0:	mflr	r5				/* Make it accessible */
 	tlbsx	r23,0,r5			/* Find entry we are in */
 	li	r4,0				/* Start at TLB entry 0 */
@@ -158,7 +158,7 @@ write_out:
 	/* Switch to other address space in MSR */
 	insrwi	r9, r7, 1, 26		/* Set MSR[IS] = r7 */
 
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r8
 	addi	r8, r8, (2f-1b)		/* Find the target offset */
 
@@ -202,7 +202,7 @@ next_tlb:
 	li	r9,0
 	insrwi	r9, r7, 1, 26			/* Set MSR[IS] = r7 */
 
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r8
 	and	r8, r8, r11			/* Get our offset within page */
 	addi	r8, r8, (2f-1b)
@@ -240,7 +240,7 @@ setup_map_47x:
 	sync
 
 	/* Find the entry we are running from */
-	bl	2f
+	bcl	20,31,$+4
 2:	mflr	r23
 	tlbsx	r23, 0, r23
 	tlbre	r24, r23, 0			/* TLB Word 0 */
@@ -296,7 +296,7 @@ clear_utlb_entry:
 	/* Update the msr to the new TS */
 	insrwi	r5, r7, 1, 26
 
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r6
 	addi	r6, r6, (2f-1b)
 
@@ -355,7 +355,7 @@ write_utlb:
 	/* Defaults to 256M */
 	lis	r10, 0x1000
 
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r4
 	addi	r4, r4, (2f-1b)			/* virtual address  of 2f */
 
-- 
2.25.0

