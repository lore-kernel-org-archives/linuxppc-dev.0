Date: Thu, 28 Oct 1999 01:25:52 -0500
From: anthony tong <atong@uiuc.edu>
To: Charlie McLachlan <cim@uk.research.att.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Accel ATI Rage 128 support, the very first step (Help needed)
Message-ID: <19991028012551.A16581@mango.genunix.net>
References: <Pine.LNX.4.10.9910201724400.366-100000@newhope.terraplex.com> <Pine.SO4.4.04.9910271119020.5658-100000@marrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SO4.4.04.9910271119020.5658-100000@marrow>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Charlie McLachlan (Wed, Oct 27, 1999 at 11:46:15AM +0100):
> The result was that vertical scolling worked fine (i.e. when you typed
> to the bottom of the screen the scroll upward was okay) but when scrooling
> horizontally (like when you back cursor through a line then add more
> characters) the remains of the line (the bit to the right of the cursor)
> is not moved.

this might be a shell vs. termcap/terminfo problem.

> 1) What gives? Why isn't bmove (seemingly) used for vertical console
> scrolls?

Because it's slow. If you want to try it set display->scrollmode to 0.
Be warned though it's not really ready for prime time use (you need
to make sure that the engine isn't busy).. simple stuff but I simply
didn't have the time to sit down and test it.

> 2) If I recompile aty128fb, how do I replace the currently active version
> without having to restart? (i.e. how do I change frame buffer modules?)

You don't; at least, I've never been able to unregister a fbdev driver
and re-registering a new one. I'm not sure if this has been fixed recently
though.

> 3) Have I got this all wrong? Is bmove even what I should be thinking of?

I'd look into panning + getting a rectfill. I'll try and do it this
weekend if I have the time.

> 5) Antony's code references registers through info->regbase (which is a
> big long hex number with some 8's in it). The Suse code references
> registers through (PCIDevice->_basel & 0xffffff00), where PCIDevice is a
> pciconfigPtr found through probing. Is this the same thing?

Pretty much.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
