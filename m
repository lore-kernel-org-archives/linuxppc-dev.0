Return-Path: <SRS0=JAc6=RM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C38C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Mar 2019 17:50:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D29E207E0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Mar 2019 17:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="E2CjHlOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D29E207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44GsMc4nwFzDqFt
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Mar 2019 04:50:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="E2CjHlOL"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44GsKy1txTzDq9J
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2019 04:48:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44GsKn0K8tz9v0Zc;
 Sat,  9 Mar 2019 18:48:29 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=E2CjHlOL; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id rqnLqfvvlDYr; Sat,  9 Mar 2019 18:48:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44GsKm6KB3z9v0Zb;
 Sat,  9 Mar 2019 18:48:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552153708; bh=/y6/+s++4k34i0GNG9aJNl5kiFfm+II+Vp07YTFtI0I=;
 h=From:Subject:To:Cc:Date:From;
 b=E2CjHlOLGvVQZ9RIIB5nbfq5FYQfPd5yBAHZNAiLgGIxtsAxOu8BOJrDjqV4KMCXY
 JPUrLrixLiEqkl53PPOFhYnPJs5FdHY2PTPoGndWPucyg9OpfT24ssMWawoMeQ7wGl
 b81lbYkXZQY+e2JMwaVHNhyvHp0yHbck2WDze5Uc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CCB88BFBC;
 Sat,  9 Mar 2019 18:48:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1on1RjBTICEW; Sat,  9 Mar 2019 18:48:30 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 62F518B806;
 Sat,  9 Mar 2019 18:48:30 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 186371051B7; Sat,  9 Mar 2019 18:47:27 +0100 (CET)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/irq: drop __irq_offset_value
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <20190309174727.186371051B7@localhost.localdomain>
Date: Sat,  9 Mar 2019 18:47:27 +0100 (CET)
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

This patch drops__irq_offset_value which has not been used since
commit 9c4cb8251513 ("powerpc: Remove use of CONFIG_PPC_MERGE")

This removes a sparse warning.

Fixes: 9c4cb8251513 ("powerpc: Remove use of CONFIG_PPC_MERGE")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 8a936723c791..6672fec75e2a 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -81,10 +81,7 @@
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
-int __irq_offset_value;
-
 #ifdef CONFIG_PPC32
-EXPORT_SYMBOL(__irq_offset_value);
 atomic_t ppc_n_lost_interrupts;
 
 #ifdef CONFIG_TAU_INT
-- 
2.17.1

