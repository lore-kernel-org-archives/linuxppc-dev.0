Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 83D80DE02D
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 08:05:52 +1100 (EST)
Message-ID: <47C72223.1080501@am.sony.com>
Date: Thu, 28 Feb 2008 13:05:39 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] PS3: Fix unlikely typo in ps3_get_irq
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Roel Kluin <12o3l@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Roel Kluin <12o3l@tiscali.nl>

Fix a typo bug 'unlikely(x) == y' and add an unlikely() call to
an unlikely code path in the PS3 interrupt routine ps3_get_irq().

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
Hi Paul,

Please apply for 2.6.25.

-Geoff

 arch/powerpc/platforms/ps3/interrupt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
