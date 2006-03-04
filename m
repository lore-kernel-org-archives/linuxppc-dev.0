Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1110767A3B
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Mar 2006 06:10:32 +1100 (EST)
Date: Sat, 4 Mar 2006 20:10:26 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] return to OF via trap, not exit
Message-ID: <20060304191026.GA9815@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Do not call prom exit prom_panic. It clears the screen and the exit message is lost.
On some (or all?) pmacs it causes another crash when OF tries to print the
date and time in its banner.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/prom_init.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.16-rc5-olh/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.16-rc5-olh.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6.16-rc5-olh/arch/powerpc/kernel/prom_init.c
@@ -398,7 +398,9 @@ static void __init __attribute__((noretu
 #endif
 	prom_print(reason);
 	/* ToDo: should put up an SRC here on p/iSeries */
-	call_prom("exit", 0, 0);
+	/* Do not call exit because it clears the screen on pmac
+	 * it also causes some sort of double-fault on early pmacs */
+	asm("trap\n");
 
 	for (;;)			/* should never get here */
 		;
