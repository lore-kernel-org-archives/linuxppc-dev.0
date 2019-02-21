Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE63FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 08:14:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6292077B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 08:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="KoVv0G0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6292077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444nLK25cTzDqP7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:14:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="KoVv0G0D"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444n7r08xxzDqNH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 19:04:56 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444n7m02m7z9vJg6;
 Thu, 21 Feb 2019 09:04:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=KoVv0G0D; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qGQ1OwQzvZCW; Thu, 21 Feb 2019 09:04:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444n7l6787z9vJg1;
 Thu, 21 Feb 2019 09:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550736291; bh=NaXbkvkn7psvy1eWkt9cv294BLfCTWF7bgvkHSXZLpc=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=KoVv0G0DNz3SqQoJTuogVN6AdHmcFdkX0fOJe3CAH55q8Fd1NfIgvNXr+x7pep6C7
 ZwO2MdOl0/eHfWdjTcl7ktAOZVupUfNrjoqZxxugz5rhJsJqOvNDjaiZUE+ZkZKkh2
 x9XkmHqsaSWhu5ersW/Kw1d1R8RGEPpqH1XWink0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CBFEE8B78F;
 Thu, 21 Feb 2019 09:04:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 7h-_uKZwI2DJ; Thu, 21 Feb 2019 09:04:52 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FD008B75B;
 Thu, 21 Feb 2019 09:04:52 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 802BF6E866; Thu, 21 Feb 2019 08:04:52 +0000 (UTC)
Message-Id: <790cf44815f8c56b3c600560bad9139f63be9f68.1550692943.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550692943.git.christophe.leroy@c-s.fr>
References: <cover.1550692943.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 04/16] powerpc/mm/32s: use generic mmu_mapin_ram() for all
 blocks.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 21 Feb 2019 08:04:52 +0000 (UTC)
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

Now that mmu_mapin_ram() is able to handle other blocks
than the one starting at 0, the WII can use it for all
its blocks.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable_32.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index b4858818523f..2bf9bf8867d4 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -254,26 +254,17 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 
 void __init mapin_ram(void)
 {
-	unsigned long s, top;
-
-#ifndef CONFIG_WII
-	top = total_lowmem;
-	s = mmu_mapin_ram(0, top);
-	__mapin_ram_chunk(s, top);
-#else
-	if (!wii_hole_size) {
-		s = mmu_mapin_ram(0, total_lowmem);
-		__mapin_ram_chunk(s, total_lowmem);
-	} else {
-		top = wii_hole_start;
-		s = mmu_mapin_ram(0, top);
-		__mapin_ram_chunk(s, top);
+	struct memblock_region *reg;
+
+	for_each_memblock(memory, reg) {
+		unsigned long base = reg->base;
+		unsigned long top = min(base + reg->size, (unsigned long)total_lowmem);
 
-		top = memblock_end_of_DRAM();
-		s = wii_mmu_mapin_mem2(top);
-		__mapin_ram_chunk(s, top);
+		if (base >= top)
+			continue;
+		base = mmu_mapin_ram(base, top);
+		__mapin_ram_chunk(base, top);
 	}
-#endif
 }
 
 /* Scan the real Linux page tables and return a PTE pointer for
-- 
2.13.3

