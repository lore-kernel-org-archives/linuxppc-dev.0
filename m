To: linuxppc-dev@lists.linuxppc.org
Subject: Restructure of arch/ppc/kernel and include/asm-ppc
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 12 Dec 1998 10:36:18 -0600
Message-ID: <m2zp8te2rh.fsf@wf-rch.cirr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

This is a patch relative to 2.1.131 that significantly restructures
the Linux PPC stuff.  It is the first step in making the code more
modular and separating the machine-specific from the
machine-independant stuff.  This currently works on my MVME2700
board.

Significantly, the following have been done:
  * Most machine-dependencies have been removed from include/asm-ppc.
    However, there is a lot of stuff with CONFIG_APUS that has
    dependencies on the include/asm-m68k directory.  I'm not sure
    what to do with that.
  * CONFIG_MACH_SPECIFIC occurs in one place now in setup.c.  Once
    good detection code is done, it should be easier to pull that
    out.
  * All machine-dependent stuff except for detection has been pulled
    out of setup.c and moved into the specific setup files.
  * The <asm/machdep.h> file has been extended to add a data structure
    that has function pointers to machine-dependent routines.  This
    must be filled in by the specific setup routines.
  * Most #ifdef CONFIG_xxx have been pulled out of all file.

To still be done:
  * More restructure needs to be done, especially for the CONFIG_APUS
    stuff.  Any takers?
  * I'm sure it won't compile for all architectures.  If you fix
    something to make it compile (or work, for that matter :-) please
    send me a patch.
  * Detection needs to be done.  This might be pretty tricky.

When I issue more patches, they will always be relative to 2.1.131
(or whatever kernel), not relative to the previous patches.  So keep
the original stuff around.

