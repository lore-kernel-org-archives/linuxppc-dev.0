Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 89EF72BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Oct 2004 09:35:05 +1000 (EST)
Date: Thu, 28 Oct 2004 16:34:59 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20041028163459.A5934@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: scott_anderson@mvista.com, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Fix ppc4xx_progress warnings
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The patch fixes these warnings by doing two things:
   1) Add the argument to the printk.
   2) Rearrange the ifdef to eliminate the unused variable
      and function warnings.

Signed-off-by: Scott Anderson <sanders@mvista.com>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

--- arch/ppc/syslib/ppc4xx_setup.c.~1~	2004-10-18 14:53:06.000000000 -0700
+++ arch/ppc/syslib/ppc4xx_setup.c	2004-10-28 15:24:59.000000000 -0700
@@ -191,6 +191,7 @@ ppc4xx_calibrate_decr(void)
 }
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 
+#ifdef SERIAL_DEBUG_IO_BASE
 /* We assume that the UART has already been initialized by the
    firmware or the boot loader */
 static void
@@ -204,7 +205,6 @@ static void
 ppc4xx_progress(char *s, unsigned short hex)
 {
 	char c;
-#ifdef SERIAL_DEBUG_IO_BASE
 	u8 *com_port = (u8 *) SERIAL_DEBUG_IO_BASE;
 
 	while ((c = *s++) != '\0') {
@@ -212,10 +212,14 @@ ppc4xx_progress(char *s, unsigned short 
 	}
 	serial_putc(com_port, '\r');
 	serial_putc(com_port, '\n');
+}
 #else
-	printk("%s\r\n");
-#endif
+static void
+ppc4xx_progress(char *s, unsigned short hex)
+{
+	printk("%s\r\n", s);
 }
+#endif
 #endif				/* CONFIG_SERIAL_TEXT_DEBUG */
 
 /*
