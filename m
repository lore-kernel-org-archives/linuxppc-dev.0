To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: A few more PPC440GP/Ebony cleanups
From: Roland Dreier <roland@topspin.com>
Date: 03 Jun 2002 17:44:57 -0700
In-Reply-To: <20020529154551.C3960@home.com>
Message-ID: <52vg8z6fee.fsf_-_@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, here's another step towards getting generic 440GP stuff out of
ebony.h/ebony.c.

At this point ebony.h looks OK to me.  For ebony.c, it seems to me
that at least ebony_calibrate_decr(), ebony_find_end_of_memory() and
the PCI setup want to be generic.

Do you think it would be better to create an
arch/ppc/kernel/ppc440_setup.c with library functions like
ppc440_find_end_of_memory() that ebony.c uses, or just turn ebony.c
into ppc440_setup.c and use #ifdefs for new 440GP boards?

Best,
  Roland

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1059  -> 1.1059.1.1
#	BitKeeper/etc/logging_ok	1.61    -> 1.62
#	arch/ppc/platforms/ebony.h	1.10    -> 1.11
#	arch/ppc/platforms/ibm440gp.h	1.2     -> 1.3
#	arch/ppc/platforms/ebony.c	1.10    -> 1.10.1.1
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	mporter@beef.az.mvista.com	1.1060
# Fix 440GP type 1 config cycle generation.  Systems with P2P
# bridges now work.
#
# The 440GP has a lazy host bridge that needs the cycle type
# bit in the CFGA set appropriately for the desired cycle type.
# We now key off a machdep flag to set the cycle type bit as
# needed in the indirect_pci method.
# --------------------------------------------
# 02/05/31	paulus@quango.ozlabs.ibm.com	1.1039.1.1
# Delete the ppc64 *.original files, they aren't needed.
# --------------------------------------------
# 02/05/31	paulus@quango.ozlabs.ibm.com	1.1061
# Merge bk://ppc@ppc.bkbits.net/linuxppc_2_4_devel
# into quango.ozlabs.ibm.com:/home/paulus/kernel/linuxppc_2_4_devel
# --------------------------------------------
# 02/05/31	trini@bill-the-cat.bloom.county	1.1062
# Merge bill-the-cat.bloom.county:/home/trini/work/kernel/pristine/linuxppc_2_4
# into bill-the-cat.bloom.county:/home/trini/work/kernel/pristine/linuxppc_2_4_devel
# --------------------------------------------
# 02/05/31	trini@bill-the-cat.bloom.county	1.1063
# Not sure how the NPNet question got added twice, but..
# Also move it into its own menu for clarity.
# --------------------------------------------
# 02/05/31	trini@bill-the-cat.bloom.county	1.1064
# Update the ash/ceder/walnut defconfigs to be a bit more reasonable.
# --------------------------------------------
# 02/06/01	paulus@samba.org	1.1065
# I finally found why my tibook wouldn't wake up from sleep.  It was
# because a couple of routines used in the wakeup code were marked
# __init.  This changeset fixes that.
# --------------------------------------------
# 02/06/01	hozer@narn.(none)	1.1066
# Fix polarities on PReP machines with OpenPIC (i.e., my MTX)
# (This needs to be done for pplus_pci.c also, I believe)
# --------------------------------------------
# 02/06/03	dgibson@zax.zax	1.1067
# Correct comment.
# --------------------------------------------
# 02/06/03	benh@zion.wanadoo.fr	1.118.1.522
# Fix briq initial IO base (should help xmon)
# --------------------------------------------
# 02/06/03	benh@zion.wanadoo.fr	1.118.1.523
# Add IBM 750FX CPU to cputable
# --------------------------------------------
# 02/06/03	benh@zion.wanadoo.fr	1.118.1.524
# Fix nvram on B&W G3 and Yikes G4, Add new iBook to machine list
# Fix warning in i2c-keywest
# --------------------------------------------
# 02/06/03	mporter@beef.az.mvista.com	1.1064.1.1
# Enable the 4xx debug code paths on 440 as well.
# Fix DBCR0 save and add Debug exception handling.
# This fixes a bug that was being avoided by having
# the BDI switch on.
# --------------------------------------------
# 02/06/03	mporter@beef.az.mvista.com	1.1068
# Merge bk://ppc@ppc.bkbits.net/linuxppc_2_4_devel
# into beef.az.mvista.com:/home/mporter/src/booke
# --------------------------------------------
# 02/06/03	trini@bill-the-cat.bloom.county	1.118.1.525
# According to the errata list, the TAU unit on the 7455 reports temperatures
# that are 35 to 55 degrees lower than actual.  It also states that the TAU
# is not supported as a feature and is not included in any 7455 documentation.
# Remove from the feature list.
# --------------------------------------------
# 02/06/03	mporter@beef.az.mvista.com	1.1069
# Book E cleanups from Kumar Gala <kumar.gala@motorola.com>.
#
# Added a CONFIG_BOOKE option so in the future as more BOOKE processores/cores
# come out generic code is not duplicated.  Currently the only BOOKE part that
# exists is the 440.
#
# Renamed CONFIG_440 to CONFIG_BOOKE in cases where we really are ifdefing
# around BOOKE architecture details, not 440 implementation details.
#
# In the future, we'll use -mbooke if we are CONFIG_BOOKE as well, but
# it's necessary to be at binutils 2.11.90.0.10+ for that and most
# folks are using 2.10-based 4xx binutils at the moment that enable
# all the necessary Book E instructions.
# --------------------------------------------
# 02/06/03	trini@bill-the-cat.bloom.county	1.118.1.526
# According to the 7450 errata sheet (#25) the TAU is not a supported
# feature of any of the 7450s and has been removed from all documentation
# except for the errata sheet, so remove it from the feature list.
# --------------------------------------------
# 02/06/03	trini@bill-the-cat.bloom.county	1.1070
# Merge recent linuxppc_2_4 changes.
# --------------------------------------------
# 02/06/03	trini@bill-the-cat.bloom.county	1.1071
# First round of Motorola Sandpoint fixes.  Tested on an X3B.
# --------------------------------------------
# 02/06/03	roland@gold.topspincom.com	1.1059.1.1
# Move generic PPC440GP serial defines from ebony.h to ibm440gp.h
# --------------------------------------------
#
diff -Nru a/BitKeeper/etc/logging_ok b/BitKeeper/etc/logging_ok
--- a/BitKeeper/etc/logging_ok	Mon Jun  3 17:08:54 2002
+++ b/BitKeeper/etc/logging_ok	Mon Jun  3 17:08:54 2002
@@ -50,3 +50,4 @@
 trini@entropy.crashing.org
 trini@opus.bloom.county
 trini@stevedallas.bloom.county
