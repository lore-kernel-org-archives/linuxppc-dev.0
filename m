Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34045679A6
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2006 07:06:47 +1100 (EST)
Date: Tue, 21 Feb 2006 21:06:41 +0100
From: Olaf Hering <olh@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>,
	Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] fix adb breakage in xmon
Message-ID: <20060221200641.GA5838@suse.de>
References: <20060221183324.GA3444@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060221183324.GA3444@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Fix up xmon compilation after the last change.
Remove lots of dead code, all the pmac and chrp support is in arch/powerpc

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/ppc/xmon/adb.c   |  212 --------------------------------------------------
 arch/ppc/xmon/start.c |  169 ---------------------------------------
 arch/ppc/xmon/xmon.c  |  108 -------------------------
 3 files changed, 3 insertions(+), 486 deletions(-)

Index: linux-2.6.16-rc4-olh/arch/ppc/xmon/start.c
===================================================================
--- linux-2.6.16-rc4-olh.orig/arch/ppc/xmon/start.c
+++ linux-2.6.16-rc4-olh/arch/ppc/xmon/start.c
@@ -6,16 +6,11 @@
 #include <asm/machdep.h>
 #include <asm/io.h>
 #include <asm/page.h>
-#include <linux/adb.h>
-#include <linux/pmu.h>
-#include <linux/cuda.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/sysrq.h>
 #include <linux/bitops.h>
 #include <asm/xmon.h>
-#include <asm/prom.h>
-#include <asm/bootx.h>
 #include <asm/machdep.h>
 #include <asm/errno.h>
 #include <asm/processor.h>
@@ -26,9 +21,7 @@ static volatile unsigned char *sccc, *sc
 unsigned int TXRDY, RXRDY, DLAB;
 static int xmon_expect(const char *str, unsigned int timeout);
 
-static int use_screen;
 static int via_modem;
-static int xmon_use_sccb;
 
 #define TB_SPEED	25000000
 
@@ -46,47 +39,6 @@ void buf_access(void)
 		sccd[3] &= ~DLAB;	/* reset DLAB */
 }
 
-extern int adb_init(void);
-
-#ifdef CONFIG_PPC_CHRP
-/*
- * This looks in the "ranges" property for the primary PCI host bridge
- * to find the physical address of the start of PCI/ISA I/O space.
- * It is basically a cut-down version of pci_process_bridge_OF_ranges.
- */
-static unsigned long chrp_find_phys_io_base(void)
-{
-	struct device_node *node;
-	unsigned int *ranges;
-	unsigned long base = CHRP_ISA_IO_BASE;
-	int rlen = 0;
-	int np;
-
-	node = find_devices("isa");
-	if (node != NULL) {
-		node = node->parent;
-		if (node == NULL || node->type == NULL
-		    || strcmp(node->type, "pci") != 0)
-			node = NULL;
-	}
-	if (node == NULL)
-		node = find_devices("pci");
-	if (node == NULL)
-		return base;
-
-	ranges = (unsigned int *) get_property(node, "ranges", &rlen);
-	np = prom_n_addr_cells(node) + 5;
-	while ((rlen -= np * sizeof(unsigned int)) >= 0) {
-		if ((ranges[0] >> 24) == 1 && ranges[2] == 0) {
-			/* I/O space starting at 0, grab the phys base */
-			base = ranges[np - 3];
-			break;
-		}
-		ranges += np;
-	}
-	return base;
-}
-#endif /* CONFIG_PPC_CHRP */
 
 #ifdef CONFIG_MAGIC_SYSRQ
 static void sysrq_handle_xmon(int key, struct pt_regs *regs,
@@ -109,22 +61,6 @@ xmon_map_scc(void)
 #ifdef CONFIG_PPC_MULTIPLATFORM
 	volatile unsigned char *base;
 
-#ifdef CONFIG_PPC_CHRP
-	base = (volatile unsigned char *) isa_io_base;
-	if (_machine == _MACH_chrp)
-		base = (volatile unsigned char *)
-			ioremap(chrp_find_phys_io_base(), 0x1000);
-
-	sccc = base + 0x3fd;
-	sccd = base + 0x3f8;
-	if (xmon_use_sccb) {
-		sccc -= 0x100;
-		sccd -= 0x100;
-	}
-	TXRDY = 0x20;
-	RXRDY = 1;
-	DLAB = 0x80;
-#endif /* CONFIG_PPC_CHRP */
 #elif defined(CONFIG_GEMINI)
 	/* should already be mapped by the kernel boot */
 	sccc = (volatile unsigned char *) 0xffeffb0d;
@@ -143,7 +79,7 @@ xmon_map_scc(void)
 	register_sysrq_key('x', &sysrq_xmon_op);
 }
 
