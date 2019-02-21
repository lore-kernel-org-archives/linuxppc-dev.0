Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA07BC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 08:12:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FCB2086C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 08:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="FlESCmKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FCB2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444nJZ2NrCzDqNk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:12:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="FlESCmKk"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444n7q32RhzDqNJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 19:04:55 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444n7l20tpz9vJg5;
 Thu, 21 Feb 2019 09:04:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=FlESCmKk; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id FSRFDSvgKXrz; Thu, 21 Feb 2019 09:04:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444n7l0zc7z9vJg1;
 Thu, 21 Feb 2019 09:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550736291; bh=oJYnubGJxtoq3azbdLhwwK1cIIERr+Sch6LNkaghcgo=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=FlESCmKka3ybPH6zB0z6yyH0TeDblrlw7lFV9SyFKOizoUlqJRaF1V4vEKVBZi2sF
 5zN81O5lvLkp2CP9SGHA3T1ldeO4LnCclAPBPzUoAfuGS1//CgbKwG7OAZazezM5+a
 l/+IzHMaGtXuDBEZFopTOXZaxp41MuUChLbkuX5c=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E09C08B78F;
 Thu, 21 Feb 2019 09:04:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id quo94uU-RUPC; Thu, 21 Feb 2019 09:04:51 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9965D8B75B;
 Thu, 21 Feb 2019 09:04:51 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 7B4266E866; Thu, 21 Feb 2019 08:04:51 +0000 (UTC)
Message-Id: <bfce930774be29e0777c1c640e7e40efe52a5929.1550692943.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550692943.git.christophe.leroy@c-s.fr>
References: <cover.1550692943.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 03/16] powerpc/mm/32s: rework mmu_mapin_ram()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 21 Feb 2019 08:04:51 +0000 (UTC)
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

This patch reworks mmu_mapin_ram() to be more generic and map as much
blocks as possible. It now supports blocks not starting at address 0.

It scans DBATs array to find free ones instead of forcing the use of
BAT2 and BAT3.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ppc_mmu_32.c | 63 ++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index b260ced065b4..5fc59b195fef 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -73,39 +73,58 @@ unsigned long p_block_mapped(phys_addr_t pa)
 	return 0;
 }
 
+static int find_free_bat(void)
+{
+	int b;
+
+	if (cpu_has_feature(CPU_FTR_601)) {
+		for (b = 0; b < 4; b++) {
+			struct ppc_bat *bat = BATS[b];
+
+			if (!(bat[0].batl & 0x40))
+				return b;
+		}
+	} else {
+		int n = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
+
+		for (b = 0; b < n; b++) {
+			struct ppc_bat *bat = BATS[b];
+
+			if (!(bat[1].batu & 3))
+				return b;
+		}
+	}
+	return -1;
+}
+
+static unsigned int block_size(unsigned long base, unsigned long top)
+{
+	unsigned int max_size = (cpu_has_feature(CPU_FTR_601) ? 8 : 256) << 20;
+	unsigned int base_shift = (fls(base) - 1) & 31;
+	unsigned int block_shift = (fls(top - base) - 1) & 31;
+
+	return min3(max_size, 1U << base_shift, 1U << block_shift);
+}
+
 unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
-	unsigned long tot, bl, done;
-	unsigned long max_size = (256<<20);
+	int idx;
 
 	if (__map_without_bats) {
 		printk(KERN_DEBUG "RAM mapped without BATs\n");
-		return 0;
+		return base;
 	}
 
-	/* Set up BAT2 and if necessary BAT3 to cover RAM. */
+	while ((idx = find_free_bat()) != -1 && base != top) {
+		unsigned int size = block_size(base, top);
 
-	/* Make sure we don't map a block larger than the
-	   smallest alignment of the physical address. */
-	tot = top;
-	for (bl = 128<<10; bl < max_size; bl <<= 1) {
-		if (bl * 2 > tot)
+		if (size < 128 << 10)
 			break;
+		setbat(idx, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
+		base += size;
 	}
 
-	setbat(2, PAGE_OFFSET, 0, bl, PAGE_KERNEL_X);
-	done = (unsigned long)bat_addrs[2].limit - PAGE_OFFSET + 1;
-	if ((done < tot) && !bat_addrs[3].limit) {
-		/* use BAT3 to cover a bit more */
-		tot -= done;
-		for (bl = 128<<10; bl < max_size; bl <<= 1)
-			if (bl * 2 > tot)
-				break;
-		setbat(3, PAGE_OFFSET+done, done, bl, PAGE_KERNEL_X);
-		done = (unsigned long)bat_addrs[3].limit - PAGE_OFFSET + 1;
-	}
-
-	return done;
+	return base;
 }
 
 /*
-- 
2.13.3

