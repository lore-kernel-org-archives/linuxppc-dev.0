Date: Wed, 4 Sep 2002 22:00:11 +0200
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Xilinx ps/2 interface
Message-ID: <20020904200011.GK781@mind.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TiqCXmo5T1hvSQQg"
From: p2@mind.be (Peter 'p2' De Schrijver)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Attached you will find a patch implementing support for the Xilinx PS/2
keyboard and mouse ports. It was tested on a Xilinx virtex2pro
implementation.

Comments welcome,

Peter.

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xilinx-keyb.patch"

diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/drivers/char/Makefile linuxppc_2_4_xseg2.new.clean2/drivers/char/Makefile
--- linuxppc_2_4_clean/drivers/char/Makefile	2002-07-20 12:04:11.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/drivers/char/Makefile	2002-09-01 17:10:57.000000000 +0200
@@ -71,6 +71,10 @@
   SERIAL = serial.o
 endif

+ifdef CONFIG_XSEG2
+  KEYBD = xilinx_keyb.o
+endif
+
 ifeq ($(ARCH),arm)
   ifneq ($(CONFIG_PC_KEYMAP),y)
     KEYMAP   =
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/drivers/char/xilinx_keyb.c linuxppc_2_4_xseg2.new.clean2/drivers/char/xilinx_keyb.c
--- linuxppc_2_4_clean/drivers/char/xilinx_keyb.c	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc_2_4_xseg2.new.clean2/drivers/char/xilinx_keyb.c	2002-09-01 16:23:56.000000000 +0200
@@ -0,0 +1,687 @@
+/*
+ * xilinx_keyb.c: A driver for Xilinx PS/2 keyboard and mouse interface core
+ *
+ * Copyright 2002 Mind NV
+ *
+ * http://www.mind.be/
+ *
+ * Author : Peter De Schrijver (p2@mind.be)
+ *
+ * Derived from : drivers/char/q40_keyb.c
+ *
+ * This software may be used and distributed according to the terms of
+ * the GNU General Public License (GPL) version 2, incorporated herein by
+ * reference. Drivers based on or derived from this code fall under the GPL
+ * and must retain the authorship, copyright and this license notice. This
+ * file is not a complete program and may only be used when the entire
+ * operating system is licensed under the GPL.
+ *
+ */
+
+#include <linux/config.h>
+
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/mm.h>
+#include <linux/keyboard.h>
+#include <linux/signal.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/kbd_ll.h>
+#include <linux/kbd_kern.h>
+#include <linux/delay.h>
+#include <linux/sysrq.h>
+#include <linux/random.h>
+#include <linux/poll.h>
+#include <linux/miscdevice.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/pc_keyb.h>
+
+#include <asm/xilinx_keyb.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/irq.h>
+
+
+/* Simple translation table for the SysRq keys */
+
+#define SYSRQ_KEY 0x54
+
+#ifdef CONFIG_MAGIC_SYSRQ
+unsigned char xilinx_kbd_sysrq_xlate[128] =
+	"\000\0331234567890-=\177\t"			/* 0x00 - 0x0f */
+	"qwertyuiop[]\r\000as"				/* 0x10 - 0x1f */
+	"dfghjkl;'`\000\\zxcv"				/* 0x20 - 0x2f */
+	"bnm,./\000*\000 \000\201\202\203\204\205"	/* 0x30 - 0x3f */
+	"\206\207\210\211\212\000\000789-456+1"		/* 0x40 - 0x4f */
+	"230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
+	"\r\000/";					/* 0x60 - 0x6f */
+#endif
+
+/* Q40 uses AT scancodes - no way to change it. so we have to translate ..*/
+/* 0x00 means not a valid entry or no conversion known                    */
+
+unsigned static char xilinx_kbd_cl[256] =
+{/* 0,   1,   2,   3,   4,   5,   6,   7,   8,   9,   a,   b,   c,   d,   e,   f, */
+ 0x00,0x43,0x00,0x3f,0x3d,0x3b,0x3c,0x58,0x00,0x44,0x42,0x40,0x3e,0x0f,0x29,0x00,     /* 0x00 - 0x0f */
+ 0x00,0x38,0x2a,0x00,0x1d,0x10,0x02,0x00,0x00,0x00,0x2c,0x1f,0x1e,0x11,0x03,0x00,     /* 0x10 - 0x1f */
+ 0x00,0x2e,0x2d,0x20,0x12,0x05,0x04,0x00,0x21,0x39,0x2f,0x21,0x14,0x13,0x06,0x00,     /* 0x20 - 0x2f  'f' is at 0x2b, what is 0x28 ???*/
+ 0x00,0x31,0x30,0x23,0x22,0x15,0x07,0x00,0x24,0x00,0x32,0x24,0x16,0x08,0x09,0x00,     /* 0x30 - 0x3f */
+ 0x00,0x33,0x25,0x17,0x18,0x0b,0x0a,0x00,0x00,0x34,0x35,0x26,0x27,0x19,0x0c,0x00,     /* 0x40 - 0x4f */
+ 0x00,0x00,0x28,0x00,0x1a,0x0d,0x00,0x00,0x3a,0x36,0x1c,0x1b,0x00,0x2b,0x00,0x00,     /* 0x50 - 0x5f*/
+ 0x00,0x56,0x00,0x00,0x00,0x00,0x0e,0x00,0x00,0x4f,0x00,0x4b,0x47,0x00,0x00,0x00,     /* 0x60 - 0x6f */
+ 0x52,0x53,0x50,0x4c,0x4d,0x48,0x01,0x45,0x57,0x4e,0x51,0x4a,0x37,0x49,0x46,0x00,     /* 0x70 - 0x7f */
+ 0x00,0x00,0x00,0x41,0x37,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0x80 - 0x8f  0x84/0x37 is SySrq*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0x90 - 0x9f */
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xa0 - 0xaf */
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xb0 - 0xbf */
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xc0 - 0xcf */
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xd0 - 0xdf */
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xe0 - 0xef */
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xf0 - 0xff */
+};
+
+/* another table, AT 0xe0 codes to PC 0xe0 codes,
+   0xff special entry for SysRq - DROPPED right now  */
+static unsigned char xilinx_kbd_ecl[]=
+{/* 0,   1,   2,   3,   4,   5,   6,   7,   8,   9,   a,   b,   c,   d,   e,   f, */
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0x00 - 0x0f*/
+ 0x00,0x38,0x2a,0x00,0x1d,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x5b,     /* 0x10 - 0x1f */
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x5c,     /* 0x20 - 0x2f*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x5d,     /* 0x30 - 0x3f*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x35,0x00,0x00,0x00,0x00,0x00,     /* 0x40 - 0x4f*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x36,0x1c,0x00,0x00,0x00,0x00,0x00,     /* 0x50 - 0x5f*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x4f,0x00,0x4b,0x47,0x00,0x00,0x00,     /* 0x60 - 0x6f*/
+ 0x52,0x53,0x50,0x00,0x4d,0x48,0x00,0x00,0x00,0x00,0x51,0x00,0x00,0x49,0x00,0x00,     /* 0x70 - 0x7f*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0x80 - 0x8f*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0x90 - 0x9f*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xa0 - 0xaf*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xb0 - 0xbf*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xc0 - 0xcf*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xd0 - 0xdf*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,     /* 0xe0 - 0xef*/
+ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00      /* 0xf0 - 0xff*/
+};
+
+
+static spinlock_t kbd_controller_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t mouse_controller_lock = SPIN_LOCK_UNLOCKED;
+
+static unsigned int kbd_base=0xe0040000;
+static unsigned int mouse_base=0xe0041000;
+
+static struct aux_queue *queue; /* Mouse data buffer. */
+static int aux_count;
+static atomic_t mouse_reply_expected;
+
+static int __init psaux_init(void);
+
+/*
+ * Translation of escaped scancodes to keycodes.
+ * This is now user-settable.
+ * The keycodes 1-88,96-111,119 are fairly standard, and
+ * should probably not be changed - changing might confuse X.
+ * X also interprets scancode 0x5d (KEY_Begin).
+ *
+ * For 1-88 keycode equals scancode.
+ */
+
+#define E0_KPENTER 96
+#define E0_RCTRL   97
+#define E0_KPSLASH 98
+#define E0_PRSCR   99
+#define E0_RALT    100
+#define E0_BREAK   101  /* (control-pause) */
+#define E0_HOME    102
+#define E0_UP      103
+#define E0_PGUP    104
+#define E0_LEFT    105
+#define E0_RIGHT   106
+#define E0_END     107
+#define E0_DOWN    108
+#define E0_PGDN    109
+#define E0_INS     110
+#define E0_DEL     111
+
+#define E1_PAUSE   119
+
+/*
+ * The keycodes below are randomly located in 89-95,112-118,120-127.
+ * They could be thrown away (and all occurrences below replaced by 0),
+ * but that would force many users to use the `setkeycodes' utility, where
+ * they needed not before. It does not matter that there are duplicates, as
+ * long as no duplication occurs for any single keyboard.
+ */
+#define SC_LIM 89
+
+#define FOCUS_PF1 85           /* actual code! */
+#define FOCUS_PF2 89
+#define FOCUS_PF3 90
+#define FOCUS_PF4 91
+#define FOCUS_PF5 92
+#define FOCUS_PF6 93
+#define FOCUS_PF7 94
+#define FOCUS_PF8 95
+#define FOCUS_PF9 120
+#define FOCUS_PF10 121
+#define FOCUS_PF11 122
+#define FOCUS_PF12 123
+
+#define JAP_86     124
+/* tfj@olivia.ping.dk:
+ * The four keys are located over the numeric keypad, and are
+ * labelled A1-A4. It's an rc930 keyboard, from
+ * Regnecentralen/RC International, Now ICL.
+ * Scancodes: 59, 5a, 5b, 5c.
+ */
+#define RGN1 124
+#define RGN2 125
+#define RGN3 126
+#define RGN4 127
+
+static unsigned char high_keys[128 - SC_LIM] = {
+  RGN1, RGN2, RGN3, RGN4, 0, 0, 0,                   /* 0x59-0x5f */
+  0, 0, 0, 0, 0, 0, 0, 0,                            /* 0x60-0x67 */
+  0, 0, 0, 0, 0, FOCUS_PF11, 0, FOCUS_PF12,          /* 0x68-0x6f */
+  0, 0, 0, FOCUS_PF2, FOCUS_PF9, 0, 0, FOCUS_PF3,    /* 0x70-0x77 */
+  FOCUS_PF4, FOCUS_PF5, FOCUS_PF6, FOCUS_PF7,        /* 0x78-0x7b */
+  FOCUS_PF8, JAP_86, FOCUS_PF10, 0                   /* 0x7c-0x7f */
+};
+
+/* BTC */
+#define E0_MACRO   112
+/* LK450 */
+#define E0_F13     113
+#define E0_F14     114
+#define E0_HELP    115
+#define E0_DO      116
+#define E0_F17     117
+#define E0_KPMINPLUS 118
+/*
+ * My OmniKey generates e0 4c for  the "OMNI" key and the
+ * right alt key does nada. [kkoller@nyx10.cs.du.edu]
+ */
+#define E0_OK	124
+/*
+ * New microsoft keyboard is rumoured to have
+ * e0 5b (left window button), e0 5c (right window button),
+ * e0 5d (menu button). [or: LBANNER, RBANNER, RMENU]
+ * [or: Windows_L, Windows_R, TaskMan]
+ */
+#define E0_MSLW	125
+#define E0_MSRW	126
+#define E0_MSTM	127
+
+/* this can be changed using setkeys : */
+static unsigned char e0_keys[128] = {
+  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x00-0x07 */
+  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x08-0x0f */
+  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x10-0x17 */
+  0, 0, 0, 0, E0_KPENTER, E0_RCTRL, 0, 0,	      /* 0x18-0x1f */
+  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x20-0x27 */
+  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x28-0x2f */
+  0, 0, 0, 0, 0, E0_KPSLASH, 0, E0_PRSCR,	      /* 0x30-0x37 */
+  E0_RALT, 0, 0, 0, 0, E0_F13, E0_F14, E0_HELP,	      /* 0x38-0x3f */
+  E0_DO, E0_F17, 0, 0, 0, 0, E0_BREAK, E0_HOME,	      /* 0x40-0x47 */
+  E0_UP, E0_PGUP, 0, E0_LEFT, E0_OK, E0_RIGHT, E0_KPMINPLUS, E0_END,/* 0x48-0x4f */
+  E0_DOWN, E0_PGDN, E0_INS, E0_DEL, 0, 0, 0, 0,	      /* 0x50-0x57 */
+  0, 0, 0, E0_MSLW, E0_MSRW, E0_MSTM, 0, 0,	      /* 0x58-0x5f */
+  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x60-0x67 */
+  0, 0, 0, 0, 0, 0, 0, E0_MACRO,		      /* 0x68-0x6f */
+  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x70-0x77 */
+  0, 0, 0, 0, 0, 0, 0, 0			      /* 0x78-0x7f */
+};
+
+
+int xilinx_kbd_setkeycode(unsigned int scancode, unsigned int keycode)
+{
+	if (scancode < SC_LIM || scancode > 255 || keycode > 127)
+	  return -EINVAL;
+	if (scancode < 128)
+	  high_keys[scancode - SC_LIM] = keycode;
+	else
+	  e0_keys[scancode - 128] = keycode;
+	return 0;
+}
+
+int xilinx_kbd_getkeycode(unsigned int scancode)
+{
+	return
+	  (scancode < SC_LIM || scancode > 255) ? -EINVAL :
+	  (scancode < 128) ? high_keys[scancode - SC_LIM] :
+	    e0_keys[scancode - 128];
+}
+
+
+#define disable_keyboard()
+#define enable_keyboard()
+
+
+
+
+int xilinx_kbd_translate(unsigned char scancode, unsigned char *keycode,
+		    char raw_mode)
+{
+	static int prev_scancode;
+
+	/* special prefix scancodes.. */
+	if (scancode == 0xe0 || scancode == 0xe1) {
+		prev_scancode = scancode;
+		return 0;
+	}
+
+	/* 0xFF is sent by a few keyboards, ignore it. 0x00 is error */
+	if (scancode == 0x00 || scancode == 0xff) {
+		prev_scancode = 0;
+		return 0;
+	}
+
+	scancode &= 0x7f;
+
+	if (prev_scancode) {
+	  /*
+	   * usually it will be 0xe0, but a Pause key generates
+	   * e1 1d 45 e1 9d c5 when pressed, and nothing when released
+	   */
+	  if (prev_scancode != 0xe0) {
+	      if (prev_scancode == 0xe1 && scancode == 0x1d) {
+		  prev_scancode = 0x100;
+		  return 0;
+	      } else if (prev_scancode == 0x100 && scancode == 0x45) {
+		  *keycode = E1_PAUSE;
+		  prev_scancode = 0;
+	      } else {
+#ifdef KBD_REPORT_UNKN
+		  if (!raw_mode)
+		    printk(KERN_INFO "keyboard: unknown e1 escape sequence\n");
+#endif
+		  prev_scancode = 0;
+		  return 0;
+	      }
+	  } else {
+	      prev_scancode = 0;
+	      /*
+	       *  The keyboard maintains its own internal caps lock and
+	       *  num lock statuses. In caps lock mode E0 AA precedes make
+	       *  code and E0 2A follows break code. In num lock mode,
+	       *  E0 2A precedes make code and E0 AA follows break code.
+	       *  We do our own book-keeping, so we will just ignore these.
+	       */
+	      /*
+	       *  For my keyboard there is no caps lock mode, but there are
+	       *  both Shift-L and Shift-R modes. The former mode generates
+	       *  E0 2A / E0 AA pairs, the latter E0 B6 / E0 36 pairs.
+	       *  So, we should also ignore the latter. - aeb@cwi.nl
+	       */
+	      if (scancode == 0x2a || scancode == 0x36)
+		return 0;
+
+	      if (e0_keys[scancode])
+		*keycode = e0_keys[scancode];
+	      else {
+#ifdef KBD_REPORT_UNKN
+		  if (!raw_mode)
+		    printk(KERN_INFO "keyboard: unknown scancode e0 %02x\n",
+			   scancode);
+#endif
+		  return 0;
+	      }
+	  }
+	} else if (scancode >= SC_LIM) {
+	    /* This happens with the FOCUS 9000 keyboard
+	       Its keys PF1..PF12 are reported to generate
+	       55 73 77 78 79 7a 7b 7c 74 7e 6d 6f
+	       Moreover, unless repeated, they do not generate
+	       key-down events, so we have to zero up_flag below */
+	    /* Also, Japanese 86/106 keyboards are reported to
+	       generate 0x73 and 0x7d for \ - and \ | respectively. */
+	    /* Also, some Brazilian keyboard is reported to produce
+	       0x73 and 0x7e for \ ? and KP-dot, respectively. */
+
+	  *keycode = high_keys[scancode - SC_LIM];
+
+	  if (!*keycode) {
+	      if (!raw_mode) {
+#ifdef KBD_REPORT_UNKN
+		  printk(KERN_INFO "keyboard: unrecognized scancode (%02x)"
+			 " - ignored\n", scancode);
+#endif
+	      }
+	      return 0;
+	  }
+ 	} else
+	  *keycode = scancode;
+ 	return 1;
+}
+
+char xilinx_kbd_unexpected_up(unsigned char keycode)
+{
+	/* unexpected, but this can happen: maybe this was a key release for a
+	   FOCUS 9000 PF key; if we want to see it, we have to clear up_flag */
+	if (keycode >= SC_LIM || keycode == 85)
+	    return 0;
+	else
+	    return 0200;
+}
+
+static int keyup=0;
+static int qprev=0;
+
+static void mouse_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned char status;
+	static unsigned char prev_mousebyte;
+
+	spin_lock(&kbd_controller_lock);
+
+	status = readb(mouse_base + INTSTAT);
+	while(status & RX_FULL) {
+
+		unsigned char mousebyte;
+
+		mousebyte=readb(mouse_base + RXREG);
+
+		if (atomic_read(&mouse_reply_expected)) {
+			if (mousebyte == AUX_ACK) {
+				atomic_dec(&mouse_reply_expected);
+				return;
+			}
+			atomic_set(&mouse_reply_expected,0);
+		}
+
+		prev_mousebyte=mousebyte;
+		add_mouse_randomness(mousebyte);
+		if(aux_count) {
+			int head = queue->head;
+
+			queue->buf[head] = mousebyte;
+			head = (head + 1) & (AUX_BUF_SIZE-1);
+			if (head != queue->tail) {
+				queue->head = head;
+				kill_fasync(&queue->fasync, SIGIO, POLL_IN);
+				wake_up_interruptible(&queue->proc_list);
+			}
+		}
+
+		writeb(status,mouse_base+INTCLR);
+		status=readb(mouse_base + INTSTAT);
+	}
+}
+
+static void keyboard_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned char status;
+
+	spin_lock(&kbd_controller_lock);
+	kbd_pt_regs = regs;
+
+	status = readb(kbd_base + INTSTAT);
+	while(status & RX_FULL) {
+	    unsigned char scancode,qcode;
+
+	    qcode = readb(kbd_base + RXREG);
+
+	    if (qcode != 0xf0)
+	      {
+		if (qcode == 0xe0)
+		  {
+		    qprev=0xe0;
+		    handle_scancode(qprev , 1);
+		    goto exit;
+		  }
+
+		scancode=qprev ? xilinx_kbd_ecl[qcode] : xilinx_kbd_cl[qcode];
+		qprev=0;
+		if (!scancode)
+		  {
+		    printk("unknown scancode %x\n",qcode);
+			writeb(status,kbd_base+INTCLR);
+		    goto exit;
+		  }
+		if (scancode==0xff)  /* SySrq */
+		  scancode=SYSRQ_KEY;
+
+		handle_scancode(scancode, ! keyup );
+		keyup=0;
+		tasklet_schedule(&keyboard_tasklet);
+	      }
+	    else
+	      keyup=1;
+
+		writeb(status,kbd_base+INTCLR);
+	    status = readb(kbd_base + INTSTAT);
+
+	}
+exit:
+	spin_unlock(&kbd_controller_lock);
+}
+
+
+#define KBD_NO_DATA	(-1)	/* No data */
+#define KBD_BAD_DATA	(-2)	/* Parity or other error */
+
+void __init xilinx_kbd_init_hw(void)
+{
+
+	/* Reset the keyboard controller */
+	writeb(1,kbd_base+RESET);
+	writeb(0,kbd_base+RESET);
+
+	request_irq(27, keyboard_interrupt, 0, "keyboard", NULL);
+
+	writeb(0x38, kbd_base+INTMSET);
+
+	psaux_init();
+
+}
+
+
+/*
+ * Send a byte to the mouse.
+ */
+
+static inline void aux_write_dev(int val)
+{
+	writeb(val, mouse_base+TXREG);
+}
+
+/*
+ * Send a byte to the mouse & handle returned ack
+ */
+
+static inline void aux_write_ack(int val)
+{
+	aux_write_dev(val);
+	atomic_inc(&mouse_reply_expected);
+}
+
+static unsigned char get_from_queue(void)
+{
+	unsigned char result;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mouse_controller_lock, flags);
+	result = queue->buf[queue->tail];
+	queue->tail = (queue->tail + 1) & (AUX_BUF_SIZE-1);
+	spin_unlock_irqrestore(&mouse_controller_lock, flags);
+	return result;
+}
+
+static inline int queue_empty(void)
+{
+	return queue->head == queue->tail;
+}
+
+static int fasync_aux(int fd, struct file *filp, int on)
+{
+	int retval;
+
+	retval = fasync_helper(fd, filp, on, &queue->fasync);
+	if (retval < 0)
+		return retval;
+
+	return 0;
+}
+
+
+/*
+ *  * Random magic cookie for the aux device
+ *   */
+#define AUX_DEV ((void *)queue)
+
+static int release_aux(struct inode * inode, struct file * file)
+{
+    lock_kernel();
+    fasync_aux(-1, file, 0);
+    if (--aux_count) {
+        unlock_kernel();
+        return 0;
+    }
+    writeb(0x3f, mouse_base+INTMCLR);	/* Disable controller ints */
+    free_irq(26,AUX_DEV);
+    unlock_kernel();
+    return 0;
+}
+
+
+static int open_aux(struct inode * inode, struct file * file)
+{
+	if (aux_count++) {
+		return 0;
+	}
+	queue->head = queue->tail = 0;      /* Flush input queue */
+	if(request_irq(26, mouse_interrupt, 0, "mouse", AUX_DEV)) {
+		aux_count--;
+		return -EBUSY;
+	}
+    /* Reset the mouse controller */
+    writeb(1,mouse_base+RESET);
+    writeb(0,mouse_base+RESET);
+
+	writeb(0x38, mouse_base+INTMSET);
+
+	aux_write_ack(AUX_ENABLE_DEV);
+	mdelay(2);
+
+	return 0;
+}
+
+/*
+ * Put bytes from input queue to buffer.
+ */
+
+static ssize_t read_aux(struct file * file, char * buffer,
+				            size_t count, loff_t *ppos)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	ssize_t i = count;
+	unsigned char c;
+
+	if (queue_empty()) {
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		add_wait_queue(&queue->proc_list, &wait);
+repeat:
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (queue_empty() && !signal_pending(current)) {
+				schedule();
+			goto repeat;
+		}
+		current->state = TASK_RUNNING;
+		remove_wait_queue(&queue->proc_list, &wait);
+	}
+	while (i > 0 && !queue_empty()) {
+		c = get_from_queue();
+		put_user(c, buffer++);
+		i--;
+	}
+	if (count-i) {
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+		return count-i;
+	}
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+	return 0;
+}
+
+/*
+ * Write to the aux device.
+ */
+
+static ssize_t write_aux(struct file * file, const char * buffer,
+				             size_t count, loff_t *ppos)
+{
+	ssize_t retval = 0;
+
+    if (count) {
+        ssize_t written = 0;
+		if (count > 32)
+		count = 32; /* Limit to 32 bytes. */
+		do {
+			char c;
+			get_user(c, buffer++);
+			aux_write_dev(c);
+			written++;
+		} while (--count);
+		retval = -EIO;
+		if (written) {
+			retval = written;
+			file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
+		}
+	}
+
+	return retval;
+}
+
+/* No kernel lock held - fine */
+static unsigned int aux_poll(struct file *file, poll_table * wait)
+{
+    poll_wait(file, &queue->proc_list, wait);
+    if (!queue_empty())
+        return POLLIN | POLLRDNORM;
+    return 0;
+}
+
+struct file_operations psaux_fops = {
+    read:       read_aux,
+    write:      write_aux,
+    poll:       aux_poll,
+    open:       open_aux,
+    release:    release_aux,
+    fasync:     fasync_aux,
+};
+
+static struct miscdevice psaux_mouse = {
+    PSMOUSE_MINOR, "psaux", &psaux_fops
+};
+
+static int __init psaux_init(void) {
+
+	int retval;
+
+	if ((retval = misc_register(&psaux_mouse)))
+		return retval;
+
+    queue = (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
+    if (queue == NULL) {
+        printk(KERN_ERR "psaux_init(): out of memory\n");
+        misc_deregister(&psaux_mouse);
+        return -ENOMEM;
+    }
+
+	memset(queue, 0, sizeof(*queue));
+	queue->head = queue->tail = 0;
+	init_waitqueue_head(&queue->proc_list);
+
+	aux_write_ack(AUX_SET_SAMPLE);
+	aux_write_ack(100);
+	aux_write_ack(AUX_SET_RES);
+	aux_write_ack(3);
+	aux_write_ack(AUX_SET_SCALE21);
+	writeb(0x3f,mouse_base + INTMCLR);
+	return 0;
+}
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/include/asm-ppc/xilinx_keyb.h linuxppc_2_4_xseg2.new.clean2/include/asm-ppc/xilinx_keyb.h
--- linuxppc_2_4_clean/include/asm-ppc/xilinx_keyb.h	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc_2_4_xseg2.new.clean2/include/asm-ppc/xilinx_keyb.h	2002-09-04 21:39:11.000000000 +0200
@@ -0,0 +1,43 @@
+/*
+ * xilinx_keyb.h: A driver for Xilinx PS/2 keyboard and mouse interface core
+ *
+ * Copyright 2002 Mind NV
+ *
+ * http://www.mind.be/
+ *
+ * Author : Peter De Schrijver (p2@mind.be)
+ *
+ * Derived from : drivers/char/q40_keyb.c
+ *
+ * This software may be used and distributed according to the terms of
+ * the GNU General Public License (GPL) version 2, incorporated herein by
+ * reference. Drivers based on or derived from this code fall under the GPL
+ * and must retain the authorship, copyright and this license notice. This
+ * file is not a complete program and may only be used when the entire
+ * operating system is licensed under the GPL.
+ *
+ */
+#ifndef _XILINX_KEYB_H
+#define _XILINX_KEYB_H
+
+/* PS/2 controller register offsets */
+
+#define RESET 	0
+#define STATUS	4
+#define RXREG	8
+#define TXREG	12
+#define INTSTAT 16
+#define INTCLR	20
+#define INTMSET	24
+#define INTMCLR	28
+
+/* PS/2 controller interrupt bits */
+
+#define WDTIMEOUT	1
+#define	TX_NOACK	2
+#define TX_ACK		4
+#define RX_OVER		8
+#define RX_ERR		16
+#define RX_FULL		32
+
+#endif

--TiqCXmo5T1hvSQQg--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
