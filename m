Message-Id: <200005312243.AAA00661@piglet.grunz.lu>
Date: Thu, 1 Jun 2000 00:43:53 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: [patch] VRAM detection in controlfb
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-959813033=:660"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-959813033=:660
Content-Type: TEXT/plain; charset=us-ascii

Hi list,

I've finally gotten bored by control's VRAM detection code that is only
semi-functional (either 7x00 or 8x00 VRAM is incorrectly detected).
Until somebody comes up with a failsafe method to detect VRAM, I've
added a command line option to control the amount of VRAM used:

- either kernel command line (compiled-in):

	video=controlfb:vram:3

- or insmod option (no idea whether controlfb works as module):

	insmod controlfb vram=3

Possible values are:

	0 = autodetect (default)
	1 = 2MB bank1
	2 = 2MB bank2
	3 = 4MB (most useful; 4MB doesn't always get detected right)

Larger values get cropped to bits 0 & 1.

If I hear no opposition, I'll send this off to Alan; it might make it
into 2.4.0-final.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-959813033=:660
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="controlfb.diff"

--- linux-2.3.paul/drivers/video/controlfb.c	Fri Apr 21 09:47:27 2000
+++ linux-2.3.paul-work/drivers/video/controlfb.c	Thu Jun  1 00:14:56 2000
@@ -109,6 +109,11 @@
 	} fbcon_cmap;
 };

+static int vram = 0;    /* VRAM config: 1 = 2MB bank1; 2 = 2MB bank2;
+					3 = 4MB */
+MODULE_PARM(vram, "i");
+MODULE_PARM_DESC(vram, "Override VRAM detection: 1 = 2MB bank1; 2 = 2MB bank2; 3 = 4MB");
+
 /******************** Prototypes for exported functions ********************/
 static int control_open(struct fb_info *info, int user);
 static int control_release(struct fb_info *info, int user);
@@ -628,8 +633,8 @@
 	out_le32(&p->control_regs->flags.r, flags);
 	out_le32(&p->control_regs->start_addr.r,
 	    par->yoffset * (par->vxres << cmode));
-	out_le32(&p->control_regs->reg18.r, 0x1e5);
-	out_le32(&p->control_regs->reg19.r, 0);
+       out_le32(&p->control_regs->refr_cnt.r, 0x1e5);
+       out_le32(&p->control_regs->int_en.r, 0);

 	for (i = 0; i < 16; ++i) {
 		controlfb_setcolreg(color_table[i], default_red[i]<<8,
@@ -715,6 +720,29 @@
 	 * - with 4M vram, it appears only as a 4M block at offset 0.
 	 */

+	/* Unfortunately, above is only true on 8x00 machines. 7x00 machines
+	 * behave differently. Until somebody comes up with a way to
+	 * differentiate between the two, you can use the vram= insmod or
+	 * video=controlfb:vram: command-line option to force a specific
+	 * VRAM config.
+	 * 				Michel Lanners <mlan@cpu.lu>
+	 */
+
+	if(vram != 0) {
+		bank1 = vram & 1;
+		bank2 = (vram & 2) / 2;
+		printk(KERN_INFO "controlfb: Overriding VRAM detection, set to"
+			" %s%s%s.\n", (bank1 && bank2) ? "4MB" : "2MB ",
+			(bank1 && !bank2) ? "(bank1)" : "",
+			(!bank1 && bank2) ? "(bank2)" : "");
+		if(!bank1) {
+			p->control_use_bank2 = 1;
+			p->frame_buffer += 0x600000;
+			p->frame_buffer_phys += 0x600000;
+		}
+		goto detect_done;
+	}
+
 	/* We know there is something at 2M if there is something at 0M. */
 	out_8(&p->frame_buffer[0x200000], 0xa5);
 	out_8(&p->frame_buffer[0x200001], 0x38);
@@ -743,7 +771,8 @@
 		p->frame_buffer += 0x600000;
 		p->frame_buffer_phys += 0x600000;
 	}
-
+
+detect_done:
 	p->total_vram = (bank1 + bank2) * 0x200000;

 	printk(KERN_INFO "controlfb: Memory bank 1 %s, bank 2 %s, total VRAM %dMB\n",
@@ -1194,11 +1223,10 @@
 					break;
 			memcpy(fontname, this_opt + 5, i);
 			fontname[i] = 0;
-		}
-		if (!strncmp(this_opt, "vmode:", 6)) {
+		} else if (!strncmp(this_opt, "vmode:", 6)) {
 			int vmode = simple_strtoul(this_opt+6, NULL, 0);
-		if (vmode > 0 && vmode <= VMODE_MAX)
-			default_vmode = vmode;
+			if (vmode > 0 && vmode <= VMODE_MAX)
+				default_vmode = vmode;
 		} else if (!strncmp(this_opt, "cmode:", 6)) {
 			int depth = simple_strtoul(this_opt+6, NULL, 0);
 			switch (depth) {
@@ -1219,6 +1247,8 @@
 				default_cmode = CMODE_32;
 				break;
 			}
+		} else if (!strncmp(this_opt, "vram:", 5)) {
+			vram = 3 & simple_strtoul(this_opt+5, NULL, 0);
 		}
 	}
 }
--- linux-2.3.paul/drivers/video/controlfb.h	Mon Jan  4 01:44:06 1999
+++ linux-2.3.paul-work/drivers/video/controlfb.h	Thu May 25 21:40:41 2000
@@ -21,13 +21,13 @@
  * Structure of the registers for the RADACAL colormap device.
  */
 struct cmap_regs {
-	unsigned char addr;
+	unsigned char addr; 	/* REG-ADDR */
 	char pad1[15];
-	unsigned char d1;
+	unsigned char d1;	/* CRSR-PALETTE */
 	char pad2[15];
-	unsigned char d2;
+	unsigned char d2;	/* REG-DATA */
 	char pad3[15];
-	unsigned char lut;
+	unsigned char lut;	/* COLOR-PALETTE */
 	char pad4[15];
 };

@@ -51,26 +51,27 @@
 	struct preg vesync;	/* vert end sync */
 	struct preg vssync;	/* vert start sync */
 	struct preg vperiod;	/* vert period */
-	struct preg reg8;
+	struct preg reg8;	/* PipeDelayHWCursor */
 	/* Horizontal params are in units of 2 pixels */
 	struct preg hperiod;	/* horiz period - 2 */
 	struct preg hsblank;	/* horiz start blank */
 	struct preg heblank;	/* horiz end blank */
 	struct preg hesync;	/* horiz end sync */
 	struct preg hssync;	/* horiz start sync */
-	struct preg rege;
-	struct preg regf;
-	struct preg reg10;
-	struct preg reg11;
+	struct preg rege;	/* HEQ */
+	struct preg regf;	/* HLFLN */
+	struct preg reg10;	/* HSERR */
+	struct preg reg11;	/* CNTTST */
 	struct preg ctrl;	/* display control */
 	struct preg start_addr;	/* start address: 5 lsbs zero */
 	struct preg pitch;	/* addrs diff between scan lines */
 	struct preg mon_sense;	/* monitor sense bits */
 	struct preg flags;
 	struct preg mode;
-	struct preg reg18;
-	struct preg reg19;
-	struct preg res[6];
+	struct preg refr_cnt;	/* REFRESH-COUNT */
+	struct preg int_en;	/* interrupt enable */
+	struct preg int_st;	/* interrupt status */
+	struct preg res[5];
 };

 struct control_regints {

--134392852-1804289383-959813033=:660-
ontent-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="controlfb.diff"


--134392852-1804289383-959813033=:660--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
