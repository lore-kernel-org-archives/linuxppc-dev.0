Message-Id: <sc0c9d3f.050@gw_tms_syd2.pty.tms.thomson-csf.com>
Date: Tue, 04 Dec 2001 09:53:57 +1100
From: "Jeremy Rosen" <Jeremy.Rosen@au.thalesgroup.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH]    mutiple uart with devfs
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_C598F89F.34553A59"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a MIME message. If you are reading this text, you may want to
consider changing to a mail reader or gateway that understands how to
properly handle MIME multipart messages.

--=_C598F89F.34553A59
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline

I had weird messages from devfs when the UART driver was trying to
install itself. Devfs was trying to register a ttyS entry wich already
existed.

After comparing with serial.c, I think that I understood what was
going. the attached patch should correct this problem


bye

Jeremy

P.S : sorry if the diff is not perfect, this is my first patch...

--=_C598F89F.34553A59
Content-Type: text/plain
Content-Disposition: attachment; filename="uart_devfs.diff"

--- uart.bak	Tue Dec  4 09:50:54 2001
+++ uart.c	Tue Dec  4 10:06:43 2001
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/version.h>
 #include <asm/uaccess.h>
 #include <asm/8xx_immap.h>
 #include <asm/mpc8xx.h>
@@ -2529,7 +2530,11 @@
 	__clear_user(&serial_driver,sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
 	serial_driver.driver_name = "serial";
-	serial_driver.name = "ttyS";
+#if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
+        serial_driver.name = "tts/%d";
+#else
+        serial_driver.name = "ttyS";
+#endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
 	serial_driver.num = NR_PORTS;
@@ -2567,7 +2572,11 @@
 	 * major number and the subtype code.
 	 */
 	callout_driver = serial_driver;
-	callout_driver.name = "cua";
+#if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
+        callout_driver.name = "cua/%d";
+#else
+        callout_driver.name = "cua";
+#endif
 	callout_driver.major = TTYAUX_MAJOR;
 	callout_driver.subtype = SERIAL_TYPE_CALLOUT;
 	callout_driver.read_proc = 0;

--=_C598F89F.34553A59--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
