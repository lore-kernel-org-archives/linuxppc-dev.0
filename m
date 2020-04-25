Return-Path: <SRS0=123t=6J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCE0C55185
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 09:04:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C1420700
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 09:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="j7qvNahf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C1420700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 498Q851lykzDrGv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 19:04:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=j7qvNahf; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 498Phd45V5zDqXm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2020 18:43:45 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 498PhY1Hr4z9txnG;
 Sat, 25 Apr 2020 10:43:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=j7qvNahf; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 3KMBZsyLJrCp; Sat, 25 Apr 2020 10:43:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 498PhY0CZhz9txnh;
 Sat, 25 Apr 2020 10:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1587804221; bh=RsyxMy7Y5Bx9LrA8rcOoGxnVO3hSnKKPR8y4ZmX75Pg=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=j7qvNahfIqIgLH7COI0Fj3i3PE3SAYWdP9t5yXvpbRkG/6DRhcqxttY06aOgFup/R
 3OVruNnt+8p+/JDQFMwbD8xAVS3f67uhtN+6ioSABZ20tjKHGvWD8iuIUtIyVov+Mx
 3nLuwLmfplxq0iHDpzwsdFyuQDF1A30u4b8WVZ18=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 333EF8B769;
 Sat, 25 Apr 2020 10:43:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZA9TPR1o3M0g; Sat, 25 Apr 2020 10:43:42 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DFBBD8B773;
 Sat, 25 Apr 2020 10:43:41 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C2D4665877; Sat, 25 Apr 2020 08:43:41 +0000 (UTC)
Message-Id: <fe274423fe7262650c77abad5f4d3d2c0490db53.1587804057.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1587804057.git.christophe.leroy@c-s.fr>
References: <cover.1587804057.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 13/13] powerpc/40x: Don't save CR in SPRN_SPRG_SCRATCH6
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 michal.simek@xilinx.com, arnd@arndb.de
Date: Sat, 25 Apr 2020 08:43:41 +0000 (UTC)
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

We have r12 available, use it to keep CR around and don't
save it in SPRN_SPRG_SCRATCH6.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_40x.S | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 804cbd0899ac..f9b880235aee 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -253,9 +253,8 @@ _ENTRY(saved_ksp_limit)
 	mtspr	SPRN_SPRG_SCRATCH1, r11
 	mtspr	SPRN_SPRG_SCRATCH3, r12
 	mtspr	SPRN_SPRG_SCRATCH4, r9
-	mfcr	r11
+	mfcr	r12
 	mfspr	r9, SPRN_PID
-	mtspr	SPRN_SPRG_SCRATCH6, r11
 	mtspr	SPRN_SPRG_SCRATCH5, r9
 	mfspr	r10, SPRN_DEAR		/* Get faulting address */
 
@@ -322,9 +321,8 @@ _ENTRY(saved_ksp_limit)
 	 * and call the heavyweights to help us out.
 	 */
 	mfspr	r9, SPRN_SPRG_SCRATCH5
-	mfspr	r11, SPRN_SPRG_SCRATCH6
 	mtspr	SPRN_PID, r9
-	mtcr	r11
+	mtcr	r12
 	mfspr	r9, SPRN_SPRG_SCRATCH4
 	mfspr	r12, SPRN_SPRG_SCRATCH3
 	mfspr	r11, SPRN_SPRG_SCRATCH1
@@ -340,9 +338,8 @@ _ENTRY(saved_ksp_limit)
 	mtspr	SPRN_SPRG_SCRATCH1, r11
 	mtspr	SPRN_SPRG_SCRATCH3, r12
 	mtspr	SPRN_SPRG_SCRATCH4, r9
-	mfcr	r11
+	mfcr	r12
 	mfspr	r9, SPRN_PID
-	mtspr	SPRN_SPRG_SCRATCH6, r11
 	mtspr	SPRN_SPRG_SCRATCH5, r9
 	mfspr	r10, SPRN_SRR0		/* Get faulting address */
 
@@ -409,9 +406,8 @@ _ENTRY(saved_ksp_limit)
 	 * and call the heavyweights to help us out.
 	 */
 	mfspr	r9, SPRN_SPRG_SCRATCH5
-	mfspr	r11, SPRN_SPRG_SCRATCH6
 	mtspr	SPRN_PID, r9
-	mtcr	r11
+	mtcr	r12
 	mfspr	r9, SPRN_SPRG_SCRATCH4
 	mfspr	r12, SPRN_SPRG_SCRATCH3
 	mfspr	r11, SPRN_SPRG_SCRATCH1
@@ -555,9 +551,8 @@ finish_tlb_load:
 	/* Done...restore registers and get out of here.
 	*/
 	mfspr	r9, SPRN_SPRG_SCRATCH5
-	mfspr	r11, SPRN_SPRG_SCRATCH6
 	mtspr	SPRN_PID, r9
-	mtcr	r11
+	mtcr	r12
 	mfspr	r9, SPRN_SPRG_SCRATCH4
 	mfspr	r12, SPRN_SPRG_SCRATCH3
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-- 
2.25.0

