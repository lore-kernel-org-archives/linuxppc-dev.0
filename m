Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.35])
	by ozlabs.org (Postfix) with ESMTP id C2832688FF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 00:06:14 +1100 (EST)
Received: from linuxdev.ECRIN-CROLLES (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id 8EA6325C0C8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 14:06:13 +0100 (CET)
Date: Mon, 19 Dec 2005 14:09:27 +0100
From: Nathael Pajani <nathael.pajani@cpe.fr>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20051219140927.55259cea.nathael.pajani@cpe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH] CPM initial console on ttyS instead of ttyCPM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

here is a patch to have the CPM consoles on /dev/ttyS* instead of /dev/ttyC=
PM*
Of course, it depends on not already having a 8250 like uart configured, in=
 which case it falls back to ttyCPM.

Signed-off-by: Nathael Pajani <nathael.pajani at cpe.fr>

diff -urpN linux-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart_core.c ecr=
in-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart_core.c
--- linux-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart_core.c	2005-12-16=
 12:08:48.867092000 +0100
+++ ecrin-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart_core.c	2005-12-16=
 11:53:13.140613000 +0100
@@ -70,10 +70,11 @@ static void cpm_uart_init_scc(struct uar
 static void cpm_uart_initbd(struct uart_cpm_port *pinfo);
=20
 /**************************************************************/
+/*cpm2_immr =3D (cpm2_map_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE)*/
=20
 static inline unsigned long cpu2cpm_addr(void *addr)
 {
-	if ((unsigned long)addr >=3D CPM_ADDR)
+	if( (unsigned long)addr >=3D CPM_ADDR )
 		return (unsigned long)addr;
 	return virt_to_bus(addr);
 }
@@ -1072,13 +1073,13 @@ static void cpm_uart_console_write(struc
 }
=20
 /*
- * Setup console. Be careful is called early !
+ * Setup console. Be careful this is called early !
  */
 static int __init cpm_uart_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	struct uart_cpm_port *pinfo;
-	int baud =3D 38400;
+	int baud =3D 9600;	/* NATH: was 38400 */
 	int bits =3D 8;
 	int parity =3D 'n';
 	int flow =3D 'n';
@@ -1136,7 +1137,11 @@ static int __init cpm_uart_console_setup
=20
 static struct uart_driver cpm_reg;
 static struct console cpm_scc_uart_console =3D {
+#ifndef CONFIG_SERIAL_8250
+	.name           =3D "ttyS",
+#else
 	.name		=3D "ttyCPM",
+#endif
 	.write		=3D cpm_uart_console_write,
 	.device		=3D uart_console_device,
 	.setup		=3D cpm_uart_console_setup,
@@ -1163,8 +1168,14 @@ console_initcall(cpm_uart_console_init);
=20
 static struct uart_driver cpm_reg =3D {
 	.owner		=3D THIS_MODULE,
+#ifndef CONFIG_SERIAL_8250
+	.driver_name    =3D "serial",
+/*	.devfs_name     =3D "tts/", */
+	.dev_name       =3D "ttyS",
+#else
 	.driver_name	=3D "ttyCPM",
 	.dev_name	=3D "ttyCPM",
+#endif
 	.major		=3D SERIAL_CPM_MAJOR,
 	.minor		=3D SERIAL_CPM_MINOR,
 	.cons		=3D CPM_UART_CONSOLE,
@@ -1174,7 +1185,7 @@ static int __init cpm_uart_init(void)
 {
 	int ret, i;
=20
-	printk(KERN_INFO "Serial: CPM driver $Revision: 0.01 $\n");
+	printk(KERN_INFO "Serial: CPM driver $Revision: 0.01b $\n");
=20
 #ifndef CONFIG_SERIAL_CPM_CONSOLE
 	ret =3D cpm_uart_init_portdesc();
diff -urpN linux-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart_cpm2.h ecr=
in-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart_cpm2.h
--- linux-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart_cpm2.h	2005-12-16=
 12:08:48.883093000 +0100
+++ ecrin-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart_cpm2.h	2005-12-16=
 11:53:13.144613000 +0100
@@ -20,9 +20,6 @@
 #define SCC3_IRQ	SIU_INT_SCC3
 #define SCC4_IRQ	SIU_INT_SCC4
=20
-/* the CPM address */
-#define CPM_ADDR	CPM_MAP_ADDR
-
 static inline void cpm_set_brg(int brg, int baud)
 {
 	cpm_setbrg(brg, baud);
diff -urpN linux-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart.h ecrin-2.=
6.13.2_light/drivers/serial/cpm_uart/cpm_uart.h
--- linux-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart.h	2005-12-16 12:0=
8:48.863092000 +0100
+++ ecrin-2.6.13.2_light/drivers/serial/cpm_uart/cpm_uart.h	2005-12-16 11:5=
3:13.140613000 +0100
@@ -17,8 +17,13 @@
 #include "cpm_uart_cpm1.h"
 #endif
=20
-#define SERIAL_CPM_MAJOR	204
-#define SERIAL_CPM_MINOR	46
+#ifndef CONFIG_SERIAL_8250
+#define SERIAL_CPM_MAJOR        TTY_MAJOR
+#define SERIAL_CPM_MINOR        64
+#else
+#define SERIAL_CPM_MAJOR        204
+#define SERIAL_CPM_MINOR        46
+#endif
=20
 #define IS_SMC(pinfo) 		(pinfo->flags & FLAG_SMC)
 #define IS_DISCARDING(pinfo)	(pinfo->flags & FLAG_DISCARDING)
diff -urpN linux-2.6.13.2_light/drivers/serial/cpm_uart/Makefile ecrin-2.6.=
13.2_light/drivers/serial/cpm_uart/Makefile
--- linux-2.6.13.2_light/drivers/serial/cpm_uart/Makefile	2005-12-16 12:08:=
48.859091000 +0100
+++ ecrin-2.6.13.2_light/drivers/serial/cpm_uart/Makefile	2005-12-16 11:53:=
13.140613000 +0100
@@ -1,5 +1,5 @@
 #
-# Makefile for the Motorola 8xx FEC ethernet controller
+# Makefile for the CPM ethernet controllers
 #
=20
 obj-$(CONFIG_SERIAL_CPM) +=3D cpm_uart.o


----=20
Nathael PAJANI
Ing=E9nieur CPE Lyon
nathael.pajani@cpe.fr
