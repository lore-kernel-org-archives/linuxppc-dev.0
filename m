Date: Mon, 9 Jun 2003 17:32:41 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] Mac/m68k ADB HID
Message-ID: <Pine.GSO.4.21.0306091731290.1347-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

Is this OK for you? It fixes compilation for Mac/m68k.

---

ADB HID: Exclude PowerMac-specific things on classic Macs

--- linux-2.5.x/drivers/macintosh/adbhid.c	Tue May 27 19:02:52 2003
+++ linux-m68k-2.5.x/drivers/macintosh/adbhid.c	Sun Jun  8 11:10:58 2003
@@ -44,7 +44,9 @@
 #include <linux/pmu.h>

 #include <asm/machdep.h>
+#ifdef CONFIG_PPC
 #include <asm/pmac_feature.h>
+#endif

 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
@@ -160,6 +162,7 @@
 		return;
 	case 0x3f: /* ignore Powerbook Fn key */
 		return;
+#ifdef CONFIG_PPC
 	case 0x7e: /* Power key on PBook 3400 needs remapping */
 		switch(pmac_call_feature(PMAC_FTR_GET_MB_INFO,
 			NULL, PMAC_MB_INFO_MODEL, 0)) {
@@ -169,6 +172,7 @@
 			keycode = 0x7f;
 		}
 		break;
+#endif /* CONFIG_PPC */
 	}

 	if (adbhid[id]->keycode[keycode]) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
