Message-Id: <199903041808.TAA18295@mitra.phys.uit.no>
To: linuxppc-dev@lists.linuxppc.org
Subject: Removing speaker hiss on PB G3
From: Alvin Brattli <Alvin.Brattli@phys.uit.no>
Date: Thu, 04 Mar 1999 19:08:10 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



With the current 2.2.1 kernel, there is a lot of hiss in the speakers
and headphones on the PowerBook G3.  The hiss starts immediately when
booting, and does not disappear until a beep has been sounding.  When I
was implementing my patch for the volume and mute buttons for the PB G3,
I added some code in the function dmasound_init() in
drivers/sound/dmasound.c to stop the beep immediately after the sound
chips have been initialized.  I first tried using PMacSilence() and
sound_silence(), but these do not do the trick.  Not knowing enough
about the underlying hardware (and not having any documentation on it,
beside the kernel code), I conjured up this code.
What it does, is simply to issue a short beep of length one tick
and with zero volume immediately after initializing the sound hardware,
and then restoring the volume, effectively stopping the hiss.

This patch is ugly, but it works (at least for my PowerBook).  What
really should be done, I think, is to change PMacSilence() so it does a
better job of making sure the sound hardware is making no sound.
However, without understanding the inner workings of the sound hardware,
I cannot do this.  Can anyone give me any hints on what I need to do?


--- drivers/sound/dmasound.c.orig	Mon Mar  1 19:21:46 1999
+++ drivers/sound/dmasound.c	Thu Mar  4 18:51:27 1999
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
+	/* Remove hiss from PowerBook speakers */
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

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
