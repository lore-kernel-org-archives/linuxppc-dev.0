From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 26 Aug 2003 22:03:03 +0200
To: Frank Murphy <murphyf+linux-ppc@f-m.fm>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux kernel / USB keyboard scancode problems
Message-ID: <20030826200303.GA14385@iram.es>
References: <200308231409.24503.murphyf+linux-ppc@f-m.fm> <20030826093512.GA7637@iram.es> <200308262124.04906.murphyf+linux-ppc@f-m.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308262124.04906.murphyf+linux-ppc@f-m.fm>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 26, 2003 at 09:24:02PM +0200, Frank Murphy wrote:
> On Tuesday 26 August 2003 11:35, Gabriel Paubert wrote:
> > On Sat, Aug 23, 2003 at 02:09:24PM +0200, Frank Murphy wrote:
> > >   To get the menu keysym, I'm supposed to press fn and Enter at the same
> > > time. But, instead of getting Menu (X keycode 117), I get 99.
> > > Unfortunately, that's the same keycode as Prior (PageUp), but I think
> > > that's an X bug. On the console with showkey -k, I get 101. With showkey
> > > -s, I get 0x5b 0xdb. Unfortunately, I don't know what these values are
> > > supposed to be for Menu
> >
> > Indeed that's an X bug, like the one (fixed now?) with the keypad equal.
>
> True, the fact that PageUp and Menu make the same keycode in X is an X bug.
> However, if the kernel sent the normal (i.e. i386) keycode, the X bug
> wouldn't be exposed.
>
> > X does its own mapping of raw keycodes to keycodes, and the mapping
> > is surjective (arghh). The option CustomKeyCodes in X allows you to bypass
> > this mapping (medium raw modes) but I believe it is deprecated.

On a PC, the Menu key sends e0 5d (and obviously e0 dd for key up). The linux
keycode is 127 but the X one is 117.


> > I believe it was benh in drivers/macintosh/adbhid.c on March 5th. Easy
> > to find with bk (1.10 revision in the tree on my Pismo which I have not
> > updated in a long time). Apparently the ADB keycodes have changed
> > depending on PB revisions.
>
> Thanks for the pointer! It looks like that's the right place. I've looked at
> it quickly, and it'll take me a while to figure out what's going on.

The following might be sufficient (just a wild guess, and it will
certainly break if you don't use linux keycodes):


===== adbhid.c 1.12 vs edited =====
--- 1.12/drivers/macintosh/adbhid.c	Sat Jul 12 03:15:34 2003
+++ edited/adbhid.c	Tue Aug 26 21:55:04 2003
@@ -70,7 +70,7 @@
 	 15, 57, 41, 14, 96,  1, 29,125, 42, 58, 56,105,106,108,103,  0,
 	  0, 83,  0, 55,  0, 78,  0, 69,  0,  0,  0, 98, 96,  0, 74,  0,
 	  0,117, 82, 79, 80, 81, 75, 76, 77, 71,  0, 72, 73,183,181,124,
-	 63, 64, 65, 61, 66, 67,191, 87,190, 99,  0, 70,  0, 68,101, 88,
+	 63, 64, 65, 61, 66, 67,191, 87,190, 99,  0, 70,  0, 68,127, 88,
 	  0,119,110,102,104,111, 62,107, 60,109, 59, 54,100, 97,126,116
 };


BTW, I'd also like to keep somewhere the state of the fn key in the
ADB keyboard driver. I've seen a MacOS utility which allows you to
use the trackpad as a scroll wheel while the fn button is pressed.
Thta's what I'd ike to copy.

	Regards,
	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
