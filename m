Message-ID: <3A5281EC.82E97EA6@drea.dnd.ca>
Date: Tue, 02 Jan 2001 21:35:40 -0400
From: Gavin Hemphill <hemphill@drea.dnd.ca>
Reply-To: hemphill@drea.dnd.ca
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: mprotect and SMP
References: <3A2F82B3.46C4C2E0@drea.dnd.ca> <19341101064649.16824@192.168.1.2>
Content-Type: multipart/mixed;
 boundary="------------BB9BB4EC05AC0D4D6AD417CB"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------BB9BB4EC05AC0D4D6AD417CB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
>
> >
> >This problem has existed since the earliest kernels I've had for the
> >gemini (about 2.2.13).
> >
> >I've got read access to the bk tree now, the problem is that it doesn't
> >boot when configured for the gemini, I'm going to look through the
> >gemini specific diffs and try and get the 2_2 tree running, but from
> >what I've seen in the larger set of diff's there's no modifications that
> >seem to apply to the mprotect problem.  Just out of curiosity, if I do
> >get the gemini configuration running who do I send the changes to so
> >that they make it back into the tree.
> >       Gavin
>
> Send them to this list, CC to me & paulus, eventually submit them to the
> sourceforge site.
>
> Ben.

Ben:
Well I've finally got what I think are the minimum set of differences
needed to make the 2.2.18 bk tree run on the "gemini" (read
synergymicro) boards.  The diffs are against the current bk linuxppc2_2
tree.  I still have not solved the mprotect problem but at least I can
run the the system with a kernel based on the bk tree.  Could you please
see about getting these changes included in the bk linuxppc_2_2 tree?
	G++
--------------BB9BB4EC05AC0D4D6AD417CB
Content-Type: text/plain; charset=us-ascii;
 name="diffgemini-base"
Content-Disposition: inline;
 filename="diffgemini-base"
Content-Transfer-Encoding: 7bit

diff -ru linux_2_2-gemini/Makefile linux_2_2-base/Makefile
--- linux_2_2-gemini/Makefile	Tue Jan  2 19:39:53 2001
+++ linux_2_2-base/Makefile	Mon Dec 18 20:57:07 2000
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 2
 SUBLEVEL = 18
-EXTRAVERSION = gemini-1
+EXTRAVERSION =

 ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)

diff -ru linux_2_2-gemini/arch/ppc/boot/head.S linux_2_2-base/arch/ppc/boot/head.S
--- linux_2_2-gemini/arch/ppc/boot/head.S	Mon Dec 18 13:08:54 2000
+++ linux_2_2-base/arch/ppc/boot/head.S	Mon Dec 18 20:56:39 2000
@@ -1,11 +1,7 @@
-#include <linux/config.h>
 #include "../kernel/ppc_defs.h"
 #include "../kernel/ppc_asm.tmpl"
 #include <asm/processor.h>
 #include <asm/cache.h>
-#include <asm/gemini.h>
-
-#define GRAK_PICR1 0x800000a8

 	.text

@@ -25,29 +21,10 @@
 start:
 	bl	start_
 start_:
-#ifdef CONFIG_GEMINI
-	lis	r11,GRACKLE_CONFIG_ADDR_ADDR@h
-	ori	r11,r11,GRACKLE_CONFIG_ADDR_ADDR@l
-	lis	r12,GRACKLE_CONFIG_DATA_ADDR@h
-	ori	r12,r12,GRACKLE_CONFIG_DATA_ADDR@l
-	lis	r13,GRAK_PICR1@h
-	ori	r13,r13,GRAK_PICR1@l
-	stwbrx	r13,0,r11
-	sync
-	lwbrx	r14,0,r12
-	li	r15,(1<<10)|(1<<11)
-	andc	r14,r14,r15
-	stwbrx	r13,0,r11
-	sync
-	stwbrx	r14,0,r12
-	sync
-#endif
 	mr	r11,r3		/* Save pointer to residual/board data */
