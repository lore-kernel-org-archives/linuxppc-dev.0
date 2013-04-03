Return-Path: <B35336@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 297D72C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 00:08:23 +1100 (EST)
Received: from mail206-co9 (localhost [127.0.0.1])	by
 mail206-co9-R.bigfish.com (Postfix) with ESMTP id 3ED97C00CC	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:18 +0000 (UTC)
Received: from CO9EHSMHS027.bigfish.com (unknown [10.236.132.233])	by
 mail206-co9.bigfish.com (Postfix) with ESMTP id 56C7B9800FE	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:16 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 01/17] powerpc/85xx: fix a bug with the parameter of
 mpic_reset_core()
Date: Wed, 3 Apr 2013 21:09:09 +0800
Message-ID: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Chen-Hui Zhao <chenhui.zhao@freescale.com>

mpic_reset_core() need a logical cpu number instead of physical.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 148c2f2..6a17599 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -201,7 +201,7 @@ static int __cpuinit smp_85xx_kick_cpu(int nr)
 		 * We don't set the BPTR register here since it already points
 		 * to the boot page properly.
 		 */
-		mpic_reset_core(hw_cpu);
+		mpic_reset_core(nr);
 
 		/*
 		 * wait until core is ready...
-- 
1.7.3
