Return-Path: <vbarshak@dev.rtsoft.ru>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2E047DDF75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Mar 2007 06:21:56 +1100 (EST)
Received: from [192.168.12.21] (unknown [10.149.0.1])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 5B9CF8814
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Mar 2007 23:02:55 +0400 (SAMT)
Message-ID: <46002FB2.7060802@dev.rtsoft.ru>
Date: Tue, 20 Mar 2007 22:02:10 +0300
From: Valentine Barshak <vbarshak@dev.rtsoft.ru>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Enable IRQ0 for PPC4xx UART.
Content-Type: multipart/mixed; boundary="------------080606000205000308000102"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080606000205000308000102
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit



--------------080606000205000308000102
Content-Type: text/plain;
 name="ppc4xx_uart_irq0_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc4xx_uart_irq0_fix.patch"

[PATCH] Enable IRQ0 for PPC4xx UART

Redefine is_real_interrupt(irq) macro,
since IRQ0 is valid for PPC4xx platform.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

diff -ruN linux.orig/include/asm-ppc/serial.h linux/include/asm-ppc/serial.h
--- linux.orig/include/asm-ppc/serial.h	2007-03-16 18:04:16.000000000 +0300
+++ linux/include/asm-ppc/serial.h	2007-03-20 15:52:02.000000000 +0300
@@ -28,6 +28,9 @@
 #elif defined(CONFIG_SPRUCE)
 #include <platforms/spruce.h>
 #elif defined(CONFIG_4xx)
+/* UART IRQ0 is valid for PPC4xx */
+#undef is_real_interrupt
+#define is_real_interrupt(irq)	((irq) >= 0)
 #include <asm/ibm4xx.h>
 #elif defined(CONFIG_83xx)
 #include <asm/mpc83xx.h>

--------------080606000205000308000102--
