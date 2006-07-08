Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C48B867B32
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jul 2006 01:58:48 +1000 (EST)
Date: Sat, 8 Jul 2006 17:58:43 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: akpm@osdl.org
Subject: Re: [PATCH] powermac: defer work in backlight key press (and export
	fixes)
Message-ID: <20060708155843.GB26186@hansmi.ch>
References: <20060704013923.GG27596@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060704013923.GG27596@cathedrallabs.org>
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net, aris@valeta.org,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pmac_backlight_key() is called under interrupt context, and therefore
can't use mutexes or semaphores, so defer the backlight level for later,
as it's not critical (code by Aristeu S. Rozanski F. <aris@valeta.org>).
Also, it fixes exports and Kconfig depdencies.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Aristeu S. Rozanski F. <aris@valeta.org>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/arch/powerpc/platforms/powermac/backlight.c linux-2.6.18-rc1/arch/powerpc/platforms/powermac/backlight.c
--- linux-2.6.18-rc1.orig/arch/powerpc/platforms/powermac/backlight.c	2006-07-08 12:27:01.000000000 +0200
+++ linux-2.6.18-rc1/arch/powerpc/platforms/powermac/backlight.c	2006-07-08 17:30:23.000000000 +0200
@@ -15,6 +15,15 @@
 
 #define OLD_BACKLIGHT_MAX 15
 
+static void pmac_backlight_key_worker(void *data);
+static DECLARE_WORK(pmac_backlight_key_work, pmac_backlight_key_worker, NULL);
+
+/* Although this variable is used in interrupt context, it makes no sense to
+ * protect it. No user is able to produce enough key events per second and
+ * notice the errors that might happen.
+ */
+static int pmac_backlight_key_queued;
+
 /* Protect the pmac_backlight variable */
 DEFINE_MUTEX(pmac_backlight_mutex);
 
@@ -71,7 +80,7 @@ int pmac_backlight_curve_lookup(struct f
 	return level;
 }
 
-static void pmac_backlight_key(int direction)
+static void pmac_backlight_key_worker(void *data)
 {
 	mutex_lock(&pmac_backlight_mutex);
 	if (pmac_backlight) {
@@ -82,7 +91,8 @@ static void pmac_backlight_key(int direc
 		props = pmac_backlight->props;
 
 		brightness = props->brightness +
-			((direction?-1:1) * (props->max_brightness / 15));
+			((pmac_backlight_key_queued?-1:1) *
+			 (props->max_brightness / 15));
 
 		if (brightness < 0)
 			brightness = 0;
@@ -97,14 +107,13 @@ static void pmac_backlight_key(int direc
 	mutex_unlock(&pmac_backlight_mutex);
 }
 
-void pmac_backlight_key_up()
+void pmac_backlight_key(int direction)
 {
-	pmac_backlight_key(0);
-}
-
-void pmac_backlight_key_down()
-{
-	pmac_backlight_key(1);
+	/* we can receive multiple interrupts here, but the scheduled work
+	 * will run only once, with the last value
+	 */
+	pmac_backlight_key_queued = direction;
+	schedule_work(&pmac_backlight_key_work);
 }
 
 int pmac_backlight_set_legacy_brightness(int brightness)
@@ -157,3 +166,7 @@ int pmac_backlight_get_legacy_brightness
 
 	return result;
 }
+
+EXPORT_SYMBOL_GPL(pmac_backlight);
+EXPORT_SYMBOL_GPL(pmac_backlight_mutex);
+EXPORT_SYMBOL_GPL(pmac_has_backlight_type);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/drivers/macintosh/Kconfig linux-2.6.18-rc1/drivers/macintosh/Kconfig
--- linux-2.6.18-rc1.orig/drivers/macintosh/Kconfig	2006-07-08 12:27:10.000000000 +0200
+++ linux-2.6.18-rc1/drivers/macintosh/Kconfig	2006-07-08 15:28:36.000000000 +0200
@@ -113,7 +113,10 @@ config PMAC_MEDIABAY
 
 config PMAC_BACKLIGHT
 	bool "Backlight control for LCD screens"
-	depends on ADB_PMU && (BROKEN || !PPC64)
+	depends on ADB_PMU && FB = y && (BROKEN || !PPC64)
+	select FB_BACKLIGHT
+	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_LCD_SUPPORT
 	help
 	  Say Y here to enable Macintosh specific extensions of the generic
 	  backlight code. With this enabled, the brightness keys on older
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/include/asm-powerpc/backlight.h linux-2.6.18-rc1/include/asm-powerpc/backlight.h
--- linux-2.6.18-rc1.orig/include/asm-powerpc/backlight.h	2006-07-08 12:27:21.000000000 +0200
+++ linux-2.6.18-rc1/include/asm-powerpc/backlight.h	2006-07-08 17:14:43.000000000 +0200
@@ -16,13 +16,16 @@
 extern struct backlight_device *pmac_backlight;
 extern struct mutex pmac_backlight_mutex;
 
-extern void pmac_backlight_calc_curve(struct fb_info*);
 extern int pmac_backlight_curve_lookup(struct fb_info *info, int value);
 
 extern int pmac_has_backlight_type(const char *type);
 
-extern void pmac_backlight_key_up(void);
-extern void pmac_backlight_key_down(void);
+extern void pmac_backlight_key(int direction);
+
+#define pmac_backlight_key_up() \
+	do { pmac_backlight_key(0); } while(0);
+#define pmac_backlight_key_down() \
+	do { pmac_backlight_key(1); } while(0);
 
 extern int pmac_backlight_set_legacy_brightness(int brightness);
 extern int pmac_backlight_get_legacy_brightness(void);
