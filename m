Return-Path: <B35336@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4E6E1B6F9C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 20:55:59 +1100 (EST)
Received: from mail51-tx2 (localhost.localdomain [127.0.0.1])	by
 mail51-tx2-R.bigfish.com (Postfix) with ESMTP id C6C8514D8122	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 09:55:28 +0000 (UTC)
Received: from TX2EHSMHS021.bigfish.com (unknown [10.9.14.254])	by
 mail51-tx2.bigfish.com (Postfix) with ESMTP id 2A31D1198053	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 09:55:28 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
Date: Wed, 16 Nov 2011 17:55:39 +0800
Message-ID: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com
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
index 2df4785..6834447 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -114,10 +114,8 @@ smp_85xx_kick_cpu(int nr)
 
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