The patch applies to 2.1.127 (although I haven't tested) except for
the keyboard.h file, which I'm not sure what to do with since it was
significantly restructured.

-- 
Corey Minyard               Internet:  minyard@acm.org
  Work: minyard@nortel.ca       UUCP:  minyard@wf-rch.cirr.com

diff -ur linux-2.1.131.orig/include/asm-ppc/dma.h linux-2.1.131/include/asm-ppc/dma.h
--- linux-2.1.131.orig/include/asm-ppc/dma.h	Sun Nov 15 12:51:49 1998
+++ linux-2.1.131/include/asm-ppc/dma.h	Sat Dec 12 09:56:52 1998
@@ -35,36 +35,9 @@
 /* Doesn't really apply... */
 #define MAX_DMA_ADDRESS      0xFFFFFFFF
 
-#if defined(CONFIG_MACH_SPECIFIC)
-
-#if defined(CONFIG_PREP)
-#define DMA_MODE_READ 0x44
-#define DMA_MODE_WRITE 0x48
-#define ISA_DMA_THRESHOLD 0x00ffffff
-#endif /* CONFIG_PREP */
-
-#if defined(CONFIG_CHRP)
-#define DMA_MODE_READ 0x44
-#define DMA_MODE_WRITE 0x48
-#define ISA_DMA_THRESHOLD ~0L
-#endif /* CONFIG_CHRP */
-
-#ifdef CONFIG_PMAC
-#define DMA_MODE_READ 1
-#define DMA_MODE_WRITE 2
-#define ISA_DMA_THRESHOLD ~0L
-#endif /* CONFIG_PMAC */
-
-#ifdef CONFIG_APUS
-/* This is bogus and should go away. */
-#define ISA_DMA_THRESHOLD (0x00ffffff)
-#endif
-
-#else
 /* in arch/ppc/kernel/setup.c -- Cort */
 extern unsigned long DMA_MODE_WRITE, DMA_MODE_READ;
 extern unsigned long ISA_DMA_THRESHOLD;
-#endif
 
 
 #ifdef HAVE_REALLY_SLOW_DMA_CONTROLLER
diff -ur linux-2.1.131.orig/include/asm-ppc/ide.h linux-2.1.131/include/asm-ppc/ide.h
--- linux-2.1.131.orig/include/asm-ppc/ide.h	Sun Nov 15 12:51:49 1998
+++ linux-2.1.131/include/asm-ppc/ide.h	Fri Dec 11 17:57:12 1998
@@ -12,6 +12,8 @@
 #define __ASMPPC_IDE_H
 
 #include <linux/config.h>
+#include <linux/sched.h>
+#include <asm/processor.h>
 #ifdef CONFIG_APUS
 #include <linux/hdreg.h>
 
diff -ur linux-2.1.131.orig/include/asm-ppc/irq.h linux-2.1.131/include/asm-ppc/irq.h
--- linux-2.1.131.orig/include/asm-ppc/irq.h	Sun Nov 15 12:51:50 1998
+++ linux-2.1.131/include/asm-ppc/irq.h	Fri Dec 11 17:55:01 1998
@@ -3,7 +3,7 @@
 #ifndef _ASM_IRQ_H
 #define _ASM_IRQ_H
 
-#include <asm/processor.h>		/* for is_prep() */
+#include <asm/machdep.h>		/* ppc_md */
 
 #ifndef CONFIG_8xx
 
@@ -42,7 +42,14 @@
  */
 static __inline__ int irq_cannonicalize(int irq)
 {
-	return (((is_prep || is_chrp) && irq == 2) ? 9 : irq);
+	if (ppc_md.irq_cannonicalize)
+	{
+		return ppc_md.irq_cannonicalize(irq);
+	}
+	else
+	{
+		return irq;
+	}
 }
 #endif
 
diff -ur linux-2.1.131.orig/include/asm-ppc/keyboard.h linux-2.1.131/include/asm-ppc/keyboard.h
--- linux-2.1.131.orig/include/asm-ppc/keyboard.h	Tue Aug  4 18:06:36 1998
+++ linux-2.1.131/include/asm-ppc/keyboard.h	Sat Dec 12 09:50:21 1998
@@ -21,155 +21,47 @@
 #ifdef CONFIG_APUS
 #include <asm-m68k/keyboard.h>
 #else
+#include <asm/machdep.h>
 
 #define KEYBOARD_IRQ			1
 #define DISABLE_KBD_DURING_INTERRUPTS	0
 #define INIT_KBD
 
-extern int mackbd_setkeycode(unsigned int scancode, unsigned int keycode);
-extern int mackbd_getkeycode(unsigned int scancode);
-extern int mackbd_pretranslate(unsigned char scancode, char raw_mode);
-extern int mackbd_translate(unsigned char scancode, unsigned char *keycode,
-			   char raw_mode);
-extern int mackbd_unexpected_up(unsigned char keycode);
-extern void mackbd_leds(unsigned char leds);
-extern void mackbd_init_hw(void);
-
-extern int pckbd_setkeycode(unsigned int scancode, unsigned int keycode);
-extern int pckbd_getkeycode(unsigned int scancode);
-extern int pckbd_pretranslate(unsigned char scancode, char raw_mode);
-extern int pckbd_translate(unsigned char scancode, unsigned char *keycode,
-			   char raw_mode);
-extern char pckbd_unexpected_up(unsigned char keycode);
-extern void pckbd_leds(unsigned char leds);
-extern void pckbd_init_hw(void);
-
 static inline int kbd_setkeycode(unsigned int scancode, unsigned int keycode)
 {
-	if ( is_prep )
-		return pckbd_setkeycode(scancode,keycode);
-	else if ( is_chrp )
-#ifndef CONFIG_MAC_KEYBOARD
-		return pckbd_setkeycode(scancode,keycode);
-#else
-		/* I'm not actually sure if it's legal to have a CHRP machine
-		 * without an ADB controller. In any case, this should really
-		 * be changed to be a test to see if an ADB _keyboard_ exists
-		 * (not just a controller), but that's another story for
-		 * another night.
-		 */
-		if ( adb_hardware == ADB_NONE )
-			return pckbd_setkeycode(scancode,keycode);
-		else
-			return mackbd_setkeycode(scancode,keycode);
-#endif
-	else
-		return mackbd_setkeycode(scancode,keycode);
-}
-
-static inline int kbd_getkeycode(unsigned int x)
-{
-	if ( is_prep )
-		return pckbd_getkeycode(x);
-	else if ( is_chrp )
-#ifndef CONFIG_MAC_KEYBOARD
-		return pckbd_getkeycode(x);
-#else
-		if ( adb_hardware == ADB_NONE )
-			return pckbd_getkeycode(x);
-		else
-			return mackbd_getkeycode(x);
-#endif
-	else
-		return mackbd_getkeycode(x);
-}
-
-static inline int kbd_pretranslate(unsigned char x,char y)
-{
-	if ( is_prep )
-		return pckbd_pretranslate(x,y);
-	else if ( is_chrp )
-#ifndef CONFIG_MAC_KEYBOARD
-		return pckbd_pretranslate(x,y);
-#else
-		if ( adb_hardware == ADB_NONE )
-			return pckbd_pretranslate(x,y);
-		else
-			return mackbd_pretranslate(x,y);
-#endif
-	else
-		return mackbd_pretranslate(x,y);
+	return ppc_md.kbd_setkeycode(scancode, keycode);
+}
+
+static inline int kbd_getkeycode(unsigned int scancode)
+{
+	return ppc_md.kbd_getkeycode(scancode);
+}
+
+static inline int kbd_pretranslate(unsigned char scancode,
+				   char          raw_mode)
+{
+	return ppc_md.kbd_pretranslate(scancode, raw_mode);
 }
 
 static inline int kbd_translate(unsigned char keycode, unsigned char *keycodep,
 		     char raw_mode)
 {
-	if ( is_prep )
-		return pckbd_translate(keycode,keycodep,raw_mode);
-	else if ( is_chrp )
-#ifndef CONFIG_MAC_KEYBOARD
-		return pckbd_translate(keycode,keycodep,raw_mode);
-#else
-		if ( adb_hardware == ADB_NONE )
-			return pckbd_translate(keycode,keycodep,raw_mode);
-		else
-			return mackbd_translate(keycode,keycodep,raw_mode);
-#endif
-	else
-		return mackbd_translate(keycode,keycodep,raw_mode);
-	
+	return ppc_md.kbd_translate(keycode, keycodep, raw_mode);
 }
 
 static inline int kbd_unexpected_up(unsigned char keycode)
 {
-	if ( is_prep )
-		return pckbd_unexpected_up(keycode);
-	else if ( is_chrp )
-#ifndef CONFIG_MAC_KEYBOARD
-		return pckbd_unexpected_up(keycode);
-#else
-		if ( adb_hardware == ADB_NONE )
-			return pckbd_unexpected_up(keycode);
-		else
-			return mackbd_unexpected_up(keycode);
-#endif
-	else
-		return mackbd_unexpected_up(keycode);
-	
+	return ppc_md.kbd_unexpected_up(keycode);
 }
 
 static inline void kbd_leds(unsigned char leds)
 {
-	if ( is_prep )
-		pckbd_leds(leds);
-	else if ( is_chrp )
-#ifndef CONFIG_MAC_KEYBOARD
-		pckbd_leds(leds);
-#else
-		if ( adb_hardware == ADB_NONE )
-			pckbd_leds(leds);
-		else
-			mackbd_leds(leds);
-#endif
-	else
-		mackbd_leds(leds);
+	ppc_md.kbd_leds(leds);
 }
 
 static inline void kbd_init_hw(void)
 {
-	if ( is_prep )
-		pckbd_init_hw();
-	else if ( is_chrp )
-#ifndef CONFIG_MAC_KEYBOARD
-		pckbd_init_hw();
-#else
-		if ( adb_hardware == ADB_NONE )
-			pckbd_init_hw();
-		else
-			mackbd_init_hw();
-#endif
-	else
-		mackbd_init_hw();
+	ppc_md.kbd_init_hw();
 }
 
 #endif /* CONFIG_APUS */
diff -ur linux-2.1.131.orig/include/asm-ppc/machdep.h linux-2.1.131/include/asm-ppc/machdep.h
--- linux-2.1.131.orig/include/asm-ppc/machdep.h	Tue Aug  4 18:06:36 1998
+++ linux-2.1.131/include/asm-ppc/machdep.h	Sat Dec 12 09:50:02 1998
@@ -1,12 +1,53 @@
+
 #ifndef _PPC_MACHDEP_H
 #define _PPC_MACHDEP_H
 
 #include <linux/config.h>
+#include <asm/ide.h>
 
 #ifdef CONFIG_APUS
 #include <asm-m68k/machdep.h>
 #endif
 
-#endif /* _PPC_MACHDEP_H */
+struct machdep_calls {
+   void          (*setup_arch)(unsigned long * memory_start_p,
+			       unsigned long * memory_end_p);
+   /* Optional, may be NULL. */
+   int           (*setup_residual)(char *buffer);
+   /* Optional, may be NULL. */
+   int           (*get_cpuinfo)(char *buffer);
+   /* Optional, may be NULL. */
+   int           (*irq_cannonicalize)(int irq);
+
+   void          (*restart)(char *cmd);
+   void          (*power_off)(void);
+   void          (*halt)(void);
+
+   void          (*time_init)(void); /* Optional, may be NULL */
+   int           (*set_rtc_time)(unsigned long nowtime);
+   unsigned long (*get_rtc_time)(void);
+   void          (*calibrate_decr)(void);
 
+   /* Optional, may be NULL. */
+   void          (*ide_init_hwif)(ide_ioreg_t *p, ide_ioreg_t base, int *irq);
 
+   /* Tons of keyboard stuff. */
+   int		 (*kbd_setkeycode)(unsigned int scancode,
+				   unsigned int keycode);
+   int		 (*kbd_getkeycode)(unsigned int scancode);
+   int		 (*kbd_pretranslate)(unsigned char scancode,
+				     char raw_mode);
+   int		 (*kbd_translate)(unsigned char scancode,
+				  unsigned char *keycode,
+				  char raw_mode);
+   char		 (*kbd_unexpected_up)(unsigned char keycode);
+   void		 (*kbd_leds)(unsigned char leds);
+   void		 (*kbd_init_hw)(void);
+};
+
+extern struct machdep_calls ppc_md;
+extern char cmd_line[512];
+
+extern void setup_pci_ptrs(void);
+
+#endif /* _PPC_MACHDEP_H */
diff -ur linux-2.1.131.orig/include/asm-ppc/nvram.h linux-2.1.131/include/asm-ppc/nvram.h
--- linux-2.1.131.orig/include/asm-ppc/nvram.h	Sat Aug 16 11:51:09 1997
+++ linux-2.1.131/include/asm-ppc/nvram.h	Thu Dec 10 15:01:05 1998
@@ -30,4 +30,138 @@
 #define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
 #endif
 
-#endif
+/* Corey Minyard (minyard@acm.org) - Stolen from PReP book.   Per the
+   license I must say:
+     (C) Copyright (Corey Minyard), (1998).  All rights reserved
+ */
+
+/* Structure map for NVRAM on PowerPC Reference Platform */
+/* All fields are either character/byte strings which are valid either
+  endian or they are big-endian numbers.
+
+  There are a number of Date and Time fields which are in RTC format,
+  big-endian. These are stored in UT (GMT).
+
+  For enum's: if given in hex then they are bit significant, i.e. only
+  one bit is on for each enum.
+*/
+
+#define NVSIZE 4096	/* size of NVRAM */
+#define OSAREASIZE 512	/* size of OSArea space */
+#define CONFSIZE 1024	/* guess at size of Configuration space */
+
+typedef struct _SECURITY {
+  unsigned long BootErrCnt;	    /* Count of boot password errors */
+  unsigned long ConfigErrCnt;	    /* Count of config password errors */
+  unsigned long BootErrorDT[2];	    /* Date&Time from RTC of last error in pw */
+  unsigned long ConfigErrorDT[2];   /* Date&Time from RTC of last error in pw */
+  unsigned long BootCorrectDT[2];   /* Date&Time from RTC of last correct pw */
+  unsigned long ConfigCorrectDT[2]; /* Date&Time from RTC of last correct pw */
+  unsigned long BootSetDT[2];	    /* Date&Time from RTC of last set of pw */
+  unsigned long ConfigSetDT[2];	    /* Date&Time from RTC of last set of pw */
+  unsigned char Serial[16];	    /* Box serial number */
+} SECURITY;
+
+typedef enum _OS_ID {
+  Unknown = 0,
+  Firmware = 1,
+  AIX = 2,
+  NT = 3,
+  MKOS2 = 4,
+  MKAIX = 5,
+  Taligent = 6,
+  Solaris = 7,
+  MK = 12
+} OS_ID;
+
+typedef struct _ERROR_LOG {
+  unsigned char ErrorLogEntry[40]; /* To be architected */
+} ERROR_LOG;
+
+typedef enum _BOOT_STATUS {
+  BootStarted = 0x01,
+  BootFinished = 0x02,
+  RestartStarted = 0x04,
+  RestartFinished = 0x08,
+  PowerFailStarted = 0x10,
+  PowerFailFinished = 0x20,
+  ProcessorReady = 0x40,
+  ProcessorRunning = 0x80,
+  ProcessorStart = 0x0100
+} BOOT_STATUS;
+
+typedef struct _RESTART_BLOCK {
+  unsigned short Version;
+  unsigned short Revision;
+  unsigned long ResumeReserve1[2];
+  volatile unsigned long BootStatus;
+  unsigned long CheckSum; /* Checksum of RESTART_BLOCK */
+  void * RestartAddress;
+  void * SaveAreaAddr;
+  unsigned long SaveAreaLength;
+} RESTART_BLOCK;
+
+typedef enum _OSAREA_USAGE {
+  Empty = 0,
+  Used = 1
+} OSAREA_USAGE;
+
+typedef enum _PM_MODE {
+  Suspend = 0x80, /* Part of state is in memory */
+  Normal = 0x00   /* No power management in effect */
+} PMMode;
+
+typedef struct _HEADER {
+  unsigned short Size;       /* NVRAM size in K(1024) */
+  unsigned char Version;     /* Structure map different */
+  unsigned char Revision;    /* Structure map the same -may
+                                be new values in old fields
+                                in other words old code still works */
+  unsigned short Crc1;       /* check sum from beginning of nvram to OSArea */
+  unsigned short Crc2;       /* check sum of config */
+  unsigned char LastOS;      /* OS_ID */
+  unsigned char Endian;      /* B if big endian, L if little endian */
+  unsigned char OSAreaUsage; /* OSAREA_USAGE */
+  unsigned char PMMode;      /* Shutdown mode */
+  RESTART_BLOCK RestartBlock;
+  SECURITY Security;
+  ERROR_LOG ErrorLog[2];
+
+  /* Global Environment information */
+  void * GEAddress;
+  unsigned long GELength;
+
+  /* Date&Time from RTC of last change to Global Environment */
+  unsigned long GELastWriteDT[2];
+
+  /* Configuration information */
+  void * ConfigAddress;
+  unsigned long ConfigLength;
+
+  /* Date&Time from RTC of last change to Configuration */
+  unsigned long ConfigLastWriteDT[2];
+  unsigned long ConfigCount; /* Count of entries in Configuration */
+
+  /* OS dependent temp area */
+  void * OSAreaAddress;
+  unsigned long OSAreaLength;
+
+  /* Date&Time from RTC of last change to OSAreaArea */
+  unsigned long OSAreaLastWriteDT[2];
+} HEADER;
+
+/* Here is the whole map of the NVRAM */
+typedef struct _NVRAM_MAP {
+  HEADER Header;
+  unsigned char GEArea[NVSIZE-CONFSIZE-OSAREASIZE-sizeof(HEADER)];
+  unsigned char OSArea[OSAREASIZE];
+  unsigned char ConfigArea[CONFSIZE];
+} NVRAM_MAP;
+
+/* Routines to manipulate the NVRAM */
+void init_prep_nvram(void);
+char *prep_nvram_get_var(const char *name);
+char *prep_nvram_first_var(void);
+char *prep_nvram_next_var(char *name);
+
+#endif /* _PPC_NVRAM_H */
diff -ur linux-2.1.131.orig/include/asm-ppc/processor.h linux-2.1.131/include/asm-ppc/processor.h
--- linux-2.1.131.orig/include/asm-ppc/processor.h	Wed Sep 30 12:14:33 1998
+++ linux-2.1.131/include/asm-ppc/processor.h	Fri Dec 11 16:54:48 1998
@@ -160,67 +160,12 @@
 #define SR15	15
 
 #ifndef __ASSEMBLY__
-/*
- * If we've configured for a specific machine set things
- * up so the compiler can optimize away the other parts.
- * -- Cort
- */
-#ifdef CONFIG_MACH_SPECIFIC
-#ifdef CONFIG_PREP
-#define _machine (_MACH_prep)
-#define is_prep (1)
-#define is_chrp (0)
-#define have_of (0)
-#endif /* CONFIG_PREP */
-
-#ifdef CONFIG_CHRP
-#define _machine (_MACH_chrp)
-#define is_prep (0)
-#define is_chrp (1)
-#define have_of (1)
-#endif /* CONFIG_CHRP */
-
-#ifdef CONFIG_PMAC
-#define _machine (_MACH_Pmac)
-#define is_prep (0)
-#define is_chrp (0)
-#define have_of (1)
-#endif /* CONFIG_PMAC */
-
-#ifdef CONFIG_MBX
-#define _machine (_MACH_mbx)
-#define is_prep (0)
-#define is_chrp (0)
-#define have_of (0)
-#endif /* CONFIG_MBX */
-
-#ifdef CONFIG_FADS
-#define _machine (_MACH_fads)
-#define is_prep (0)
-#define is_chrp (0)
-#define have_of (0)
-#endif /* CONFIG_FADS */
-
-#ifdef CONFIG_APUS
-#define _machine (_MACH_apus)
-#define is_prep (0)
-#define is_chrp (0)
-#define have_of (0)
-#endif /* CONFIG_APUS */
-
-#else /* CONFIG_MACH_SPECIFIC */
-
 extern int _machine;
 
-/* if we're a prep machine */
-#define is_prep (_machine == _MACH_prep)
-
-/* if we're a chrp machine */
-#define is_chrp (_machine == _MACH_chrp)
-
-/* if we have openfirmware */
-extern unsigned long have_of;
-#endif /* CONFIG_MACH_SPECIFIC */
+/* Temporary hacks until we can clean things up better - Corey */
+extern int have_of;
+extern int is_prep;
+extern int is_chrp;
 
 /* what kind of prep workstation we are */
 extern int _prep_type;
@@ -318,10 +263,3 @@
 
   
 #endif /* __ASM_PPC_PROCESSOR_H */
-
-
-
-
-
-
-
--- linux-2.1.131.orig/arch/ppc/kernel/Makefile	Sun Nov 15 12:51:43 1998
+++ linux-2.1.131/arch/ppc/kernel/Makefile	Thu Dec 10 15:01:05 1998
@@ -36,7 +36,8 @@
 O_OBJS += prep_time.o pmac_time.o chrp_time.o \
 	  pmac_setup.o pmac_support.o \
 	  prep_pci.o pmac_pci.o chrp_pci.o \
-	  residual.o prom.o openpic.o
+	  residual.o prom.o openpic.o \
+	  prep_nvram.o
 OX_OBJS += chrp_setup.o prep_setup.o
 endif
 endif
--- linux-2.1.131.orig/arch/ppc/kernel/apus_setup.c	Sun Nov 15 12:51:43 1998
+++ linux-2.1.131/arch/ppc/kernel/apus_setup.c	Sat Dec 12 09:57:22 1998
@@ -20,6 +20,21 @@
 #include <asm/amigappc.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/machdep.h>
+
+unsigned long apus_get_rtc_time(void);
+int apus_set_rtc_time(unsigned long nowtime);
+
+/* APUS defs */
+extern int parse_bootinfo(const struct bi_record *);
+extern char _end[];
+#ifdef CONFIG_APUS
+struct mem_info ramdisk;
+unsigned long isa_io_base;
+unsigned long isa_mem_base;
+unsigned long pci_dram_offset;
+#endif
+/* END APUS defs */
 
 unsigned long m68k_machtype;
 char debug_device[6] = "";
@@ -72,6 +87,8 @@
 	int i;
 	char *p, *q;
 
+	m68k_machtype = MACH_AMIGA;
+
 	/* Parse the command line for arch-specific options.
 	 * For the m68k, this is currently only "debug=xxx" to enable printing
 	 * certain kernel messages to some machine-specific device.  */
@@ -408,4 +425,82 @@
 	       "icbi 0,%0 \n\t"
 	       "isync \n\t"
 	       : : "r" (addr));