-#ifndef CONFIG_GEMINI
 	mr      r25,r5          /* Save OFW pointer */
 	li	r3,MSR_IP	/* Establish default MSR value */
 	mtmsr	r3
-#endif

 /* check if we need to relocate ourselves to the link addr or were we
    loaded there to begin with -- Cort */
@@ -117,21 +94,6 @@
 	subi	r1,r1,256
 	li	r2,0x000F		/* Mask pointer to 16-byte boundary */
 	andc	r1,r1,r2
-#ifdef CONFIG_GEMINI
-	/* save any command-line args */
-	cmpwi	0,r11,0
-	beq	24f
-	lis	r3,cmd_buf@h
-	ori	r3,r3,cmd_buf@l
-	addi	r3,r3,-1
-	addi	r4,r11,-1
-23:	lbzu	r0,1(r4)
-	cmpwi	0,r0,0
-	stbu	r0,1(r3)
-	bne	23b
-24:
-	li	r11,0
-#endif
 /* Run loader */
 	mr	r3,r8			/* Load point */
 	mr	r4,r7			/* Program length */
@@ -150,18 +112,6 @@
 	cmpi	0,r2,0
 	bne	00b

-#ifdef CONFIG_GEMINI
-	lis	r3,cmd_line@h
-	ori	r3,r3,cmd_line@l
-	lwz	r3,0(r3)
-	lis	r2,initrd_start@h
-	ori	r2,r2,initrd_start@l
-	lwz	r4,0(r2)
-	lis	r2,initrd_end@h
-	ori	r2,r2,initrd_end@l
-	lwz	r5,0(r2)
-#endif /* CONFIG_GEMINI */
-
 	/* r4,r5 have initrd_start, size */
 	lis	r2,initrd_start@h
 	ori	r2,r2,initrd_start@l
@@ -181,7 +131,6 @@
 	ori	r10,r10,0xdeadc0de@l
 	li	r9,0
 	stw	r10,0(r9)
-#ifndef CONFIG_GEMINI
 /*
  * The Radstone firmware maps PCI memory at 0xc0000000 using BAT2
  * so disable BATs before setting this to avoid a clash
@@ -195,7 +144,6 @@
 	mtspr   IBAT1U,r8
 	mtspr   IBAT2U,r8
 	mtspr   IBAT3U,r8
-+#endif /* !CONFIG_GEMINI */

 	blr
 hang:
diff -ru linux_2_2-gemini/arch/ppc/boot/misc.c linux_2_2-base/arch/ppc/boot/misc.c
--- linux_2_2-gemini/arch/ppc/boot/misc.c	Mon Dec 18 13:19:20 2000
+++ linux_2_2-base/arch/ppc/boot/misc.c	Mon Dec 18 20:56:45 2000
@@ -42,13 +42,7 @@
 char cmd_buf[256];
 char *cmd_line = cmd_buf;

-#ifdef CONFIG_VGA
-#define HAS_KEYB 1
-#else
-#define HAS_KEYB 0
-#endif
-
-int keyb_present = HAS_KEYB;	/* keyboard controller is present by default */
+int keyb_present = 1;	/* keyboard controller is present by default */
 RESIDUAL hold_resid_buf;
 RESIDUAL *hold_residual = &hold_resid_buf;
 unsigned long initrd_start = 0, initrd_end = 0;
@@ -382,11 +376,8 @@
 #if defined(CONFIG_SERIAL_CONSOLE)
 	com_port = (struct NS16550 *)NS16550_init(0);
 #endif /* CONFIG_SERIAL_CONSOLE */
-#ifdef CONFIG_VGA
 	vga_init(0xC0000000);
-#endif

-#ifndef CONFIG_GEMINI
 	if (residual)
 	{
 		/* Is this Motorola PPCBug? */
@@ -454,7 +445,6 @@
 		/* Turn MMU back off */
 		_put_MSR(orig_MSR & ~0x0030);
 	}
-#endif /* !CONFIG_GEMINI */

 	if (start_multi) {
 		hold_residual->VitalProductData.SmpIar = 0;
@@ -493,22 +483,13 @@
 		puts("\n");
 	}

