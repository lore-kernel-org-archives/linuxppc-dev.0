Return-Path: <SRS0=Q9Ec=BX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B171C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2020 16:44:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011F320855
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2020 16:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011F320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BSC8n5ySJzDqfD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2020 02:44:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BSBzY0VxJzDqdn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2020 02:36:38 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BSBzN432nz9vCyF;
 Thu, 13 Aug 2020 18:36:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id iMel7HhtXNCD; Thu, 13 Aug 2020 18:36:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BSBzN3Cddz9vCy4;
 Thu, 13 Aug 2020 18:36:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 13F248B7A7;
 Thu, 13 Aug 2020 18:36:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id vZvoj64d3-_E; Thu, 13 Aug 2020 18:36:34 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C012F8B7A1;
 Thu, 13 Aug 2020 18:36:33 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 9EA7565C8D; Thu, 13 Aug 2020 16:36:33 +0000 (UTC)
Message-Id: <cf59a61d9e6da20e45c872a02460b783092127aa.1597336548.git.christophe.leroy@csgroup.eu>
In-Reply-To: <11a330af231af22874c006302a945388846f8112.1597336548.git.christophe.leroy@csgroup.eu>
References: <11a330af231af22874c006302a945388846f8112.1597336548.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/9] powerpc: Remove SYNC on non 6xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 13 Aug 2020 16:36:33 +0000 (UTC)
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

SYNC is usefull for Powerpc 601 only. On everything else,
SYNC is empty.

Remove it from code that is not made to run on 6xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_40x.S   | 1 -
 arch/powerpc/kernel/head_booke.h | 1 -
 arch/powerpc/kernel/misc_64.S    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 5b282d9965a5..44c9018aed1b 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -72,7 +72,6 @@ turn_on_mmu:
 	lis	r0,start_here@h
 	ori	r0,r0,start_here@l
 	mtspr	SPRN_SRR0,r0
-	SYNC
 	rfi				/* enables MMU */
 	b	.			/* prevent prefetch past rfi */
 
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 18f87bf9e32b..71c359d438b5 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -176,7 +176,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 #endif
 	mtspr	SPRN_SRR1,r10
 	mtspr	SPRN_SRR0,r11
-	SYNC
 	RFI				/* jump to handler, enable MMU */
 99:	b	ret_from_kernel_syscall
 .endm
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 7bb46ad98207..070465825c21 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -365,7 +365,6 @@ _GLOBAL(kexec_smp_wait)
 
 	li	r4,KEXEC_STATE_REAL_MODE
 	stb	r4,PACAKEXECSTATE(r13)
-	SYNC
 
 	b	kexec_wait
 
-- 
2.25.0

