Message-ID: <762A181C0D966E459A2EB3B810142C7703861518@nmrusdunsx12.nmrlan.net>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: "'Robert P. J. Day'" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: random ramblings on 8xx patches (long and tedious :-)
Date: Thu, 22 Jul 2004 13:10:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu 7/22/2004 8:00 AM, rday wrote:

> apparently, the onboard USB on the 850 is somewhat flaky, which is
> why the USB SOF patch isn't even selectable in micropatch.c, is that
> it?

I've been working in the background for over a year now to get the host-mode
USB interface working on our custom '850 hardware (running vxworks
(unfortunately)).  The problem is not so much that the USB controller is
"flakey", it does what it does quite reliably.  The real problem is that the
MPC850 USB controller was designed for target-mode applications and not
host-mode applications.  Host-mode in the MPC850 is, at best, an
after-thought.

At the implementation level, there are (at least) two major problems:

0. The MPC850 USB controller is neither of the popular USB 1.1
implementation models (UHCI or OHCI).  Since the controller is really an SCC
implemented in microcode in the CP, it has buffer descriptors (BDs) rather
than transfer descriptors (TDs).  Further, it doesn't do any of the
tree-walking that a proper [UO]HCI does.  It's pretty ugly if you're trying
to use a manufacturer-supplied driver.

1. The USB spec. says that the start of frame (SOF) pulse must be sent
within  +/- 500 nanoseconds of the beginning of every 1 msec. frame
interval. There is no provision in the MPC850 hardware to do this
automatically and it's simply impossible to get anywhere close to this
timing with software.  I haven't timed it, but I suspect the microcode patch
has trouble meeting this spec. as well.  It does get a whole lot closer than
a software-only solution, though.

There's a bunch of other detailed problems that I won't bore everyone with.
Bottom line: Don't expect too much out of the MPC850 USB controller in
host-mode.

Regards,
Charlie

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
