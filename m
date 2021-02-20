Return-Path: <SRS0=XM77=HW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CFCC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Feb 2021 08:58:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1950864ED5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Feb 2021 08:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1950864ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DjMmT1KNGz3cL1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Feb 2021 19:58:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=yang.lee@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DjMm54g4Xz30N7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2021 19:57:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=yang.lee@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0UP0IAvR_1613811457; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0UP0IAvR_1613811457) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 20 Feb 2021 16:57:37 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc/sstep: Use bitwise instead of arithmetic operator for
 flags
Date: Sat, 20 Feb 2021 16:57:35 +0800
Message-Id: <1613811455-2457-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: Yang Li <yang.lee@linux.alibaba.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix the following coccinelle warnings:
./arch/powerpc/lib/sstep.c:1090:20-21: WARNING: sum of probable
bitmasks, consider |
./arch/powerpc/lib/sstep.c:1115:20-21: WARNING: sum of probable
bitmasks, consider |
./arch/powerpc/lib/sstep.c:1134:20-21: WARNING: sum of probable
bitmasks, consider |

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/lib/sstep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index ede093e..e568cc5 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1087,7 +1087,7 @@ static nokprobe_inline void add_with_carry(const struct pt_regs *regs,
 
 	if (carry_in)
 		++val;
-	op->type = COMPUTE + SETREG + SETXER;
+	op->type = COMPUTE | SETREG | SETXER;
 	op->reg = rd;
 	op->val = val;
 #ifdef __powerpc64__
@@ -1112,7 +1112,7 @@ static nokprobe_inline void do_cmp_signed(const struct pt_regs *regs,
 {
 	unsigned int crval, shift;
 
-	op->type = COMPUTE + SETCC;
+	op->type = COMPUTE | SETCC;
 	crval = (regs->xer >> 31) & 1;		/* get SO bit */
 	if (v1 < v2)
 		crval |= 8;
@@ -1131,7 +1131,7 @@ static nokprobe_inline void do_cmp_unsigned(const struct pt_regs *regs,
 {
 	unsigned int crval, shift;
 
-	op->type = COMPUTE + SETCC;
+	op->type = COMPUTE | SETCC;
 	crval = (regs->xer >> 31) & 1;		/* get SO bit */
 	if (v1 < v2)
 		crval |= 8;
-- 
1.8.3.1

