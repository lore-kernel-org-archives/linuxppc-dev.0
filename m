Date: Wed, 26 May 1999 16:47:25 -0700 (MST)
From: Matt Porter <mporter@phx.mcd.mot.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.9 patch for Motorola support.
Message-ID: <Pine.LNX.3.96.990526163555.23472S-100000@fwrsl-11.phx.mcd.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Below is a cumulative patch versus official 2.2.9 to support Motorola
boards.  Fixes OpenPIC irq handling, kbd controllerless board support, and
initrd relocation.

--
Matt Porter
Motorola Computer Group
mporter@mcg.mot.com

----snip------

Index: linux/arch/ppc/boot/misc.c
diff -u linux/arch/ppc/boot/misc.c:1.1.1.1 linux/arch/ppc/boot/misc.c:1.1.1.1.2.4
--- linux/arch/ppc/boot/misc.c:1.1.1.1	Mon May 17 14:27:33 1999
+++ linux/arch/ppc/boot/misc.c	Wed May 26 15:26:33 1999
@@ -363,7 +363,7 @@
 			if (board_type == 0xe0) {	
 				base_mod = inb(0x803);
 				/* if a MVME2300/2400 or a Sitka then no keyboard */
-				if((base_mod == 0x9) || (base_mod == 0xF9) ||
+				if((base_mod == 0xFA) || (base_mod == 0xF9) ||
 				   (base_mod == 0xE1)) {
 					keyb_present = 0;	/* no keyboard */
 				}
@@ -472,7 +472,6 @@
 	{
 		puts("initrd at:     "); puthex(initrd_start);
 		puts(" "); puthex(initrd_end); puts("\n");
-#ifdef OMIT
 		avail_ram = (char *)PAGE_ALIGN(
 			(unsigned long)zimage_size+(unsigned long)zimage_start);
 		memcpy ((void *)avail_ram, (void *)initrd_start, INITRD_SIZE );
@@ -480,7 +479,6 @@
 		initrd_end = initrd_start + INITRD_SIZE;
 		puts("relocated to:  "); puthex(initrd_start);
 		puts(" "); puthex(initrd_end); puts("\n");
-#endif
 	}
 
 	avail_ram = (char *)0x00400000;
Index: linux/arch/ppc/kernel/prep_pci.c
diff -u linux/arch/ppc/kernel/prep_pci.c:1.1.1.1 linux/arch/ppc/kernel/prep_pci.c:1.1.1.1.2.2
--- linux/arch/ppc/kernel/prep_pci.c:1.1.1.1	Mon May 17 14:27:33 1999
+++ linux/arch/ppc/kernel/prep_pci.c	Tue May 25 14:57:13 1999
@@ -38,6 +38,8 @@
 /* Used for Motorola to store system config register */
 static unsigned long	*ProcInfo;
 
+extern void chrp_do_IRQ(struct pt_regs *,int , int);
+
 /* Tables for known hardware */   
 
 /* Motorola PowerStackII - Utah */
@@ -680,7 +682,7 @@
 #define MOT_RAVEN_PRESENT	0x1
 #define MOT_HAWK_PRESENT	0x2
 
-int prep_keybd_present = 1;
+extern int kbd_present;
 int MotMPIC = 0;
 
 __initfunc(int raven_init(void))
@@ -731,6 +733,8 @@
 	OpenPIC_InitSenses = mvme2600_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof(mvme2600_openpic_initsenses);
 
+	ppc_md.do_IRQ = chrp_do_IRQ;
+
 	/* If raven is present on Motorola store the system config register
 	 * for later use.
 	 */
@@ -742,7 +746,7 @@
 	base_mod = inb(MOTOROLA_BASETYPE_REG);
 	if ((MotMPIC == MOT_HAWK_PRESENT) || (base_mod == 0xF9) ||
 	    (base_mod == 0xFA) || (base_mod == 0xE1))
-		prep_keybd_present = 0;
+		kbd_present = 0;
 
 	return 1;
 }
Index: linux/arch/ppc/kernel/prep_setup.c
diff -u linux/arch/ppc/kernel/prep_setup.c:1.1.1.1 linux/arch/ppc/kernel/prep_setup.c:1.1.1.1.2.1
--- linux/arch/ppc/kernel/prep_setup.c:1.1.1.1	Mon May 17 14:27:33 1999
+++ linux/arch/ppc/kernel/prep_setup.c	Mon May 17 14:39:48 1999
@@ -246,7 +246,7 @@
 	case _PREP_Motorola:
 		/* Enable L2.  Assume we don't need to flush -- Cort*/
 		*(unsigned char *)(0x8000081c) |= 3;
-		ROOT_DEV = to_kdev_t(0x0801); /* sda1 */
+		ROOT_DEV = to_kdev_t(0x0802); /* sda2 */
 		break;
 	case _PREP_Radstone:
 		ROOT_DEV = to_kdev_t(0x0801); /* sda1 */
Index: linux/arch/ppc/kernel/syscalls.c
diff -u linux/arch/ppc/kernel/syscalls.c:1.1.1.1 linux/arch/ppc/kernel/syscalls.c:1.1.1.1.2.1
--- linux/arch/ppc/kernel/syscalls.c:1.1.1.1	Mon May 17 14:27:33 1999
+++ linux/arch/ppc/kernel/syscalls.c	Mon May 17 14:40:29 1999
@@ -33,6 +33,7 @@
 #include <linux/sys.h>
 #include <linux/ipc.h>
 #include <linux/utsname.h>
+#include <linux/file.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
Index: linux/drivers/char/keyboard.c
diff -u linux/drivers/char/keyboard.c:1.1.1.1 linux/drivers/char/keyboard.c:1.1.1.1.2.1
--- linux/drivers/char/keyboard.c:1.1.1.1	Mon May 17 14:26:56 1999
+++ linux/drivers/char/keyboard.c	Tue May 25 14:55:44 1999
@@ -67,6 +67,9 @@
 struct wait_queue * keypress_wait = NULL;
 struct console;
 
+/* Keyboard presence flag */
+int kbd_present = 1;	/* Keyboard present by default */
+
 int keyboard_wait_for_keypress(struct console *co)
 {
 	sleep_on(&keypress_wait);
@@ -908,9 +911,16 @@
 		kbd_table[i] = kbd0;
 
 	ttytab = console_driver.table;
+	
+	if (kbd_present)
+	{
+		kbd_init_hw();
 
-	kbd_init_hw();
-	init_bh(KEYBOARD_BH, kbd_bh);
-	mark_bh(KEYBOARD_BH);
-	return 0;
+		init_bh(KEYBOARD_BH, kbd_bh);
+		mark_bh(KEYBOARD_BH);
+
+		return 0;
+	}
+	else
+		return 1;
 }



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
