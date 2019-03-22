Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84DFC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 08:11:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14B320700
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 08:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="tAJMX/1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14B320700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qbvs1qf4zDqQB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 19:11:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="tAJMX/1t"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Qbrr5hfvzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 19:08:44 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Qbrm1B3pz9v9vL;
 Fri, 22 Mar 2019 09:08:40 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=tAJMX/1t; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id J_EDFwehDTbV; Fri, 22 Mar 2019 09:08:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Qbrm04Vpz9v9vG;
 Fri, 22 Mar 2019 09:08:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553242120; bh=vuX9mjDqG9V5hTI4EOw+h7yoI6fzAlRXWPPWa05ZC2M=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=tAJMX/1tKKfQOh0G5X9lWosgLupVLMJzOtgOkPwZxmwuCLhF2+rOW8ZkLNfjEuaM9
 sesuovY46BGvXn1BeLCMKR5daYyLQWkf03l+uUMRUyG5/xPH+ZAy8JvCNX4Nb6waBa
 DcmNzSzixpqidmIUau/85NFpi9wKgfpqJyQCZyMY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EDF5B8B845;
 Fri, 22 Mar 2019 09:08:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2r5_HJ1yyVDQ; Fri, 22 Mar 2019 09:08:40 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D3A958B844;
 Fri, 22 Mar 2019 09:08:40 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C99C46CD85; Fri, 22 Mar 2019 08:08:40 +0000 (UTC)
Message-Id: <2d9fe7eac16d51000747648b5f84a58ef258633e.1553242059.git.christophe.leroy@c-s.fr>
In-Reply-To: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
References: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/7] powerpc/mm: define an empty mm_iommu_init()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 22 Mar 2019 08:08:40 +0000 (UTC)
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

To avoid ifdefs, define a empty static inline mm_iommu_init() function
when CONFIG_SPAPR_TCE_IOMMU is not selected.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu_context.h | 1 +
 arch/powerpc/kernel/setup-common.c     | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 6ee8195a2ffb..95b93ce428b7 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -52,6 +52,7 @@ static inline bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 {
 	return false;
 }
+static inline void mm_iommu_init(struct mm_struct *mm) { }
 #endif
 extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
 extern void set_context(unsigned long id, pgd_t *pgd);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 971f50d99d87..a90e8367ccde 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -956,9 +956,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 #endif
 
-#ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(&init_mm);
-#endif
 	irqstack_early_init();
 	exc_lvl_early_init();
 	emergency_stack_init();
-- 
2.13.3