-#ifndef CONFIG_GEMINI
 	/* we have to subtract 0x10000 here to correct for objdump including the
 	   size of the elf header which we strip -- Cort */
 	zimage_start = (char *)(load_addr - 0x10000 + ZIMAGE_OFFSET);
 	zimage_size = ZIMAGE_SIZE;
-#else
-	zimage_start = (char *)(load_addr + ZIMAGE_OFFSET);
-	zimage_size = ZIMAGE_SIZE;
-#endif

 	if ( INITRD_OFFSET )
-#ifndef CONFIG_GEMINI
 		initrd_start = load_addr - 0x10000 + INITRD_OFFSET;
-#else
-	        initrd_start = load_addr + INITRD_OFFSET;
-#endif
 	else
 		initrd_start = 0;
 	initrd_end = INITRD_SIZE + initrd_start;
@@ -558,9 +539,7 @@
 	puts("\nLinux/PPC load: ");
 	timer = 0;
 	cp = cmd_line;
-#ifndef CONFIG_GEMINI
 	memcpy (cmd_line, cmd_preset, sizeof(cmd_preset));
-#endif
 	while ( *cp ) putc(*cp++);
 	while (timer++ < 5*1000) {
 		if (tstc()) {
@@ -579,9 +558,7 @@
 		}
 		udelay(1000);  /* 1 msec */
 	}
-#ifndef CONFIG_GEMINI
 	*cp = 0;
-#endif
 	puts("\n");

 	/* mappings on early boot can only handle 16M */
diff -ru linux_2_2-gemini/arch/ppc/boot/ns16550.c linux_2_2-base/arch/ppc/boot/ns16550.c
--- linux_2_2-gemini/arch/ppc/boot/ns16550.c	Mon Dec 18 13:23:38 2000
+++ linux_2_2-base/arch/ppc/boot/ns16550.c	Mon Dec 18 20:59:04 2000
@@ -2,7 +2,6 @@
  * COM1 NS16550 support
  */

-#include <linux/config.h>
 #include "ns16550.h"
 typedef struct NS16550 *NS16550_t;

@@ -23,7 +22,6 @@
 #if 0
  if (com_port->ier != 0x0F) return ((struct NS16550 *)0);
 #endif
-#ifndef CONFIG_GEMINI
  com_port->ier = 0x00;
  com_port->lcr = 0x80;  /* Access baud rate */
  com_port->dll = 0xc;  /* 9600 baud */
@@ -31,14 +29,6 @@
  com_port->lcr = 0x03;  /* 8 data, 1 stop, no parity */
  com_port->mcr = 0x03;  /* RTS/DTR */
  com_port->fcr = 0x07;  /* Clear & enable FIFOs */
-#else
- com_port->lcr = 0x83;
- com_port->rbr = 0x9c;
- com_port->ier = 0;
- com_port->lcr = 7;
- com_port->mcr = 0xf;
- asm("sync");
-#endif
  return (com_port);
 }

@@ -48,7 +38,6 @@
  volatile int i;
  while ((com_port->lsr & LSR_THRE) == 0) ;
  com_port->thr = c;
- asm("sync");
 }

 unsigned char
diff -ru linux_2_2-gemini/arch/ppc/boot/ns16550.h linux_2_2-base/arch/ppc/boot/ns16550.h
--- linux_2_2-gemini/arch/ppc/boot/ns16550.h	Mon Dec 18 13:25:07 2000
+++ linux_2_2-base/arch/ppc/boot/ns16550.h	Mon Dec 18 20:57:54 2000
@@ -2,8 +2,6 @@
  * NS16550 Serial Port
  */

