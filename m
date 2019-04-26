Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA7CC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:52:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678D9206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="MYXCxOo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678D9206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rKqF3ThyzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:52:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="MYXCxOo/"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rKSm4mJBzDqK5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 02:36:40 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rKSg4nKHz9v0yl;
 Fri, 26 Apr 2019 18:36:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=MYXCxOo/; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id HJEGc3-AZhaZ; Fri, 26 Apr 2019 18:36:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rKSg3fFhz9v0yk;
 Fri, 26 Apr 2019 18:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556296595; bh=1NTdsRpgeghBuMP/6pixXQ9ve5hGuboDJAzh0KEx4Hs=;
 h=From:Subject:To:Cc:Date:From;
 b=MYXCxOo/i6bo65it0sGJk8k8Pvi8Exg4EiL+DPEzX5ONUYQe8cXHZxkLAo05DzkLm
 jv2c8Ve4mxWMd2X3HnlD7nz9R0lZdJPmVJTyNRG133agE7t315CUmdxVNoSEnAAPST
 KTKKzowFfw3Y6uhi5ALFlKKtZxIe8YanKEScLeIE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3383F8B82F;
 Fri, 26 Apr 2019 18:36:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gCm0N4wMEoGM; Fri, 26 Apr 2019 18:36:37 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BD6F8B950;
 Fri, 26 Apr 2019 18:36:37 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F1C6C666FD; Fri, 26 Apr 2019 16:36:36 +0000 (UTC)
Message-Id: <809c41e209068baf1045edbf154cc8d25c520d1e.1556296364.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/3] powerpc/32s: drop Hash_end
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 26 Apr 2019 16:36:36 +0000 (UTC)
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

Hash_end has never been used, drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: no change

 arch/powerpc/mm/mmu_decl.h   | 2 +-
 arch/powerpc/mm/ppc_mmu_32.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 74ff61dabcb1..f7f1374ba3ee 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -104,7 +104,7 @@ extern int __map_without_bats;
 extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
-extern struct hash_pte *Hash, *Hash_end;
+extern struct hash_pte *Hash;
 extern unsigned long Hash_size, Hash_mask;
 
 #endif /* CONFIG_PPC32 */
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index bf1de3ca39bc..061feab884a6 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -36,7 +36,7 @@
 
 #include "mmu_decl.h"
 
-struct hash_pte *Hash, *Hash_end;
+struct hash_pte *Hash;
 unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;
 
@@ -345,8 +345,6 @@ void __init MMU_init_hw(void)
 		      __func__, Hash_size, Hash_size);
 	_SDR1 = __pa(Hash) | SDR1_LOW_BITS;
 
-	Hash_end = (struct hash_pte *) ((unsigned long)Hash + Hash_size);
-
 	printk("Total memory = %lldMB; using %ldkB for hash table (at %p)\n",
 	       (unsigned long long)(total_memory >> 20), Hash_size >> 10, Hash);
 
-- 
2.13.3

