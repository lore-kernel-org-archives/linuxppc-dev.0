Message-ID: <38DC7171.735D9DF5@iiic.ethz.ch>
Date: Sat, 25 Mar 2000 08:57:37 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: khendricks@ivey.uwo.ca
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>, Ani Joshi <ajoshi@shell.unixbox.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Found bug in mode switching but who is at fault...XFree86 or
 aty128fb.c?
References: <Pine.LNX.4.10.10003230911180.6826-100000@shell.unixbox.com> <00032313263100.01328@localhost.localdomain> <00032423100100.00584@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin Hendricks wrote:

> Okay so I found the bug.  It seems all through the r128 driver, crtc.pitch
> values are set to the virtual x resolution  (vxres) / 8.  But in aty128fb.c
> in the var_to_crtc routine the crtc.pitch is set to be just the xres / 8.
>
> This is not a problem if xres == vxres.  Which is what happens when the
> aty128fb.c starts up.

Not necessarily. The problem could have shown up if someone had put a mode
with xres < vxres as first in the "Modes" line, but apparently only
configuration tools tend to do that...


> So for any one mode it defaults to being okay.

Okay.


> Who is wrong?  Should xfree shrink the vxres and vyres to match xres and
> yres before calling set_var or should aty128fb.c var_to_crtc routine be
> fixed to use vxres >> 3 instead of just xres >> 3?

I vote for the latter, because otherwise invisible parts of the screen may be
damaged, or am I wrong?

A better reason might be that it works perfectly as-is in glint ;)


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
