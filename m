Date: Sat, 15 Apr 2000 22:24:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Logan Hall <warrior514@worldnet.att.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.99-pre5 compile problems
In-Reply-To: <38F3F9B9.9DB92F87@worldnet.att.net>
Message-ID: <Pine.LNX.4.10.10004152223530.876-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Apr 2000, Logan Hall wrote:
> I just downloaded the 2.3.99-pre5 kernel in hopes of getting my
> /dev/mixer working.  This is on a G3 beige tower.  It apears to have
> problems with the dma sound for ppc.  here is the error:
>
> dmasound_core.c: In function `dmasound_init':
> dmasound_core.c:1196: `irq_installed' undeclared (first use in this
> function)

Please let me know whether it works fine or not after this patch:

--- geert-2.3.99-pre5/drivers/sound/dmasound/dmasound_core.c.orig	Sat Apr 15 22:08:03 2000
+++ geert-2.3.99-pre5/drivers/sound/dmasound/dmasound_core.c	Sat Apr 15 22:23:26 2000
@@ -1193,8 +1193,10 @@

 int __init dmasound_init(void)
 {
+#ifdef MODULE
 	if (irq_installed)
 		return -EBUSY;
+#endif

 	/* Set up sound queue, /dev/audio and /dev/dsp. */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
