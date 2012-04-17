Return-Path: <R58495@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 75FEDB7095
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2012 07:39:19 +1000 (EST)
Received: from mail97-db3 (localhost [127.0.0.1])	by mail97-db3-R.bigfish.com
 (Postfix) with ESMTP id AF73B4A016C	for <linuxppc-dev@ozlabs.org>;
 Tue, 17 Apr 2012 21:39:15 +0000 (UTC)
Received: from DB3EHSMHS009.bigfish.com (unknown [10.3.81.227])	by
 mail97-db3.bigfish.com (Postfix) with ESMTP id 7C0571E0048	for
 <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 21:39:12 +0000 (UTC)
From: York Sun <yorksun@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: Add back condition for smp
Date: Tue, 17 Apr 2012 14:39:06 -0700
Message-ID: <1334698746-11529-1-git-send-email-yorksun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The timebase synchronization is only necessary if we need to reset a
separate core.  Currently only KEXEC and CPU hotplug require resetting
a single core. The following code should be in the condition of
CONFIG_KEXEC or CONFIG_HOTPLUG_CPU

        .give_timebase  = smp_generic_give_timebase,
        .take_timebase  = smp_generic_take_timebase,

Signed-off-by: York Sun <yorksun@freescale.com>
Acked-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 56942af..868c6d7 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -192,8 +192,10 @@ struct smp_ops_t smp_85xx_ops = {
 	.cpu_disable	= generic_cpu_disable,
 	.cpu_die	= generic_cpu_die,
 #endif
+#if defined(CONFIG_KEXEC) || defined(CONFIG_HOTPLUG_CPU)
 	.give_timebase	= smp_generic_give_timebase,
 	.take_timebase	= smp_generic_take_timebase,
+#endif
 };
 
 #ifdef CONFIG_KEXEC
-- 
1.7.0.4
