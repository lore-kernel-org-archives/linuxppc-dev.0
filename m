Date: Tue, 12 Dec 2000 10:12:18 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Mac/m68k patches?
Message-ID: <Pine.GSO.4.10.10012121010320.1109-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

I have these Mac/m68k patches in my patchqueue which affect PowerMac as well.
Anyone who has a problem with them, or can I send them to Linus?

diff -urN linux-2.4.0-test12/drivers/input/keybdev.c linux-m68k-2.4.0-test12/drivers/input/keybdev.c
--- linux-2.4.0-test12/drivers/input/keybdev.c	Fri Jul 28 03:36:54 2000
+++ linux-m68k-2.4.0-test12/drivers/input/keybdev.c	Tue Dec 12 09:02:47 2000
@@ -90,7 +90,7 @@
 	return 0;
 }

-#elif defined(CONFIG_ADB_KEYBOARD)
+#elif defined(CONFIG_INPUT_ADBHID)

 static unsigned char mac_keycodes[128] =
 	{ 0, 53, 18, 19, 20, 21, 23, 22, 26, 28, 25, 29, 27, 24, 51, 48,
diff -urN linux-2.4.0-test12/drivers/macintosh/adb.c linux-m68k-2.4.0-test12/drivers/macintosh/adb.c
--- linux-2.4.0-test12/drivers/macintosh/adb.c	Sun Sep 17 18:48:05 2000
+++ linux-m68k-2.4.0-test12/drivers/macintosh/adb.c	Tue Dec 12 09:02:47 2000
@@ -61,7 +61,7 @@
 #ifdef CONFIG_ADB_IOP
 	&adb_iop_driver,
 #endif
-#ifdef CONFIG_ADB_PMU
+#if defined(CONFIG_ADB_PMU) || defined(CONFIG_ADB_PMU68K)
 	&via_pmu_driver,
 #endif
 #ifdef CONFIG_ADB_MACIO
@@ -335,7 +335,7 @@
 	    int flags, int nbytes, ...)
 {
 	va_list list;
-	int i;
+	int i,len;
 	struct adb_request sreq;

 	if ((adb_controller == NULL) || (adb_controller->send_request == NULL))
@@ -347,13 +347,22 @@
 		req = &sreq;
 		flags |= ADBREQ_SYNC;
 	}
-	req->nbytes = nbytes+1;
+	if (flags & ADBREQ_RAW) {
+		i = 0;
+		len = nbytes;
+	} else {
+		req->data[0] = ADB_PACKET;
+		i = 1;
+		len = nbytes+1;
+	}
+	req->nbytes = len;
 	req->done = done;
 	req->reply_expected = flags & ADBREQ_REPLY;
 	req->data[0] = ADB_PACKET;
 	va_start(list, nbytes);
-	for (i = 0; i < nbytes; ++i)
-		req->data[i+1] = va_arg(list, int);
+	while(i < len) {
+		req->data[i++] = va_arg(list, int);
+	}
 	va_end(list);

 	if (flags & ADBREQ_NOSEND)
diff -urN linux-2.4.0-test12/drivers/macintosh/adbhid.c linux-m68k-2.4.0-test12/drivers/macintosh/adbhid.c
--- linux-2.4.0-test12/drivers/macintosh/adbhid.c	Sun Sep 17 18:48:05 2000
+++ linux-m68k-2.4.0-test12/drivers/macintosh/adbhid.c	Tue Dec 12 09:02:45 2000
@@ -855,8 +855,10 @@

 static int __init adbhid_init(void)
 {
+#ifndef CONFIG_MAC
 	if ( (_machine != _MACH_chrp) && (_machine != _MACH_Pmac) )
 	    return 0;
+#endif

 	led_request.complete = 1;

diff -urN linux-2.4.0-test12/drivers/macintosh/via-cuda.c linux-m68k-2.4.0-test12/drivers/macintosh/via-cuda.c
--- linux-2.4.0-test12/drivers/macintosh/via-cuda.c	Sun Sep 17 18:48:05 2000
+++ linux-m68k-2.4.0-test12/drivers/macintosh/via-cuda.c	Tue Dec 12 09:02:48 2000
@@ -220,12 +220,19 @@
 static int
 cuda_init(void)
 {
+#ifdef CONFIG_PPC
     if (via == NULL)
 	return -ENODEV;
-#ifndef CONFIG_PPC
+    return 0;
+#else
+    int err = cuda_init_via();
+    if (err) {
+	printk(KERN_ERR "cuda_init_via() failed\n");
+	return -ENODEV;
+    }
+
     return via_cuda_start();
 #endif
-    return 0;
 }
 #endif /* CONFIG_ADB */

diff -urN linux-2.4.0-test12/include/linux/adb.h linux-m68k-2.4.0-test12/include/linux/adb.h
--- linux-2.4.0-test12/include/linux/adb.h	Sun Sep 17 18:48:05 2000
+++ linux-m68k-2.4.0-test12/include/linux/adb.h	Tue Dec 12 09:02:49 2000
@@ -67,6 +67,7 @@
 #define ADBREQ_REPLY	1	/* expect reply */
 #define ADBREQ_SYNC	2	/* poll until done */
 #define ADBREQ_NOSEND	4	/* build the request, but don't send it */
+#define ADBREQ_RAW	8	/* send raw packet (don't prepend ADB_PACKET) */

 /* Messages sent thru the client_list notifier. You should NOT stop
    the operation, at least not with this version */
diff -urN linux-2.4.0-test12/include/linux/pmu.h linux-m68k-2.4.0-test12/include/linux/pmu.h
--- linux-2.4.0-test12/include/linux/pmu.h	Sun Sep 17 18:48:05 2000
+++ linux-m68k-2.4.0-test12/include/linux/pmu.h	Tue Dec 12 09:02:50 2000
@@ -63,6 +63,8 @@
 	PMU_HEATHROW_BASED,	/* PowerBook G3 series */
 	PMU_PADDINGTON_BASED,	/* 1999 PowerBook G3 */
 	PMU_KEYLARGO_BASED,	/* Core99 motherboard (PMU99) */
+	PMU_68K_V1,		/* 68K PMU, version 1 */
+	PMU_68K_V2, 		/* 68K PMU, version 2 */
 };

 /* PMU PMU_POWER_EVENTS commands */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
