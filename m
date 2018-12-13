Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755A1C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 08:10:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B837020672
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 08:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B837020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FmZC57VhzDqsK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 19:10:11 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FmWz65x8zDqjj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 19:08:15 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43FmWv47VCz9v09t;
 Thu, 13 Dec 2018 09:08:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id f2t-AmjL5-At; Thu, 13 Dec 2018 09:08:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43FmWv35mfz9v09D;
 Thu, 13 Dec 2018 09:08:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D6978B754;
 Thu, 13 Dec 2018 09:08:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id x7Em4TGLBh7d; Thu, 13 Dec 2018 09:08:12 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1DDBB8B864;
 Thu, 13 Dec 2018 09:08:12 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id D9EC3716EC; Thu, 13 Dec 2018 08:08:11 +0000 (UTC)
Message-Id: <998f5532a4ec358acdbeb4238182f416304b3293.1544687473.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/8xx: hide itlbie and dtlbie symbols
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 13 Dec 2018 08:08:11 +0000 (UTC)
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

When disassembling InstructionTLBError we get the following messy code:

c000138c:       7d 84 63 78     mr      r4,r12
c0001390:       75 25 58 00     andis.  r5,r9,22528
c0001394:       75 2a 40 00     andis.  r10,r9,16384
c0001398:       41 a2 00 08     beq     c00013a0 <itlbie>
c000139c:       7c 00 22 64     tlbie   r4,r0

c00013a0 <itlbie>:
c00013a0:       39 40 04 01     li      r10,1025
c00013a4:       91 4b 00 b0     stw     r10,176(r11)
c00013a8:       39 40 10 32     li      r10,4146
c00013ac:       48 00 cc 59     bl      c000e004 <transfer_to_handler>

For a cleaner code dump, this patch replaces itlbie and dtlbie
symbols by local symbols.

c000138c:       7d 84 63 78     mr      r4,r12
c0001390:       75 25 58 00     andis.  r5,r9,22528
c0001394:       75 2a 40 00     andis.  r10,r9,16384
c0001398:       41 a2 00 08     beq     c00013a0 <InstructionTLBError+0xa0>
c000139c:       7c 00 22 64     tlbie   r4,r0
c00013a0:       39 40 04 01     li      r10,1025
c00013a4:       91 4b 00 b0     stw     r10,176(r11)
c00013a8:       39 40 10 32     li      r10,4146
c00013ac:       48 00 cc 59     bl      c000e004 <transfer_to_handler>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Using local named symbol instead of num symbol

 arch/powerpc/kernel/head_8xx.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index b171b7c0a0e7..34cd6c260da6 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -548,11 +548,11 @@ InstructionTLBError:
 	mr	r4,r12
 	andis.	r5,r9,DSISR_SRR1_MATCH_32S@h /* Filter relevant SRR1 bits */
 	andis.	r10,r9,SRR1_ISI_NOPT@h
-	beq+	1f
+	beq+	.Litlbie
 	tlbie	r4
-itlbie:
 	/* 0x400 is InstructionAccess exception, needed by bad_page_fault() */
-1:	EXC_XFER_LITE(0x400, handle_page_fault)
+.Litlbie:
+	EXC_XFER_LITE(0x400, handle_page_fault)
 
 /* This is the data TLB error on the MPC8xx.  This could be due to
  * many reasons, including a dirty update to a pte.  We bail out to
@@ -574,10 +574,10 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 	stw	r5,_DSISR(r11)
 	mfspr	r4,SPRN_DAR
 	andis.	r10,r5,DSISR_NOHPTE@h
-	beq+	1f
+	beq+	.Ldtlbie
 	tlbie	r4
-dtlbie:
-1:	li	r10,RPN_PATTERN
+.Ldtlbie:
+	li	r10,RPN_PATTERN
 	mtspr	SPRN_DAR,r10	/* Tag DAR, to be used in DTLB Error */
 	/* 0x300 is DataAccess exception, needed by bad_page_fault() */
 	EXC_XFER_LITE(0x300, handle_page_fault)
@@ -600,8 +600,8 @@ DataBreakpoint:
 	mtspr	SPRN_SPRG_SCRATCH1, r11
 	mfcr	r10
 	mfspr	r11, SPRN_SRR0
-	cmplwi	cr0, r11, (dtlbie - PAGE_OFFSET)@l
-	cmplwi	cr7, r11, (itlbie - PAGE_OFFSET)@l
+	cmplwi	cr0, r11, (.Ldtlbie - PAGE_OFFSET)@l
+	cmplwi	cr7, r11, (.Litlbie - PAGE_OFFSET)@l
 	beq-	cr0, 11f
 	beq-	cr7, 11f
 	EXCEPTION_PROLOG_1
-- 
2.13.3

