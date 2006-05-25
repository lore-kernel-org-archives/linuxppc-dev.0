Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6732467A41
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 00:11:54 +1000 (EST)
Subject: [PATCH] PowerMac: force only suspend-to-disk to be valid
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 25 May 2006 16:11:45 +0200
Message-Id: <1148566305.11759.35.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the .valid callback to pm_ops on PowerMac so that only the
suspend to disk state can be entered. Note that just returning 0 would
suffice since the upper layers don't pass PM_SUSPEND_DISK down, but we
handle it there regardless just in case that changes.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- wireless-dev.orig/arch/powerpc/platforms/powermac/setup.c	2006-05-02 10:57:32.101509438 +0200
+++ wireless-dev/arch/powerpc/platforms/powermac/setup.c	2006-05-02 10:58:44.491509438 +0200
@@ -463,11 +463,23 @@ static int pmac_pm_finish(suspend_state_
 	return 0;
 }
 
+static int pmac_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_DISK:
+		return 1;
+	/* can't do any other states via generic mechanism yet */
+	default:
+		return 0;
+	}
+}
+
 static struct pm_ops pmac_pm_ops = {
 	.pm_disk_mode	= PM_DISK_SHUTDOWN,
 	.prepare	= pmac_pm_prepare,
 	.enter		= pmac_pm_enter,
 	.finish		= pmac_pm_finish,
+	.valid		= pmac_pm_valid,
 };
 
 #endif /* CONFIG_SOFTWARE_SUSPEND */
