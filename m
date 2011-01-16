Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
	by ozlabs.org (Postfix) with ESMTP id D8400B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Jan 2011 05:47:24 +1100 (EST)
Received: from georges.telenet-ops.be (unknown [195.130.137.68])
	by winston.telenet-ops.be (Postfix) with ESMTP id 0D8BC1C2986
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 16 Jan 2011 19:37:02 +0100 (CET)
Date: Sun, 16 Jan 2011 19:36:58 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH] m68k/amiga: Reclaim Chip RAM for PPC exception handlers
Message-ID: <alpine.DEB.2.00.1101161931280.12726@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On m68k, it doesn't make sense to reserve memory for the PPC exception
handlers, and APUS support is dead.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Or does this impact Amigas with APUS boards running in m68k mode?
As we don't (no longer) modify the start address, we were actually stealing the
_last_ 4 pages.

 arch/m68k/amiga/chipram.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/amiga/chipram.c b/arch/m68k/amiga/chipram.c
index 61df1d3..dd0447d 100644
--- a/arch/m68k/amiga/chipram.c
+++ b/arch/m68k/amiga/chipram.c
@@ -33,10 +33,6 @@ void __init amiga_chip_init(void)
     if (!AMIGAHW_PRESENT(CHIP_RAM))
 	return;
 
-    /*
-     *  Remove the first 4 pages where PPC exception handlers will be located
-     */
-    amiga_chip_size -= 0x4000;
     chipram_res.end = amiga_chip_size-1;
     request_resource(&iomem_resource, &chipram_res);
 
-- 
1.7.0.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
