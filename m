From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Tom Rini" <trini@kernel.crashing.org>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] CPCI405 update (2nd version)
Date: Thu, 27 Mar 2003 11:56:37 +0100
Message-ID: <EFEAIMDCOOOHIEPHDNFJGEOBFDAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0012_01C2F457.EBDEBB50"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0012_01C2F457.EBDEBB50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello

Please forget the patch from yesterday! I just found a small calculation
bug. Here is the corrected version:

The attached patch fixes a baudrate problem with the 400MHz version of the
PPC405GPr on the CPCI405 board.

- Added cpci405_early_serial_map (cloned from evb405ep) to generate
BASE_BAUD dynamically from the UDIV settings (configured by U-Boot).

Please apply this patch to linuxppc_2_4_devel.

Best regards,
Stefan.

------=_NextPart_000_0012_01C2F457.EBDEBB50
Content-Type: application/octet-stream;
	name="linuxppc_2_4_devel_2.4.21pre5.patch2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linuxppc_2_4_devel_2.4.21pre5.patch2"

diff -N -u -r --exclude=3DCVS --exclude=3DLOG =
linuxppc_2_4_devel_2.4.21pre5_orig/arch/ppc/platforms/cpci405.c =
linuxppc_2_4_devel_2.4.21pre5_esd/arch/ppc/platforms/cpci405.c=0A=
--- linuxppc_2_4_devel_2.4.21pre5_orig/arch/ppc/platforms/cpci405.c	Wed =
Mar 26 14:00:18 2003=0A=
+++ linuxppc_2_4_devel_2.4.21pre5_esd/arch/ppc/platforms/cpci405.c	Thu =
Mar 27 11:46:30 2003=0A=
@@ -6,7 +6,7 @@=0A=
  * Author: Stefan Roese=0A=
  *         stefan.roese@esd-electronics.com=0A=
  *=0A=
- * Copyright 2001 esd electronic system design - hannover germany=0A=
+ * Copyright 2001-2003 esd electronic system design - hannover germany=0A=
  *=0A=
  * This program is free software; you can redistribute  it and/or =
modify it=0A=
  * under  the terms of  the GNU General Public License as published by =
the=0A=
@@ -16,6 +16,10 @@=0A=
  *	History: 11/09/2001 - armin=0A=
  *       added board_init to add in additional instuctions needed =
during platfrom_init=0A=
  *=0A=
+ * 		: 03/26/03 - stefan=0A=
+ *		Added cpci405_early_serial_map (cloned from evb405ep) to generate=0A=
+ *		BASE_BAUD dynamically from the UDIV settings (configured by U-Boot).=0A=
+ *=0A=
  */=0A=
 =0A=
 #include <linux/config.h>=0A=
@@ -25,8 +29,9 @@=0A=
 #include <asm/pci-bridge.h>=0A=
 #include <asm/machdep.h>=0A=
 #include <asm/todc.h>=0A=
+#include <linux/serial.h>=0A=
 =0A=
