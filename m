Return-Path: <geert@linux-m68k.org>
Received: from adicia.telenet-ops.be (adicia.telenet-ops.be [195.130.132.56])
	by ozlabs.org (Postfix) with ESMTP id F376DDDDCA
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 22:51:56 +1000 (EST)
Date: Sun, 22 Jul 2007 14:51:52 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [patch 1/3] m68k/mac: Make mac_hid_mouse_emulate_buttons()
	declaration visible
In-Reply-To: <200707220022.41797.dtor@insightbb.com>
Message-ID: <Pine.LNX.4.64.0707221451140.18493@anakin>
References: <20070720164043.523003359@mail.of.borg>
	<d120d5000707201151q433f1f3eteb479109291a54bd@mail.gmail.com>
	<Pine.LNX.4.64.0707211026070.18493@anakin>
	<200707220022.41797.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Bunk <bunk@stusta.de>, linuxppc-dev@ozlabs.org,
	linux-input@atrey.karlin.mff.cuni.cz,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 22 Jul 2007, Dmitry Torokhov wrote:
> On Saturday 21 July 2007 04:27, Geert Uytterhoeven wrote:
> > On Fri, 20 Jul 2007, Dmitry Torokhov wrote:
> > > I am OK with adding a new header file. I was just saying that placing
> > > that declaration in linux/hid.h makes about the same sense as putting
> > > it into linux/scsi.h
> > 
> > At first I just wanted to move it. Then I thought about the angry
> > comments I would get about not moving it to a header file ;-)
> > 
> > <linux/hid.h> looked like the best candidate. <linux/kbd_kern.h> is
> > another option.
> > 
> 
> linux/kbd_kern.h sounds much better.

And so it will be.

---
m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible

drivers/char/keyboard.c: In function 'kbd_keycode':
drivers/char/keyboard.c:1142: error: implicit declaration of function 'mac_hid_mouse_emulate_buttons'

The forward declaration of mac_hid_mouse_emulate_buttons() is not visible on
m68k because it's hidden in the middle of a big #ifdef block.

Move it to <linux/kbd_kern.h>, correct the type of the second parameter, and
include <linux/kbd_kern.h> where needed.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/char/keyboard.c     |    4 ----
 drivers/macintosh/mac_hid.c |    1 +
 include/linux/kbd_kern.h    |    3 +++
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1022,10 +1022,6 @@ static const unsigned short x86_keycodes
 	308,310,313,314,315,317,318,319,320,357,322,323,324,325,276,330,
 	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372 };
 
-#ifdef CONFIG_MAC_EMUMOUSEBTN
-extern int mac_hid_mouse_emulate_buttons(int, int, int);
-#endif /* CONFIG_MAC_EMUMOUSEBTN */
-
 #ifdef CONFIG_SPARC
 static int sparc_l1_a_state = 0;
 extern void sun_do_break(void);
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -13,6 +13,7 @@
 #include <linux/sysctl.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/kbd_kern.h>
 
 
 static struct input_dev *emumousebtn;
--- a/include/linux/kbd_kern.h
+++ b/include/linux/kbd_kern.h
@@ -161,4 +161,7 @@ static inline void con_schedule_flip(str
 	schedule_delayed_work(&t->buf.work, 0);
 }
 
+/* mac_hid.c */
+extern int mac_hid_mouse_emulate_buttons(int, unsigned int, int);
+
 #endif


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
