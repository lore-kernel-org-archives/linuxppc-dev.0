Message-Id: <199906112254.AAA06098@mitra.phys.uit.no>
To: Ryan Nielsen <ran@krazynet.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: patch for dmasound bug 
From: Alvin Brattli <Alvin.Brattli@phys.uit.no>
In-reply-to: Your message of "Fri, 11 Jun 1999 13:07:54 PDT."
             <19990611130754.A67@gondolin>
Date: Sat, 12 Jun 1999 00:54:46 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Ryan Nielsen:
>Alvin Brattli wrote:
>> Although this patch might do what it was intended for, it has some
>> unwanted consequences on the PowerBook G3 Series, namely that one gets a
>> constant, really annoying hiss from the loudspeakers, most notably
>> during the boot sequence.  Without this patch, the hiss stops after a
>> system beep (like when you do an "echo ^G" in a shell), but now even
>> this does not help.  So, if this patch is included in the standard
>> distribution, I suspect we will hear a lot of complaints from PowerBook
>> G3 users.
>
>is this better?
>--- dmasound.c	1999/02/05 05:45:42	1.41
>+++ dmasound.c	1999/06/11 20:04:43
>@@ -3255,6 +3255,11 @@
> 	save_flags(flags); cli();
> 	if (beep_playing) {
> 		st_le16(&beep_dbdma_cmd->command, DBDMA_STOP);
>+		out_le32(&awacs_txdma->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
>+		out_le32(&awacs->control, MASK_IEPC
>+			 | (awacs_rate_index << 8) | 0x11
>+			 | (awacs_revision < AWACS_BURGUNDY? MASK_IEE: 0));
>+		out_le32(&awacs->byteswap, sound.hard.format != AFMT_S16_BE);
> 		beep_playing = 0;
> 	}
> 	restore_flags(flags);

Nope.  The hiss is still there, and won't go away.  If it can be of any
help, the patch below removes the hiss during boot-time when your
patch is not applied.  The patch simply makes a very short beep with
zero volume.  However, after playing certain sounds, the hiss comes
back, and can then be stopped with a system beep (like with "echo ^G" in
a terminal window).


--- linux-2.2.8-orig/drivers/sound/dmasound.c	Fri May 14 22:24:46 1999
+++ linux-2.2.8/drivers/sound/dmasound.c	Sat Jun 12 00:49:44 1999
@@ -4840,6 +4840,7 @@
 	int has_sound = 0;
 #ifdef CONFIG_PPC
 	struct device_node *np;
+	int beep_volume_tmp;
 #endif
 
 #if defined(__mc68000__) || defined(CONFIG_APUS)
@@ -4974,6 +4975,14 @@
 #ifdef MODULE
 	irq_installed = 1;
 #endif
+
+#ifdef CONFIG_PPC
+	/* Remove hiss from PowerBook speakers (very ad hoc) */
+	beep_volume_tmp = beep_volume;
+	beep_volume = 0;
+	awacs_mksound(750, 1);
+	beep_volume = beep_volume_tmp;
+#endif /* CONFIG_PPC */
 
 	printk(KERN_INFO "DMA sound driver installed, using %d buffers of %dk.\n",
 	       numBufs, bufSize);




aLViN
-- 
:r .signature

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
