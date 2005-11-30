Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 302096884B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2005 17:00:40 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 16:54:12 +1100
Message-Id: <1133330054.16726.71.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: udbg updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The udbg low level io layer has an issue with udbg_getc() returning a
char (unsigned on ppc) instead of an int, thus the -1 if you had no
available input device could end up turned into 0xff, filling your
display with bogus characters. This fixes it, along with adding a little
blob to xmon to do a delay before exiting when getting an EOF and fixing
the detection of ADB keyboards in udbg_adb.c

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

For the powerpc tree, not for 2.6.15.

Index: linux-work/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_parse.c	2005-11-30 15:23:47.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom_parse.c	2005-11-30 15:30:17.000000000 +1100
@@ -276,7 +276,7 @@ static int of_translate_one(struct devic
 
  finish:
 	of_dump_addr("OF: parent translation for:", addr, pna);
-	DBG("OF: with offset: %lx\n", offset);
+	DBG("OF: with offset: "PRu64"\n", offset);
 
 	/* Translate it into parent bus space */
 	return pbus->translate(addr, offset, pna);
Index: linux-work/arch/powerpc/kernel/udbg.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/udbg.c	2005-11-30 15:19:50.000000000 +1100
+++ linux-work/arch/powerpc/kernel/udbg.c	2005-11-30 15:30:40.000000000 +1100
@@ -17,7 +17,7 @@
 #include <asm/processor.h>
 
 void (*udbg_putc)(char c);
-char (*udbg_getc)(void);
+int (*udbg_getc)(void);
 int (*udbg_getc_poll)(void);
 
 /* udbg library, used by xmon et al */
@@ -57,8 +57,8 @@ int udbg_write(const char *s, int n)
 
 int udbg_read(char *buf, int buflen)
 {
-	char c, *p = buf;
-	int i;
+	char *p = buf;
+	int i, c;
 
 	if (!udbg_getc)
 		return 0;
@@ -66,8 +66,11 @@ int udbg_read(char *buf, int buflen)
 	for (i = 0; i < buflen; ++i) {
 		do {
 			c = udbg_getc();
+			if (c == -1 && i == 0)
+				return -1;
+
 		} while (c == 0x11 || c == 0x13);
-		if (c == 0)
+		if (c == 0 || c == -1)
 			break;
 		*p++ = c;
 	}
Index: linux-work/arch/powerpc/kernel/udbg_16550.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/udbg_16550.c	2005-11-30 15:19:50.000000000 +1100
+++ linux-work/arch/powerpc/kernel/udbg_16550.c	2005-11-30 15:24:47.000000000 +1100
@@ -69,14 +69,14 @@ static int udbg_550_getc_poll(void)
 	return -1;
 }
 
-static char udbg_550_getc(void)
+static int udbg_550_getc(void)
 {
 	if (udbg_comport) {
 		while ((in_8(&udbg_comport->lsr) & LSR_DR) == 0)
 			/* wait for char */;
 		return in_8(&udbg_comport->rbr);
 	}
-	return 0;
+	return -1;
 }
 
 void udbg_init_uart(void __iomem *comport, unsigned int speed,
Index: linux-work/arch/powerpc/platforms/powermac/udbg_adb.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/udbg_adb.c	2005-11-30 15:19:50.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/udbg_adb.c	2005-11-30 15:24:47.000000000 +1100
@@ -29,7 +29,7 @@
  */
 
 static void (*udbg_adb_old_putc)(char c);
-static char (*udbg_adb_old_getc)(void);
+static int (*udbg_adb_old_getc)(void);
 static int (*udbg_adb_old_getc_poll)(void);
 
 static enum {
@@ -73,7 +73,7 @@ static unsigned char xmon_shift_keytab[1
 	"\0.\0*\0+\0\0\0\0\0/\r\0-\0"			/* 0x40 - 0x4f */
 	"\0\0000123456789\0\0\0";			/* 0x50 - 0x5f */
 
-static char udbg_adb_local_getc(void)
+static int udbg_adb_local_getc(void)
 {
 	int k, t, on;
 
@@ -116,7 +116,7 @@ static char udbg_adb_local_getc(void)
 }
 #endif /* CONFIG_BOOTX_TEXT */
 
-static char udbg_adb_getc(void)
+static int udbg_adb_getc(void)
 {
 #ifdef CONFIG_BOOTX_TEXT
 	if (udbg_adb_use_btext && input_type != input_adb_none)
@@ -192,7 +192,7 @@ int udbg_adb_init(int force_btext)
 	 */
 	for (np = NULL; (np = of_find_node_by_name(np, "keyboard")) != NULL;) {
 		struct device_node *parent = of_get_parent(np);
-		int found = (parent && !strcmp(parent->type, "adb") == 0);
+		int found = (parent && strcmp(parent->type, "adb") == 0);
 		of_node_put(parent);
 		if (found)
 			break;
Index: linux-work/arch/powerpc/platforms/powermac/udbg_scc.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/udbg_scc.c	2005-11-30 15:19:50.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/udbg_scc.c	2005-11-30 15:24:47.000000000 +1100
@@ -47,14 +47,14 @@ static int udbg_scc_getc_poll(void)
 	return -1;
 }
 
-static char udbg_scc_getc(void)
+static int udbg_scc_getc(void)
 {
 	if (sccc) {
 		while ((in_8(sccc) & SCC_RXRDY) == 0)
 			;
 		return in_8(sccd);
 	}
-	return 0;
+	return -1;
 }
 
 static unsigned char scc_inittab[] = {
Index: linux-work/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/lpar.c	2005-11-30 15:19:50.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/lpar.c	2005-11-30 15:24:47.000000000 +1100
@@ -112,7 +112,7 @@ static int udbg_hvsi_getc_poll(void)
 	return ch;
 }
 
-static char udbg_hvsi_getc(void)
+static int udbg_hvsi_getc(void)
 {
 	int ch;
 	for (;;) {
@@ -173,7 +173,7 @@ static int udbg_getc_pollLP(void)
 	return ch;
 }
 
-static char udbg_getcLP(void)
+static int udbg_getcLP(void)
 {
 	int ch;
 	for (;;) {
Index: linux-work/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-work.orig/arch/powerpc/xmon/xmon.c	2005-11-30 15:19:50.000000000 +1100
+++ linux-work/arch/powerpc/xmon/xmon.c	2005-11-30 15:24:47.000000000 +1100
@@ -450,7 +450,6 @@ int xmon_core(struct pt_regs *regs, int 
  leave:
 	cpu_clear(cpu, cpus_in_xmon);
 	xmon_fault_jmp[cpu] = NULL;
-
 #else
 	/* UP is simple... */
 	if (in_xmon) {
@@ -805,7 +804,10 @@ cmds(struct pt_regs *excp)
 			break;
 		case 'x':
 		case 'X':
+			return cmd;
 		case EOF:
+			printf(" <no input ...>\n");
+			mdelay(2000);
 			return cmd;
 		case '?':
 			printf(help_string);
Index: linux-work/include/asm-powerpc/udbg.h
===================================================================
--- linux-work.orig/include/asm-powerpc/udbg.h	2005-11-30 15:19:50.000000000 +1100
+++ linux-work/include/asm-powerpc/udbg.h	2005-11-30 15:24:47.000000000 +1100
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 
 extern void (*udbg_putc)(char c);
-extern char (*udbg_getc)(void);
+extern int (*udbg_getc)(void);
 extern int (*udbg_getc_poll)(void);
 
 extern void udbg_puts(const char *s);
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-11-30 15:23:50.000000000 +1100
+++ linux-work/drivers/macintosh/via-pmu.c	2005-11-30 15:30:20.000000000 +1100
@@ -313,7 +313,7 @@ int __init find_via_pmu(void)
 		goto fail;
 	}
 	taddr = of_translate_address(vias, reg);
-	if (taddr == 0) {
+	if (taddr == OF_BAD_ADDR) {
 		printk(KERN_ERR "via-pmu: Can't translate address !\n");
 		goto fail;
 	}
@@ -376,7 +376,7 @@ int __init find_via_pmu(void)
 		return 0;
 	}
 
-	printk(KERN_INFO "PMU driver %d initialized for %s, firmware: %02x\n",
+	printk(KERN_INFO "PMU driver v%d initialized for %s, firmware: %02x\n",
 	       PMU_DRIVER_VERSION, pbook_type[pmu_kind], pmu_version);
 	       
 	sys_ctrler = SYS_CTRLER_PMU;
