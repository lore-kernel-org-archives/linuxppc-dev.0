Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58343C433F5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Oct 2021 11:49:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D0D60FDA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Oct 2021 11:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3D0D60FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HbzzN4LK8z3dp0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Oct 2021 22:49:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hbzwz0zRfz2yP7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Oct 2021 22:47:47 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4HbzwW1m9Sz9s2t;
 Sat, 23 Oct 2021 13:47:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b9j-txkBeket; Sat, 23 Oct 2021 13:47:23 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by pegase1.c-s.fr (Postfix) with ESMTPS id 4HbzwS30HBz9s2q;
 Sat, 23 Oct 2021 13:47:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19NBlKfL441179
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 23 Oct 2021 13:47:20 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19NBlKvV441178;
 Sat, 23 Oct 2021 13:47:20 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 06/10] powerpc/fsl_booke: Enable reloading of TLBCAM
 without switching to AS1
Date: Sat, 23 Oct 2021 13:47:11 +0200
Message-Id: <ba02555bb912382b729c3b3dad4575bc84246a72.1634983809.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <33e7fe0f6134c58e044eb63d3925cd34aa120104.1634983809.git.christophe.leroy@csgroup.eu>
References: <33e7fe0f6134c58e044eb63d3925cd34aa120104.1634983809.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634989633; l=1787; s=20211009;
 h=from:subject:message-id; bh=hnT3Htr9Kbjvusle9HHm9twnh707ikQ9q4C7xZV0VCI=;
 b=mm0VTjxyZnHkEiWZ+UfNvUF40XqaZ5duwP80HNQAODJ3/i8DY17prjHTMvw8+JpJBbaw6hckZ/vg
 gCByfb4hCmio4ULga6Spb/rAb8anoe7M+UHDAtUZucZlJ/cjgjgh
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519;
 pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
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

Avoid switching to AS1 when reloading TLBCAM after init for
STRICT_KERNEL_RWX.

When we setup AS1 we expect the entire accessible memory to be mapped
through one entry, this is not the case anymore at the end of init.

We are not changing the size of TLBCAMs, only flags, so no need to
switch to AS1.

So change loadcam_multi() to not switch to AS1 when the given
temporary tlb entry in 0.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: No change
---
 arch/powerpc/mm/nohash/tlb_low.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/nohash/tlb_low.S b/arch/powerpc/mm/nohash/tlb_low.S
index 5add4a51e51f..dd39074de9af 100644
--- a/arch/powerpc/mm/nohash/tlb_low.S
+++ b/arch/powerpc/mm/nohash/tlb_low.S
@@ -369,7 +369,7 @@ _GLOBAL(_tlbivax_bcast)
  * extern void loadcam_entry(unsigned int index)
  *
  * Load TLBCAM[index] entry in to the L2 CAM MMU
- * Must preserve r7, r8, r9, r10 and r11
+ * Must preserve r7, r8, r9, r10, r11, r12
  */
 _GLOBAL(loadcam_entry)
 	mflr	r5
@@ -401,7 +401,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
  *
  * r3 = first entry to write
  * r4 = number of entries to write
- * r5 = temporary tlb entry
+ * r5 = temporary tlb entry (0 means no switch to AS1)
  */
 _GLOBAL(loadcam_multi)
 	mflr	r8
@@ -409,6 +409,8 @@ _GLOBAL(loadcam_multi)
 	mfmsr	r11
 	andi.	r11,r11,MSR_IS
 	bne	10f
+	mr.	r12, r5
+	beq	10f
 
 	/*
 	 * Set up temporary TLB entry that is the same as what we're
@@ -446,6 +448,8 @@ _GLOBAL(loadcam_multi)
 	/* Don't return to AS=0 if we were in AS=1 at function start */
 	andi.	r11,r11,MSR_IS
 	bne	3f
+	cmpwi	r12, 0
+	beq	3f
 
 	/* Return to AS=0 and clear the temporary entry */
 	mfmsr	r6
-- 
2.31.1