+}
+
+void
+apus_restart(char *cmd)
+{
+	cli();
+
+	APUS_WRITE(APUS_REG_LOCK, 
+		   REGLOCK_BLACKMAGICK1|REGLOCK_BLACKMAGICK2);
+	APUS_WRITE(APUS_REG_LOCK, 
+		   REGLOCK_BLACKMAGICK1|REGLOCK_BLACKMAGICK3);
+	APUS_WRITE(APUS_REG_LOCK, 
+		   REGLOCK_BLACKMAGICK2|REGLOCK_BLACKMAGICK3);
+	APUS_WRITE(APUS_REG_SHADOW, REGSHADOW_SELFRESET);
+	APUS_WRITE(APUS_REG_RESET, REGRESET_AMIGARESET);
+	for(;;);
+}
+
+void
+apus_power_off(void)
+{
+	for (;;);
+}
+
+void
+apus_halt(void)
+{
+   apus_restart(NULL);
+}
+
+__initfunc(void
+apus_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	  unsigned long r6, unsigned long r7))
+{
+	/* Parse bootinfo. The bootinfo is located right after
+           the kernel bss */
+	parse_bootinfo((const struct bi_record *)&_end);
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* Take care of initrd if we have one. Use data from
+	   bootinfo to avoid the need to initialize PPC
+	   registers when kernel is booted via a PPC reset. */
+	if ( ramdisk.addr ) {
+		initrd_start = (unsigned long) __va(ramdisk.addr);
+		initrd_end = (unsigned long) 
+			__va(ramdisk.size + ramdisk.addr);
+	}
+	/* Make sure code below is not executed. */
+	r4 = 0;
+	r6 = 0;
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+	ISA_DMA_THRESHOLD = 0x00ffffff;
+
+	ppc_md.setup_arch     = apus_setup_arch;
+	ppc_md.setup_residual = NULL;
+	ppc_md.get_cpuinfo    = apus_get_cpuinfo;
+	ppc_md.irq_cannonicalize = NULL;
+
+	ppc_md.restart        = apus_restart;
+	ppc_md.power_off      = apus_power_off;
+	ppc_md.halt           = apus_halt;
+
+	ppc_md.time_init      = NULL;
+	ppc_md.set_rtc_time   = apus_set_rtc_time;
+	ppc_md.get_rtc_time   = apus_get_rtc_time;
+	ppc_md.calibrate_decr = apus_calibrate_decr;
+
+	ppc_md.ide_init_hwif  = NULL;
+
+	/* These should not be used for the APUS yet, since it uses
+	   the M68K keyboard now. */
+	ppc_md.kbd_setkeycode    = NULL;
+	ppc_md.kbd_getkeycode    = NULL;
+	ppc_md.kbd_pretranslate  = NULL;
+	ppc_md.kbd_translate     = NULL;
+	ppc_md.kbd_unexpected_up = NULL;
+	ppc_md.kbd_leds          = NULL;
+	ppc_md.kbd_init_hw       = NULL;
 }
--- linux-2.1.131.orig/arch/ppc/kernel/chrp_pci.c	Tue Aug  4 18:06:36 1998
+++ linux-2.1.131/arch/ppc/kernel/chrp_pci.c	Fri Dec 11 18:00:52 1998
@@ -15,6 +15,7 @@
 #include <asm/hydra.h>
 #include <asm/prom.h>
 #include <asm/gg2.h>
+#include <asm/ide.h>
 
 /* LongTrail */
 #define pci_config_addr(bus, dev, offset) \
@@ -216,8 +217,6 @@
 	return 1;
 }
 
-
-extern int chrp_ide_irq;
 
 __initfunc(int w83c553f_init(void))
 {
--- linux-2.1.131.orig/arch/ppc/kernel/chrp_setup.c	Sun Nov 15 12:51:43 1998
+++ linux-2.1.131/arch/ppc/kernel/chrp_setup.c	Sat Dec 12 10:03:14 1998
@@ -40,6 +40,30 @@
 #include <asm/prom.h>
 #include <asm/gg2.h>
 #include <asm/pci-bridge.h>
+#include <asm/dma.h>
+#include <asm/machdep.h>
+
+unsigned long chrp_get_rtc_time(void);
+int chrp_set_rtc_time(unsigned long nowtime);
+void chrp_calibrate_decr(void);
+void chrp_time_init(void);
+
+extern int pckbd_setkeycode(unsigned int scancode, unsigned int keycode);
+extern int pckbd_getkeycode(unsigned int scancode);
+extern int pckbd_pretranslate(unsigned char scancode, char raw_mode);
+extern int pckbd_translate(unsigned char scancode, unsigned char *keycode,
+			   char raw_mode);
+extern char pckbd_unexpected_up(unsigned char keycode);
+extern void pckbd_leds(unsigned char leds);
+extern void pckbd_init_hw(void);
+extern int mackbd_setkeycode(unsigned int scancode, unsigned int keycode);
+extern int mackbd_getkeycode(unsigned int scancode);
+extern int mackbd_pretranslate(unsigned char scancode, char raw_mode);
+extern int mackbd_translate(unsigned char scancode, unsigned char *keycode,
+			   char raw_mode);
+extern char mackbd_unexpected_up(unsigned char keycode);
+extern void mackbd_leds(unsigned char leds);
+extern void mackbd_init_hw(void);
 
 extern void hydra_init(void);
 extern void w83c553f_init(void);
@@ -276,3 +300,146 @@
 EXPORT_SYMBOL(chrp_ide_probe);
 
 #endif
+
+void
+chrp_restart(char *cmd)
+{
+	/* RTAS doesn't seem to work on Longtrail.
+	   For now, do it the same way as the PReP. */
+#if 0
+	extern unsigned int rtas_entry, rtas_data, rtas_size;
+	unsigned long status, value;
+	/*err = call_rtas("system-reboot", 0, 1, NULL);
+	printk("RTAS system-reboot returned %d\n", err);
+	for (;;);*/
+		
+	printk("rtas_entry: %08x rtas_data: %08x rtas_size: %08x\n",
+	       rtas_entry,rtas_data,rtas_size);
+#else
+	unsigned long i = 10000;
+
+
+	_disable_interrupts();
+
+/* Fixme - This doesn't work anymore with the new save and restore flags */
+#if 0
+	/* set exception prefix high - to the prom */
+	save_flags( flags );
+	restore_flags( flags|MSR_IP );
+#endif
+		
+	/* make sure bit 0 (reset) is a 0 */
+	outb( inb(0x92) & ~1L , 0x92 );
+	/* signal a reset to system control port A - soft reset */
+	outb( inb(0x92) | 1 , 0x92 );
+		
+	while ( i != 0 ) i++;
+	panic("restart failed\n");
+#endif
+}
+
+void
+chrp_power_off(void)
+{
+	/* RTAS doesn't seem to work on Longtrail.
+	   For now, do it the same way as the PReP. */
+#if 0
+	int err;
+	err = call_rtas("power-off", 2, 1, NULL, 0, 0);
+	printk("RTAS system-reboot returned %d\n", err);
+	for (;;);
+#else
+	chrp_restart(NULL);
+#endif
+}
+
+void
+chrp_halt(void)
+{
+	chrp_restart(NULL);
+}
+
+int
+chrp_irq_cannonicalize(int irq)
+{
+	if (irq == 2)
+	{
+		return 9;
+	}
+	else
+	{
+		return irq;
+	}
+}
+
+__initfunc(void
+chrp_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	  unsigned long r6, unsigned long r7))
+{
+	setup_pci_ptrs();
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* take care of initrd if we have one */
+	if ( r3 )
+	{
+		initrd_start = r3 + KERNELBASE;
+		initrd_end = r3 + r4 + KERNELBASE;
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+	/* isa_io_base set by setup_pci_ptrs() */
+	isa_mem_base = CHRP_ISA_MEM_BASE;
+	pci_dram_offset = CHRP_PCI_DRAM_OFFSET;
+	ISA_DMA_THRESHOLD = ~0L;
+	DMA_MODE_READ = 0x44;
+	DMA_MODE_WRITE = 0x48;
+
+	ppc_md.setup_arch     = chrp_setup_arch;
+	ppc_md.setup_residual = NULL;
+	ppc_md.get_cpuinfo    = chrp_get_cpuinfo;
+	ppc_md.irq_cannonicalize = chrp_irq_cannonicalize;
+
+	ppc_md.restart        = chrp_restart;
+	ppc_md.power_off      = chrp_power_off;
+	ppc_md.halt           = chrp_halt;
+
+	ppc_md.time_init      = chrp_time_init;
+	ppc_md.set_rtc_time   = chrp_set_rtc_time;
+	ppc_md.get_rtc_time   = chrp_get_rtc_time;
+	ppc_md.calibrate_decr = chrp_calibrate_decr;
+
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+	ppc_md.ide_init_hwif  = chrp_ide_init_hwif_ports;
+#else
+	ppc_md.ide_init_hwif  = NULL;
+#endif		
+
+#ifdef CONFIG_MAC_KEYBOAD
+	if ( adb_hardware == ADB_NONE )
+	{
+		ppc_md.kbd_setkeycode    = pckbd_setkeycode;
+		ppc_md.kbd_getkeycode    = pckbd_getkeycode;
+		ppc_md.kbd_pretranslate  = pckbd_pretranslate;
+		ppc_md.kbd_translate     = pckbd_translate;
+		ppc_md.kbd_unexpected_up = pckbd_unexpected_up;
+		ppc_md.kbd_leds          = pckbd_leds;
+		ppc_md.kbd_init_hw       = pckbd_init_hw;
+	}
+	else
+	{
+		ppc_md.kbd_setkeycode    = mackbd_setkeycode;
+		ppc_md.kbd_getkeycode    = mackbd_getkeycode;
+		ppc_md.kbd_pretranslate  = mackbd_pretranslate;
+		ppc_md.kbd_translate     = mackbd_translate;
+		ppc_md.kbd_unexpected_up = mackbd_unexpected_up;
+		ppc_md.kbd_leds          = mackbd_leds;
+		ppc_md.kbd_init_hw       = mackbd_init_hw;
+	}
+#else
+	ppc_md.kbd_setkeycode    = pckbd_setkeycode;
+	ppc_md.kbd_getkeycode    = pckbd_getkeycode;
+	ppc_md.kbd_pretranslate  = pckbd_pretranslate;
+	ppc_md.kbd_translate     = pckbd_translate;
+	ppc_md.kbd_unexpected_up = pckbd_unexpected_up;
+	ppc_md.kbd_leds          = pckbd_leds;
+	ppc_md.kbd_init_hw       = pckbd_init_hw;
+#endif
+}
--- linux-2.1.131.orig/arch/ppc/kernel/idle.c	Sun Nov 15 12:51:43 1998
+++ linux-2.1.131/arch/ppc/kernel/idle.c	Fri Dec 11 10:29:50 1998
@@ -302,7 +302,11 @@
 			hid0 &= ~(HID0_NAP | HID0_SLEEP | HID0_DOZE);
 			hid0 |= (powersave_nap? HID0_NAP: HID0_DOZE) | HID0_DPM;
 			asm("mtspr 1008,%0" : : "r" (hid0));
+/* Fixme - This is a problem, because restore_flags doesn't work like
+   it used to. */
+#if 0
 			msr |= MSR_POW;
+#endif
 		}
 		restore_flags(msr);
 	default:
--- linux-2.1.131.orig/arch/ppc/kernel/irq.c	Sun Nov 15 12:51:43 1998
+++ linux-2.1.131/arch/ppc/kernel/irq.c	Thu Dec 10 22:18:44 1998
@@ -614,6 +614,31 @@
 	return retval;
 }
 
+int
+tb(long vals[],
+   int  max_size)
+{
+   register unsigned long *orig_sp __asm__ ("r1");
+   register unsigned long lr __asm__ ("r3");
+   unsigned long *sp;
+   int i;
+
+   asm volatile ("mflr 3");
+   vals[0] = lr;
+   sp = (unsigned long *) *orig_sp;
+   sp = (unsigned long *) *sp;
+   for (i=1; i<max_size; i++) {
+      if (sp == 0) {
+         break;
+      }
+
+      vals[i] = *(sp+1);
+      sp = (unsigned long *) *sp;
+   }
+
+   return i;
+}
+
 void __global_restore_flags(unsigned long flags)
 {
 	switch (flags) {
@@ -630,8 +655,20 @@
 		__sti();
 		break;
 	default:
+	{
+		unsigned long trace[5];
+                int           count;
+                int           i;
+
 		printk("global_restore_flags: %08lx (%08lx)\n",
 			flags, (&flags)[-1]);
+                count = tb(trace, 5);
+                printk("tb:");
+                for(i=0; i<count; i++) {
+			printk(" %8.8lx", trace[i]);
+		}
+		printk("\n");
+	}
 	}
 }
 
