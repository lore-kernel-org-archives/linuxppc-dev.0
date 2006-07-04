Return-Path: <aris@valeta.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22FC167B6D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 12:01:20 +1000 (EST)
Received: from tate.cathedrallabs.org
	(201-25-166-92.ctame704.dsl.brasiltelecom.net.br [201.25.166.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tinc.cathedrallabs.org (Postfix) with ESMTP id 26D0210009
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Jul 2006 21:39:40 -0400 (EDT)
Date: Mon, 3 Jul 2006 22:39:23 -0300
From: Aristeu Sergio Rozanski Filho <aris@valeta.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powermac: defer work in backlight key press
Message-ID: <20060704013923.GG27596@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powermac: defer work in backlight key press

pmac_backlight_key() is called under interrupt context, can't use mutexes or
semaphores, so defer the backlight level for later, as it's not critical

Signed-off-by: Aristeu S. Rozanski F. <aris@valeta.org>

Index: ppc-2.6/arch/powerpc/platforms/powermac/backlight.c
===================================================================
--- ppc-2.6.orig/arch/powerpc/platforms/powermac/backlight.c	2006-07-03 21:00:44.000000000 -0300
+++ ppc-2.6/arch/powerpc/platforms/powermac/backlight.c	2006-07-03 21:38:12.000000000 -0300
@@ -15,6 +15,10 @@
 
 #define OLD_BACKLIGHT_MAX 15
 
+static void pmac_backlight_key_worker(void *data);
+static DECLARE_WORK(pmac_backlight_key_work, pmac_backlight_key_worker, NULL);
+static int pmac_backlight_key_queued;
+
 /* Protect the pmac_backlight variable */
 DEFINE_MUTEX(pmac_backlight_mutex);
 
@@ -71,7 +75,7 @@
 	return level;
 }
 
-static void pmac_backlight_key(int direction)
+static void pmac_backlight_key_worker(void *data)
 {
 	mutex_lock(&pmac_backlight_mutex);
 	if (pmac_backlight) {
@@ -82,7 +86,8 @@
 		props = pmac_backlight->props;
 
 		brightness = props->brightness +
-			((direction?-1:1) * (props->max_brightness / 15));
+			((pmac_backlight_key_queued?-1:1) *
+			 (props->max_brightness / 15));
 
 		if (brightness < 0)
 			brightness = 0;
@@ -97,6 +102,14 @@
 	mutex_unlock(&pmac_backlight_mutex);
 }
 
+static void pmac_backlight_key(int direction)
+{
+	/* we can receive multiple interrupts here, but the scheduled work
+	 * will run only once, with the last value */
+	pmac_backlight_key_queued = direction;
+	schedule_work(&pmac_backlight_key_work);
+}
+
 void pmac_backlight_key_up()
 {
 	pmac_backlight_key(0);
