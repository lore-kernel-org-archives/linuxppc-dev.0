Date: Mon, 23 Jun 2003 22:20:53 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] Intermezzo build failure
Message-ID: <Pine.GSO.4.21.0306232216570.28300-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Intermezzo doesn't build because <asm/ioctls.h> uses e.g. struct termios
without including <asm/termbits.h>.

Source tree is linuxppc-2.5 from a few days ago. I tried to update, but it
failed:

| callisto$ rsync -avz --delete source.mvista.com::linuxppc-2.5/ .
| @ERROR: chroot failed
| rsync: connection unexpectedly closed (34 bytes read so far)
| rsync error: error in rsync protocol data stream (code 12) at io.c(150)

--- linux-ppc-2.5.72/include/asm-ppc/ioctls.h.orig	Wed Jun 18 12:17:35 2003
+++ linux-ppc-2.5.72/include/asm-ppc/ioctls.h	Thu Jun 19 22:48:09 2003
@@ -2,6 +2,7 @@
 #define _ASM_PPC_IOCTLS_H

 #include <asm/ioctl.h>
+#include <asm/termbits.h>

 #define FIOCLEX		_IO('f', 1)
 #define FIONCLEX	_IO('f', 2)


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
