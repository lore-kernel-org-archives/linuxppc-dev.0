Return-Path: <torsten.demke@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id E50F22BF26
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 01:47:11 +1100 (EST)
Received: from il06exr06.mot.com (il06exr06.mot.com [129.188.137.136])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id j0CEmqJD011391
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 07:48:52 -0700 (MST)
Received: from zwg57exm01.ds.mot.com (zwg57exm01.ea.mot.com [10.170.189.6])
	by il06exr06.mot.com (Motorola/il06exr06) with ESMTP id j0CEkw61019343
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Jan 2005 08:46:59 -0600
Message-ID: <43395BE65409D911B9FF00110A9BFFDC9F8542@zwg57exm01.ea.mot.com>
From: Demke Torsten-atd012 <torsten.demke@motorola.com>
To: David Jander <david.jander@protonic.nl>,
	linuxppc-embedded@ozlabs.org
Date: Wed, 12 Jan 2005 15:46:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: MPC8xx: Using SCM/SCC and standard 16C550 Uarts together...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello David,
> 
> On Wednesday 12 January 2005 10:59, Demke Torsten-atd012 wrote:
> > I dont know exactly the state of the DENX kernel, but in 
> the standard
> > kernel the 8xx UART driver and the 16550 driver are using the same
> > device numbers (TTY_MAJOR) and device names (/dev/ttySx).
> > You have to change one of them.
> 
> You are right! What now? I cannot go around and change TTY_MAJOR!
> Is it true then, that you normally cannot have a mix of 
> non-16550 uarts and 
> 16550 uarts on the same system, without doing nonstandard 
> things with major 
> numbers?
> Should maybe arch/ppc/8xx_io/uart.c use another major number?
Yes, indeed I changed the major device number and the name in 
8xx_io/uart.c. I used the same numbers and names that are used
in the 2.6 kernel (TTY_CPM_MAJOR=42, name= "ttyCPM"). Of course
you have to change all applications that use the 8xx UART then.

See pseudo-patch:

+#ifdef CONFIG_SERIAL_CONSOLE
 static struct console sercons = {
-	name:		"ttyS",
+	name:		"ttyCPM",
 	write:		serial_console_write,
 	device:		serial_console_device,
 	setup:		serial_console_setup,
 	flags:		CON_PRINTBUFFER,
 	index:		CONFIG_SERIAL_CONSOLE_PORT,
 };
+#endif

...

 static kdev_t serial_console_device(struct console *c)
 {
+#ifdef CONFIG_SERIAL
+	return MKDEV(TTY_CPM_MAJOR, 42 + c->index);
+#else
 	return MKDEV(TTY_MAJOR, 64 + c->index);
+#endif
 }

...

 	serial_driver.magic = TTY_DRIVER_MAGIC;
 	serial_driver.driver_name = "serial";
+#ifdef CONFIG_SERIAL
+/* use different numbers if "standard" serial driver is enabled */
+	serial_driver.driver_name = "serialCPM";
+#ifdef CONFIG_DEVFS_FS
+	serial_driver.name = "tts/%d";
+#else
+	serial_driver.name = "ttyCPM";
+#endif
+	serial_driver.major = TTY_CPM_MAJOR;
+	serial_driver.minor_start = 42;
+#else
+	serial_driver.driver_name = "serial";
 #ifdef CONFIG_DEVFS_FS
 	serial_driver.name = "tts/%d";
 #else
@@ -2553,6 +2585,7 @@ int __init rs_8xx_init(void)
 #endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
+#endif /* CONFIG_SERIAL */
 	serial_driver.num = NR_PORTS;
 	serial_driver.type = TTY_DRIVER_TYPE_SERIAL;
 	serial_driver.subtype = SERIAL_TYPE_NORMAL;

Greetings,
Torsten

> 
> Greetings,
> 
> -- 
> David Jander
> Protonic Holland.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