--- linux-2.1.131.orig/arch/ppc/kernel/mbx_setup.c	Fri May  8 02:18:14 1998
+++ linux-2.1.131/arch/ppc/kernel/mbx_setup.c	Fri Dec 11 17:50:01 1998
@@ -37,6 +37,22 @@
 #include <asm/pgtable.h>
 #include <asm/ide.h>
 #include <asm/mbx.h>
+#include <asm/machdep.h>
+
+#include "time.h"
+
+static int mbx_set_rtc_time(unsigned long time);
+unsigned long mbx_get_rtc_time(void);
+void mbx_calibrate_decr(void);
+
+extern int mackbd_setkeycode(unsigned int scancode, unsigned int keycode);
+extern int mackbd_getkeycode(unsigned int scancode);
+extern int mackbd_pretranslate(unsigned char scancode, char raw_mode);
+extern int mackbd_translate(unsigned char scancode, unsigned char *keycode,
+			   char raw_mode);
+extern char mackbd_unexpected_up(unsigned char keycode);
+extern void mackbd_leds(unsigned char leds);
+extern void mackbd_init_hw(void);
 
 extern unsigned long loops_per_sec;
 
@@ -132,4 +148,183 @@
 	xmon(0);
 #endif
 	machine_restart(NULL);
+}
+
+/* The decrementer counts at the system (internal) clock frequency divided by
+ * sixteen, or external oscillator divided by four.  Currently, we only
+ * support the MBX, which is system clock divided by sixteen.
+ */
+__initfunc(void mbx_calibrate_decr(void))
+{
+	bd_t	*binfo = (bd_t *)&res;
+	int freq, fp, divisor;
+
+	if ((((immap_t *)MBX_IMAP_ADDR)->im_clkrst.car_sccr & 0x02000000) == 0)
+		printk("WARNING: Wrong decrementer source clock.\n");
+
+	/* The manual says the frequency is in Hz, but it is really
+	 * as MHz.  The value 'fp' is the number of decrementer ticks
+	 * per second.
+	 */
+	fp = (binfo->bi_intfreq * 1000000) / 16;
+	freq = fp*60;	/* try to make freq/1e6 an integer */
+        divisor = 60;
+        printk("time_init: decrementer frequency = %d/%d\n", freq, divisor);
+        decrementer_count = freq / HZ / divisor;
+        count_period_num = divisor;
+        count_period_den = freq / 1000000;
+}
+
+/* A place holder for time base interrupts, if they are ever enabled.
+*/
+void timebase_interrupt(int irq, void * dev, struct pt_regs * regs)
+{
+	printk("timebase_interrupt()\n");
+}
+
+/* The RTC on the MPC8xx is an internal register.
+ * We want to protect this during power down, so we need to unlock,
+ * modify, and re-lock.
+ */
+static int
+mbx_set_rtc_time(unsigned long time)
+{
+	((immap_t *)MBX_IMAP_ADDR)->im_sitk.sitk_rtck = KAPWR_KEY;
+	((immap_t *)MBX_IMAP_ADDR)->im_sit.sit_rtc = time;
+	((immap_t *)MBX_IMAP_ADDR)->im_sitk.sitk_rtck = ~KAPWR_KEY;
+	return(0);
+}
+
+initfunc(unsigned long
+mbx_get_rtc_time(void)
+{
+	/* First, unlock all of the registers we are going to modify.
+	 * To protect them from corruption during power down, registers
+	 * that are maintained by keep alive power are "locked".  To
+	 * modify these registers we have to write the key value to
+	 * the key location associated with the register.
+	 */
+	((immap_t *)MBX_IMAP_ADDR)->im_sitk.sitk_tbscrk = KAPWR_KEY;
+	((immap_t *)MBX_IMAP_ADDR)->im_sitk.sitk_rtcsck = KAPWR_KEY;
+
+
+	/* Disable the RTC one second and alarm interrupts.
+	*/
+	((immap_t *)MBX_IMAP_ADDR)->im_sit.sit_rtcsc &=
+						~(RTCSC_SIE | RTCSC_ALE);
+
+	/* Enabling the decrementer also enables the timebase interrupts
+	 * (or from the other point of view, to get decrementer interrupts
+	 * we have to enable the timebase).  The decrementer interrupt
+	 * is wired into the vector table, nothing to do here for that.
+	 */
+	((immap_t *)MBX_IMAP_ADDR)->im_sit.sit_tbscr =
+				((mk_int_int_mask(DEC_INTERRUPT) << 8) |
+					 (TBSCR_TBF | TBSCR_TBE));
+	if (request_irq(DEC_INTERRUPT, timebase_interrupt, 0, "tbint", NULL) != 0)
+		panic("Could not allocate timer IRQ!");
+
+	/* Get time from the RTC.
+	*/
+	return ((immap_t *)MBX_IMAP_ADDR)->im_sit.sit_rtc;
+}
+
+void
+mbx_restart(char *cmd)
+{
+	extern void MBX_gorom(void);
+
+	MBX_gorom();
+}
+
+void
+mbx_power_off(void)
+{
+   mbx_restart(NULL);
+}
+
+void
+mbx_halt(void)
+{
+   mbx_restart(NULL)
+}
+
+__initfunc(int
+mbx_setup_residual(char *buffer))
+{
+        int     len = 0;
+	bd_t	*bp;
+	extern	RESIDUAL *res;
+			
+	bp = (bd_t *)res;
+			
+	len += sprintf(len+buffer,"clock\t\t: %dMHz\n"
+		       "bus clock\t: %dMHz\n",
+		       bp->bi_intfreq /*/ 1000000*/,
+		       bp->bi_busfreq /*/ 1000000*/);
+
+	return len;
+}
+
+__initfunc(void
+mbx_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	 unsigned long r6, unsigned long r7))
+{
+
+	if ( r3 )
+		memcpy( (void *)&res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+	
+#ifdef CONFIG_PCI
+	setup_pci_ptrs();
+#endif
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* take care of initrd if we have one */
+	if ( r4 )
+	{
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+	/* take care of cmd line */
+	if ( r6 )
+	{
+		
+		*(char *)(r7+KERNELBASE) = 0;
+		strcpy(cmd_line, (char *)(r6+KERNELBASE));
+	}
+
+	ppc_md.setup_arch     = mbx_setup_arch;
+	ppc_md.setup_residual = mbx_setup_residual;
+	ppc_md.get_cpuinfo    = NULL;
+	ppc_md.irq_cannonicalize = NULL;
+
+	ppc_md.restart        = mbx_restart;
+	ppc_md.power_off      = mbx_power_off;
+	ppc_md.halt           = mbx_halt;
+
+	ppc_md.time_init      = NULL;
+	ppc_md.set_rtc_time   = mbx_set_rtc_time;
+	ppc_md.get_rtc_time   = mbx_get_rtc_time;
+	ppc_md.calibrate_decr = mbx_calibrate_decr;
+
+	ppc_md.ide_init_hwif  = NULL;
+
+#ifdef CONFIG_MAC_KEYBOARD
+	ppc_md.kbd_setkeycode    = mackbd_setkeycode;
+	ppc_md.kbd_getkeycode    = mackbd_getkeycode;
+	ppc_md.kbd_pretranslate  = mackbd_pretranslate;
+	ppc_md.kbd_translate     = mackbd_translate;
+	ppc_md.kbd_unexpected_up = mackbd_unexpected_up;
+	ppc_md.kbd_leds          = mackbd_leds;
+	ppc_md.kbd_init_hw       = mackbd_init_hw;
+#else
+	ppc_md.kbd_setkeycode    = pckbd_setkeycode;
+	ppc_md.kbd_getkeycode    = pckbd_getkeycode;
+	ppc_md.kbd_pretranslate  = pckbd_pretranslate;
+	ppc_md.kbd_translate     = pckbd_translate;
+	ppc_md.kbd_unexpected_up = pckbd_unexpected_up;
+	ppc_md.kbd_leds          = pckbd_leds;
+	ppc_md.kbd_init_hw       = pckbd_init_hw;
+#endif
 }
--- linux-2.1.131.orig/arch/ppc/kernel/pmac_setup.c	Sun Nov 15 12:51:43 1998
+++ linux-2.1.131/arch/ppc/kernel/pmac_setup.c	Sat Dec 12 09:57:33 1998
@@ -52,8 +52,33 @@
 #include <asm/ohare.h>
 #include <asm/mediabay.h>
 #include <asm/feature.h>
+#include <asm/ide.h>
+#include <asm/machdep.h>
+
 #include "time.h"
 
+unsigned long pmac_get_rtc_time(void);
+int pmac_set_rtc_time(unsigned long nowtime);
+void pmac_read_rtc_time(void);
+void pmac_calibrate_decr(void);
+
+extern int mackbd_setkeycode(unsigned int scancode, unsigned int keycode);
+extern int mackbd_getkeycode(unsigned int scancode);
+extern int mackbd_pretranslate(unsigned char scancode, char raw_mode);
+extern int mackbd_translate(unsigned char scancode, unsigned char *keycode,
+			   char raw_mode);
+extern char mackbd_unexpected_up(unsigned char keycode);
+extern void mackbd_leds(unsigned char leds);
+extern void mackbd_init_hw(void);
+extern int pckbd_setkeycode(unsigned int scancode, unsigned int keycode);
+extern int pckbd_getkeycode(unsigned int scancode);
+extern int pckbd_pretranslate(unsigned char scancode, char raw_mode);
+extern int pckbd_translate(unsigned char scancode, unsigned char *keycode,
+			   char raw_mode);
+extern char pckbd_unexpected_up(unsigned char keycode);
+extern void pckbd_leds(unsigned char leds);
+extern void pckbd_init_hw(void);
+
 unsigned char drive_info;
 
 extern char saved_command_line[];
@@ -371,3 +396,102 @@
 	}
 }
 
+void
+pmac_restart(char *cmd)
+{
+	struct adb_request req;
+
+	switch (adb_hardware) {
+	case ADB_VIACUDA:
+		cuda_request(&req, NULL, 2, CUDA_PACKET,
+			     CUDA_RESET_SYSTEM);
+		for (;;)
+			cuda_poll();
+		break;
+
+	case ADB_VIAPMU:
+		pmu_restart();
+		break;
+	default:
+	}
+}
+
+void
+pmac_power_off(void)
+{
+	struct adb_request req;
+
+	switch (adb_hardware) {
+	case ADB_VIACUDA:
+		cuda_request(&req, NULL, 2, CUDA_PACKET,
+			     CUDA_POWERDOWN);
+		for (;;)
+			cuda_poll();
+		break;
+
+	case ADB_VIAPMU:
+		pmu_shutdown();
+		break;
+	default:
+	}
+}
+
+void
+pmac_halt(void)
+{
+   pmac_power_off();
+}
+
+__initfunc(void
+pmac_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	  unsigned long r6, unsigned long r7))
+{
+	setup_pci_ptrs();
+
+	/* isa_io_base gets set in pmac_find_bridges */
+	isa_mem_base = PMAC_ISA_MEM_BASE;
+	pci_dram_offset = PMAC_PCI_DRAM_OFFSET;
+	ISA_DMA_THRESHOLD = ~0L;
+	DMA_MODE_READ = 1;
+	DMA_MODE_WRITE = 2;
+
+	ppc_md.setup_arch     = pmac_setup_arch;
+	ppc_md.setup_residual = NULL;
+	ppc_md.get_cpuinfo    = pmac_get_cpuinfo;
+	ppc_md.irq_cannonicalize = NULL;
+
+	ppc_md.restart        = pmac_restart;
+	ppc_md.power_off      = pmac_power_off;
+	ppc_md.halt           = pmac_halt;
+
+	ppc_md.time_init      = NULL;
+	ppc_md.set_rtc_time   = pmac_set_rtc_time;
+	ppc_md.get_rtc_time   = pmac_get_rtc_time;
+	ppc_md.calibrate_decr = pmac_calibrate_decr;
+
+#if defined(CONFIG_BLK_DEV_IDE_PMAC)
+	ppc_md.ide_init_hwif  = pmac_ide_init_hwif_ports;
+#else
+	ppc_md.ide_init_hwif  = NULL;
+#endif		
+
+	/* This is kind of a hack if the MAC keyboard is not defined,
+	   but what to do? - Corey */
+#ifdef CONFIG_MAC_KEYBOARD
+	ppc_md.kbd_setkeycode    = mackbd_setkeycode;
+	ppc_md.kbd_getkeycode    = mackbd_getkeycode;
+	ppc_md.kbd_pretranslate  = mackbd_pretranslate;
+	ppc_md.kbd_translate     = mackbd_translate;
+	ppc_md.kbd_unexpected_up = mackbd_unexpected_up;
+	ppc_md.kbd_leds          = mackbd_leds;
+	ppc_md.kbd_init_hw       = mackbd_init_hw;
+#else
+	ppc_md.kbd_setkeycode    = pckbd_setkeycode;
+	ppc_md.kbd_getkeycode    = pckbd_getkeycode;
+	ppc_md.kbd_pretranslate  = pckbd_pretranslate;
+	ppc_md.kbd_translate     = pckbd_translate;
+	ppc_md.kbd_unexpected_up = pckbd_unexpected_up;
+	ppc_md.kbd_leds          = pckbd_leds;
+	ppc_md.kbd_init_hw       = pckbd_init_hw;
+#endif
+}
--- linux-2.1.131.orig/arch/ppc/kernel/ppc_defs.h	Wed Sep 30 12:14:17 1998
+++ linux-2.1.131/arch/ppc/kernel/ppc_defs.h	Fri Dec 11 17:08:41 1998
@@ -7,9 +7,9 @@
 #define	COUNTER	24
 #define	PROCESSOR	36
 #define	SIGPENDING	8
