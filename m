Date: Tue, 27 Nov 2001 12:00:28 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: debian-powerpc@lists.debian.org,
	<linuxppc-dev@lists.linuxppc.org>, <xpert@xfree86.org>
Subject: Rage128 (esp. RageM3) bad line length issue - I figured it out...
Message-ID: <Pine.LNX.4.40.0111271147140.2420-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I finally determined why it is that the XFree Rage128 driver always gets
the wrong framebuffer row width. In XFree 4.1.0's source, in
xc/programs/Xserver/hw/xfree86/drivers/ati/r128_driver.c, lines 1105 to
1118 call XF86ValidateModes with a minPitch of 8 * 64 (512) and a max
pitch of 8 * 1024 (8192). The default pitch increment value is 64 *
pScrn->bitsPerPixel, such that the row width is ALWAYS a multiple of 64.
However, on the Rage M3 that laptops with an 800x600 LCD panel, like the
original iBook and iBookSE (and the FireWire versions) are outfitted with,
the 800-pixel row width is NOT, EVER, a multiple of 64. I tried changing
the pitch increment to 16 * pScrn->bitsPerPixel, and the X server then
correctly determined the real row width (of 800 pixels) by itself, with no
forcing and no other help. Please correct this before 4.2.0's release -
the CVS HEAD version has the same (too large) pitch increment, and should
be corrected.

Also, sorry about the crosspost to three lists, but I believe that this is
relevant to all these lists. If you reply to this message, please remove
references to the other mailing lists.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
