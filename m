Message-Id: <200003191141.MAA00285@piglet.grunz.lu>
Date: Sun, 19 Mar 2000 12:41:58 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: controlfb: please test!
To: drow@false.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000319034624.A8893@drow.res.cmu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-953466118=:284"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-953466118=:284
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi list,

Here's another test patch for the detection problem on controlfb.
Again, this doesn't fix any problem, it's just to get a better
understanding of what happens in control..

I've also set up a little web page about the issue:

http://piglet.grunz.lu/~mlan/linux/dev/control.html

Please boot a kernel with this patch included ASAP and report your
results back to me! Thanks.

For the interested, there's more below...

On  19 Mar, this message from Daniel Jacobowitz echoed through cyberspace:
>> Here's what I've found so far:
>>
>> - control manages mem in chunks of 2M (a pair of DIMMs), within a
>> region of 8M in size.
>> - 2M in bank 1, and 4M, are accessed at offset 0x0.
>> - 2M in bank 2 are accessed at offset 6M.
>> - the 2.3 code doesn't detect the mem at 2M in my case. It seems
>> writing to 0x0 garbles the memory contents at 2M: write to
>> 2M, write to 0x0-garbling 2M, detect 0x0, detect 2M-garbled, so nothing
>> detected.
>
> Aha!  This signifies a much bigger problem.  If the write to 0M garbles
> the read from 2M, than the two are actually the same memory location!
> It's my understanding that if only 2M is present it can be accessed at
> 0M and 2M (and possibly other offsets).  Does that seem to be wrong for
> you?  Perhaps it can only be accessed when in a mode that requires it?

The detection code seems to indicate garbling; however, practical
experience seems to contradict that:

>> The next step is to compile a better detection check, that can detect
>> mirrored memory regions, so that I can find out what's wrong between
>> 0x0 and 2M..... It's actually very strange, as my 4M do work when
>> accessed in one block starting at 0x0... so 2M would have to be
>> different from 0x0 ???
>
> Try running the check after switching to a vmode which requires more
> than 2M, please.

That's precisely what I run: 1152x870 at 32 bpp. Except when controlfb
only detects 2MB and sets me back to 16 bpp...

So, yes, under 2.2 kernels, I do use all my 4MB of VRAM, and they are
accessed as a single block starting at 0x0! Which indicates the mem at
2MB is _not_ the same as at 0x0.....

Anyway, below is yet another test patch which also checks for mirrored
locations. Have fun!

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "



--134392852-1804289383-953466118=:284
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: memtest.patch