-#define	TSS	568
-#define	MM	872
-#define	TASK_STRUCT_SIZE	912
+#define	TSS	816
+#define	MM	1120
+#define	TASK_STRUCT_SIZE	1176
 #define	KSP	0
 #define	PG_TABLES	4
 #define	PGD	8
--- linux-2.1.131.orig/arch/ppc/kernel/ppc_ksyms.c	Wed Nov 25 14:21:40 1998
+++ linux-2.1.131/arch/ppc/kernel/ppc_ksyms.c	Sat Dec 12 09:58:29 1998
@@ -157,9 +157,7 @@
 EXPORT_SYMBOL(flush_icache_range);
 EXPORT_SYMBOL(xchg_u32);
 
-#ifndef CONFIG_MACH_SPECIFIC
 EXPORT_SYMBOL(_machine);
-#endif
 
 EXPORT_SYMBOL(adb_request);
 EXPORT_SYMBOL(adb_autopoll);
--- linux-2.1.131.orig/arch/ppc/kernel/prep_setup.c	Sun Nov 15 12:51:44 1998
+++ linux-2.1.131/arch/ppc/kernel/prep_setup.c	Sat Dec 12 10:04:20 1998
@@ -30,6 +30,7 @@
 #include <linux/blk.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
+#include <linux/timex.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -38,12 +39,33 @@
 #include <asm/pgtable.h>
 #include <asm/ide.h>
 #include <asm/cache.h>
+#include <asm/nvram.h>
+#include <asm/dma.h>
+#include <asm/machdep.h>
+
+#include "time.h"
 
 #if defined(CONFIG_SOUND) || defined(CONFIG_SOUND_MODULE)
 #include <../drivers/sound/sound_config.h>
 #include <../drivers/sound/dev_table.h>
 #endif
 
+extern unsigned long prep_get_rtc_time(void);
+extern int prep_set_rtc_time(unsigned long nowtime);
+
+extern int pckbd_setkeycode(unsigned int scancode, unsigned int keycode);
+extern int pckbd_getkeycode(unsigned int scancode);
+extern int pckbd_pretranslate(unsigned char scancode, char raw_mode);
+extern int pckbd_translate(unsigned char scancode, unsigned char *keycode,
+			   char raw_mode);
+extern char pckbd_unexpected_up(unsigned char keycode);
+extern void pckbd_leds(unsigned char leds);
+extern void pckbd_init_hw(void);
+
+
+int _prep_type;
+
+
 /* for the mac fs */
 kdev_t boot_dev;
 /* used in nasty hack for sound - see prep_setup_arch() -- Cort */
@@ -55,6 +77,7 @@
 extern int probingmem;
 extern unsigned long loops_per_sec;
 extern unsigned char aux_device_present;
+extern char saved_command_line[256];
 
 #ifdef CONFIG_BLK_DEV_RAM
 extern int rd_doload;		/* 1 = load ramdisk, 0 = don't load */
@@ -175,27 +198,48 @@
 	outb(reg, SIO_CONFIG_RD);
 	outb(reg, SIO_CONFIG_RD);	/* Have to write twice to change! */
 
+	/* Read in the NVRAM data. */
+	init_prep_nvram();
+
 	/* we should determine this according to what we find! -- Cort */
-	switch ( _prep_type )
-	{
-	case _PREP_IBM:
-		ROOT_DEV = to_kdev_t(0x0301); /* hda1 */
-		break;
-	case _PREP_Motorola:
-		ROOT_DEV = to_kdev_t(0x0801); /* sda1 */
-		break;
+	if (initrd_start) {
+		ROOT_DEV = to_kdev_t(0x0100); /* ram0 */
+	} else {
+		switch ( _prep_type )
+		{
+		case _PREP_IBM:
+			ROOT_DEV = to_kdev_t(0x0301); /* hda1 */
+			break;
+		case _PREP_Motorola:
+			ROOT_DEV = to_kdev_t(0x0801); /* sda1 */
+			break;
+		}
 	}
 
 	/* Enable L2.  Assume we don't need to flush -- Cort*/
 	*(unsigned char *)(0x8000081c) = *(unsigned char *)(0x8000081c)|3;
 	
+	/* It there were no supplied boot arguments, the maybe there
+           are bootargs in the NVRAM */
+	if (cmd_line[0] == '\0') {
+	        char *bootargs;
+		
+		bootargs = prep_nvram_get_var("bootargs");
+		if (bootargs != NULL) {
+			strcpy(cmd_line, bootargs);
+
+			/* Do this again. */
+			strcpy(saved_command_line, cmd_line);
+		}
+	}
+
 	/* make the serial port the console */
 	/* strcat(cmd_line,"console=ttyS0,9600n8"); */
 	/* use the normal console but send output to the serial port, too */
-	/*strcat(cmd_line,"console=tty0 console=ttyS0,9600n8");*/
-        sprintf(cmd_line,"%s console=tty0 console=ttyS0,9600n8", cmd_line);
-	printk("Boot arguments: %s\n", cmd_line);
-	
+	/* strcat(cmd_line,"console=tty0 console=ttyS0,9600n8");*/
+
+	printk("Boot arguments: '%s'\n", cmd_line);
+
 #ifdef CONFIG_SOUND_CS4232
 	/*
 	 * setup proper values for the cs4232 driver so we don't have
@@ -248,7 +292,9 @@
 #endif
 }
 
-__initfunc(void prep_ide_init_hwif_ports (ide_ioreg_t *p, ide_ioreg_t base, int *irq))
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+__initfunc(void
+prep_ide_init_hwif_ports (ide_ioreg_t *p, ide_ioreg_t base, int *irq))
 {
 	ide_ioreg_t port = base;
 	int i = 8;
@@ -258,6 +304,228 @@
 	*p++ = base + 0x206;
 	if (irq != NULL)
 		*irq = 0;
+}
+#endif
+
+/*
+ * Uses the on-board timer to calibrate the on-chip decrementer register
+ * for prep systems.  On the pmac the OF tells us what the frequency is
+ * but on prep we have to figure it out.
+ * -- Cort
+ */
+int calibrate_done = 0;
+volatile int *done_ptr = &calibrate_done;
+
+__initfunc(void prep_calibrate_decr_handler(int irq, void *dev, struct pt_regs * regs))
+{
+	unsigned long freq, divisor;
+	static unsigned long t1 = 0, t2 = 0;
+	
+	if ( !t1 )
+		t1 = get_dec();
+	else if (!t2)
+	{
+		t2 = get_dec();
+		t2 = t1-t2;  /* decr's in 1/HZ */
+		t2 = t2*HZ;  /* # decrs in 1s - thus in Hz */
+		freq = t2 * 60;	/* try to make freq/1e6 an integer */
+		divisor = 60;
+		printk("time_init: decrementer frequency = %lu/%lu (%luMHz)\n",
+		       freq, divisor,t2>>20);
+		decrementer_count = freq / HZ / divisor;
+		count_period_num = divisor;
+		count_period_den = freq / 1000000;
+		*done_ptr = 1;
+	}
+}
+
+__initfunc(void prep_calibrate_decr(void))
+{
+	unsigned long flags;
+
+	/* the Powerstack II's have trouble with the timer so
+	 * we use a default value -- Cort
+	 */
+	if ( (_prep_type == _PREP_Motorola) &&
+	     ((inb(0x800) & 0xF0) & 0x40) )
+	{
+		unsigned long freq, divisor;
+		static unsigned long t2 = 0;
+		
+		t2 = 999950000/60;
+		freq = t2 * 60;	/* try to make freq/1e6 an integer */
+		divisor = 60;
+		printk("time_init: decrementer frequency = %lu/%lu (%luMHz)\n",
+		       freq, divisor,t2>>20);
+		decrementer_count = freq / HZ / divisor;
+		count_period_num = divisor;
+		count_period_den = freq / 1000000;
+		return;
+	}
+	
+	
+	save_flags(flags);
+
+#define TIMER0_COUNT 0x40
+#define TIMER_CONTROL 0x43
+	/* set timer to periodic mode */
+	outb_p(0x34,TIMER_CONTROL);/* binary, mode 2, LSB/MSB, ch 0 */
+	/* set the clock to ~100 Hz */
+	outb_p(LATCH & 0xff , TIMER0_COUNT);	/* LSB */
+	outb(LATCH >> 8 , TIMER0_COUNT);	/* MSB */
+	
+	if (request_irq(0, prep_calibrate_decr_handler, 0, "timer", NULL) != 0)
+		panic("Could not allocate timer IRQ!");
+	__sti();
+	while ( ! *done_ptr ) /* nothing */; /* wait for calibrate */
+        restore_flags(flags);
+	free_irq( 0, NULL);
+}
+
+void
+prep_restart(char *cmd)
+{
+	unsigned long i = 10000;
+
+
+	_disable_interrupts();
+
+/* Fixme - This doesn't work anymore with the new save and restore flags */
+#if 0
+	/* set exception prefix high - to the prom */
+	save_flags( flags );
+	restore_flags( flags|MSR_IP );
+#endif
+		
+	/* make sure bit 0 (reset) is a 0 */
+	outb( inb(0x92) & ~1L , 0x92 );
+	/* signal a reset to system control port A - soft reset */
+	outb( inb(0x92) | 1 , 0x92 );
+		
+	while ( i != 0 ) i++;
+	panic("restart failed\n");
+}
+
+void
+prep_power_off(void)
+{
+	prep_restart(NULL);
+}
+
+void
+prep_halt(void)
+{
+	prep_restart(NULL);
+}
+
+__initfunc(int
+prep_setup_residual(char *buffer))
+{
+        int len = 0;
+
+
+	/* PREP's without residual data for some reason will give
+	   incorrect values here */
+	len += sprintf(len+buffer, "clock\t\t: ");
+	if ( res->ResidualLength )
+		len += sprintf(len+buffer, "%ldMHz\n",
+		       (res->VitalProductData.ProcessorHz > 1024) ?
+		       res->VitalProductData.ProcessorHz>>20 :
+		       res->VitalProductData.ProcessorHz);
+	else
+		len += sprintf(len+buffer, "???\n");
+
+	return len;
+}
+
+int
+prep_irq_cannonicalize(int irq)
+{
+	if (irq == 2)
+	{
+		return 9;
+	}
+	else
+	{
+		return irq;
+	}
+}
+
+__initfunc(void
+prep_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	  unsigned long r6, unsigned long r7))
+{
+	/* make a copy of residual data */
+	if ( r3 )
+	{
+		memcpy((void *)res,(void *)(r3+KERNELBASE),
+		       sizeof(RESIDUAL));
+	}
+
+	setup_pci_ptrs();
+	isa_io_base = PREP_ISA_IO_BASE;
+	isa_mem_base = PREP_ISA_MEM_BASE;
+	pci_dram_offset = PREP_PCI_DRAM_OFFSET;
+	ISA_DMA_THRESHOLD = 0x00ffffff;
+	DMA_MODE_READ = 0x44;
+	DMA_MODE_WRITE = 0x48;
+
+	/* figure out what kind of prep workstation we are */
+	if ( res->ResidualLength != 0 )
+	{
+		if ( !strncmp(res->VitalProductData.PrintableModel,"IBM",3) )
+			_prep_type = _PREP_IBM;
+		else
+			_prep_type = _PREP_Motorola;
+	}
+	else /* assume motorola if no residual (netboot?) */
+	{
+		_prep_type = _PREP_Motorola;
+	}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* take care of initrd if we have one */
+	if ( r4 )
+	{
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+	/* take care of cmd line */
+	if ( r6  && (((char *) r6) != '\0'))
+	{
+		*(char *)(r7+KERNELBASE) = 0;
+		strcpy(cmd_line, (char *)(r6+KERNELBASE));
+	}
+
+	ppc_md.setup_arch     = prep_setup_arch;
+	ppc_md.setup_residual = prep_setup_residual;
+	ppc_md.get_cpuinfo    = prep_get_cpuinfo;
+	ppc_md.irq_cannonicalize = prep_irq_cannonicalize;
+
+	ppc_md.restart        = prep_restart;
+	ppc_md.power_off      = prep_power_off;
+	ppc_md.halt           = prep_halt;
+
+	ppc_md.time_init      = NULL;
+	ppc_md.set_rtc_time   = prep_set_rtc_time;
+	ppc_md.get_rtc_time   = prep_get_rtc_time;
+	ppc_md.calibrate_decr = prep_calibrate_decr;
+
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+	ppc_md.ide_init_hwif  = prep_ide_init_hwif_ports;
+#else
+	ppc_md.ide_init_hwif  = NULL;
+#endif		
+
+	ppc_md.kbd_setkeycode    = pckbd_setkeycode;
+	ppc_md.kbd_getkeycode    = pckbd_getkeycode;
+	ppc_md.kbd_pretranslate  = pckbd_pretranslate;
+	ppc_md.kbd_translate     = pckbd_translate;
+	ppc_md.kbd_unexpected_up = pckbd_unexpected_up;
+	ppc_md.kbd_leds          = pckbd_leds;
+	ppc_md.kbd_init_hw       = pckbd_init_hw;
 }
 
 #ifdef CONFIG_SOUND_MODULE
--- linux-2.1.131.orig/arch/ppc/kernel/setup.c	Sun Nov 15 12:51:44 1998
+++ linux-2.1.131/arch/ppc/kernel/setup.c	Sat Dec 12 10:02:34 1998
@@ -12,53 +12,63 @@
 #include <linux/delay.h>
 #include <linux/blk.h>
 
-#include <asm/adb.h>
-#include <asm/cuda.h>
-#include <asm/pmu.h>
 #include <asm/residual.h>
 #include <asm/io.h>
-#include <asm/ide.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
 #include <asm/pgtable.h>
 #include <asm/bootinfo.h>
 #include <asm/setup.h>
-#include <asm/amigappc.h>
 #include <asm/smp.h>
-#ifdef CONFIG_MBX
-#include <asm/mbx.h>
-#endif
 #include <asm/bootx.h>
+#include <asm/machdep.h>
+
+extern void pmac_init(unsigned long r3,
+		      unsigned long r4,
+		      unsigned long r5,
+		      unsigned long r6,
+		      unsigned long r7);
+extern void chrp_init(unsigned long r3,
+		      unsigned long r4,
+		      unsigned long r5,
+		      unsigned long r6,
+		      unsigned long r7);
+extern void prep_init(unsigned long r3,
+		      unsigned long r4,
+		      unsigned long r5,
+		      unsigned long r6,
+		      unsigned long r7);
+extern void mbx_init(unsigned long r3,
+		     unsigned long r4,
+		     unsigned long r5,
+		     unsigned long r6,
+		     unsigned long r7);
+extern void apus_init(unsigned long r3,
+		      unsigned long r4,
+		      unsigned long r5,
+		      unsigned long r6,
+		      unsigned long r7);
 
-/* APUS defs */
-extern unsigned long m68k_machtype;
-extern int parse_bootinfo(const struct bi_record *);
-extern char _end[];
-#ifdef CONFIG_APUS
-struct mem_info ramdisk;
-unsigned long isa_io_base;
-unsigned long isa_mem_base;
-unsigned long pci_dram_offset;
-#endif
-/* END APUS defs */
 
 extern char cmd_line[512];
 char saved_command_line[256];
 unsigned char aux_device_present;
 
-#if !defined(CONFIG_MACH_SPECIFIC)
 unsigned long ISA_DMA_THRESHOLD;
 unsigned long DMA_MODE_READ, DMA_MODE_WRITE;
+
+/* These are hacks until we can get machdep.h fully done. */
 int _machine;
 /* if we have openfirmware */
-unsigned long have_of;
-#endif /* ! CONFIG_MACH_SPECIFIC */
+int have_of = 0;
+int is_prep = 0;
+int is_chrp = 0;
 
 /* copy of the residual data */
 unsigned char __res[sizeof(RESIDUAL)] __prepdata = {0,};
 RESIDUAL *res = (RESIDUAL *)&__res;
 
-int _prep_type;
+struct machdep_calls ppc_md;
 
 extern boot_infos_t *boot_infos;
 
@@ -110,159 +120,33 @@
 };
 #endif /* CONFIG_MBX */
 