-#include <linux/config.h>
-
 struct NS16550
  {
   unsigned char rbr;  /* 0 */
@@ -30,14 +28,7 @@
 #define LSR_TEMT 0x40  /* Xmitter empty */
 #define LSR_ERR  0x80  /* Error */

-#ifndef CONFIG_GEMINI
 #define COM1 0x800003F8
 #define COM2 0x800002F8
 #define COM3 0x800003F8
 #define COM4 0x80000388
-#else
-#define COM1 0xffeffb08
-#define COM2 0xffeffb00
-#define COM3 0
-#define COM4 0
-#endif
diff -ru linux_2_2-gemini/arch/ppc/kernel/gemini_prom.S linux_2_2-base/arch/ppc/kernel/gemini_prom.S
--- linux_2_2-gemini/arch/ppc/kernel/gemini_prom.S	Mon Dec 18 13:39:23 2000
+++ linux_2_2-base/arch/ppc/kernel/gemini_prom.S	Mon Dec 18 20:56:43 2000
@@ -37,6 +37,28 @@
 	ori	r3,r3,MSR_IR|MSR_DR
 	andc	r4,r4,r3
 	mtmsr	r4
+#if 0
+	/* zero out the bats now that the MMU is off */
+prom_no_mmu:
+	li	r3,0
+        mtspr   IBAT0U,r3
+        mtspr   IBAT0L,r3
+        mtspr   IBAT1U,r3
+        mtspr   IBAT1L,r3
+        mtspr   IBAT2U,r3
+        mtspr   IBAT2L,r3
+        mtspr   IBAT3U,r3
+        mtspr   IBAT3L,r3
+
+        mtspr   DBAT0U,r3
+        mtspr   DBAT0L,r3
+        mtspr   DBAT1U,r3
+        mtspr   DBAT1L,r3
+        mtspr   DBAT2U,r3
+	mtspr   DBAT2L,r3
+        mtspr   DBAT3U,r3
+        mtspr   DBAT3L,r3
+#endif

 	/* the bootloader (as far as I'm currently aware) doesn't mess with page
 	   tables, but since we're already here, might as well zap these, too */
diff -ru linux_2_2-gemini/arch/ppc/kernel/gemini_setup.c linux_2_2-base/arch/ppc/kernel/gemini_setup.c
--- linux_2_2-gemini/arch/ppc/kernel/gemini_setup.c	Tue Jan  2 16:45:48 2001
+++ linux_2_2-base/arch/ppc/kernel/gemini_setup.c	Mon Dec 18 21:00:11 2000
@@ -19,7 +19,6 @@
 #include <linux/types.h>
 #include <linux/major.h>
 #include <linux/blk.h>
-#include <linux/vt_kern.h>
 #include <linux/console.h>
 #include <linux/openpic.h>
 #include <linux/delay.h>
@@ -39,14 +38,8 @@

 void gemini_setup_pci_ptrs(void);

-#ifdef CONFIG_FB
-extern int pckbd_setkeycode(unsigned int scancode, unsigned int keycode);
-extern int pckbd_getkeycode(unsigned int scancode);
-extern int pckbd_translate(unsigned char scancode, unsigned char *keycode,
-			char raw_mode);
-extern char pckbd_unexpected_up(unsigned char keycode);
-extern char pckbd_sysrq_xlate[128];
-#endif /* CONFIG_FB */
+static int l2_printed = 0;
+static unsigned char gemini_switch_map = 0;
 static char *gemini_board_families[] = {
 	"VGM", "VSS", "KGM", "VGR", "KSS"
 };
@@ -62,30 +55,6 @@
 	0, 0, 14, 0, 0, 13, 5, 9, 6, 11, 8, 10, 0, 12, 7, 0
 };

-#define NVRAM_START 0xffe80000
-#define NVRAM_SIZE  (1<<17)       /* 128k length */
-
-#define NVRAM_OS_LINUX  0xffe9e900  /* agreed-upon start for Linux-specific
-				       region of NVRAM */
-#define NVRAM_OS_SMON   0xffe9f800  /* SMon start */
-#define NVRAM_OS_PSOS   0xffe9f000  /* pSOS */
-
-void
-gemini_nvram_write_val(unsigned char val, int offset)
-{
-	if (offset > NVRAM_SIZE)
-		return;
-	outb(val, (NVRAM_START + offset));
-}
-
-unsigned char
-gemini_nvram_read_val(int offset)
-{
-	if (offset > NVRAM_SIZE)
-		return -1;
-	return inb(NVRAM_START + offset);
-}
-
 void
 gemini_do_IRQ(struct pt_regs *regs, int cpu, int isfake)
 {
@@ -135,44 +104,10 @@
 	return val;
 }

