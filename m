Date: Tue, 29 Dec 1998 17:53:47 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Alan Cox <alan@cymru.net>
cc: Linux kernel <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: 2.2.0pre-1 sound fixes
Message-ID: <Pine.LNX.4.03.9812291752200.11294-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Alan,

This patch allows me to run 2.2.0-pre1 (with a few PPC specific mods) on my
CHRP box.

--- chrp/drivers/sound/ad1848.c.orig	Tue Dec 29 10:58:23 1998
+++ chrp/drivers/sound/ad1848.c	Tue Dec 29 17:20:45 1998
@@ -1204,16 +1204,20 @@
 	{
 		int             tmout;
 		
+#ifdef CONFIG_PCI_QUIRKS
 		if(!isa_dma_bridge_buggy)
 		        disable_dma(audio_devs[dev]->dmap_in->dma);
+#endif
 
 		for (tmout = 0; tmout < 100000; tmout++)
 			if (ad_read(devc, 11) & 0x10)
 				break;
 		ad_write(devc, 9, ad_read(devc, 9) & ~0x02);	/* Stop capture */
 
+#ifdef CONFIG_PCI_QUIRKS
 		if(!isa_dma_bridge_buggy)
 		        enable_dma(audio_devs[dev]->dmap_in->dma);
+#endif
 		devc->audio_mode &= ~PCM_ENABLE_INPUT;
 	}
 
@@ -1240,16 +1244,20 @@
 	{
 		int             tmout;
 
+#ifdef CONFIG_PCI_QUIRKS
 		if(!isa_dma_bridge_buggy)
 		        disable_dma(audio_devs[dev]->dmap_out->dma);
+#endif
 
 		for (tmout = 0; tmout < 100000; tmout++)
 			if (ad_read(devc, 11) & 0x10)
 				break;
 		ad_write(devc, 9, ad_read(devc, 9) & ~0x01);	/* Stop playback */
 
+#ifdef CONFIG_PCI_QUIRKS
 		if(!isa_dma_bridge_buggy)
 		       enable_dma(audio_devs[dev]->dmap_out->dma);
+#endif
 
 		devc->audio_mode &= ~PCM_ENABLE_OUTPUT;
 	}
--- chrp/drivers/sound/dmabuf.c.orig	Wed Dec 23 19:36:55 1998
+++ chrp/drivers/sound/dmabuf.c	Tue Dec 29 17:24:13 1998
@@ -631,8 +631,10 @@
 		f=claim_dma_lock();
 		clear_dma_ff(chan);
 		
+#ifdef CONFIG_PCI_QUIRKS
 		if(!isa_dma_bridge_buggy)
 			disable_dma(dmap->dma);
+#endif
 		
 		pos = get_dma_residue(chan);
 		
@@ -654,8 +656,10 @@
 		if (pos >= dmap->bytes_in_use)
 			pos = 0;
 		
+#ifdef CONFIG_PCI_QUIRKS
 		if(!isa_dma_bridge_buggy)
 			enable_dma(dmap->dma);
+#endif
 			
 		release_dma_lock(f);
 	}
@@ -1023,12 +1027,16 @@
 		
 		f=claim_dma_lock();
 		
+#ifdef CONFIG_PCI_QUIRKS
 		if(!isa_dma_bridge_buggy)
 			disable_dma(dmap->dma);
+#endif
 		clear_dma_ff(chan);
 		pos = dmap->bytes_in_use - get_dma_residue(chan);
+#ifdef CONFIG_PCI_QUIRKS
 		if(!isa_dma_bridge_buggy)
 			enable_dma(dmap->dma);
+#endif
 		release_dma_lock(f);
 		
 		pos = pos / dmap->fragment_size;	/* Actual qhead */
@@ -1120,12 +1128,16 @@
 		unsigned long f;
 		
 		f=claim_dma_lock();
+#ifdef CONFIG_PCI_QUIRKS
 		if(!isa_dma_bridge_buggy)
 			disable_dma(dmap->dma);
+#endif
 		clear_dma_ff(chan);
 		pos = dmap->bytes_in_use - get_dma_residue(chan);
+#ifdef CONFIG_PCI_QUIRKS
 		if(!isa_dma_bridge_buggy)
 			enable_dma(dmap->dma);
+#endif
 		release_dma_lock(f);
 
 		pos = pos / dmap->fragment_size;	/* Actual qhead */

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