-/* cmd is ignored for now... */
 void machine_restart(char *cmd)
 {
-#ifndef CONFIG_MBX
-	struct adb_request req;
-	unsigned long flags;
-	unsigned long i = 10000;
-#if 0
-	int err;
-#endif	
-
-	switch(_machine)
-	{
-	case _MACH_Pmac:
-		switch (adb_hardware) {
-		case ADB_VIACUDA:
-			cuda_request(&req, NULL, 2, CUDA_PACKET,
-				     CUDA_RESET_SYSTEM);
-			for (;;)
-				cuda_poll();
-			break;
-		case ADB_VIAPMU:
-			pmu_restart();
-			break;
-		default:
-		}
-		break;
-
-	case _MACH_chrp:
-#if 0		/* RTAS doesn't seem to work on Longtrail.
-		   For now, do it the same way as the PReP. */
-	        /*err = call_rtas("system-reboot", 0, 1, NULL);
-		printk("RTAS system-reboot returned %d\n", err);
-		for (;;);*/
-		
-		{
-			extern unsigned int rtas_entry, rtas_data, rtas_size;
-			unsigned long status, value;
-			printk("rtas_entry: %08x rtas_data: %08x rtas_size: %08x\n",
-			       rtas_entry,rtas_data,rtas_size);
-	}
-#endif
-	case _MACH_prep:
-		_disable_interrupts();
-		
-		/* set exception prefix high - to the prom */
-		save_flags( flags );
-		restore_flags( flags|MSR_IP );
-		
-		/* make sure bit 0 (reset) is a 0 */
-		outb( inb(0x92) & ~1L , 0x92 );
-		/* signal a reset to system control port A - soft reset */
-		outb( inb(0x92) | 1 , 0x92 );
-		
-		while ( i != 0 ) i++;
-		panic("restart failed\n");
-		break;
-	case _MACH_apus:
-		cli();
-
-		APUS_WRITE(APUS_REG_LOCK, 
-			   REGLOCK_BLACKMAGICK1|REGLOCK_BLACKMAGICK2);
-		APUS_WRITE(APUS_REG_LOCK, 
-			   REGLOCK_BLACKMAGICK1|REGLOCK_BLACKMAGICK3);
-		APUS_WRITE(APUS_REG_LOCK, 
-			   REGLOCK_BLACKMAGICK2|REGLOCK_BLACKMAGICK3);
-		APUS_WRITE(APUS_REG_SHADOW, REGSHADOW_SELFRESET);
-		APUS_WRITE(APUS_REG_RESET, REGRESET_AMIGARESET);
-		for(;;);
-		break;
-	}
-#else /* CONFIG_MBX */
-	extern void MBX_gorom(void);
-	MBX_gorom();
-#endif /* CONFIG_MBX */
+	ppc_md.restart(cmd);
 }
 
 void machine_power_off(void)
 {
-#ifndef CONFIG_MBX	
-	struct adb_request req;
-#if 0	
-	int err;
-#endif	
-
-	switch (_machine) {
-	case _MACH_Pmac:
-		switch (adb_hardware) {
-		case ADB_VIACUDA:
-			cuda_request(&req, NULL, 2, CUDA_PACKET,
-				     CUDA_POWERDOWN);
-			for (;;)
-				cuda_poll();
-			break;
-		case ADB_VIAPMU:
-			pmu_shutdown();
-			break;
-		default:
-		}
-		break;
-
-	case _MACH_chrp:
-#if 0		/* RTAS doesn't seem to work on Longtrail.
-		   For now, do it the same way as the PReP. */
-		err = call_rtas("power-off", 2, 1, NULL, 0, 0);
-		printk("RTAS system-reboot returned %d\n", err);
-		for (;;);
-#endif
-
-	case _MACH_prep:
-		machine_restart(NULL);
-	case _MACH_apus:
-		for (;;);
-	}
-	for (;;);
-#else /* CONFIG_MBX */
-	machine_restart(NULL);
-#endif /* CONFIG_MBX */
+	ppc_md.power_off();
 }
 
 void machine_halt(void)
 {
-	if ( _machine == _MACH_Pmac )
-	{
-		machine_power_off();
-	}
-	else /* prep, chrp or apus */
-		machine_restart(NULL);
-
+	ppc_md.halt();
 }
 
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 void ide_init_hwif_ports (ide_ioreg_t *p, ide_ioreg_t base, int *irq)
 {
-#if !defined(CONFIG_MBX) && !defined(CONFIG_APUS)
-	switch (_machine) {
-#if defined(CONFIG_BLK_DEV_IDE_PMAC)
-	case _MACH_Pmac:
-	  	pmac_ide_init_hwif_ports(p,base,irq);
-		break;
-#endif		
-	case _MACH_chrp:
-		chrp_ide_init_hwif_ports(p,base,irq);
-		break;
-	case _MACH_prep:
-		prep_ide_init_hwif_ports(p,base,irq);
-		break;
+	if (ppc_md.ide_init_hwif != NULL)
+	{
+		ppc_md.ide_init_hwif(p, base, irq);
 	}
-#endif
 }
 EXPORT_SYMBOL(ide_init_hwif_ports);
 #endif
 
+
 unsigned long cpu_temp(void)
 {
 	unsigned char thres = 0;
@@ -294,10 +178,6 @@
 
 int get_cpuinfo(char *buffer)
 {
-	extern int pmac_get_cpuinfo(char *);
-	extern int chrp_get_cpuinfo(char *);	
-	extern int prep_get_cpuinfo(char *);
-	extern int apus_get_cpuinfo(char *);
 	unsigned long len = 0;
 	unsigned long bogosum = 0;
 	unsigned long i;
@@ -361,7 +241,6 @@
 			break;
 		}
 		
-#ifndef CONFIG_MBX
 		/*
 		 * Assume here that all clock rates are the same in a
 		 * smp system.  -- Cort
@@ -378,33 +257,11 @@
 			len += sprintf(len+buffer, "clock\t\t: %dMHz\n",
 				       *fp / 1000000);
 		}
-		
-		/* PREP's without residual data for some reason will give
-		   incorrect values here */
-		if ( is_prep )
-		{
-			len += sprintf(len+buffer, "clock\t\t: ");
-			if ( res->ResidualLength )
-				len += sprintf(len+buffer, "%ldMHz\n",
-				       (res->VitalProductData.ProcessorHz > 1024) ?
-				       res->VitalProductData.ProcessorHz>>20 :
-				       res->VitalProductData.ProcessorHz);
-			else
-				len += sprintf(len+buffer, "???\n");
-		}
-#else /* CONFIG_MBX */
+
+		if (ppc_md.setup_residual != NULL)
 		{
-			bd_t	*bp;
-			extern	RESIDUAL *res;
-			
-			bp = (bd_t *)res;
-			
-			len += sprintf(len+buffer,"clock\t\t: %dMHz\n"
-				      "bus clock\t: %dMHz\n",
-				      bp->bi_intfreq /*/ 1000000*/,
-				      bp->bi_busfreq /*/ 1000000*/);
+		   len += ppc_md.setup_residual(buffer + len);
 		}
-#endif /* CONFIG_MBX */		
 		
 		len += sprintf(len+buffer, "revision\t: %ld.%ld\n",
 			       (GET_PVR & 0xff00) >> 8, GET_PVR & 0xff);
@@ -439,24 +296,11 @@
 			            ((quicklists.zeropage_calls)?quicklists.zeropage_calls:1));
 	}
 
