Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC84C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:49:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E02120827
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E02120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s72Z1tl7zF3WN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 04:49:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s6gz6CDHzF3bC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 04:33:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42s6gp6y7Vz9v0XP;
 Fri,  9 Nov 2018 18:33:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id x0R32gMzQ9Yt; Fri,  9 Nov 2018 18:33:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42s6gp6SxVz9v0XL;
 Fri,  9 Nov 2018 18:33:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7DD528B89A;
 Fri,  9 Nov 2018 18:33:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 4PI4i_6WGSS6; Fri,  9 Nov 2018 18:33:32 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 52BF38B899;
 Fri,  9 Nov 2018 18:33:32 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 334B269A2A; Fri,  9 Nov 2018 17:33:32 +0000 (UTC)
Message-Id: <0ed66fd61da6c8488366a3226dd4fd1cc8eb8729.1541784640.git.christophe.leroy@c-s.fr>
In-Reply-To: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
References: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 9/9] powerpc/smp: Use code patching to restore reset vector
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  9 Nov 2018 17:33:32 +0000 (UTC)
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

Instead of hardcoding reset vector restore, use patch_instruction()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/86xx/mpc86xx_smp.c | 3 +--
 arch/powerpc/platforms/powermac/smp.c     | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
index 020e84a47a32..9f2c1ecc85c3 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
@@ -86,8 +86,7 @@ smp_86xx_kick_cpu(int nr)
 		mdelay(1);
 
 	/* Restore the exception vector */
-	*vector = save_vector;
-	flush_icache_range((unsigned long) vector, (unsigned long) vector + 4);
+	patch_instruction(vector, save_vector);
 
 	local_irq_restore(flags);
 
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 447da6db450a..35be6e0b886d 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -832,8 +832,7 @@ static int smp_core99_kick_cpu(int nr)
 	mdelay(1);
 
 	/* Restore our exception vector */
-	*vector = save_vector;
-	flush_icache_range((unsigned long) vector, (unsigned long) vector + 4);
+	patch_instruction(vector, save_vector);
 
 	local_irq_restore(flags);
 	if (ppc_md.progress) ppc_md.progress("smp_core99_kick_cpu done", 0x347);
-- 
2.13.3

