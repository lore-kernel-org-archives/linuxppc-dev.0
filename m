Return-Path: <b10716@udp157453uds.ea.freescale.net>
Received: from CH1EHSOBE015.bigfish.com (ch1ehsobe006.messaging.microsoft.com
	[216.32.181.186]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 72BC7B6F00
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 00:03:42 +1000 (EST)
Received: from mail116-ch1 (localhost.localdomain [127.0.0.1])	by
	mail116-ch1-R.bigfish.com (Postfix) with ESMTP id 1E7A56082DE	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Jul 2011 14:03:39 +0000 (UTC)
Received: from CH1EHSMHS007.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.243])	by mail116-ch1.bigfish.com (Postfix) with ESMTP id
	C4CA4A2004B	for <linuxppc-dev@ozlabs.org>;
	Thu,  7 Jul 2011 14:03:38 +0000 (UTC)
From: Laurentiu TUDOR <Laurentiu.Tudor@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Remove a BUG_ON that triggered when running under FSL
	Hypervisor
Date: Thu, 7 Jul 2011 16:44:30 +0300
Message-ID: <1310046270-6654-1-git-send-email-Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Laurentiu TUDOR <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc85xx_smp_init platform init function assumed that smp_ops.message_pass
was set to default arch dependent smp_muxed_ipi_message_pass.
However this does not seem to happen. Moreover, the arch specific code
in arch/powerpc/kernel/smp.c handles smp_ops.message_pass == NULL and if so
calls the default implementation.

Signed-off-by: Laurentiu TUDOR <Laurentiu.Tudor@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index f5aa619..5b9b901 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -2,7 +2,7 @@
  * Author: Andy Fleming <afleming@freescale.com>
  * 	   Kumar Gala <galak@kernel.crashing.org>
  *
- * Copyright 2006-2008 Freescale Semiconductor Inc.
+ * Copyright 2006-2008, 2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -239,12 +239,13 @@ void __init mpc85xx_smp_init(void)
 	}
 
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
-		/* .message_pass defaults to smp_muxed_ipi_message_pass */
+		/*
+		 * If left NULL, .message_pass defaults to
+		 * smp_muxed_ipi_message_pass
+		 */
 		smp_85xx_ops.cause_ipi = doorbell_cause_ipi;
 	}
 
-	BUG_ON(!smp_85xx_ops.message_pass);
-
 	smp_ops = &smp_85xx_ops;
 
 #ifdef CONFIG_KEXEC
-- 
1.6.6
