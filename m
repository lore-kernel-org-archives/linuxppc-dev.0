Date: Mon, 1 Dec 2003 21:23:58 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tom Rini <trini@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] 2.4.23 and LongTrail
Message-ID: <Pine.GSO.4.21.0312012117210.25040-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


New stable kernel, time to try it on my LongTrail ;-)

Here are a few fixes:
  - Kill warning by removing unneeded forward declaration of openpic_reset().
  - Kill warning by fixing printf()-style format.
  - Fix detection of bogus ttyS02 (ttyS02 at 0x03e8 (irq = 4) is a 16450).
    Ack'ed by RMK a while ago, valid for 2.6 as well.

Patches are relative to source.mvista.com::linuxppc_2_4 from last weekend.

Thanks for applying!

--- linux-ppc-2.4.23/arch/ppc/kernel/open_pic.c.orig	Fri Nov 28 21:05:24 2003
+++ linux-ppc-2.4.23/arch/ppc/kernel/open_pic.c	Sun Nov 30 12:12:30 2003
@@ -69,7 +69,6 @@
  * These functions are not used but the code is kept here
  * for completeness and future reference.
  */
-static void openpic_reset(void);
 #ifdef notused
 static void openpic_enable_8259_pass_through(void);
 static u_int openpic_get_priority(void);
--- linux-ppc-2.4.23/arch/ppc/kernel/setup.c.orig	Fri Nov 28 21:04:43 2003
+++ linux-ppc-2.4.23/arch/ppc/kernel/setup.c	Sun Nov 30 12:13:46 2003
@@ -157,7 +157,7 @@
 	lpj = loops_per_jiffy;
 #endif

-	seq_printf(m, "processor\t: %lu\n", i);
+	seq_printf(m, "processor\t: %u\n", i);
 	seq_printf(m, "cpu\t\t: ");

 	if (cur_cpu_spec[i]->pvr_mask)
--- linux-ppc-2.4.23/include/asm-ppc/pc_serial.h.orig	Fri Nov 28 21:04:24 2003
+++ linux-ppc-2.4.23/include/asm-ppc/pc_serial.h	Sun Nov 30 11:28:57 2003
@@ -28,10 +28,10 @@

 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #ifdef CONFIG_SERIAL_DETECT_IRQ
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
 #define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
 #else
-#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
+#define STD_COM_FLAGS ASYNC_BOOT_AUTOCONF
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
