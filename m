Date: Mon, 1 Sep 2003 11:46:02 +0000
From: Gabriel Paubert <paubert@iram.es>
To: Frank Murphy <murphyf+linux-ppc@f-m.fm>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux kernel / USB keyboard scancode problems
Message-ID: <20030901114602.A28710@mrt-lx1.iram.es>
References: <200308231409.24503.murphyf+linux-ppc@f-m.fm> <200308291728.01954.murphyf+linux-ppc@f-m.fm> <20030830152017.A26312@mrt-lx1.iram.es> <200309011256.40807.murphyf+linux-ppc@f-m.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309011256.40807.murphyf+linux-ppc@f-m.fm>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Sep 01, 2003 at 12:56:38PM +0200, Frank Murphy wrote:
> On Saturday 30 August 2003 5:20, Gabriel Paubert wrote:
> > On Fri, Aug 29, 2003 at 05:28:01PM +0200, Frank Murphy wrote:
> > > Thanks for these. Because they're such a mess, perhaps the codes for F13,
> > > F14, and F15 should be used instead. Now just to find out what they are,
> > > and if all Apple keyboards have these keys as F13, 14, & 15.
> >
> > From include/linux/input.h (latest Linus'bk repository, lines 195-200):
> >
> > #define KEY_F13                 85
> > #define KEY_102ND               86
> > #define KEY_F11                 87
> > #define KEY_F12                 88
> > #define KEY_F14                 89
> > #define KEY_F15                 90
> >
> > which are mapped to 85/115/119 for emulated raw scancodes
> > in drivers/char/keyboard.c, or rather 0x55/0x73/0x77 since
> > scancodes ar normally typed in hex.
> >
> > Of course the problem is that X wants these in 118/119/120.  I've just
> > checked out the X CVS tree and my head hurts. I believe that the relevant
> > code is in:  programs/Xserver/hw/xfree86/common/xf86Events.c.
> >
> > But it's so hard to follow :-(
> >
> > Anyway, if I follow the X code correctly (a big if), 0x55 and 0x77
> > won't be remapped, but 0x73 will be, to 0xCB. After that we add 8
> > to compute the X keycode which become: 93, 211, and 127.
> >
> > With some luck, there may be a solution since none of these key
> > codes are used under X, neither on the Mac nor on the PC.
>
> Yeah, the keycode/scancode/keysym stuff is a twisty maze. I do have the
> hardware to test these changes, if you have a guess to what they should be.

What keyboard(s) do you have ?

I've only access to my Pismo now, and it obviously does not have the
F13-F15 keys. I shall be back in front on my G4 in a few days.

I'd first need to know what "showkey -k" and "showkey -s" give for these
3 keys on your keybord.

> > Did you actually try the patch. If yes, on which kernel?
>
> I have, and it seems to work fine for me. I patched the debian source from
> kernel-source-2.4.21. Other keys seem to work fine, but I havent checked
> every single key, but I'm using it succesfully now.

Good, given the very limited impact of the patch it's probably correct :-)


	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
