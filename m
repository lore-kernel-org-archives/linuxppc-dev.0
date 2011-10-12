Return-Path: <B29882@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8417DB6F67
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 11:07:04 +1100 (EST)
Received: from mail58-ch1 (localhost.localdomain [127.0.0.1])	by
 mail58-ch1-R.bigfish.com (Postfix) with ESMTP id 627298C03BF	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 00:06:57 +0000 (UTC)
Received: from CH1EHSMHS026.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.252])	by mail58-ch1.bigfish.com (Postfix) with ESMTP id
 B04FA172004E	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 00:06:44
 +0000 (UTC)
From: Matthew McClintock <msm@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Fix doorbells
Date: Tue, 11 Oct 2011 19:06:42 -0500
Message-ID: <1318378002-32531-1-git-send-email-msm@freescale.com>
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

Commit 765342526246c97600e5344c0949824d94bb51c3 made some small
changes to IPI, message_pass in smp_ops was initialized to NULL
for other platforms but not for 85xx which causes us to always
use the mpic for IPI's. This patch makes doorbells work again.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 5b9b901..d6e4746 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -243,6 +243,7 @@ void __init mpc85xx_smp_init(void)
 		 * If left NULL, .message_pass defaults to
 		 * smp_muxed_ipi_message_pass
 		 */
+		smp_85xx_ops.message_pass = NULL;
 		smp_85xx_ops.cause_ipi = doorbell_cause_ipi;
 	}
 
-- 
1.7.6.1
