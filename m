Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ani Joshi <ajoshi@shell.unixbox.com>
Subject: flat panel stays black - help
Date: Fri, 9 Nov 2001 17:16:15 -0500
Cc: Daniel Berlin <dan@cgsoftware.com>,
	linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <20011109221339.IAGA25459.tomts20-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Okay I am now officially crazy.  I have decoded the EDID and hardcoded the
radeon driver to use the proper timings and even fixed the code that
assigns timing for LCD/DFP (it should not use left-right margins taken
from the mode unless the mode is correct, it should use the info taken
from rinfo which should always be the same for this FP monitor since all
resolution changes are just done with stretching of horiz or vertical (i.e
the timing never changes).

I have turned on RTRACE and checked all of these things and all is fine
but still my FP stays dark (OF does not properly intialize it).

I read up all I could and compared it to the latest radeon drivers in XF86
HEAD.

I can not find anything wrong.  Then I looked in the older XF410 radeon
driver and noticed one little register that we never manipulate:

FP_PANEL_CNTL should have bits 0 and 1 turned on when the FLAT panel is
being used (power up the panel).

RADEON_FP_DIGON  (1 << 0)
RADEON_FP_BLON (1 << 1)

The older radeon code was present to actually turn this on (i.e. load and
save these registers along with all of the other FP registers).

For some reason we are choosing to never play with this register (I guess
assuming OF will turn the monitor on properly?).

Why was this removed from the radeon_driver.c code?  The fp_panel_cntl
register is actually defined in radeon.h in the kernel code but neither
FP_DIGON nor FP_BLON are defined or used.

Given the code that does the similar thing for the LCD (with a delay loop)
does anyone know the right way to use this register?

Does anyone have any ideas here?  I am at a complete loss if this is not
the problem.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
