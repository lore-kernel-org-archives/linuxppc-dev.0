Date: Thu, 22 Feb 2001 19:08:54 -0800 (PST)
From: William Blew <wblew@home.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: OT: A XF4 patch that gives the mach64 a HW cursor
Message-ID: <Pine.LNX.4.30.0102221907020.9423-100000@apollo.kulian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For Your Information; I have submitted a patch to Ani Joshi that
provides the ati driver's mach64 support with a hardware cursor
and thus silken mouse support.

Should anyone want an "advance" copy of the patch, just drop me a
request via email.

-------- Original Message --------
Subject: A patch to 4.0.2-1e that enhances the ati driver (HW cursor for
m64)
Date: Mon, 19 Feb 2001 21:54:27 -0800
From: William Blew <wblew@nospan.home.com>
To: Ani Joshi <ajoshi@shell.unixbox.com>

I have finished (and attached) a patch to the XF4 tree that
provides the following changes:

1) Fixup the "ati" driver so that it doesn't SIGSEGV on the PPC
when the XFree86 server doesn't support loadable modules.

     as in "xc/config/cf/host.def" "DoLoadableServer NO"

   I found that this made debugging XF4 under PPC more doable...

2) Added hardware cursor support for mach64 to the "ati" driver
and thus a "silken mouse". And boy, is it smooth, even under
serious loads.

   This included another public option for the ati driver:
      SwCursor (bool) "use the SW cursor instead of the HW cursor?"

There are a few caveats with this patch:

2.1) It probably doesn't support doublescan modes properly.

Within the r128 driver's SetCursorPostiion, when the current
mode had the doublescan bit set, the y was doubled.

However as under some circumstances the ati driver has no
currentMode I left this out of the atimach64.c routine.

2.2) While this patch should work with x86 hardware, I
have no such with which to test it.

I own a beige G3/266 rev2 with its builtin mach64 support.
It is noted as being a 3D RAGE PRO [0x4750 rev 0x7c]. I
have only tested this patch with this particular mach64 chip.

Overall I would describe this patch as unstable, pending
some testing by other people even tho it works great for me!
--
William Blew, wblew@home.com
Gamer by Choice, Geek by Birth


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