-static int
-gemini_get_clock_speed(void)
-{
-	unsigned long hid1, rev = ((_get_PVR()>>16) & 0xf);
-	int clock;
-	unsigned char reg;
-
-	hid1 = ((_get_HID1()>>28) & 0xf);
-	if (rev == 8 || rev == 12)
-		hid1 = cpu_7xx[hid1];
-	else
-		hid1 = cpu_6xx[hid1];
-
-	reg = readb(GEMINI_BSTAT) & 0xc0;
-
-	switch( reg >> 2 ) {
-
-	case 0:
-	default:
-		clock = (hid1*100)/3;
-		break;
-
-	case 1:
-		clock = (hid1*125)/3;
-		break;
-
-	case 2:
-	  clock = (hid1*50);	/* /3; */
-		break;
-	}
-
-	return clock;
-}
-
 int
 gemini_get_cpuinfo(char *buffer)
 {
-	int len;
+	int i, len;
 	unsigned char reg, rev;
 	char *family;
 	unsigned int type;
@@ -197,8 +132,13 @@
 	reg = readb(GEMINI_MEMCFG);
 	len += sprintf( buffer+len, "memory type\t: %s\n",
 			gemini_memtypes[(reg & 0xc0)>>6]);
-	len += sprintf(buffer+len, "clock\t\t: %dMHz\n",
-		       gemini_get_clock_speed());
+	len += sprintf( buffer+len, "switches on\t: ");
+	for( i=0; i < 8; i++ ) {
+		if ( gemini_switch_map & (1<<i))
+			len += sprintf(buffer+len, "%d ", i);
+	}
+	len += sprintf(buffer+len, "\n");
+
 	return len;
 }

@@ -217,57 +157,65 @@

 void __init gemini_openpic_init(void)
 {
-	unsigned long reg;
+	grackle_write(GEMINI_MPIC_PCI_CFG + PCI_BASE_ADDRESS_0,
+		      GEMINI_MPIC_ADDR);
+	grackle_write(GEMINI_MPIC_PCI_CFG + PCI_COMMAND, PCI_COMMAND_MEMORY);

-	reg = grackle_read(0x80005810);
+	OpenPIC = (volatile struct OpenPIC *) GEMINI_MPIC_ADDR;
 	OpenPIC_InitSenses = gemini_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof( gemini_openpic_initsenses );
-	OpenPIC = (volatile struct OpenPIC *) ioremap( reg, sizeof( struct OpenPIC ));
-}

-static void
-gemini_mksound(unsigned int hz, unsigned int ticks)
-{
+	ioremap( GEMINI_MPIC_ADDR, sizeof( struct OpenPIC ));
 }

-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-	kd_mksound = gemini_mksound;
-#endif
-
 extern int root_mountflags;
 extern char cmd_line[];

