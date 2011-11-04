Return-Path: <B35336@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 97BB1B6F89
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 23:29:56 +1100 (EST)
Received: from mail84-ch1 (localhost.localdomain [127.0.0.1])	by
 mail84-ch1-R.bigfish.com (Postfix) with ESMTP id 9536515502B6	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 12:29:40 +0000 (UTC)
Received: from CH1EHSMHS015.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.244])	by mail84-ch1.bigfish.com (Postfix) with ESMTP id
 7988D166004C	for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 12:29:38
 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by KEXEC
 patch
Date: Fri, 4 Nov 2011 20:29:47 +0800
Message-ID: <1320409787-14360-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: chenhui.zhao@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>

The timebase sync is not only necessary when using KEXEC. It should also
be used by normal boot up and cpu hotplug. Remove the ifdef added by
the KEXEC patch.

Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 5b9b901..9b0de9c 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -113,10 +113,8 @@ smp_85xx_kick_cpu(int nr)
 
 struct smp_ops_t smp_85xx_ops = {
 	.kick_cpu = smp_85xx_kick_cpu,
-#ifdef CONFIG_KEXEC
 	.give_timebase	= smp_generic_give_timebase,
 	.take_timebase	= smp_generic_take_timebase,
-#endif
 };
 
 #ifdef CONFIG_KEXEC
-- 
1.6.4.1
