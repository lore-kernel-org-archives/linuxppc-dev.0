Message-Id: <200108282111.XAA00990@piglet.grunz.lu>
Date: Tue, 28 Aug 2001 23:11:37 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Xvideo acceleration: GATOS for PPC?
To: DebianPPC <debian-powerpc@lists.debian.org>,
	linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

During my quest for improved performance in such goodies as xine and
vlc, I came across the fact that currently on PPC, the X server eats
between 20 and 40 percent of the cpu cycles, whereas on i386 (with GATOS
drivers), it just sleeps doing nothing....

Although I found no evidence documented evicende of this, I suppose this
is because XFree (plain), although implementing Xvideo, doesn't use the
hardware acceleration in the ATI chips, whereas the GATOS drivers do
just that.

Anyway, I tried to use teh GATOS drivers on PPC; but unfortunately hit
two problems:

- XFree doesn't autoload the i2c module of which some symbols are
  referenced by the r128 driver. Solved by adding 'Module "i2c"' to
  XF86Config-4.

- Now the Xserver segfaults on startup. Last lines in the log:

[list of available accelerations]
(II) R128(0): Acceleration enabled
(II) R128(0): Using hardware cursor (scanline 3080)
(II) R128(0): Largest offscreen area available: 1152 x 1048
(II) R128(0): Dotclock is 0 Mhz, setting ecp_div to 0
(II) R128(0): Cannot access BIOS: info->VBIOS==NULL.

Fatal server error:
Caught signal 11.  Server aborting

The last two '(II)' lines look strange... for comparison, plain debian
XF410 looks thus:

[list of available accelerations]
(II) R128(0): Acceleration enabled
(II) R128(0): Using hardware cursor (scanline 3080)
(II) R128(0): Largest offscreen area available: 1152 x 1048
(WW) R128(0): Option "power_saver" is not used
(WW) R128(0): Option "DPMS" is not used
(II) R128(0): Direct rendering disabled
(II) Setting vga for screen 0.
(II) Initializing built-in extension MIT-SHM
etc...

Anybody else tried to use GATOS drivers on PPC? FYI, I'm using Debian
XF410 out of unstable, and I'm trying out the XF410 GATOS drivers.

Help? Ideas where to look?

Cheers, and thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
