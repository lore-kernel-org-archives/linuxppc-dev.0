Subject: [PATCH]: Fixes CONFIG_CONFIG_CPM2_UART bug in tty_io.c
From: Jeff Angielski <jangiels@speakeasy.net>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Content-Type: multipart/mixed; boundary="=-bRS9oMriilfIoKojgI1r"
Message-Id: <1092088985.4368.8.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 09 Aug 2004 18:03:05 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-bRS9oMriilfIoKojgI1r
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is a very small patch to fix a configuration bug in
drivers/char/tty_io.c where the CPM2 UART would not work for non-8xx
targets.

Cheers,
Jeff Angielski



--=-bRS9oMriilfIoKojgI1r
Content-Disposition: attachment; filename=cpm2uart.patch
Content-Type: text/plain; name=cpm2uart.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== drivers/char/tty_io.c 1.33 vs edited =====
--- 1.33/drivers/char/tty_io.c	Tue Aug  3 16:53:10 2004
+++ edited/drivers/char/tty_io.c	Mon Aug  9 14:17:34 2004
@@ -2250,7 +2250,7 @@
 	au1x00_serial_console_init();
 #endif
 #ifdef CONFIG_SERIAL_CONSOLE
-#if defined(CONFIG_8xx) || defined(CONFIG_CONFIG_CPM2_UART)
+#if defined(CONFIG_8xx) || defined(CONFIG_CPM2_UART)
 	console_8xx_init();
 #elif defined(CONFIG_MAC_SERIAL) && defined(CONFIG_SERIAL)
 	if (_machine == _MACH_Pmac)
@@ -2439,7 +2439,7 @@
 #ifdef CONFIG_SPECIALIX
 	specialix_init();
 #endif
-#if (defined(CONFIG_8xx) || (defined(CONFIG_CPM2) && defined(CONFIG_CONFIG_CPM2_UART)))
+#if (defined(CONFIG_8xx) || (defined(CONFIG_CPM2) && defined(CONFIG_CPM2_UART)))
 	rs_8xx_init();
 #endif /* CONFIG_8xx */
 	pty_init();

--=-bRS9oMriilfIoKojgI1r--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
