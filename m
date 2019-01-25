Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D36C282C6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 12:06:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA77F218D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 12:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="i3nR3GBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA77F218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mHmq4NY6zDqNj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 23:06:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="i3nR3GBV"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mHk80zk3zDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 23:04:00 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43mHk30Zlpz9tyRJ;
 Fri, 25 Jan 2019 13:03:55 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=i3nR3GBV; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id T-S7tndRbSlp; Fri, 25 Jan 2019 13:03:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43mHk26WMCz9tyRH;
 Fri, 25 Jan 2019 13:03:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548417834; bh=ivmH+AoutJHc7vJDgG4UgyzcqbN5JHmAR0vsyyq01ro=;
 h=From:Subject:To:Cc:Date:From;
 b=i3nR3GBV5YF1cyvGtooAIH/DZvQoNnFNfHfJFpuXHEVe1/DSzFkigWZejO3HudDqO
 DqfVmxoc/rz9op5BZwT8NmMkDA7SdnlDmG+CBXCGp2GABstho3oEIXeokPjOSZD0lT
 abRlZwMkwR2ft5TBQiC4h5Pa36l5Uef3Kcweq71Y=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C0FF8B876;
 Fri, 25 Jan 2019 13:03:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id uBLdh_CtQi6Z; Fri, 25 Jan 2019 13:03:56 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 11E4D8B761;
 Fri, 25 Jan 2019 13:03:56 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id E29BF72DA7; Fri, 25 Jan 2019 12:03:55 +0000 (UTC)
Message-Id: <5a09a970ce5f7998719f0b4cd8af22cc7dd09ef0.1548371001.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/83xx: Also save/restore SPRG4-7 during suspend
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Date: Fri, 25 Jan 2019 12:03:55 +0000 (UTC)
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

The 83xx has 8 SPRG registers and uses at least SPRG4
for DTLB handling LRU.

Fixes: 2319f1239592 ("powerpc/mm: e300c2/c3/c4 TLB errata workaround")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/83xx/suspend-asm.S | 34 ++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/suspend-asm.S b/arch/powerpc/platforms/83xx/suspend-asm.S
index 3d1ecd211776..8137f77abad5 100644
--- a/arch/powerpc/platforms/83xx/suspend-asm.S
+++ b/arch/powerpc/platforms/83xx/suspend-asm.S
@@ -26,13 +26,13 @@
 #define SS_MSR		0x74
 #define SS_SDR1		0x78
 #define SS_LR		0x7c
-#define SS_SPRG		0x80 /* 4 SPRGs */
-#define SS_DBAT		0x90 /* 8 DBATs */
-#define SS_IBAT		0xd0 /* 8 IBATs */
-#define SS_TB		0x110
-#define SS_CR		0x118
-#define SS_GPREG	0x11c /* r12-r31 */
-#define STATE_SAVE_SIZE 0x16c
+#define SS_SPRG		0x80 /* 8 SPRGs */
+#define SS_DBAT		0xa0 /* 8 DBATs */
+#define SS_IBAT		0xe0 /* 8 IBATs */
+#define SS_TB		0x120
+#define SS_CR		0x128
+#define SS_GPREG	0x12c /* r12-r31 */
+#define STATE_SAVE_SIZE 0x17c
 
 	.section .data
 	.align	5
@@ -103,6 +103,16 @@ _GLOBAL(mpc83xx_enter_deep_sleep)
 	stw	r7, SS_SPRG+12(r3)
 	stw	r8, SS_SDR1(r3)
 
+	mfspr	r4, SPRN_SPRG4
+	mfspr	r5, SPRN_SPRG5
+	mfspr	r6, SPRN_SPRG6
+	mfspr	r7, SPRN_SPRG7
+
+	stw	r4, SS_SPRG+16(r3)
+	stw	r5, SS_SPRG+20(r3)
+	stw	r6, SS_SPRG+24(r3)
+	stw	r7, SS_SPRG+28(r3)
+
 	mfspr	r4, SPRN_DBAT0U
 	mfspr	r5, SPRN_DBAT0L
 	mfspr	r6, SPRN_DBAT1U
@@ -493,6 +503,16 @@ mpc83xx_deep_resume:
 	mtspr	SPRN_IBAT7U, r6
 	mtspr	SPRN_IBAT7L, r7
 
+	lwz	r4, SS_SPRG+16(r3)
+	lwz	r5, SS_SPRG+20(r3)
+	lwz	r6, SS_SPRG+24(r3)
+	lwz	r7, SS_SPRG+28(r3)
+
+	mtspr	SPRN_SPRG4, r4
+	mtspr	SPRN_SPRG5, r5
+	mtspr	SPRN_SPRG6, r6
+	mtspr	SPRN_SPRG7, r7
+
 	lwz	r4, SS_SPRG+0(r3)
 	lwz	r5, SS_SPRG+4(r3)
 	lwz	r6, SS_SPRG+8(r3)
-- 
2.13.3

