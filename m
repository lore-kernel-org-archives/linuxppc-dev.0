Message-Id: <200005302237.AAA00626@piglet.grunz.lu>
Date: Wed, 31 May 2000 00:37:45 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Serial console in 2.3.99 (PATCH)
To: toa@pop.agri.ch
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3932D946.2E0955C3@pop.agri.ch>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-959726265=:625"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-959726265=:625
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

On  29 May, this message from Andreas Tobler echoed through cyberspace:
>> I don't seem to get the serial console working in Paul's 2.3.99-pre9. I
>> have tried all kernel command lines, but no dice.... I had it working in
>> 2.2.15, but that same command line does not work for 2.3.99.
[snip]
> In other words, I'm also interested in getting this to work.

Well, here comes the patch to get the mac serial console working in the
late 2.3.99 and 2.4.0 kernel series.

The problem was that macserial.c used serial_console_init() to init the
serial ports as possible console devices, but that function was only
called when CONFIG_SERIAl (i.e.generic PC-style serial ports) was
enabled. On the other hand, macserial.c refused to compile serial
console support in (in fact, refused to compile at all) with
CONFIG_SERIAl set. Errr.....

Well, my fix changes the mac serial console init function to
mac_scc_console_init(), so it's not exclusive vs. PC-style serial ports.
However, as there are potential problems with port naming, if you have
CONFIG_MAC_SERIAl, CONFIG_SERIAl and CONFIG_SERIAl_CONSOLE all set, mac
serial ports will take precedence, and no console device can be on a
PC-style serial port. I'm not sure there's a simple way to fix this
short of givng the mac serial ports a different name (not ttyS...) so
they are differentiated from PC-style serial.

Anyway, while I was at it, I also included a check on the kernel command
line options for serial ports, so that specifying console=ttyS99 doesn't
crash the kernel ;-)

Please test, especially on machines having both mac-style and PC-style
serial ports, an report back. I'd like to send this off to Alan ASAP.

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-959726265=:625
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="serial.diff"

--- linux-2.3.paul/drivers/char/tty_io.c	Thu May 11 11:56:26 2000
+++ linux-2.3.paul-work/drivers/char/tty_io.c	Wed May 31 00:19:43 2000
@@ -150,6 +150,9 @@
 extern void console_8xx_init(void);
 extern int rs_8xx_init(void);
 #endif /* CONFIG_8xx */
+#ifdef CONFIG_MAC_SERIAL
+extern void mac_scc_console_init(void);
+#endif /* CONFIG_MAC_SERIAL */
 #ifdef CONFIG_HWC
 extern void hwc_console_init(void);
 #endif
@@ -2196,16 +2199,18 @@
 #ifdef CONFIG_SERIAL_CONSOLE
 #if (defined(CONFIG_8xx) || defined(CONFIG_8260))
 	console_8xx_init();
+#elif defined(CONFIG_MAC_SERIAL)
+	mac_scc_console_init();
 #elif defined(CONFIG_SERIAL)
 	serial_console_init();
 #endif /* CONFIG_8xx */
 #if defined(CONFIG_MVME162_SCC) || defined(CONFIG_BVME6000_SCC) || defined(CONFIG_MVME147_SCC)
 	vme_scc_console_init();
-#endif
+#endif /* CONFIG_xVME */
 #if defined(CONFIG_SERIAL167)
 	serial167_console_init();
-#endif
-#endif
+#endif /* CONFIG_SERIAL167 */
+#endif /* CONFIG_SERIAL_CONSOLE */
 #ifdef CONFIG_3215
         con3215_init();
 #endif
--- linux-2.3.paul/drivers/macintosh/macserial.c	Wed Apr 26 09:14:19 2000
+++ linux-2.3.paul-work/drivers/macintosh/macserial.c	Wed May 31 00:20:16 2000
@@ -2643,9 +2643,6 @@
  * ------------------------------------------------------------
  */
 #ifdef CONFIG_SERIAL_CONSOLE
-#ifdef CONFIG_SERIAL
-#error Cannot build serial console with macserial and serial drivers
-#endif

 /*
  *	Print a string to the serial port trying not to disturb
@@ -2719,7 +2716,7 @@
  */
 static int __init serial_console_setup(struct console *co, char *options)
 {
-	struct mac_serial *info = zs_soft + co->index;
+	struct mac_serial *info;
 	int	baud = 38400;
 	int	bits = 8;
 	int	parity = 'n';
@@ -2735,6 +2732,11 @@
 	if (zs_chain == 0)
 		return -1;

+	/* Do we have the device asked for? */
+	if (co->index >= zs_channels_found)
+		return -1;
+	info = zs_soft + co->index;
+
 	set_scc_power(info, 1);

 	/* Reset the channel */
@@ -2904,7 +2906,7 @@
 /*
  *	Register console.
  */
-void __init serial_console_init(void)
+void __init mac_scc_console_init(void)
 {
 	register_console(&sercons);
 }

--134392852-1804289383-959726265=:625-
ontent-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="serial.diff"


--134392852-1804289383-959726265=:625--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
