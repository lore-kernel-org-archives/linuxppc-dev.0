Date: Fri, 15 Aug 2003 23:48:46 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5 and serial console
Message-ID: <20030815214846.GA8236@suse.de>
References: <20030504165116.GA22339@suse.de> <20030505172533.GA4762@ip68-0-152-218.tc.ph.cox.net> <20030505174544.GA26356@suse.de> <20030505192910.GA5447@ip68-0-152-218.tc.ph.cox.net> <20030505194410.GA30123@suse.de> <20030507202040.GB20482@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20030507202040.GB20482@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Wed, May 07, Tom Rini wrote:

> > I had serial console set. Maybe I screwed my config while hunting for a
> > workaround.
> > [*] Support for PowerMac serial ports
> > [*]   Support for console on serial port
>
> Well that explains it then.  The pmac code is bad and still uses
> CONFIG_SERIAL_CONSOLE.  It needs to be changed, at a miniumum to
> CONFIG_SERIAL_PMAC_CONSOLE, and the driver really should be ported to
> the new serial backend.

I'm not the one who can port the driver, but this patch makes it useable
for me.

diff -purNX /home/olaf/kernel/kernel_exclude.txt linuxppc-2.5/arch/ppc/Kconfig linux-2.6.0-test3-lxppc25/arch/ppc/Kconfig
--- linuxppc-2.5/arch/ppc/Kconfig	2003-08-05 01:18:06.000000000 +0200
+++ linux-2.6.0-test3-lxppc25/arch/ppc/Kconfig	2003-08-15 22:25:33.000000000 +0200
@@ -1293,7 +1293,7 @@ config MAC_SERIAL
 	  here. If you also have regular serial ports and enable the driver
 	  for them, you can't currently use the serial console feature.

-config SERIAL_CONSOLE
+config SERIAL_PMAC_CONSOLE
 	bool "Support for console on serial port"
 	depends on PPC_PMAC && MAC_SERIAL=y

diff -purNX /home/olaf/kernel/kernel_exclude.txt linuxppc-2.5/drivers/macintosh/macserial.c linux-2.6.0-test3-lxppc25/drivers/macintosh/macserial.c
--- linuxppc-2.5/drivers/macintosh/macserial.c	2003-07-09 05:24:42.000000000 +0200
+++ linux-2.6.0-test3-lxppc25/drivers/macintosh/macserial.c	2003-08-15 22:26:57.000000000 +0200
@@ -28,7 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_PMAC_CONSOLE
 #include <linux/console.h>
 #endif
 #include <linux/slab.h>
@@ -88,7 +88,7 @@ struct tty_struct zs_ttys[NUM_CHANNELS];

 static int is_powerbook;

-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_PMAC_CONSOLE
 static struct console sercons;
 #endif

@@ -2230,7 +2230,7 @@ static int rs_open(struct tty_struct *tt
 		return retval;
 	}

-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_PMAC_CONSOLE
 	if (sercons.cflag && sercons.index == line) {
 		tty->termios->c_cflag = sercons.cflag;
 		sercons.cflag = 0;
@@ -2706,7 +2706,7 @@ void unregister_serial(int line)
  * Serial console driver
  * ------------------------------------------------------------
  */
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_PMAC_CONSOLE

 /*
  *	Print a string to the serial port trying not to disturb
@@ -2950,7 +2950,7 @@ static void __init mac_scc_console_init(
 }
 console_initcall(mac_scc_console_init);

-#endif /* ifdef CONFIG_SERIAL_CONSOLE */
+#endif /* ifdef CONFIG_SERIAL_PMAC_CONSOLE */

 #ifdef CONFIG_KGDB
 /* These are for receiving and sending characters under the kgdb

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