-static int scc_initialized = 0;
+static int scc_initialized;
 
 void xmon_init_scc(void);
 
@@ -163,14 +99,6 @@ xmon_write(void *handle, void *ptr, int 
 			break;
 #endif
 
-#ifdef CONFIG_BOOTX_TEXT
-	if (use_screen) {
-		/* write it on the screen */
-		for (i = 0; i < nb; ++i)
-			btext_drawchar(*p++);
-		goto out;
-	}
-#endif
 	if (!scc_initialized)
 		xmon_init_scc();
 	ct = 0;
@@ -190,7 +118,6 @@ xmon_write(void *handle, void *ptr, int 
 		eieio();
 	}
 
- out:
 #ifdef CONFIG_SMP
 	if (!locked)
 		clear_bit(0, &xmon_write_lock);
@@ -199,65 +126,7 @@ xmon_write(void *handle, void *ptr, int 
 }
 
 int xmon_wants_key;
-int xmon_adb_keycode;
-
-#ifdef CONFIG_BOOTX_TEXT
-static int xmon_adb_shiftstate;
 
-static unsigned char xmon_keytab[128] =
-	"asdfhgzxcv\000bqwer"				/* 0x00 - 0x0f */
-	"yt123465=97-80]o"				/* 0x10 - 0x1f */
-	"u[ip\rlj'k;\\,/nm."				/* 0x20 - 0x2f */
-	"\t `\177\0\033\0\0\0\0\0\0\0\0\0\0"		/* 0x30 - 0x3f */
-	"\0.\0*\0+\0\0\0\0\0/\r\0-\0"			/* 0x40 - 0x4f */
-	"\0\0000123456789\0\0\0";			/* 0x50 - 0x5f */
-
-static unsigned char xmon_shift_keytab[128] =
-	"ASDFHGZXCV\000BQWER"				/* 0x00 - 0x0f */
-	"YT!@#$^%+(&_*)}O"				/* 0x10 - 0x1f */
-	"U{IP\rLJ\"K:|<?NM>"				/* 0x20 - 0x2f */
-	"\t ~\177\0\033\0\0\0\0\0\0\0\0\0\0"		/* 0x30 - 0x3f */
-	"\0.\0*\0+\0\0\0\0\0/\r\0-\0"			/* 0x40 - 0x4f */
-	"\0\0000123456789\0\0\0";			/* 0x50 - 0x5f */
-
-static int
-xmon_get_adb_key(void)
-{
-	int k, t, on;
-
-	xmon_wants_key = 1;
-	for (;;) {
-		xmon_adb_keycode = -1;
-		t = 0;
-		on = 0;
-		do {
-			if (--t < 0) {
-				on = 1 - on;
-				btext_drawchar(on? 0xdb: 0x20);
-				btext_drawchar('\b');
-				t = 200000;
-			}
-			do_poll_adb();
-		} while (xmon_adb_keycode == -1);
-		k = xmon_adb_keycode;
-		if (on)
-			btext_drawstring(" \b");
-
-		/* test for shift keys */
-		if ((k & 0x7f) == 0x38 || (k & 0x7f) == 0x7b) {
-			xmon_adb_shiftstate = (k & 0x80) == 0;
-			continue;
-		}
-		if (k >= 0x80)
-			continue;	/* ignore up transitions */
-		k = (xmon_adb_shiftstate? xmon_shift_keytab: xmon_keytab)[k];
-		if (k != 0)
-			break;
-	}
-	xmon_wants_key = 0;
-	return k;
-}
-#endif /* CONFIG_BOOTX_TEXT */
 
 int
 xmon_read(void *handle, void *ptr, int nb)
@@ -265,18 +134,11 @@ xmon_read(void *handle, void *ptr, int n
     char *p = ptr;
     int i;
 
-#ifdef CONFIG_BOOTX_TEXT
-    if (use_screen) {
-	for (i = 0; i < nb; ++i)
-	    *p++ = xmon_get_adb_key();
-	return i;
-    }
-#endif
     if (!scc_initialized)
 	xmon_init_scc();
     for (i = 0; i < nb; ++i) {
 	while ((*sccc & RXRDY) == 0)
-	    do_poll_adb();
+	    ;
 	buf_access();
 	*p++ = *sccd;
     }
@@ -287,7 +149,7 @@ int
 xmon_read_poll(void)
 {
 	if ((*sccc & RXRDY) == 0) {
-		do_poll_adb();
+		;
 		return -1;
 	}
 	buf_access();
@@ -297,15 +159,6 @@ xmon_read_poll(void)
 void
 xmon_init_scc(void)
 {
-	if ( _machine == _MACH_chrp )
-	{
-		sccd[3] = 0x83; eieio();	/* LCR = 8N1 + DLAB */
-		sccd[0] = 12; eieio();		/* DLL = 9600 baud */
-		sccd[1] = 0; eieio();
-		sccd[2] = 0; eieio();		/* FCR = 0 */
-		sccd[3] = 3; eieio();		/* LCR = 8N1 */
-		sccd[1] = 0; eieio();		/* IER = 0 */
-	}
 	scc_initialized = 1;
 	if (via_modem) {
 		for (;;) {
@@ -321,22 +174,6 @@ xmon_init_scc(void)
 	}
 }
 
-#if 0
-extern int (*prom_entry)(void *);
-
-int
-xmon_exit(void)
-{
-    struct prom_args {
-	char *service;
-    } args;
-
-    for (;;) {
-	args.service = "exit";
-	(*prom_entry)(&args);
-    }
-}
-#endif
 
 void *xmon_stdin;
 void *xmon_stdout;
Index: linux-2.6.16-rc4-olh/arch/ppc/xmon/adb.c
===================================================================
--- linux-2.6.16-rc4-olh.orig/arch/ppc/xmon/adb.c
+++ /dev/null
@@ -1,212 +0,0 @@
-/*
- * Copyright (C) 1996 Paul Mackerras.
- */
-#include "nonstdio.h"
-#include "privinst.h"
-
-#define scanhex	xmon_scanhex
-#define skipbl	xmon_skipbl
-
-#define ADB_B		(*(volatile unsigned char *)0xf3016000)
-#define ADB_SR		(*(volatile unsigned char *)0xf3017400)
-#define ADB_ACR		(*(volatile unsigned char *)0xf3017600)
-#define ADB_IFR		(*(volatile unsigned char *)0xf3017a00)
-
-static inline void eieio(void) { asm volatile ("eieio" : :); }
-
-#define N_ADB_LOG	1000
-struct adb_log {
-    unsigned char b;
-    unsigned char ifr;
-    unsigned char acr;
-    unsigned int time;
-} adb_log[N_ADB_LOG];
-int n_adb_log;
-
-void
-init_adb_log(void)
-{
-    adb_log[0].b = ADB_B;
-    adb_log[0].ifr = ADB_IFR;
-    adb_log[0].acr = ADB_ACR;
-    adb_log[0].time = get_dec();
-    n_adb_log = 0;
-}
-
-void
-dump_adb_log(void)
-{
-    unsigned t, t0;
-    struct adb_log *ap;
-    int i;
-
-    ap = adb_log;
-    t0 = ap->time;
-    for (i = 0; i <= n_adb_log; ++i, ++ap) {
-	t = t0 - ap->time;
-	printf("b=%x ifr=%x acr=%x at %d.%.7d\n", ap->b, ap->ifr, ap->acr,
-	       t / 1000000000, (t % 1000000000) / 100);
-    }
-}
-
-void
-adb_chklog(void)
-{
-    struct adb_log *ap = &adb_log[n_adb_log + 1];
-
-    ap->b = ADB_B;
-    ap->ifr = ADB_IFR;
-    ap->acr = ADB_ACR;
-    if (ap->b != ap[-1].b || (ap->ifr & 4) != (ap[-1].ifr & 4)
-	|| ap->acr != ap[-1].acr) {
-	ap->time = get_dec();
-	++n_adb_log;
-    }
-}
-
-int
-adb_bitwait(int bmask, int bval, int fmask, int fval)
-{
-    int i;
-    struct adb_log *ap;
-
-    for (i = 10000; i > 0; --i) {
-	adb_chklog();
-	ap = &adb_log[n_adb_log];
-	if ((ap->b & bmask) == bval && (ap->ifr & fmask) == fval)
-	    return 0;
-    }
-    return -1;
-}
-
-int
-adb_wait(void)
-{
-    if (adb_bitwait(0, 0, 4, 4) < 0) {
-	printf("adb: ready wait timeout\n");
-	return -1;
-    }
-    return 0;
-}
-
-void
-adb_readin(void)
-{
-    int i, j;
-    unsigned char d[64];
-
-    if (ADB_B & 8) {
-	printf("ADB_B: %x\n", ADB_B);
-	return;
-    }
-    i = 0;
-    adb_wait();
-    j = ADB_SR;
-    eieio();
-    ADB_B &= ~0x20;
-    eieio();
-    for (;;) {
-	if (adb_wait() < 0)
-	    break;
-	d[i++] = ADB_SR;
-	eieio();
-	if (ADB_B & 8)
-	    break;
-	ADB_B ^= 0x10;
-	eieio();
-    }
-    ADB_B |= 0x30;
-    if (adb_wait() == 0)
-	j = ADB_SR;
-    for (j = 0; j < i; ++j)
-	printf("%.2x ", d[j]);
-    printf("\n");
-}
-
-int
-adb_write(unsigned char *d, int i)
-{
-    int j;
-    unsigned x;
-
-    if ((ADB_B & 8) == 0) {
-	printf("r: ");
-	adb_readin();
-    }
-    for (;;) {
-	ADB_ACR = 0x1c;
-	eieio();
-	ADB_SR = d[0];
-	eieio();
-	ADB_B &= ~0x20;
-	eieio();
-	if (ADB_B & 8)
-	    break;
-	ADB_ACR = 0xc;
-	eieio();
-	ADB_B |= 0x20;
-	eieio();
-	adb_readin();
-    }
-    adb_wait();
-    for (j = 1; j < i; ++j) {
-	ADB_SR = d[j];
-	eieio();
-	ADB_B ^= 0x10;
-	eieio();
-	if (adb_wait() < 0)
-	    break;
-    }
-    ADB_ACR = 0xc;
-    eieio();
-    x = ADB_SR;
-    eieio();
-    ADB_B |= 0x30;
-    return j;
-}
-
-void
-adbcmds(void)
-{
-    char cmd;
-    unsigned rtcu, rtcl, dec, pdec, x;
-    int i, j;
-    unsigned char d[64];
-
-    cmd = skipbl();
-    switch (cmd) {
-    case 't':
-	for (;;) {
-	    rtcl = get_rtcl();
-	    rtcu = get_rtcu();
-	    dec = get_dec();
-	    printf("rtc u=%u l=%u dec=%x (%d = %d.%.7d)\n",
-		   rtcu, rtcl, dec, pdec - dec, (pdec - dec) / 1000000000,
-		   ((pdec - dec) % 1000000000) / 100);
-	    pdec = dec;
-	    if (cmd == 'x')
-		break;
-	    while (xmon_read(stdin, &cmd, 1) != 1)
-		;
-	}
-	break;
-    case 'r':
-	init_adb_log();
-	while (adb_bitwait(8, 0, 0, 0) == 0)
-	    adb_readin();
-	break;
-    case 'w':
-	i = 0;
-	while (scanhex(&x))
-	    d[i++] = x;
-	init_adb_log();
-	j = adb_write(d, i);
-	printf("sent %d bytes\n", j);
-	while (adb_bitwait(8, 0, 0, 0) == 0)
-	    adb_readin();
-	break;
-    case 'l':
-	dump_adb_log();
-	break;
-    }
-}
Index: linux-2.6.16-rc4-olh/arch/ppc/xmon/xmon.c
===================================================================
--- linux-2.6.16-rc4-olh.orig/arch/ppc/xmon/xmon.c
+++ linux-2.6.16-rc4-olh/arch/ppc/xmon/xmon.c
@@ -12,8 +12,6 @@
 #include <linux/kallsyms.h>
 #include <asm/ptrace.h>
 #include <asm/string.h>
-#include <asm/prom.h>
-#include <asm/bootx.h>
 #include <asm/machdep.h>
 #include <asm/xmon.h>
 #include "nonstdio.h"
@@ -101,9 +99,6 @@ void cacheflush(void);
 static void cpu_cmd(void);
 #endif /* CONFIG_SMP */
 static void csum(void);
-#ifdef CONFIG_BOOTX_TEXT
-static void vidcmds(void);
-#endif
 static void bootcmds(void);
 static void proccall(void);
 static void printtime(void);
@@ -522,11 +517,6 @@ cmds(struct pt_regs *excp)
 			cpu_cmd();
 			break;
 #endif /* CONFIG_SMP */
-#ifdef CONFIG_BOOTX_TEXT
-		case 'v':
-			vidcmds();
-			break;
-#endif
 		case 'z':
 			bootcmds();
 			break;
@@ -618,43 +608,6 @@ static void cpu_cmd(void)
 }
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_BOOTX_TEXT
-extern boot_infos_t disp_bi;
-
-static void vidcmds(void)
-{
-	int c = inchar();
-	unsigned int val, w;
-	extern int boot_text_mapped;
-
-	if (!boot_text_mapped)
-		return;
-	if (c != '\n' && scanhex(&val)) {
-		switch (c) {
-		case 'd':
-			w = disp_bi.dispDeviceRowBytes
-				/ (disp_bi.dispDeviceDepth >> 3);
-			disp_bi.dispDeviceDepth = val;
-			disp_bi.dispDeviceRowBytes = w * (val >> 3);
-			return;
-		case 'p':
-			disp_bi.dispDeviceRowBytes = val;
-			return;
-		case 'w':
-			disp_bi.dispDeviceRect[2] = val;
-			return;
-		case 'h':
-			disp_bi.dispDeviceRect[3] = val;
-			return;
-		}
-	}
-	printf("W = %d (0x%x) H = %d (0x%x) D = %d (0x%x) P = %d (0x%x)\n",
-	       disp_bi.dispDeviceRect[2], disp_bi.dispDeviceRect[2],
-	       disp_bi.dispDeviceRect[3], disp_bi.dispDeviceRect[3],
-	       disp_bi.dispDeviceDepth, disp_bi.dispDeviceDepth,
-	       disp_bi.dispDeviceRowBytes, disp_bi.dispDeviceRowBytes);
-}
-#endif /* CONFIG_BOOTX_TEXT */
 
 static unsigned short fcstab[256] = {
 	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
@@ -1020,7 +973,6 @@ dump_hash_table(void)
 }
 #else
 
-#ifndef CONFIG_PPC64BRIDGE
 static void
 dump_hash_table_seg(unsigned seg, unsigned start, unsigned end)
 {
@@ -1079,66 +1031,6 @@ dump_hash_table_seg(unsigned seg, unsign
 		printf(" ... %x\n", last_va);
 }
 
-#else /* CONFIG_PPC64BRIDGE */
-static void
-dump_hash_table_seg(unsigned seg, unsigned start, unsigned end)
-{
-	extern void *Hash;
-	extern unsigned long Hash_size;
-	unsigned *htab = Hash;
-	unsigned hsize = Hash_size;
-	unsigned v, hmask, va, last_va;
-	int found, last_found, i;
-	unsigned *hg, w1, last_w2, last_va0;
-
-	last_found = 0;
-	hmask = hsize / 128 - 1;
-	va = start;
-	start = (start >> 12) & 0xffff;
-	end = (end >> 12) & 0xffff;
-	for (v = start; v < end; ++v) {
-		found = 0;
-		hg = htab + (((v ^ seg) & hmask) * 32);
-		w1 = 1 | (seg << 12) | ((v & 0xf800) >> 4);
-		for (i = 0; i < 8; ++i, hg += 4) {
-			if (hg[1] == w1) {
-				found = 1;
-				break;
-			}
-		}
-		if (!found) {
-			w1 ^= 2;
-			hg = htab + ((~(v ^ seg) & hmask) * 32);
-			for (i = 0; i < 8; ++i, hg += 4) {
-				if (hg[1] == w1) {
-					found = 1;
-					break;
-				}
-			}
-		}
-		if (!(last_found && found && (hg[3] & ~0x180) == last_w2 + 4096)) {
-			if (last_found) {
-				if (last_va != last_va0)
-					printf(" ... %x", last_va);
-				printf("\n");
-			}
-			if (found) {
-				printf("%x to %x", va, hg[3]);
-				last_va0 = va;
-			}
-			last_found = found;
-		}
-		if (found) {
-			last_w2 = hg[3] & ~0x180;
-			last_va = va;
-		}
-		va += 4096;
-	}
-	if (last_found)
-		printf(" ... %x\n", last_va);
-}
-#endif /* CONFIG_PPC64BRIDGE */
-
 static unsigned hash_ctx;
 static unsigned hash_start;
 static unsigned hash_end;
