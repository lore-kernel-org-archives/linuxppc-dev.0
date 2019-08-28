Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6206C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 13:48:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373DC20856
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 13:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="McnM47Sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373DC20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JRsS2r0CzDqhk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 23:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="McnM47Sw"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JRk61tmrzDql6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 23:42:06 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46JRk12DWFz9txgl;
 Wed, 28 Aug 2019 15:42:01 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=McnM47Sw; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id EbMeLWH2Bh5V; Wed, 28 Aug 2019 15:42:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46JRk10cSKz9txgf;
 Wed, 28 Aug 2019 15:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1566999721; bh=WlF/NSltuPx4PM3qTDCqQGZT8tc/4RbHenX+NeVwbvY=;
 h=From:Subject:To:Cc:Date:From;
 b=McnM47SwSpPMO6QuYvKKyyQZ648H4n+/LV51JTu8o3Xibt98fpDBFMT5U6czyfLJh
 k6E89dZM4kQUGZKK6cfnEXvNHz8PP9ehnwwMAnbA1LFoHYp1fgP3O0k7SAdQ7ScGdD
 x8vQDatxay1Us4HZnxp6IUnDo1ZQR+eNalwEyMcE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 86B838B89B;
 Wed, 28 Aug 2019 15:42:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id guMCPJ6UOkHP; Wed, 28 Aug 2019 15:42:02 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.105])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AF798B885;
 Wed, 28 Aug 2019 15:42:02 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 13C5B69728; Wed, 28 Aug 2019 13:42:01 +0000 (UTC)
Message-Id: <ac19713826fa55e9e7bfe3100c5a7b1712ab9526.1566999711.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/reg: use ASM_FTR_IFSET() instead of opencoding fixup.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 28 Aug 2019 13:42:01 +0000 (UTC)
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

mftb() includes a feature fixup for CELL ppc.

Use ASM_FTR_IFSET() macro instead of opencoding the setup
of the fixup sections.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/reg.h | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 10caa145f98b..7acce24ace49 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1378,19 +1378,9 @@ static inline void msr_check_and_clear(unsigned long bits)
 #define mftb()		({unsigned long rval;				\
 			asm volatile(					\
 				"90:	mfspr %0, %2;\n"		\
-				"97:	cmpwi %0,0;\n"			\
-				"	beq- 90b;\n"			\
-				"99:\n"					\
-				".section __ftr_fixup,\"a\"\n"		\
-				".align 3\n"				\
-				"98:\n"					\
-				"	.8byte %1\n"			\
-				"	.8byte %1\n"			\
-				"	.8byte 97b-98b\n"		\
-				"	.8byte 99b-98b\n"		\
-				"	.8byte 0\n"			\
-				"	.8byte 0\n"			\
-				".previous"				\
+				ASM_FTR_IFSET(				\
+					"97:	cmpwi %0,0;\n"		\
+					"	beq- 90b;\n", "", %1)	\
 			: "=r" (rval) \
 			: "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL) : "cr0"); \
 			rval;})
-- 
2.13.3

