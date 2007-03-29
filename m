Return-Path: <SRS0+97d39be1a89b1495b2c5+1313+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: [PATCH] Sync PS3 framebuffer on panic.
From: David Woodhouse <dwmw2@infradead.org>
To: cbe-oss-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 29 Mar 2007 23:46:27 +0100
Message-Id: <1175208387.3122.82.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's not a lot of point in printing a nice message about the panic
unless we then ask the hypervisor to update the screen for us. It's a
hack, but in the absence of sensible devel units with a real console
(thanks, Sony!) it's the best we can do.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index ac5df96..1ae9091 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -46,6 +46,8 @@
 static void smp_send_stop(void) {}
 #endif
 
+extern void ps3fb_sync(int);
+
 int ps3_get_firmware_version(union ps3_firmware_version *v)
 {
 	int result = lv1_get_version_info(&v->raw);
@@ -88,8 +90,20 @@ static void ps3_power_off(void)
 
 static void ps3_panic(char *str)
 {
+	static int panicked = 0;
+
 	DBG("%s:%d %s\n", __func__, __LINE__, str);
 
+#ifdef CONFIG_FB_PS3
+	/* It's almost certainly the only available console device outside
+	   Sony, and we don't _see_ the events leading up to the panic 
+	   unless we ask the hypervisor to update it. So do so. Once. */
+	if (!panicked) {
+		panicked = 1;
+		ps3fb_sync(0);
+	}
+#endif
+
 	smp_send_stop();
 	printk("\n");
 	printk("   System does not reboot automatically.\n");
diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 81e43cd..f90a43e 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -381,7 +381,7 @@ static const struct fb_videomode *ps3fb_default_mode(void)
 	return &ps3fb_modedb[mode - 1];
 }
 
-static int ps3fb_sync(u32 frame)
+int ps3fb_sync(u32 frame)
 {
 	int i, status;
 	u32 xres, yres;

-- 
dwmw2