-#define GRACKLE_MCP_EN (1<<11)
-#define GRACKLE_TEA_EN (1<<10)

 void __init
 gemini_setup_arch(unsigned long * memory_start_p, unsigned long * memory_end_p)
 {
-	unsigned long t;
+	unsigned int cpu;
 	extern char cmd_line[];


 	loops_per_jiffy = 50000000/HZ;

-	/* SMon sets the pair, so we can disable both safely */
-	t = grackle_read(0x800000a8);  /* get PICR1 */
-	if (t & (GRACKLE_TEA_EN|GRACKLE_MCP_EN)) {
-		printk("Disabling Grackle MPC and TEA.\n");
-		t &= ~(GRACKLE_TEA_EN|GRACKLE_MCP_EN);
-		grackle_write(0x800000a8, t);
-	}
-
 #ifdef CONFIG_BLK_DEV_INITRD
-	/* with non-ELF ramdisk support, do it from a ramdisk */
+	/* bootable off CDROM */
 	if (initrd_start)
-		ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
+		ROOT_DEV = MKDEV(SCSI_CDROM_MAJOR, 0);
 	else
 #endif
 		ROOT_DEV = to_kdev_t(0x0801);

+	/* nothing but serial consoles... */
+	sprintf(cmd_line, "%s console=ttyS0", cmd_line);
+
+
+	/* The user switches on the front panel can be used as follows:
+
+	   Switch 0 - adds "debug" to the command line for verbose boot info,
+	   Switch 7 - boots in single-user mode
+
+	*/
+
+	gemini_switch_map = readb( GEMINI_USWITCH );
+
+	if ( gemini_switch_map & (1<<GEMINI_SWITCH_VERBOSE))
+		sprintf(cmd_line, "%s debug", cmd_line);
+
+	if ( gemini_switch_map & (1<<GEMINI_SWITCH_SINGLE_USER))
+		sprintf(cmd_line, "%s single", cmd_line);
+
 	printk("Boot arguments: %s\n", cmd_line);

+	/* mutter some kind words about who made the CPU */
+	cpu = _get_PVR();
+	printk("CPU manufacturer: %s [rev=%04x]\n", (cpu & (1<<15)) ? "IBM" :
+	       "Motorola", (cpu & 0xffff));
+
+	/* take special pains to map the MPIC, since it isn't mapped yet */
 	gemini_openpic_init();

 	/* start the L2 */
@@ -275,66 +223,116 @@

 }

