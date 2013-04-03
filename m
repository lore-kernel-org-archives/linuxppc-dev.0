Return-Path: <B35336@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CA392C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 00:08:22 +1100 (EST)
Received: from mail43-co9 (localhost [127.0.0.1])	by mail43-co9-R.bigfish.com
 (Postfix) with ESMTP id A0EEDA40174	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Apr 2013 13:08:18 +0000 (UTC)
Received: from CO9EHSMHS016.bigfish.com (unknown [10.236.132.254])	by
 mail43-co9.bigfish.com (Postfix) with ESMTP id EF2EC30006E	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:16 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 02/17] powerpc/85xx: do not sync time base at boot time
Date: Wed, 3 Apr 2013 21:09:10 +0800
Message-ID: <1364994565-16010-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
References: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
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

The bootloader have done time base sync for all cores, so skip
the synchronization process at boot time of kernel.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 6a17599..35dae8e 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -62,6 +62,10 @@ static void mpc85xx_give_timebase(void)
 {
 	unsigned long flags;
 
+	/* only do time base sync when system is running */
+	if (system_state == SYSTEM_BOOTING)
+		return;
+
 	local_irq_save(flags);
 
 	while (!tb_req)
@@ -85,6 +89,10 @@ static void mpc85xx_take_timebase(void)
 {
 	unsigned long flags;
 
+	/* only do time base sync when system is running */
+	if (system_state == SYSTEM_BOOTING)
+		return;
+
 	local_irq_save(flags);
 
 	tb_req = 1;
-- 
1.7.3
