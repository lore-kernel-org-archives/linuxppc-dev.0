Date: Wed, 27 Oct 1999 11:46:15 +0100 (BST)
From: Charlie McLachlan <cim@uk.research.att.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Accel ATI Rage 128 support, the very first step (Help needed)
In-Reply-To: <Pine.LNX.4.10.9910201724400.366-100000@newhope.terraplex.com>
Message-ID: <Pine.SO4.4.04.9910271119020.5658-100000@marrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've taken a look at the the Suse code and the Antony's aty128 fb with a
mind to accelerating console scrolling (for a start).

Starting with the fb device. 

I've found the bmove function and guess that's what is used to copy
bits of the screen around.

As an experiment, I replace it with a  function that does nothing.

Thus,

(all the following based on  Antony's aty128fb.c)

add a display_switch to fb_info_aty128

struct fb_info_aty128 {
	...
	struct display_switch dispw;
	...
	};

then alter aty128_set_disp so that instead of just

disp->dispw = &fbcon_cfb<whatever>;

we have

disp->dispw= &info->dispw;
memcpy(&info->dispw,&fbcon_cfb<whatever>,sizeof(fbcon_cfb<whatever>));
info->dispw.bmove=fbcon_aty128_bmove;

where fbcon_aty128_bmove is a function of my own devising that does
nothing.

The result was that vertical scolling worked fine (i.e. when you typed
to the bottom of the screen the scroll upward was okay) but when scrooling
horizontally (like when you back cursor through a line then add more
characters) the remains of the line (the bit to the right of the cursor)
is not moved.

So on to the questions:

(I realise some of these might be RTFM answers, but I don't know which FM
I should be R'ing)

1) What gives? Why isn't bmove (seemingly) used for vertical console
scrolls?

2) If I recompile aty128fb, how do I replace the currently active version
without having to restart? (i.e. how do I change frame buffer modules?)

3) Have I got this all wrong? Is bmove even what I should be thinking of?

4) Where can I find more frame buffer documentation? I've worked most of
this out from the skellington framebuffer device and Antony's code.

5) Antony's code references registers through info->regbase (which is a
big long hex number with some 8's in it). The Suse code references
registers through (PCIDevice->_basel & 0xffffff00), where PCIDevice is a
pciconfigPtr found through probing. Is this the same thing?

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Charlie McLachlan - Responsible for VNC on the Mac
	AT&T Research Lab. Cambridge.
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
