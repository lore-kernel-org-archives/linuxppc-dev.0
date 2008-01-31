Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C35DDDE0E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 23:25:40 +1100 (EST)
Subject: [PATCH] fix comment for ppc_md enable/disable irq hooks
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 31 Jan 2008 18:12:21 +0100
Message-Id: <1201799541.4149.31.camel@johannes.berg>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When committing the patch "Implement arch disable/enable irq hooks" in
commit 7ac5dde99eb9fefdb526973c600075b7c5703a86 you changed the code to
always call the generic decrementer/interrupt enabling/disabling but
forgot to update the comment, this fixes that.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 include/asm/machdep.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6-git.orig/include/asm/machdep.h	2008-01-31 18:02:54.113774156 +0100
+++ linux-2.6-git/include/asm/machdep.h	2008-01-31 18:04:18.125023706 +0100
@@ -253,10 +253,11 @@ struct machdep_calls {
 #endif /* CONFIG_KEXEC */
 
 #ifdef CONFIG_SUSPEND
-	/* These are called to disable and enable, respectively, IRQs when
-	 * entering a suspend state.  If NULL, then the generic versions
-	 * will be called.  The generic versions disable/enable the
-	 * decrementer along with interrupts.
+	/*
+	 * These are called before disabling and after enabling, respectively,
+	 * IRQs when entering a suspend state. The generic code will always
+	 * make sure local interrupts and the decrementer are disabled/enabled
+	 * properly.
 	 */
 	void (*suspend_disable_irqs)(void);
 	void (*suspend_enable_irqs)(void);
