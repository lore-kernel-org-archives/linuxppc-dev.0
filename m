From: "Viljo Viitanen" <Viljo.Viitanen@helsinki.fi>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Pcmcia interrupts & power key scancode on pismo powerbook
Date: Tue, 2 Jan 2001 19:43:54 +0200
Message-ID: <NCEPLFKFPCEAOMFHNBNPIEFICEAA.Viljo.Viitanen@helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


First, the power key in a pismo (stock 2.2.18 kernel) produces a kernel
message:
keyboard: unknown scancode e0 5e

this diff fixes it and allows one to bind the power key to shutdown via
init's keyboard request:

--- linux/drivers/macintosh/mac_hid.c_orig      Mon Dec 11 02:49:42 2000
+++ linux/drivers/macintosh/mac_hid.c   Tue Jan  2 19:08:15 2001
@@ -207,7 +207,7 @@
        0, 0, 0, 0, 0, 0, 0, KEY_HOME,                          /* 0x40-0x47
*/
        KEY_UP, KEY_PAGEUP, 0, KEY_LEFT, 0, KEY_RIGHT, 0, KEY_END, /*
0x48-0x4f */
        KEY_DOWN, KEY_PAGEDOWN, KEY_INSERT, KEY_DELETE, 0, 0, 0, 0, /*
0x50-0x57 */
-       0, 0, 0, KEY_LEFTMETA, KEY_RIGHTMETA, KEY_COMPOSE, 0, 0, /*
0x58-0x5f */
+       0, 0, 0, KEY_LEFTMETA, KEY_RIGHTMETA, KEY_COMPOSE, KEY_POWER, 0, /*
0x58-0x5f */
        0, 0, 0, 0, 0, 0, 0, 0,                                 /* 0x60-0x67
*/
        0, 0, 0, 0, 0, 0, 0, KEY_MACRO,                         /* 0x68-0x6f
*/
        0, 0, 0, 0, 0, 0, 0, 0,                                 /* 0x70-0x77
*/

Then, after trying to get pcmcia working (pcmcia 3.1.23+stock 2.2.18 says
"*NO* card interrupts"), I finally came across this (long url, should be one
line but outlook probably cuts it):

http://www.google.com/search?q=cache:pcmcia.sourceforge.org/cgi-bin/HyperNew
s/get/pcmcia/ports/10/1.html%3Fnogifs++site:pcmcia.sourceforge.org+pismo+pow
erbook+success+pcmcia&hl=en

But even with that patch, I get a kernel panic if I remove the card 'on
fly', without cardctl eject (I'm fiddling with a lucent wavelan silver
card).

I can live with that even if it's a bit annoying, but what I'm curious about
is why I could not find that patch in no other place than google's cache :)

--
Viljo Viitanen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