-void __init gemini_init_l2(void)
+
+int
+gemini_get_clock_speed(void)
 {
-	unsigned char reg, brev, fam, creg;
-	unsigned long cache, pvr = _get_PVR();
+	unsigned long hid1;
+	int clock;
+	unsigned char reg;
+
+	hid1 = _get_HID1();
+	if ((_get_PVR()>>16) == 8)
+		hid1 = cpu_7xx[hid1];
+	else
+		hid1 = cpu_6xx[hid1];

-	reg = readb(GEMINI_L2CFG);
-	brev = readb(GEMINI_BREV);
-	fam = readb(GEMINI_FEAT);
+	reg = readb(GEMINI_BSTAT) & 0xc0;

-	switch((pvr >> 16) & 0xf) {
-	case 8:
-	    if (reg & 0xc0)
-		cache = (((reg >> 6) & 0x3) << 28);
-	    else
-		cache = 3 << 28;
-
-#ifdef CONFIG_SMP
-	    /* Pre 3.0 processors have snooping errata.  If found,
-	       leave the L2 disabled.  - Dan */
-	    if (((pvr >> 8) & 0xf) < 3) {
-		printk("Pre 3.0 750 silicon; L2 left disabled\n");
-		return;
-	    }
-#endif /* CONFIG_SMP */
-	    if ((brev == 0x51) && ((fam & 0xa0) >> 4) == 0)
-		reg |= 1;
-	    else if (gemini_get_clock_speed() > 250)
-		    reg = 2;
-	    break;
+	switch( reg >> 2 ) {

-	case 12:
-	{
-	    static unsigned long l2_size_val = 0;
-
-	    if (!l2_size_val)
-		l2_size_val = _get_L2CR();
-	    cache = l2_size_val;
-	    break;
+	case 0:
+	default:
+		clock = (hid1*100)/3;
+		break;
+
+	case 1:
+		clock = (hid1*125)/3;
+		break;
+
+	case 2:
+		clock = (hid1*50)/3;
+		break;
 	}

-	case 4:
-	case 9:
-	    creg = readb(GEMINI_CPUSTAT);
-	    if (((creg & 0xc) >> 2) != 1)
-		printk("Dual-604 w/Grackle errata; L2 left disabled.\n");
-	    else
-		writeb(1, GEMINI_L2CFG);
-	    return;
+	return clock;
+}

-	default:
-	    printk("Unknown processor type (%08lx); L2 left disabled.\n",
-		   ((pvr>>16) & 0xf));
-	    return;
+void __init gemini_init_l2(void)
+{
+	unsigned char reg;
+	unsigned long cache;
+	int speed;
+
+	reg = readb(GEMINI_L2CFG);
+
+	/* 750's L2 initializes differently from a 604's.  Also note that a Grackle
+	   bug will hang a dual-604 board, so make sure that doesn't happen by not
+	   turning on the L2 */
+	if ( _get_PVR() >> 16 != 8 ) {
+
+		/* check for dual cpus and cry sadly about the loss of an L2... */
+		if ((( readb(GEMINI_CPUSTAT) & 0x0c ) >> 2) != 1)
+			printk("Sorry. Your dual-604 does not allow the L2 to be enabled due "
+			       "to a Grackle bug.\n");
+		else if ( reg & GEMINI_L2_SIZE_MASK ) {
+			printk("Enabling 604 L2 cache: %dKb\n",
+			       (128<<((reg & GEMINI_L2_SIZE_MASK)>>6)));
+			writeb( 1, GEMINI_L2CFG );
+		}
 	}

-	/* standard stuff */
-	cache |= ((1<<reg)<<25);
-	cache |= L2CR_PIPE_LATEWR|L2CR_L2CTL|L2CR_INST_DISABLE;
-	_set_L2CR(0);
-	_set_L2CR(cache|L2CR_L2I|L2CR_L2E);
+	/* do a 750 */
+	else {
+		/* Synergy's first round of 750 boards had the L2 size stuff into the
+		   board register above.  If it's there, it's used; if not, the
+		   standard default is 1Mb.  The L2 type, I'm told, is "most likely
+		   probably always going to be late-write".  --Dan */
+
+		if (reg & 0xc0) {
+			if (!l2_printed) {
+				printk("Enabling 750 L2 cache: %dKb\n",
+				       (128 << ((reg & 0xc0)>>6)));
+				l2_printed=1;
+			}
+
+			/* take the size given */
+			cache = (((reg>>6) & 0x3)<<28);
+		}
+		else
+			/* default of 1Mb */
+			cache = 0x3<<28;
+
+		reg &= 0x3;
+
+		/* a cache ratio of 1:1 and CPU clock speeds in excess of 300Mhz are bad
+		   things.  If found, tune it down to 1:1.5.  -- Dan */
+		if (!reg) {
+
+			speed = gemini_get_clock_speed();
+
+			if (speed >= 300) {
+				printk("Warning:  L2 ratio is 1:1 on a %dMhz processor.  Dropping to 1:1.5.\n",
+				       speed );
+				printk("Contact Synergy Microsystems for an ECO to fix this problem\n");
+				reg = 0x1;
+			}
+		}
+
+		/* standard stuff */
+		cache |= ((1<<reg)<<25);
+#ifdef __SMP__
+		/* A couple errata for the 750's (both IBM and Motorola silicon)
+		   note that you can get missed cache lines on MP implementations.
+		   The workaround - if you call it that - is to make the L2
+		   write-through.  This is fixed in IBM's 3.1 rev (I'm told), but
+		   for now, always make 2.x versions use L2 write-through. --Dan */
+		if (((_get_PVR()>>8) & 0xf) <= 2)
+			cache |= L2CR_L2WT;
+#endif
+		cache |= L2CR_PIPE_LATEWR|L2CR_L2CTL|L2CR_INST_DISABLE;
+		_set_L2CR(cache|L2CR_L2E);
+	}
 }

 void
@@ -503,17 +501,17 @@
 	switch(((reg & 0x0c)>>2)&0x3) {
 	case 0:
 	default:
-		freq = 66667;
+		freq = 66;
 		break;
 	case 1:
-		freq = 83000;
+		freq = 83;
 		break;
 	case 2:
-		freq = 100000;
+		freq = 100;
 		break;
 	}

-	freq *= 1000;
+	freq *= 1000000;
 	divisor = 4;
 	decrementer_count = freq / HZ / divisor;
 	count_period_num = divisor;
@@ -556,15 +554,12 @@
 	ppc_md.set_rtc_time = gemini_set_rtc_time;
 	ppc_md.get_rtc_time = gemini_get_rtc_time;
 	ppc_md.calibrate_decr = gemini_calibrate_decr;
-	ppc_md.nvram_read_val = gemini_nvram_read_val;
-	ppc_md.nvram_write_val = gemini_nvram_write_val;

-#ifdef CONFIG_FB
-	ppc_md.kbd_setkeycode = pckbd_setkeycode;
-	ppc_md.kbd_getkeycode = pckbd_getkeycode;
-	ppc_md.kbd_translate = pckbd_translate;
-	ppc_md.kbd_unexpected_up = pckbd_unexpected_up;
-#endif
+	/* no keyboard/mouse/video stuff yet.. */
+	ppc_md.kbd_setkeycode = NULL;
+	ppc_md.kbd_getkeycode = NULL;
+	ppc_md.kbd_translate = NULL;
+	ppc_md.kbd_unexpected_up = NULL;
 	ppc_md.kbd_leds = NULL;
 	ppc_md.kbd_init_hw = NULL;
 #ifdef CONFIG_MAGIC_SYSRQ
diff -ru linux_2_2-gemini/arch/ppc/kernel/idle.c linux_2_2-base/arch/ppc/kernel/idle.c
--- linux_2_2-gemini/arch/ppc/kernel/idle.c	Mon Dec 18 19:43:42 2000
+++ linux_2_2-base/arch/ppc/kernel/idle.c	Mon Dec 18 20:57:14 2000
@@ -297,7 +297,6 @@
 	case 6:			/* 603e */
 	case 7:			/* 603ev */
 	case 8:			/* 750 */
-	case 12:		/* 7400 */
 		save_flags(msr);
 		__cli();
 		if (!current->need_resched) {
diff -ru linux_2_2-gemini/drivers/char/serial.c linux_2_2-base/drivers/char/serial.c
--- linux_2_2-gemini/drivers/char/serial.c	Mon Dec 18 20:26:20 2000
+++ linux_2_2-base/drivers/char/serial.c	Mon Dec 18 20:57:06 2000
@@ -2963,7 +2963,6 @@
 	 * 0x80 is a non-existent port; which should be safe since
 	 * include/asm/io.h also makes this assumption.
 	 */
-#ifdef __i386__
 	scratch = serial_inp(info, UART_IER);
 	serial_outp(info, UART_IER, 0);
 	outb(0xff, 0x080);
@@ -2973,7 +2972,6 @@
 		restore_flags(flags);
 		return;		/* We failed; there's nothing here */
 	}
-#endif

 	/*
 	 * Check to see if a UART is really there.  Certain broken
diff -ru linux_2_2-gemini/include/asm-ppc/gemini_serial.h linux_2_2-base/include/asm-ppc/gemini_serial.h
--- linux_2_2-gemini/include/asm-ppc/gemini_serial.h	Mon Dec 18 20:52:24 2000
+++ linux_2_2-base/include/asm-ppc/gemini_serial.h	Mon Dec 18 21:00:37 2000
@@ -7,10 +7,10 @@
 #define BASE_BAUD  (24576000 / 16)

 #ifdef CONFIG_SERIAL_DETECT_IRQ
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST|ASYNC_AUTO_IRQ)
+#define STD_COM_FLAGS (/*ASYNC_BOOT_AUTOCONF|*/ASYNC_SKIP_TEST|ASYNC_AUTO_IRQ)
 #define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_AUTO_IRQ)
 #else
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST)
+#define STD_COM_FLAGS (/*ASYNC_BOOT_AUTOCONF|*/ASYNC_SKIP_TEST)
 #define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF)
 #endif


--------------BB9BB4EC05AC0D4D6AD417CB--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
