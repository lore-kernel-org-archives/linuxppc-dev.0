Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out0.tiscali.nl (smtp-out0.tiscali.nl [195.241.79.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CC9EDDE32
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 03:08:11 +1100 (EST)
Message-ID: <47B70A61.9030306@tiscali.nl>
Date: Sat, 16 Feb 2008 17:08:01 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: geoffrey.levand@am.sony.com
Subject: [PATCH 1/3] Fix Unlikely(x) == y
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch below was not yet tested. If it's correct as it is, please comment.
---
Fix Unlikely(x) == y

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 3a6db04..a14e5cd 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -709,7 +709,7 @@ static unsigned int ps3_get_irq(void)
 	asm volatile("cntlzd %0,%1" : "=r" (plug) : "r" (x));
 	plug &= 0x3f;
 
-	if (unlikely(plug) == NO_IRQ) {
+	if (unlikely(plug == NO_IRQ)) {
 		pr_debug("%s:%d: no plug found: thread_id %lu\n", __func__,
 			__LINE__, pd->thread_id);
 		dump_bmp(&per_cpu(ps3_private, 0));