-#ifndef CONFIG_MBX
-	switch (_machine)
+	if (ppc_md.get_cpuinfo != NULL)
 	{
-	case _MACH_Pmac:
-		len += pmac_get_cpuinfo(buffer+len);
-		break;
-	case _MACH_prep:
-		len += prep_get_cpuinfo(buffer+len);
-		break;
-	case _MACH_chrp:
-		len += chrp_get_cpuinfo(buffer+len);
-		break;
-	case _MACH_apus:
-		/* Not much point in printing m68k info when it is not
-                   used. */
-		break;
+		len += ppc_md.get_cpuinfo(buffer+len);
 	}
-#endif /* ndef CONFIG_MBX */	
+
 	return len;
 }
 
@@ -468,7 +312,6 @@
 identify_machine(unsigned long r3, unsigned long r4, unsigned long r5,
 		 unsigned long r6, unsigned long r7))
 {
-	extern void setup_pci_ptrs(void);
 	
 #ifdef __SMP__
 	if ( first_cpu_booted ) return 0;
@@ -480,13 +323,12 @@
 	if ( r3 == 0x61707573 )
 	{
 		_machine = _MACH_apus;
-		have_of = 0;
 		r3 = 0;
 	}
 	/* prep boot loader tells us if we're prep or not */
 	else if ( *(unsigned long *)(KERNELBASE) == (0xdeadc0de) ) {
 		_machine = _MACH_prep;
-		have_of = 0;
+		is_prep = 1;
 	} else {
 		char *model;
 
@@ -494,19 +336,49 @@
 		/* ask the OF info if we're a chrp or pmac */
 		model = get_property(find_path_device("/"), "device_type", NULL);
 		if ( model && !strncmp("chrp",model,4) )
+		{
 			_machine = _MACH_chrp;
+			is_chrp = 1;
+		}
 		else
 		{
 			model = get_property(find_path_device("/"),
 					     "model", NULL);
 			if ( model && !strncmp(model, "IBM", 3))
+			{
 				_machine = _MACH_chrp;
+				is_chrp = 1;
+			}
 			else
+			{
 				_machine = _MACH_Pmac;
+				is_prep = 1;
+			}
 		}
 
 	}
-#endif /* CONFIG_MACH_SPECIFIC */		
+#else /* CONFIG_MACH_SPECIFIC */
+
+#ifdef CONFIG_PREP
+	_machine = _MACH_prep;
+	is_prep  = 1;
+#elif defined(CONFIG_CHRP)
+	_machine = _MACH_chrp;
+	is_chrp  = 1;
+	have_of  = 1;
+#elif defined(CONFIG_PMAC)
+	_machine = _MACH_Pmac;
+	have_of  = 1;
+#elif defined(CONFIG_MBX)
+	_machine = _MACH_mbx;
+#elif defined(CONFIG_FADS)
+	_machine = _MACH_fads;
+#elif defined(CONFIG_APUS)
+	_machine = _MACH_apus;
+#else
+#error "Machine not defined correctly"
+#endif /* CONFIG_APUS */
+#endif /* CONFIG_MACH_SPECIFIC */
 
 	if ( have_of )
 	{
@@ -567,95 +439,17 @@
 	switch (_machine)
 	{
 	case _MACH_Pmac:
-		setup_pci_ptrs();
-		/* isa_io_base gets set in pmac_find_bridges */
-		isa_mem_base = PMAC_ISA_MEM_BASE;
-		pci_dram_offset = PMAC_PCI_DRAM_OFFSET;
-#if !defined(CONFIG_MACH_SPECIFIC)
-		ISA_DMA_THRESHOLD = ~0L;
-		DMA_MODE_READ = 1;
-		DMA_MODE_WRITE = 2;
-#endif /* ! CONFIG_MACH_SPECIFIC */
+		pmac_init(r3, r4, r5, r6, r7);
 		break;
 	case _MACH_prep:
-		/* make a copy of residual data */
-		if ( r3 )
-			memcpy((void *)res,(void *)(r3+KERNELBASE),
-			       sizeof(RESIDUAL));
-		setup_pci_ptrs();
-		isa_io_base = PREP_ISA_IO_BASE;
-		isa_mem_base = PREP_ISA_MEM_BASE;
-		pci_dram_offset = PREP_PCI_DRAM_OFFSET;
-#if !defined(CONFIG_MACH_SPECIFIC)
-		ISA_DMA_THRESHOLD = 0x00ffffff;
-		DMA_MODE_READ = 0x44;
-		DMA_MODE_WRITE = 0x48;
-#endif /* ! CONFIG_MACH_SPECIFIC */
-		/* figure out what kind of prep workstation we are */
-		if ( res->ResidualLength != 0 )
-		{
-			if ( !strncmp(res->VitalProductData.PrintableModel,"IBM",3) )
-				_prep_type = _PREP_IBM;
-			else
-				_prep_type = _PREP_Motorola;
-		}
-		else /* assume motorola if no residual (netboot?) */
-			_prep_type = _PREP_Motorola;
-#ifdef CONFIG_BLK_DEV_INITRD
-		/* take care of initrd if we have one */
-		if ( r4 )
-		{
-			initrd_start = r4 + KERNELBASE;
-			initrd_end = r5 + KERNELBASE;
-		}
-#endif /* CONFIG_BLK_DEV_INITRD */
-		/* take care of cmd line */
-		if ( r6 )
-		{
-			*(char *)(r7+KERNELBASE) = 0;
-			strcpy(cmd_line, (char *)(r6+KERNELBASE));
-		}
+		prep_init(r3, r4, r5, r6, r7);
 		break;
 	case _MACH_chrp:
-		setup_pci_ptrs();
-#ifdef CONFIG_BLK_DEV_INITRD
-		/* take care of initrd if we have one */
-		if ( r3 )
-		{
-			initrd_start = r3 + KERNELBASE;
-			initrd_end = r3 + r4 + KERNELBASE;
-		}
-#endif /* CONFIG_BLK_DEV_INITRD */
-		/* isa_io_base set by setup_pci_ptrs() */
-		isa_mem_base = CHRP_ISA_MEM_BASE;
-		pci_dram_offset = CHRP_PCI_DRAM_OFFSET;
-#if !defined(CONFIG_MACH_SPECIFIC)
-		ISA_DMA_THRESHOLD = ~0L;
-		DMA_MODE_READ = 0x44;
-		DMA_MODE_WRITE = 0x48;
-#endif /* ! CONFIG_MACH_SPECIFIC */
+		chrp_init(r3, r4, r5, r6, r7);
 		break;
 #ifdef CONFIG_APUS		
 	case _MACH_apus:
-		/* Parse bootinfo. The bootinfo is located right after
-                   the kernel bss */
-		parse_bootinfo((const struct bi_record *)&_end);
-#ifdef CONFIG_BLK_DEV_INITRD
-		/* Take care of initrd if we have one. Use data from
-		   bootinfo to avoid the need to initialize PPC
-		   registers when kernel is booted via a PPC reset. */
-		if ( ramdisk.addr ) {
-			initrd_start = (unsigned long) __va(ramdisk.addr);
-			initrd_end = (unsigned long) 
-				__va(ramdisk.size + ramdisk.addr);
-		}
-		/* Make sure code below is not executed. */
-		r4 = 0;
-		r6 = 0;
-#endif /* CONFIG_BLK_DEV_INITRD */
-#if !defined(CONFIG_MACH_SPECIFIC)
-		ISA_DMA_THRESHOLD = 0x00ffffff;
-#endif /* ! CONFIG_MACH_SPECIFIC */
+		apus_init(r3, r4, r5, r6, r7);
 		break;
 #endif
 	default:
@@ -663,29 +457,7 @@
 	}
 
 #else /* CONFIG_MBX */
-
-	if ( r3 )
-		memcpy( (void *)&res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
-	
-#ifdef CONFIG_PCI
-	setup_pci_ptrs();
-#endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	/* take care of initrd if we have one */
-	if ( r4 )
-	{
-		initrd_start = r4 + KERNELBASE;
-		initrd_end = r5 + KERNELBASE;
-	}
-#endif /* CONFIG_BLK_DEV_INITRD */
-	/* take care of cmd line */
-	if ( r6 )
-	{
-		
-		*(char *)(r7+KERNELBASE) = 0;
-		strcpy(cmd_line, (char *)(r6+KERNELBASE));
-	}
+	mbx_init(r3, r4, r5, r6, r7);
 #endif /* CONFIG_MBX */
 
 	/* Check for nobats option (used in mapin_ram). */
@@ -699,11 +471,6 @@
 __initfunc(void setup_arch(char **cmdline_p,
 	unsigned long * memory_start_p, unsigned long * memory_end_p))
 {
-	extern void pmac_setup_arch(unsigned long *, unsigned long *);
-	extern void chrp_setup_arch(unsigned long *, unsigned long *);
-	extern void prep_setup_arch(unsigned long *, unsigned long *);
-	extern void mbx_setup_arch(unsigned long *, unsigned long *);
-	extern void apus_setup_arch(unsigned long *, unsigned long *);
 	extern int panic_timeout;
 	extern char _etext[], _edata[];
 	extern char *klimit;
@@ -732,27 +499,5 @@
 	*memory_start_p = find_available_memory();
 	*memory_end_p = (unsigned long) end_of_DRAM;
 
-#ifdef CONFIG_MBX
-	mbx_setup_arch(memory_start_p,memory_end_p);
-#else /* CONFIG_MBX */	
-	switch (_machine) {
-	case _MACH_Pmac:
-		pmac_setup_arch(memory_start_p, memory_end_p);
-		break;
-	case _MACH_prep:
-		prep_setup_arch(memory_start_p, memory_end_p);
-		break;
-	case _MACH_chrp:
-		chrp_setup_arch(memory_start_p, memory_end_p);
-		break;
-#ifdef CONFIG_APUS		
-	case _MACH_apus:
-		m68k_machtype = MACH_AMIGA;
-		apus_setup_arch(memory_start_p,memory_end_p);
-		break;
-#endif
-	default:
-		printk("Unknown machine %d in setup_arch()\n", _machine);
-	}
-#endif /* CONFIG_MBX */	
+	ppc_md.setup_arch(memory_start_p, memory_end_p);
 }
--- linux-2.1.131.orig/arch/ppc/kernel/time.c	Sun Nov 15 12:51:45 1998
+++ linux-2.1.131/arch/ppc/kernel/time.c	Fri Dec 11 17:27:30 1998
@@ -38,18 +38,13 @@
 #include <asm/processor.h>
 #include <asm/nvram.h>
 #include <asm/cache.h>
-#ifdef CONFIG_MBX
-#include <asm/mbx.h>
-#endif
 #ifdef CONFIG_8xx
 #include <asm/8xx_immap.h>
 #endif
+#include <asm/machdep.h>
 
 #include "time.h"
 
-/* this is set to the appropriate pmac/prep/chrp func in init_IRQ() */
-int (*set_rtc_time)(unsigned long);
-
 void smp_local_timer_interrupt(struct pt_regs *);
 
 /* keep track of when we need to update the rtc */
@@ -96,7 +91,7 @@
 			 */
 			if ( xtime.tv_sec > last_rtc_update + 660 )
 			{
-				if (set_rtc_time(xtime.tv_sec) == 0)
+				if (ppc_md.set_rtc_time(xtime.tv_sec) == 0)
 					last_rtc_update = xtime.tv_sec;
 				else
 					last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
@@ -118,28 +113,6 @@
 	lock_dcache(dcache_locked);
 }
 
-#ifdef CONFIG_MBX
-/* A place holder for time base interrupts, if they are ever enabled.
-*/
-void timebase_interrupt(int irq, void * dev, struct pt_regs * regs)
-{
-	printk("timebase_interrupt()\n");
-}
-
-/* The RTC on the MPC8xx is an internal register.
- * We want to protect this during power down, so we need to unlock,
- * modify, and re-lock.
- */
-static int
-mbx_set_rtc_time(unsigned long time)
-{
-	((immap_t *)MBX_IMAP_ADDR)->im_sitk.sitk_rtck = KAPWR_KEY;
-	((immap_t *)MBX_IMAP_ADDR)->im_sit.sit_rtc = time;
-	((immap_t *)MBX_IMAP_ADDR)->im_sitk.sitk_rtck = ~KAPWR_KEY;
-	return(0);
-}
-#endif /* CONFIG_MBX */
-
 /*
  * This version of gettimeofday has microsecond resolution.
  */
@@ -178,7 +151,6 @@
 
 __initfunc(void time_init(void))
 {
-#ifndef CONFIG_MBX
 	if ((_get_PVR() >> 16) == 1) {
 		/* 601 processor: dec counts down by 128 every 128ns */
 		decrementer_count = DECREMENTER_COUNT_601;
@@ -186,182 +158,23 @@
 		count_period_den = COUNT_PERIOD_DEN_601;
 	}
 
-	switch (_machine) {
-	case _MACH_Pmac:
-		xtime.tv_sec = pmac_get_rtc_time();
-		if ( (_get_PVR() >> 16) != 1 && (!smp_processor_id()) )
-			pmac_calibrate_decr();
-		if ( !smp_processor_id() )
-			set_rtc_time = pmac_set_rtc_time;
-		break;
-	case _MACH_chrp:
-		chrp_time_init();
-		xtime.tv_sec = chrp_get_rtc_time();
-		if ((_get_PVR() >> 16) != 1)
-			chrp_calibrate_decr();
-		set_rtc_time = chrp_set_rtc_time;
-		break;
-	case _MACH_prep:
-		xtime.tv_sec = prep_get_rtc_time();
-		prep_calibrate_decr();
-		set_rtc_time = prep_set_rtc_time;
-		break;
-#ifdef CONFIG_APUS		
-	case _MACH_apus:
+	if (ppc_md.time_init != NULL)
 	{
-		xtime.tv_sec = apus_get_rtc_time();
-		apus_calibrate_decr();
-		set_rtc_time = apus_set_rtc_time;
- 		break;
+		ppc_md.time_init();
 	}
-#endif	
+	xtime.tv_sec = ppc_md.get_rtc_time();
+	if ( (_get_PVR() >> 16) != 1 && (!smp_processor_id()) )
+	{
+		ppc_md.calibrate_decr();
 	}
 	xtime.tv_usec = 0;
-#else /* CONFIG_MBX */
-	mbx_calibrate_decr();
-	set_rtc_time = mbx_set_rtc_time;
-
-	/* First, unlock all of the registers we are going to modify.
-	 * To protect them from corruption during power down, registers
-	 * that are maintained by keep alive power are "locked".  To
-	 * modify these registers we have to write the key value to
-	 * the key location associated with the register.
-	 */
-	((immap_t *)MBX_IMAP_ADDR)->im_sitk.sitk_tbscrk = KAPWR_KEY;
-	((immap_t *)MBX_IMAP_ADDR)->im_sitk.sitk_rtcsck = KAPWR_KEY;
 
-
-	/* Disable the RTC one second and alarm interrupts.
-	*/
-	((immap_t *)MBX_IMAP_ADDR)->im_sit.sit_rtcsc &=
-						~(RTCSC_SIE | RTCSC_ALE);
-
-	/* Enabling the decrementer also enables the timebase interrupts
-	 * (or from the other point of view, to get decrementer interrupts
-	 * we have to enable the timebase).  The decrementer interrupt
-	 * is wired into the vector table, nothing to do here for that.
-	 */
-	((immap_t *)MBX_IMAP_ADDR)->im_sit.sit_tbscr =
-				((mk_int_int_mask(DEC_INTERRUPT) << 8) |
-					 (TBSCR_TBF | TBSCR_TBE));
-	if (request_irq(DEC_INTERRUPT, timebase_interrupt, 0, "tbint", NULL) != 0)
-		panic("Could not allocate timer IRQ!");
-
-	/* Get time from the RTC.
-	*/
-	xtime.tv_sec = ((immap_t *)MBX_IMAP_ADDR)->im_sit.sit_rtc;
-	xtime.tv_usec = 0;
-
-#endif /* CONFIG_MBX */
 	set_dec(decrementer_count);
 	/* mark the rtc/on-chip timer as in sync
 	 * so we don't update right away
 	 */
 	last_rtc_update = xtime.tv_sec;
 }
-
-#ifndef CONFIG_MBX
-/*
- * Uses the on-board timer to calibrate the on-chip decrementer register
- * for prep systems.  On the pmac the OF tells us what the frequency is
- * but on prep we have to figure it out.
- * -- Cort
- */
-int calibrate_done = 0;
-volatile int *done_ptr = &calibrate_done;
-__initfunc(void prep_calibrate_decr(void))
-{
-	unsigned long flags;
-
-	/* the Powerstack II's have trouble with the timer so
-	 * we use a default value -- Cort
-	 */
-	if ( (_prep_type == _PREP_Motorola) &&
-	     ((inb(0x800) & 0xF0) & 0x40) )
-	{
-		unsigned long freq, divisor;
-		static unsigned long t2 = 0;
-		
-		t2 = 998700000/60;
-		freq = t2 * 60;	/* try to make freq/1e6 an integer */
-		divisor = 60;
-		printk("time_init: decrementer frequency = %lu/%lu (%luMHz)\n",
-		       freq, divisor,t2>>20);
-		decrementer_count = freq / HZ / divisor;
-		count_period_num = divisor;
-		count_period_den = freq / 1000000;
-		return;
-	}
-	
-	
-	save_flags(flags);
-
-#define TIMER0_COUNT 0x40
-#define TIMER_CONTROL 0x43
-	/* set timer to periodic mode */
-	outb_p(0x34,TIMER_CONTROL);/* binary, mode 2, LSB/MSB, ch 0 */
-	/* set the clock to ~100 Hz */
-	outb_p(LATCH & 0xff , TIMER0_COUNT);	/* LSB */
-	outb(LATCH >> 8 , TIMER0_COUNT);	/* MSB */
-	
-	if (request_irq(0, prep_calibrate_decr_handler, 0, "timer", NULL) != 0)
-		panic("Could not allocate timer IRQ!");
-	__sti();
-	while ( ! *done_ptr ) /* nothing */; /* wait for calibrate */
-        restore_flags(flags);
-	free_irq( 0, NULL);
-}
-
-__initfunc(void prep_calibrate_decr_handler(int irq, void *dev, struct pt_regs * regs))
-{
-	unsigned long freq, divisor;
-	static unsigned long t1 = 0, t2 = 0;
-	
-	if ( !t1 )
-		t1 = get_dec();
-	else if (!t2)
-	{
-		t2 = get_dec();
-		t2 = t1-t2;  /* decr's in 1/HZ */
-		t2 = t2*HZ;  /* # decrs in 1s - thus in Hz */
-		freq = t2 * 60;	/* try to make freq/1e6 an integer */
-		divisor = 60;
-		printk("time_init: decrementer frequency = %lu/%lu (%luMHz)\n",
-		       freq, divisor,t2>>20);
-		decrementer_count = freq / HZ / divisor;
-		count_period_num = divisor;
-		count_period_den = freq / 1000000;
-		*done_ptr = 1;
-	}
-}
-
-#else /* CONFIG_MBX */
-
-/* The decrementer counts at the system (internal) clock frequency divided by
- * sixteen, or external oscillator divided by four.  Currently, we only
- * support the MBX, which is system clock divided by sixteen.
- */
-__initfunc(void mbx_calibrate_decr(void))
-{
-	bd_t	*binfo = (bd_t *)&res;
-	int freq, fp, divisor;
-
-	if ((((immap_t *)MBX_IMAP_ADDR)->im_clkrst.car_sccr & 0x02000000) == 0)
-		printk("WARNING: Wrong decrementer source clock.\n");
-
-	/* The manual says the frequency is in Hz, but it is really
-	 * as MHz.  The value 'fp' is the number of decrementer ticks
-	 * per second.
-	 */
-	fp = (binfo->bi_intfreq * 1000000) / 16;
-	freq = fp*60;	/* try to make freq/1e6 an integer */
-        divisor = 60;
-        printk("time_init: decrementer frequency = %d/%d\n", freq, divisor);
-        decrementer_count = freq / HZ / divisor;
-        count_period_num = divisor;
-        count_period_den = freq / 1000000;
-}
-#endif /* CONFIG_MBX */
 
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
--- linux-2.1.131.orig/arch/ppc/kernel/time.h	Tue Apr 14 19:33:58 1998
+++ linux-2.1.131/arch/ppc/kernel/time.h	Fri Dec 11 17:14:40 1998
@@ -9,10 +9,6 @@
 #include <linux/mc146818rtc.h>
 
 /* time.c */
-void prep_calibrate_decr_handler(int, void *,struct pt_regs *);
-void prep_calibrate_decr(void);
-void pmac_calibrate_decr(void);
-extern void apus_calibrate_decr(void);
 extern unsigned decrementer_count;
 extern unsigned count_period_num;
 extern unsigned count_period_den;
@@ -21,20 +17,7 @@
 extern void to_tm(int tim, struct rtc_time * tm);
 extern unsigned long last_rtc_update;
 
-/* pmac/prep/chrp_time.c */
-unsigned long prep_get_rtc_time(void);
-unsigned long pmac_get_rtc_time(void);
-unsigned long chrp_get_rtc_time(void);
-unsigned long apus_get_rtc_time(void);
-int prep_set_rtc_time(unsigned long nowtime);
-int pmac_set_rtc_time(unsigned long nowtime);
-int chrp_set_rtc_time(unsigned long nowtime);
-int apus_set_rtc_time(unsigned long nowtime);
-void pmac_read_rtc_time(void);
-void chrp_calibrate_decr(void);
-void chrp_time_init(void);
 int via_calibrate_decr(void);
-void mbx_calibrate_decr(void);
 
 /* Accessor functions for the decrementer register. */
 static __inline__ unsigned int get_dec(void)
--- linux-2.1.131.orig/arch/ppc/kernel/prep_nvram.c	Sat Dec 12 10:10:28 1998
+++ linux-2.1.131/arch/ppc/kernel/prep_nvram.c	Thu Dec 10 15:01:05 1998
@@ -0,0 +1,109 @@
+/*
+ *  linux/arch/ppc/kernel/prep_nvram.c
+ *
+ *  Copyright (C) 1998  Corey Minyard
+ *
+ */
+#include <linux/init.h>
+
+#include <asm/segment.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/nvram.h>
+
+static NVRAM_MAP nvram;
+
+__initfunc(static unsigned char read_val(int addr))
+{
+	outb(addr>>8, NVRAM_AS1);
+	outb(addr, NVRAM_AS0);
+	return inb(NVRAM_DATA);
+}
+  
+__initfunc(void init_prep_nvram(void))
+{
+	unsigned char *nvp;
+	int  i;
+
+	nvp = (char *) &nvram;
+	for (i=0; i<sizeof(nvram); i++) {
+		*nvp = read_val(i);
+		nvp++;
+	}
+}
+
+__prep
+char *prep_nvram_get_var(const char *name)
+{
+	char *cp;
+	int  namelen;
+
+	namelen = strlen(name);
+	cp = prep_nvram_first_var();
+	while (cp != NULL) {
+		if ((strncmp(name, cp, namelen) == 0)
+		    && (cp[namelen] == '='))
+		{
+			return cp+namelen+1;
+		}
+		cp = prep_nvram_next_var(cp);
+	}
+
+	return NULL;
+}
+
+__prep
+char *prep_nvram_first_var(void)
+{
+        if (nvram.Header.GELength == 0) {
+		return NULL;
+	} else {
+		return (((char *) &nvram)
+			+ ((unsigned int) nvram.Header.GEAddress));
+	}
+}
+
+__prep
+char *prep_nvram_next_var(char *name)
+{
+	char *cp;
+
+
+	cp = name;
+	while (((cp - ((char *) nvram.GEArea)) < nvram.Header.GELength)
+	       && (*cp != '\0'))
+	{
+		cp++;
+	}
+
+	/* Skip over any null characters. */
+	while (((cp - ((char *) nvram.GEArea)) < nvram.Header.GELength)
+	       && (*cp == '\0'))
+	{
+		cp++;
+	}
+
+	if ((cp - ((char *) nvram.GEArea)) < nvram.Header.GELength) {
+		return cp;
+	} else {
+		return NULL;
+	}
+}
+
+
+void prep_dump_nvram(void)
+{
+	int  i;
+
+	init_prep_nvram();
+
+	printk("NVRAM data, gevstart=%x, length=%d", nvram.Header.GEAddress,
+	       nvram.Header.GELength);
+	for (i=0; i<sizeof(nvram); i++) {
+		if ((i % 16) == 0) {
+			printk("\n  %4.4x :", i);
+		}
+		printk(" %2.2x", read_val(i));
+	}
+	printk("\n");
+}

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
