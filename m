Return-Path: <SRS0=dcvz=7D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B537C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 17:12:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E9720759
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 17:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E9720759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Sblq07xnzDqkX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 03:12:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49SbPP0xXWzDqg8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2020 02:56:41 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49SbNZ4rTWz9v0pl;
 Thu, 21 May 2020 18:55:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Ikr7BF9VLiRi; Thu, 21 May 2020 18:55:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49SbNZ3ztrz9v0pY;
 Thu, 21 May 2020 18:55:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D9B098B7DB;
 Thu, 21 May 2020 18:56:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id UWFXngziVbXJ; Thu, 21 May 2020 18:56:00 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A04C38B778;
 Thu, 21 May 2020 18:56:00 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6FBB165A53; Thu, 21 May 2020 16:56:00 +0000 (UTC)
Message-Id: <906c6a6df710f2826e332b8a0cd5d2859a913a1c.1590079969.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1590079968.git.christophe.leroy@csgroup.eu>
References: <cover.1590079968.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 09/13] powerpc/40x: Remove support for IBM 405GP
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 michal.simek@xilinx.com, arnd@arndb.de
Date: Thu, 21 May 2020 16:56:00 +0000 (UTC)
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

From: Christophe Leroy <christophe.leroy@c-s.fr>

All platforms selecting the obsolete processor are gone now.

Remove support for it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/cputable.c     | 13 -------------
 arch/powerpc/platforms/40x/Kconfig |  6 ------
 2 files changed, 19 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index bdc4eab0daaf..8ed553734919 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1232,19 +1232,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 	},
 #endif /* CONFIG_PPC_8xx */
 #ifdef CONFIG_40x
-	{	/* 405GP */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x40110000,
-		.cpu_name		= "405GP",
-		.cpu_features		= CPU_FTRS_40X,
-		.cpu_user_features	= PPC_FEATURE_32 |
-			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-		.mmu_features		= MMU_FTR_TYPE_40x,
-		.icache_bsize		= 32,
-		.dcache_bsize		= 32,
-		.machine_check		= machine_check_4xx,
-		.platform		= "ppc405",
-	},
 	{	/* STB 04xxx */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x41810000,
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 5d9d96e7223a..253c047fe6fe 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -51,12 +51,6 @@ config PPC40x_SIMPLE
 	help
 	  This option enables the simple PowerPC 40x platform support.
 
-config 405GP
-	bool
-	select IBM405_ERR77
-	select IBM405_ERR51
-	select IBM_EMAC_ZMII if IBM_EMAC
-
 config 405EX
 	bool
 	select IBM_EMAC_EMAC4 if IBM_EMAC
-- 
2.25.0

