Date: Tue, 29 Aug 2000 13:07:47 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: davidm@amberdata.demon.co.uk, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI resource initialisation
In-Reply-To: <200008290604.IAA00738@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10008291140390.385-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 29 Aug 2000, Michel Lanners wrote:
> On  28 Aug, this message from Geert Uytterhoeven echoed through cyberspace:
> > You could also start from my patches for the CHRP LongTrail (which seems to
> > work fine on PowerMac as well, especially on 7200 with extra SCSI cards :-).
> > It assigns resources to all devices that don't have (valid) resources
> > assigned.
>
> I already wanted to point out your patches, Geert :-)
>
> How about actually getting them _into_ the PPC kernel trees? Do you have
> any plans in that direction?

I do have plans, but since I'm currently unable to do anything with the
bitkeeper tree, I still hope some other bk power will do it for me [hint!]...

Besides, it would also allow us to remove the workaround in atyfb for broken OF
in some PowerBooks, i.e. _revert_ the following patch which went into 2.3.51:

--- v2.3.50/linux/drivers/video/atyfb.c	Sat Feb 26 22:31:51 2000
+++ linux/drivers/video/atyfb.c	Fri Mar 10 09:43:04 2000
@@ -2689,15 +2689,6 @@
     fix->smem_start = info->frame_buffer_phys;
     fix->smem_len = (u32)info->total_vram;

-#ifdef __LITTLE_ENDIAN
-    /*
-     *  Last page of 8 MB little-endian aperture is MMIO
-     *  FIXME: we should use the auxiliary aperture instead so we can acces the
-     *  full 8 MB of video RAM on 8 MB boards
-     */
-    if (fix->smem_len > 0x800000-GUI_RESERVE)
-	fix->smem_len = 0x800000-GUI_RESERVE;
-#endif
     /*
      *  Reg Block 0 (CT-compatible block) is at ati_regbase_phys
      *  Reg Block 1 (multimedia extensions) is at ati_regbase_phys-0x400
@@ -3501,11 +3492,14 @@
     }
 #endif

-    if (info->bus_type == ISA)
-	if ((info->total_vram == 0x400000) || (info->total_vram == 0x800000)) {
-	    /* protect GUI-regs if complete Aperture is VRAM */
+    /*
+     *  Last page of 8 MB (4 MB on ISA) aperture is MMIO
+     *  FIXME: we should use the auxiliary aperture instead so we can acces the
+     *  full 8 MB of video RAM on 8 MB boards
+     */
+    if (info->total_vram == 0x800000 ||
+	(info->bus_type == ISA && info->total_vram == 0x400000))
 	    info->total_vram -= GUI_RESERVE;
-	}

     /* Clear the video memory */
     fb_memset((void *)info->frame_buffer, 0, info->total_vram);


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
