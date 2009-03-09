Return-Path: <andrew@cesa.opbu.xerox.com>
Received: from wbmler5.mail.xerox.com (wbmler5.mail.xerox.com [13.13.138.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler5.mail.xerox.com",
	Issuer "AAA Certificate Services" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A780DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 05:04:04 +1100 (EST)
Received: from wbmlir1.mail.xerox.com (wbmlir1.mail.xerox.com [13.131.8.221])
	by wbmler5.mail.xerox.com (8.14.2/8.13.8) with ESMTP id
	n29Hqtx2019743
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 13:52:55 -0400
Received: from wbmlir1.mail.xerox.com (localhost [127.0.0.1])
	by wbmlir1.mail.xerox.com (8.14.2/8.13.6) with ESMTP id n29HqhGl011282
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 13:52:43 -0400
Received: from hermes.opbu.xerox.com (hermes.opbu.xerox.com [13.62.6.81])
	by wbmlir1.mail.xerox.com (8.14.2/8.13.6) with ESMTP id n29Hqg6L011252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 13:52:43 -0400
Received: from pogo.cesa.opbu.xerox.com (ns158-4.cesa.opbu.xerox.com
	[13.253.158.23])
	by hermes.opbu.xerox.com (8.13.8+Sun/8.13.8) with ESMTP id
	n29HqgOj027321
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 10:52:42 -0700 (PDT)
Received: from cesa.opbu.xerox.com (gto.cesa.opbu.xerox.com [13.62.136.98])
	by pogo.cesa.opbu.xerox.com (8.13.6+Sun/8.13.6) with ESMTP id
	n29HqfrT005075
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Mar 2009 10:52:42 -0700 (PDT)
Message-Id: <200903091752.n29HqfrT005075@pogo.cesa.opbu.xerox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc udbg: fix lost byte during console handover;
	change LFCR to CRLF
Date: Mon, 09 Mar 2009 10:52:41 -0700
From: Andrew Klossner <andrew@cesa.opbu.xerox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When the console is on a serial port to be driven by serial8250, a
character can be lost from the end of the first line in the two-line
sequence

	serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 42) is a 16550A
	console handover: boot [udbg0] -> real [ttyS0]

This happens because udbg_puts or udbg_write stuff the last byte of
the line into the Tx FIFO and return, whereupon the serial8250
initialization code immediately empties that FIFO.  The fix: udbg_puts
and udbg_write now wait for the Tx FIFO to clear before returning.
This delays the system by one additional serial frame time for each
line written by udbg, but the effect is not noticeable, a cumulative
17 milliseconds for 200 lines of early printk output at 115200 baud.

Also, the routines in udbg_16550.c now emit CRLF instead of LFCR.
Linux makes a point of emitting CRLF because, when serial output is
captured to a file, LFCR sequences can confuse text editors.  See
http://lkml.org/lkml/2006/2/4/50 for some history.

Signed-off-by: Andrew Klossner <andrew@cesa.opbu.xerox.com>
---
 arch/powerpc/include/asm/udbg.h  |    1 +
 arch/powerpc/kernel/udbg.c       |    7 ++++
 arch/powerpc/kernel/udbg_16550.c |   60 +++++++++++++++++++++++++++++++------
 3 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index 6418cee..cd21e5e 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 
 extern void (*udbg_putc)(char c);
+extern void (*udbg_flush)(void);
 extern int (*udbg_getc)(void);
 extern int (*udbg_getc_poll)(void);
 
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 7d6c9bb..fc9af47 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -18,6 +18,7 @@
 #include <asm/udbg.h>
 
 void (*udbg_putc)(char c);
+void (*udbg_flush)(void);
 int (*udbg_getc)(void);
 int (*udbg_getc_poll)(void);
 
@@ -76,6 +77,9 @@ void udbg_puts(const char *s)
 			while ((c = *s++) != '\0')
 				udbg_putc(c);
 		}
+
+		if (udbg_flush)
+			udbg_flush();
 	}
 #if 0
 	else {
@@ -98,6 +102,9 @@ int udbg_write(const char *s, int n)
 		}
 	}
 
+	if (udbg_flush)
+		udbg_flush();
+
 	return n - remain;
 }
 
diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_16550.c
index 7b7da8c..0362a89 100644
--- a/arch/powerpc/kernel/udbg_16550.c
+++ b/arch/powerpc/kernel/udbg_16550.c
@@ -48,14 +48,21 @@ struct NS16550 {
 
 static struct NS16550 __iomem *udbg_comport;
 
-static void udbg_550_putc(char c)
+static void udbg_550_flush(void)
 {
 	if (udbg_comport) {
 		while ((in_8(&udbg_comport->lsr) & LSR_THRE) == 0)
 			/* wait for idle */;
-		out_8(&udbg_comport->thr, c);
+	}
+}
+
+static void udbg_550_putc(char c)
+{
+	if (udbg_comport) {
 		if (c == '\n')
 			udbg_550_putc('\r');
+		udbg_550_flush();
+		out_8(&udbg_comport->thr, c);
 	}
 }
 
@@ -108,6 +115,7 @@ void udbg_init_uart(void __iomem *comport, unsigned int speed,
 		/* Clear & enable FIFOs */
 		out_8(&udbg_comport->fcr ,0x07);
 		udbg_putc = udbg_550_putc;
+		udbg_flush = udbg_550_flush;
 		udbg_getc = udbg_550_getc;
 		udbg_getc_poll = udbg_550_getc_poll;
 	}
@@ -149,14 +157,21 @@ unsigned int udbg_probe_uart_speed(void __iomem *comport, unsigned int clock)
 }
 
 #ifdef CONFIG_PPC_MAPLE
