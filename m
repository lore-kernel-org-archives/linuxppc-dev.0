Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C7CC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:46:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B0E20657
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="KjQS7fdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B0E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HsCk6p3kzDqFY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 19:46:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="KjQS7fdA"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HrsF4SWqzDqCs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 19:30:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Hrs05JXYzB09Zt;
 Mon, 11 Mar 2019 09:30:28 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=KjQS7fdA; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id e7WkMtuvE9Ax; Mon, 11 Mar 2019 09:30:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Hrs04D2DzB09ZD;
 Mon, 11 Mar 2019 09:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552293028; bh=5HP9JKRLJaNfDyk43udUO/ht3HOcmvqwX2XGpiV/vL4=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=KjQS7fdAX5nbsXxGYnBt7glCbKLtYLcDTdMcRP/2BehB9qPD/87/DATr4CE3G9/n1
 ucuOtMniGrvIsfiyyY3UHo0bsiJjk9MItSfAAfkmEO+YOMcYEOY4kHtCtkcAVmh5fM
 g3DM7g8zdXwcsYYRGQbVaMqQ0q2fLmRNf5WiKUzo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A6118B813;
 Mon, 11 Mar 2019 09:30:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id AwmLAcnKnppU; Mon, 11 Mar 2019 09:30:33 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E29938B7FE;
 Mon, 11 Mar 2019 09:30:32 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C93516FA08; Mon, 11 Mar 2019 08:30:32 +0000 (UTC)
Message-Id: <769dcafeb871ff0ab2e7a932a51e6fb125bdafed.1552292207.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 05/10] powerpc/8xx: Only define APG0 and APG1
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 ruscur@russell.cc
Date: Mon, 11 Mar 2019 08:30:32 +0000 (UTC)
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

Since the 8xx implements hardware page table walk assistance,
the PGD entries always point to a 4k aligned page, so the 2 upper
bits of the APG are not clobbered anymore and remain 0. Therefore
only APG0 and APG1 are used and need a definition. We set the
other APG to the lowest permission level.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 0a1a3fc54e54..fc5a653d5dd2 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -35,11 +35,11 @@
  * Then we use the APG to say whether accesses are according to Page rules or
  * "all Supervisor" rules (Access to all)
  * Therefore, we define 2 APG groups. lsb is _PMD_USER
- * 0 => No user => 01 (all accesses performed according to page definition)
+ * 0 => Kernel => 01 (all accesses performed according to page definition)
  * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
- * We define all 16 groups so that all other bits of APG can take any value
+ * 2-16 => NA => 11 (all accesses performed as user iaw page definition)
  */
-#define MI_APG_INIT	0x44444444
+#define MI_APG_INIT	0x4fffffff
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MI_RPN is written, bits in
@@ -108,11 +108,11 @@
  * Then we use the APG to say whether accesses are according to Page rules or
  * "all Supervisor" rules (Access to all)
  * Therefore, we define 2 APG groups. lsb is _PMD_USER
- * 0 => No user => 01 (all accesses performed according to page definition)
+ * 0 => Kernel => 01 (all accesses performed according to page definition)
  * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
- * We define all 16 groups so that all other bits of APG can take any value
+ * 2-16 => NA => 11 (all accesses performed as user iaw page definition)
  */
-#define MD_APG_INIT	0x44444444
+#define MD_APG_INIT	0x4fffffff
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
-- 
2.13.3