+roland@gold.topspincom.com
diff -Nru a/arch/ppc/platforms/ebony.c b/arch/ppc/platforms/ebony.c
--- a/arch/ppc/platforms/ebony.c	Mon Jun  3 17:08:54 2002
+++ b/arch/ppc/platforms/ebony.c	Mon Jun  3 17:08:54 2002
@@ -255,7 +255,7 @@
 	serial_req.irq = 0;
 	serial_req.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	serial_req.io_type = SERIAL_IO_MEM;
-	serial_req.iomem_base = ioremap64(EBONY_UART_0, 8);
+	serial_req.iomem_base = ioremap64(PPC440GP_UART_0, 8);
 	serial_req.iomem_reg_shift = 0;

 	if (early_serial_setup(&serial_req) != 0) {
@@ -266,7 +266,7 @@
 	serial_req.line = 1;
 	serial_req.port = 1;
 	serial_req.irq = 1;
-	serial_req.iomem_base = ioremap64(EBONY_UART_1, 8);
+	serial_req.iomem_base = ioremap64(PPC440GP_UART_1, 8);

 	if (early_serial_setup(&serial_req) != 0) {
 		printk("Early serial init of port 1 failed\n");
diff -Nru a/arch/ppc/platforms/ebony.h b/arch/ppc/platforms/ebony.h
--- a/arch/ppc/platforms/ebony.h	Mon Jun  3 17:08:54 2002
+++ b/arch/ppc/platforms/ebony.h	Mon Jun  3 17:08:54 2002
@@ -62,29 +62,7 @@
 /*
  * Serial port defines
  */
-#define RS_TABLE_SIZE	2
-
-/* OpenBIOS defined UART mappings, used before early_serial_setup */
-#define UART0_IO_BASE	(u8 *) 0xE0000200
-#define UART1_IO_BASE	(u8 *) 0xE0000300
-
-/* 440GP UART physical addresses, ioremapped for early_serial_setup */
-#define EBONY_UART_0	0x0000000140000200
-#define EBONY_UART_1	0x0000000140000300
-
 #define BASE_BAUD	33000000/3/16
-#define UART0_INT	0
-#define UART1_INT	1
-
-#define STD_UART_OP(num)					\
-	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
-		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
-		iomem_base: UART##num##_IO_BASE,		\
-		io_type: SERIAL_IO_MEM},
-
-#define SERIAL_PORT_DFNS	\
-	STD_UART_OP(0)		\
-	STD_UART_OP(1)

 /* PCI support */
 #define EBONY_PCI_LOWER_IO	0x00000000
diff -Nru a/arch/ppc/platforms/ibm440gp.h b/arch/ppc/platforms/ibm440gp.h
--- a/arch/ppc/platforms/ibm440gp.h	Mon Jun  3 17:08:54 2002
+++ b/arch/ppc/platforms/ibm440gp.h	Mon Jun  3 17:08:54 2002
@@ -40,13 +40,34 @@
 #define PPC440GP_ZMII_SIZE	0x0c

 /* I2C location */
-#define PPC440GP_IIC0_ADDR	0x40000400
-#define PPC440GP_IIC1_ADDR	0x40000500
+#define PPC440GP_IIC0_ADDR	0x0000000140000400
+#define PPC440GP_IIC1_ADDR	0x0000000140000500

 /*
  * Serial port defines
  */
 #define RS_TABLE_SIZE	2
+
+/* OpenBIOS defined UART mappings, used before early_serial_setup */
+#define UART0_IO_BASE	(u8 *) 0xE0000200
+#define UART1_IO_BASE	(u8 *) 0xE0000300
+
+/* 440GP UART physical addresses, ioremapped for early_serial_setup */
+#define PPC440GP_UART_0	0x0000000140000200
+#define PPC440GP_UART_1	0x0000000140000300
+
+#define UART0_INT	0
+#define UART1_INT	1
+
+#define STD_UART_OP(num)					\
+	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
+		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
+		iomem_base: UART##num##_IO_BASE,		\
+		io_type: SERIAL_IO_MEM},
+
+#define SERIAL_PORT_DFNS	\
+	STD_UART_OP(0)		\
+	STD_UART_OP(1)

 #include <asm/ibm440.h>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
