Date: Sun, 12 Sep 1999 14:10:14 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
Message-ID: <19990912141014.A17732@them.org>
References: <19990910161322.A1674@them.org> <19990911112323.032168@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=gBBFr7Ir9EOA20Yy
In-Reply-To: <19990911112323.032168@smtp.calvacom.fr>; from Benjamin Herrenschmidt on Sat, Sep 11, 1999 at 11:23:23AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii

OK, this patch should d the trick.

On Sat, Sep 11, 1999 at 11:23:23AM +0200, Benjamin Herrenschmidt wrote:
> >I have a bunch of information on this lying around, and most of my
> >other kernel problems seem to be resolved now.  I'm in the process of
> >upgrading to current vger; if it succeeds, I'll try to merge all
> >pending controlfb stuff tomorrow.
> 
> I also have a pair of crazy 8500 who have 2Mb of VRAM but in bank2 (they
> don't work if the VRAM is moved to bank1, even under MacOS). The current
> controlfb appears to work well. Send me your merge results, I'll test on
> one of those weird machines Monday.
> 
> 
> -- 
>            E-Mail: <mailto:bh40@calva.net>
> BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>
> 
> 
> 
> 


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="control.diff"

Index: controlfb.c
===================================================================
RCS file: /cvs/linux/linux/drivers/video/controlfb.c,v
retrieving revision 1.20
diff -u -r1.20 controlfb.c
--- controlfb.c	1999/09/10 07:04:03	1.20
+++ controlfb.c	1999/09/12 18:03:57
@@ -702,26 +702,48 @@
 	p->cmap_regs = ioremap(p->cmap_regs_phys, 0x1000);
 
 	/* Work out which banks of VRAM we have installed. */
-	/* danj: I guess the card just ignores writes to nonexistant VRAM... */
+	/* According to Andrew Fyfe <bandr@best.com>, the VRAM behaves like so: */
+	/* afyfe: observations from an 8500:
+	 * - with 2M vram in bank 1, it appears at offsets 0, 2M and 4M
+	 * - with 2M vram in bank 2, it appears only at offset 6M
+	 * - with 4M vram, it appears only as a 4M block at offset 0.
+	 */
+
+	/* We know there is something at 2M if there is something at 0M. */
+	out_8(&p->frame_buffer[0x200000], 0xa5);
+	out_8(&p->frame_buffer[0x200001], 0x38);
+	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x200000]) : "memory" );
+
 	out_8(&p->frame_buffer[0], 0x5a);
 	out_8(&p->frame_buffer[1], 0xc7);
 	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0]) : "memory" );
-	bank1 = (in_8(&p->frame_buffer[0]) == 0x5a) && (in_8(&p->frame_buffer[1]) == 0xc7);
 
-	out_8(&p->frame_buffer[0x600000], 0xa5);
-	out_8(&p->frame_buffer[0x600001], 0x38);
-	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x600000]) : "memory" );
-	bank2 = (in_8(&p->frame_buffer[0x600000]) == 0xa5)
-		&& (in_8(&p->frame_buffer[0x600001]) == 0x38);
-	
-	p->total_vram = (bank1 + bank2) * 0x200000;
-	/* If we don't have bank 1 installed, we hope we have bank 2 :-) */
-	p->control_use_bank2 = !bank1;
-	if (p->control_use_bank2) {
+	bank1 =  (in_8(&p->frame_buffer[0x000000]) == 0x5a)
+		&& (in_8(&p->frame_buffer[0x000001]) == 0xc7);
+	bank2 =  (in_8(&p->frame_buffer[0x200000]) == 0xa5)
+		&& (in_8(&p->frame_buffer[0x200001]) == 0x38);
+
+	if(bank2 && !bank1)
+		printk(KERN_INFO "controlfb: Found memory at 2MB but not at 0!  Please contact dan@debian.org\n");
+
+	if(!bank1) {
+		out_8(&p->frame_buffer[0x600000], 0xa5);
+		out_8(&p->frame_buffer[0x600001], 0x38);
+		asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x600000]) : "memory" );
+		bank2 = (in_8(&p->frame_buffer[0x600000]) == 0xa5)
+			&& (in_8(&p->frame_buffer[0x600001]) == 0x38);
+		/* If we don't have bank 1 installed, we hope we have bank 2 :-) */
+		p->control_use_bank2 = 1;
 		p->frame_buffer += 0x600000;
 		p->frame_buffer_phys += 0x600000;
 	}
 	
+	p->total_vram = (bank1 + bank2) * 0x200000;
+	
+	printk(KERN_INFO "controlfb: Memory bank 1 %s, bank 2 %s, total VRAM %dMB\n",
+		bank1 ? "present" : "absent", bank2 ? "present" : "absent",
+		2 * (bank1 + bank2));
+
 	init_control(p);
 }
 

--gBBFr7Ir9EOA20Yy--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
