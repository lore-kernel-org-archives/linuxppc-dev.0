Message-Id: <199905191848.UAA01955@mitra.phys.uit.no>
To: linuxppc-dev@lists.linuxppc.org
Cc: linuxppc-user@lists.linuxppc.org
Subject: Ad hoc patch: Removing PowerBook G3 speaker hiss when booting
From: Alvin Brattli <Alvin.Brattli@phys.uit.no>
Date: Wed, 19 May 1999 20:48:44 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



The following patch removes the highly annoying hiss PowerBook G3 users
hear during the boot sequence, and until one plays a system beep through
the loudspeakers.  It works by playing a very short beep (with volume 0)
during the DMA sound driver setup phase.  This as an alternative to
putting "echo ^G" in /etc/rc.d/rc.local.  Admittedly, this is a very ad
hoc way to do it, and the source of this problem seems to be something
more fundamental in the handling of the way the awacs drivers switches
off dma sound, and I don't know enough about how the dma sound works to
dig deeper into it.  However, the patch works :)
The patch is relative to kernel 2.2.8 on ftp.kernel.org.

Even if the patch is not included in the kernel, it might help pinpoint
the real source of the problem, and help inspire someone to dig deeper
into it :)

aLViN


--- drivers/sound/dmasound.c.orig	Fri May 14 22:24:46 1999
+++ drivers/sound/dmasound.c	Wed May 19 20:31:38 1999
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
+	/* Remove hiss from PowerBook G3 speakers (very ad hoc) */
+	beep_volume_tmp = beep_volume;
+	beep_volume = 0;
+	awacs_mksound(750, 1);
+	beep_volume = beep_volume_tmp;
+#endif /* CONFIG_PPC */
 
 	printk(KERN_INFO "DMA sound driver installed, using %d buffers of %dk.\n",
 	       numBufs, bufSize);

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