-void *cpci405_nvram; =0A=
+void *cpci405_nvram;=0A=
 =0A=
 /*=0A=
  * Some IRQs unique to CPCI-405.=0A=
@@ -52,9 +57,65 @@=0A=
 	return PCI_IRQ_TABLE_LOOKUP;=0A=
 };=0A=
 =0A=
+/* The serial clock for the chip is an internal clock determined by=0A=
+ * different clock speeds/dividers.=0A=
+ * Calculate the proper input baud rate and setup the serial driver.=0A=
+ */=0A=
+static void __init=0A=
+cpci405_early_serial_map(void)=0A=
+{=0A=
+	u32 uart_div;=0A=
+	int serial_baud_405;=0A=
+	bd_t *bip =3D (bd_t *) __res;=0A=
+	struct serial_struct serialreq =3D {0};=0A=
+=0A=
+         /* Calculate the serial clock input frequency=0A=
+          *=0A=
+          * The base baud is the PLL OUTA (provided in the board info=0A=
+          * structure) divided by the external UART Divisor, divided=0A=
+          * by 16.=0A=
+          */=0A=
+	uart_div =3D ((mfdcr(DCRN_CHCR_BASE) & CHR0_UDIV) >> 1) + 1;=0A=
+	serial_baud_405 =3D bip->bi_procfreq / uart_div / 16;=0A=
+=0A=
+	/* Update the serial port attributes */=0A=
+	serialreq.baud_base =3D serial_baud_405;=0A=
+	serialreq.flags =3D (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST);=0A=
+	serialreq.io_type =3D SERIAL_IO_MEM;=0A=
+=0A=
+	serialreq.line =3D 0;=0A=
+	serialreq.port =3D 0;=0A=
+	serialreq.irq =3D ACTING_UART0_INT;=0A=
+	serialreq.iomem_base =3D (void*)ACTING_UART0_IO_BASE;=0A=
+=0A=
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)=0A=
+	/* Configure debug serial access */=0A=
+	gen550_init(0, &serialreq);=0A=
+#endif=0A=
+=0A=
+	if (early_serial_setup(&serialreq) !=3D 0) {=0A=
+		printk("Early serial init of port 0 failed\n");=0A=
+	}=0A=
+=0A=
+	serialreq.line =3D 1;=0A=
+	serialreq.port =3D 1;=0A=
+	serialreq.irq =3D ACTING_UART1_INT;=0A=
+	serialreq.iomem_base =3D (void*)ACTING_UART1_IO_BASE;=0A=
+=0A=
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)=0A=
+	/* Configure debug serial access */=0A=
+	gen550_init(1, &serialreq);=0A=
+#endif=0A=
+=0A=
+	if (early_serial_setup(&serialreq) !=3D 0) {=0A=
+		printk("Early serial init of port 1 failed\n");=0A=
+	}=0A=
+}=0A=
+=0A=
 void __init=0A=
 board_setup_arch(void)=0A=
 {=0A=
+        cpci405_early_serial_map();=0A=
 	TODC_INIT(TODC_TYPE_MK48T35, cpci405_nvram, cpci405_nvram, =
cpci405_nvram, 8);=0A=
 }=0A=
 =0A=
diff -N -u -r --exclude=3DCVS --exclude=3DLOG =
linuxppc_2_4_devel_2.4.21pre5_orig/arch/ppc/platforms/cpci405.h =
linuxppc_2_4_devel_2.4.21pre5_esd/arch/ppc/platforms/cpci405.h=0A=
--- linuxppc_2_4_devel_2.4.21pre5_orig/arch/ppc/platforms/cpci405.h	Wed =
Mar 26 13:58:28 2003=0A=
+++ linuxppc_2_4_devel_2.4.21pre5_esd/arch/ppc/platforms/cpci405.h	Thu =
Mar 27 11:46:34 2003=0A=
@@ -24,11 +24,26 @@=0A=
 #define CPCI405_NVRAM_PADDR	((uint)0xf0200000)=0A=
 #define CPCI405_NVRAM_SIZE	((uint)32*1024)=0A=
 =0A=
-#ifdef CONFIG_PPC405GP_INTERNAL_CLOCK=0A=
-#define BASE_BAUD		201600=0A=
+#if defined(CONFIG_UART0_TTYS0)=0A=
+#define ACTING_UART0_IO_BASE	UART0_IO_BASE=0A=
+#define ACTING_UART1_IO_BASE	UART1_IO_BASE=0A=
+#define ACTING_UART0_INT	UART0_INT=0A=
+#define ACTING_UART1_INT	UART1_INT=0A=
 #else=0A=
-#define BASE_BAUD		691200=0A=
+#define ACTING_UART0_IO_BASE	UART1_IO_BASE=0A=
+#define ACTING_UART1_IO_BASE	UART0_IO_BASE=0A=
+#define ACTING_UART0_INT	UART1_INT=0A=
+#define ACTING_UART1_INT	UART0_INT=0A=
 #endif=0A=
+=0A=
+/* The UART clock is based off an internal clock -=0A=
+ * define BASE_BAUD based on the internal clock and divider(s).=0A=
+ * Since BASE_BAUD must be a constant, we will initialize it=0A=
+ * using clock/divider values which U-Boot initializes=0A=
+ * for typical configurations at various CPU speeds.=0A=
+ * The base baud is calculated as (FWDA / EXT UART DIV / 16)=0A=
+ */=0A=
+#define BASE_BAUD       0=0A=
 =0A=
 #define PPC4xx_MACHINE_NAME "esd CPCI-405"=0A=
 =0A=

------=_NextPart_000_0012_01C2F457.EBDEBB50--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