-void udbg_maple_real_putc(char c)
+void udbg_maple_real_flush(void)
 {
 	if (udbg_comport) {
 		while ((real_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
 			/* wait for idle */;
-		real_writeb(c, &udbg_comport->thr); eieio();
+	}
+}
+
+void udbg_maple_real_putc(char c)
+{
+	if (udbg_comport) {
 		if (c == '\n')
 			udbg_maple_real_putc('\r');
+		udbg_maple_real_flush();
+		real_writeb(c, &udbg_comport->thr); eieio();
 	}
 }
 
@@ -165,20 +180,28 @@ void __init udbg_init_maple_realmode(void)
 	udbg_comport = (struct NS16550 __iomem *)0xf40003f8;
 
 	udbg_putc = udbg_maple_real_putc;
+	udbg_flush = udbg_maple_real_flush;
 	udbg_getc = NULL;
 	udbg_getc_poll = NULL;
 }
 #endif /* CONFIG_PPC_MAPLE */
 
 #ifdef CONFIG_PPC_PASEMI
-void udbg_pas_real_putc(char c)
+void udbg_pas_real_flush(void)
 {
 	if (udbg_comport) {
 		while ((real_205_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
 			/* wait for idle */;
-		real_205_writeb(c, &udbg_comport->thr); eieio();
+	}
+}
+
+void udbg_pas_real_putc(char c)
+{
+	if (udbg_comport) {
 		if (c == '\n')
 			udbg_pas_real_putc('\r');
+		udbg_pas_real_flush();
+		real_205_writeb(c, &udbg_comport->thr); eieio();
 	}
 }
 
@@ -187,6 +210,7 @@ void udbg_init_pas_realmode(void)
 	udbg_comport = (struct NS16550 __iomem *)0xfcff03f8UL;
 
 	udbg_putc = udbg_pas_real_putc;
+	udbg_flush = udbg_pas_real_flush;
 	udbg_getc = NULL;
 	udbg_getc_poll = NULL;
 }
@@ -195,14 +219,21 @@ void udbg_init_pas_realmode(void)
 #ifdef CONFIG_PPC_EARLY_DEBUG_44x
 #include <platforms/44x/44x.h>
 
-static void udbg_44x_as1_putc(char c)
+static int udbg_44x_as1_flush(void)
 {
 	if (udbg_comport) {
 		while ((as1_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
 			/* wait for idle */;
-		as1_writeb(c, &udbg_comport->thr); eieio();
+	}
+}
+
+static void udbg_44x_as1_putc(char c)
+{
+	if (udbg_comport) {
 		if (c == '\n')
 			udbg_44x_as1_putc('\r');
+		udbg_44x_as1_flush();
+		as1_writeb(c, &udbg_comport->thr); eieio();
 	}
 }
 
@@ -222,19 +253,27 @@ void __init udbg_init_44x_as1(void)
 		(struct NS16550 __iomem *)PPC44x_EARLY_DEBUG_VIRTADDR;
 
 	udbg_putc = udbg_44x_as1_putc;
+	udbg_flush = udbg_44x_as1_flush;
 	udbg_getc = udbg_44x_as1_getc;
 }
 #endif /* CONFIG_PPC_EARLY_DEBUG_44x */
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_40x
-static void udbg_40x_real_putc(char c)
+static void udbg_40x_real_flush(void)
 {
 	if (udbg_comport) {
 		while ((real_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
 			/* wait for idle */;
-		real_writeb(c, &udbg_comport->thr); eieio();
+	}
+}
+
+static void udbg_40x_real_putc(char c)
+{
+	if (udbg_comport) {
 		if (c == '\n')
 			udbg_40x_real_putc('\r');
+		udbg_40x_real_flush();
+		real_writeb(c, &udbg_comport->thr); eieio();
 	}
 }
 
@@ -254,6 +293,7 @@ void __init udbg_init_40x_realmode(void)
 		CONFIG_PPC_EARLY_DEBUG_40x_PHYSADDR;
 
 	udbg_putc = udbg_40x_real_putc;
+	udbg_flush = udbg_40x_real_flush;
 	udbg_getc = udbg_40x_real_getc;
 	udbg_getc_poll = NULL;
 }
-- 
1.6.1.3
