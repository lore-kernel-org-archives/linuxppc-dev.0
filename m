Message-Id: <200003180903.KAA00291@piglet.grunz.lu>
Date: Sat, 18 Mar 2000 10:03:05 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: controlfb: please test!
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-953370185=:290"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-953370185=:290
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi list,

You may remeber my problems (and the many other problems reported over
the years ;-) with controlfb's detection of the amount of VRAM
installed.

Well, it seems control has some bugs, which makes detection less easy,
and until now, only one of two possible schemes for the memory layout
was correctly detected.

Well, I think it's time to clean this mess up, so I want _all_
developers with any machine that has the control hardware
(PowerMacs 7300, 7500, 7600, 8500, 8600, clones?) to try the following
patch on a 2.3 kernel, and report the results to me.

Mine look like this, with 2 MB in bank2:
....
control: mem at 0x000000: no
control: mem at 0x200000: no
control: mem at 0x400000: no
control: mem at 0x600000: yes
controlfb: Memory bank 1 absent, bank 2 present, total VRAM 2MB
....

Please include yur VRAM configuration, and if you have the time, please
try all possible combinations (2MB in either bank1 or bank2, and 4MB).

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-953370185=:290
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: memtest.patch

--- linux-2.3.paul/drivers/video/controlfb.c	Fri Feb 11 00:20:08 2000
+++ linux-2.3.paul-work/drivers/video/controlfb.c	Sat Mar 18 09:48:38 2000
@@ -715,6 +715,39 @@
 	 * - with 4M vram, it appears only as a 4M block at offset 0.
 	 */

+	/* Let's do the mem test... */
+	out_8(&p->frame_buffer[0x200000], 0xa5);
+	out_8(&p->frame_buffer[0x200001], 0x38);
+	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x200000]) : "memory" );
+
+	out_8(&p->frame_buffer[0], 0x5a);
+	out_8(&p->frame_buffer[1], 0xc7);
+	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0]) : "memory" );
+
+	bank1 =  (in_8(&p->frame_buffer[0x000000]) == 0x5a)
+		&& (in_8(&p->frame_buffer[0x000001]) == 0xc7);
+	bank2 =  (in_8(&p->frame_buffer[0x200000]) == 0xa5)
+		&& (in_8(&p->frame_buffer[0x200001]) == 0x38);
+
+	printk(KERN_INFO "control: mem at 0x000000: %s\n", bank1 ? "yes" : "no");
+	printk(KERN_INFO "control: mem at 0x200000: %s\n", bank2 ? "yes" : "no");
+
+	out_8(&p->frame_buffer[0x400000], 0xc1);
+	out_8(&p->frame_buffer[0x400001], 0x02);
+	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x400000]) : "memory" );
+
+	out_8(&p->frame_buffer[0x600000], 0xb3);
+	out_8(&p->frame_buffer[0x600001], 0x71);
+	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x600000]) : "memory" );
+
+	bank1 =  (in_8(&p->frame_buffer[0x400000]) == 0xc1)
+		&& (in_8(&p->frame_buffer[0x400001]) == 0x02);
+	bank2 =  (in_8(&p->frame_buffer[0x600000]) == 0xb3)
+		&& (in_8(&p->frame_buffer[0x600001]) == 0x71);
+
+	printk(KERN_INFO "control: mem at 0x400000: %s\n", bank1 ? "yes" : "no");
+	printk(KERN_INFO "control: mem at 0x600000: %s\n", bank2 ? "yes" : "no");
+
 	/* We know there is something at 2M if there is something at 0M. */
 	out_8(&p->frame_buffer[0x200000], 0xa5);
 	out_8(&p->frame_buffer[0x200001], 0x38);

--134392852-1804289383-953370185=:290--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