--- linux-2.3.paul/drivers/video/controlfb.c	Fri Feb 11 00:20:08 2000
+++ linux-2.3.paul-work/drivers/video/controlfb.c	Sun Mar 19 12:36:30 2000
@@ -678,7 +678,7 @@
 {
 	struct fb_info_control	*p;
 	unsigned long		addr, size;
-	int			i, bank1, bank2;
+	int			i, bank1, bank2, m[7];

 	if(dp->n_addrs != 2) {
 		printk(KERN_ERR "expecting 2 address for control (got %d)", dp->n_addrs);
@@ -714,7 +714,70 @@
 	 * - with 2M vram in bank 2, it appears only at offset 6M
 	 * - with 4M vram, it appears only as a 4M block at offset 0.
 	 */
+#if (1)
+	/* Let's do the mem test... */
+	for (i=0; i<7; i++) m[i]=0;

+	out_8(&p->frame_buffer[0], 0x5a);
+	out_8(&p->frame_buffer[1], 0xc7);
+	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0]) : "memory" );
+	m[0] =  (in_8(&p->frame_buffer[0x000000]) == 0x5a)
+		&& (in_8(&p->frame_buffer[0x000001]) == 0xc7);
+	m[2] =  (in_8(&p->frame_buffer[0x200000]) == 0x5a)
+		&& (in_8(&p->frame_buffer[0x200001]) == 0xc7);
+	m[4] =  (in_8(&p->frame_buffer[0x400000]) == 0x5a)
+		&& (in_8(&p->frame_buffer[0x400001]) == 0xc7);
+	m[6] =  (in_8(&p->frame_buffer[0x600000]) == 0x5a)
+		&& (in_8(&p->frame_buffer[0x600001]) == 0xc7);
+
+	printk(KERN_INFO "control: mem at 0x000000: %s", m[0] ? "yes" : "no");
+	printk(", mirrored at:%s%s%s\n", m[2]?" 2M":"", m[4]?" 4M":"", m[6]?" 6M":"");
+
+	out_8(&p->frame_buffer[0x200000], 0xa5);
+	out_8(&p->frame_buffer[0x200001], 0x38);
+	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x200000]) : "memory" );
+	m[0] =  (in_8(&p->frame_buffer[0x000000]) == 0xa5)
+		&& (in_8(&p->frame_buffer[0x000001]) == 0x38);
+	m[2] =  (in_8(&p->frame_buffer[0x200000]) == 0xa5)
+		&& (in_8(&p->frame_buffer[0x200001]) == 0x38);
+	m[4] =  (in_8(&p->frame_buffer[0x400000]) == 0xa5)
+		&& (in_8(&p->frame_buffer[0x400001]) == 0x38);
+	m[6] =  (in_8(&p->frame_buffer[0x600000]) == 0xa5)
+		&& (in_8(&p->frame_buffer[0x600001]) == 0x38);
+
+	printk(KERN_INFO "control: mem at 0x200000: %s", m[2] ? "yes" : "no");
+	printk(", mirrored at:%s%s%s\n", m[0]?" 0M":"", m[4]?" 4M":"", m[6]?" 6M":"");
+
+	out_8(&p->frame_buffer[0x400000], 0xc1);
+	out_8(&p->frame_buffer[0x400001], 0x02);
+	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x400000]) : "memory" );
+	m[0] =  (in_8(&p->frame_buffer[0x000000]) == 0xc1)
+		&& (in_8(&p->frame_buffer[0x000001]) == 0x02);
+	m[2] =  (in_8(&p->frame_buffer[0x200000]) == 0xc1)
+		&& (in_8(&p->frame_buffer[0x200001]) == 0x02);
+	m[4] =  (in_8(&p->frame_buffer[0x400000]) == 0xc1)
+		&& (in_8(&p->frame_buffer[0x400001]) == 0x02);
+	m[6] =  (in_8(&p->frame_buffer[0x600000]) == 0xc1)
+		&& (in_8(&p->frame_buffer[0x600001]) == 0x02);
+
+	printk(KERN_INFO "control: mem at 0x400000: %s", m[4] ? "yes" : "no");
+	printk(", mirrored at:%s%s%s\n", m[0]?" 0M":"", m[2]?" 2M":"", m[6]?" 6M":"");
+
+	out_8(&p->frame_buffer[0x600000], 0xb3);
+	out_8(&p->frame_buffer[0x600001], 0x71);
+	asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x600000]) : "memory" );
+	m[0] =  (in_8(&p->frame_buffer[0x000000]) == 0xb3)
+		&& (in_8(&p->frame_buffer[0x000001]) == 0x71);
+	m[2] =  (in_8(&p->frame_buffer[0x200000]) == 0xb3)
+		&& (in_8(&p->frame_buffer[0x200001]) == 0x71);
+	m[4] =  (in_8(&p->frame_buffer[0x400000]) == 0xb3)
+		&& (in_8(&p->frame_buffer[0x400001]) == 0x71);
+	m[6] =  (in_8(&p->frame_buffer[0x600000]) == 0xb3)
+		&& (in_8(&p->frame_buffer[0x600001]) == 0x71);
+
+	printk(KERN_INFO "control: mem at 0x600000: %s", m[6] ? "yes" : "no");
+	printk(", mirrored at:%s%s%s\n", m[0]?" 0M":"", m[2]?" 2M":"", m[4]?" 4M":"");
+#endif
 	/* We know there is something at 2M if there is something at 0M. */
 	out_8(&p->frame_buffer[0x200000], 0xa5);
 	out_8(&p->frame_buffer[0x200001], 0x38);

--134392852-1804289383-953466118=:284--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
