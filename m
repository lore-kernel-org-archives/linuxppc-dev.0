Return-Path: <SRS0=FJcg=WK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AC1C433FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 14:39:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB8F2084F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="IOCDbVF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB8F2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467sfD03GkzDqtk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 00:39:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="IOCDbVF2"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467sb30J7fzDqXT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 00:36:15 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 467sZy0wjWz9v0cY;
 Wed, 14 Aug 2019 16:36:10 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=IOCDbVF2; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id GJuQh6NpEI3c; Wed, 14 Aug 2019 16:36:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 467sZx6n46z9v0cW;
 Wed, 14 Aug 2019 16:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1565793369; bh=uVlcbbt2vYsDBHkw72NGcMtXcQFr6Bu9GfjyLcnyyyM=;
 h=From:Subject:To:Cc:Date:From;
 b=IOCDbVF2Qr50DoKA0gu+DEXTafRT/xILV9Sw/LIgeRHhSau5VS2nE/xZn6Fmivx+B
 XatXjrFmNgxYFHBrwevoHJwbNdH93CzFqo5ASNq0RNnku9LLMtHbADAqC6nXSGUMxp
 irNtZow9gjCwKpe6l9qnzcstr12LkcojYdqzgXtw=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C7338B7FB;
 Wed, 14 Aug 2019 16:36:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id XM00X-5Iz3uR; Wed, 14 Aug 2019 16:36:11 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.101])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7DE328B761;
 Wed, 14 Aug 2019 16:36:11 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 3CCFB6B6C6; Wed, 14 Aug 2019 14:36:10 +0000 (UTC)
Message-Id: <f6267226038cb25a839b567319e240576e3f8565.1565793287.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: don't display empty early ioremap area
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 14 Aug 2019 14:36:10 +0000 (UTC)
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

On the 8xx, the layout displayed at boot is:

[    0.000000] Memory: 121856K/131072K available (5728K kernel code, 592K rwdata, 1248K rodata, 560K init, 448K bss, 9216K reserved, 0K cma-reserved)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xffefc000..0xffffc000  : fixmap
[    0.000000]   * 0xffefc000..0xffefc000  : early ioremap
[    0.000000]   * 0xc9000000..0xffefc000  : vmalloc & ioremap
[    0.000000] SLUB: HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1

Remove display of an empty early ioremap.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 3e9e9a051c93..69f99128a8d6 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -306,8 +306,9 @@ void __init mem_init(void)
 	pr_info("  * 0x%08lx..0x%08lx  : consistent mem\n",
 		IOREMAP_TOP, IOREMAP_TOP + CONFIG_CONSISTENT_SIZE);
 #endif /* CONFIG_NOT_COHERENT_CACHE */
-	pr_info("  * 0x%08lx..0x%08lx  : early ioremap\n",
-		ioremap_bot, IOREMAP_TOP);
+	if (ioremap_bot != IOREMAP_TOP)
+		pr_info("  * 0x%08lx..0x%08lx  : early ioremap\n",
+			ioremap_bot, IOREMAP_TOP);
 	pr_info("  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
 		VMALLOC_START, VMALLOC_END);
 #endif /* CONFIG_PPC32 */
-- 
2.13.3

