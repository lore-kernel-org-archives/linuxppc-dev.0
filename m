Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F62@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC8xx, FEC and DP83847 !?
Date: Thu, 21 Mar 2002 13:43:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven,

> > - The DP83847 can not drive an external IRQ on the PPC,
> while LXT can.
> So does that mean, that the kernel can't detect link changes?
Exactly!

However, I have added a call back, driven by the timer interrupt,
to periodically check for link changes. Of course, it can not
be detected as fast as with interrupt, but it will be correct
in most applications.

Detecting link changes at run-time is not absolutely neccessary,
except for the duplex mode, because the FEC must be aware of it.

> Is there any special reason why your code is not in a recent
> kernel (e.g DENX)?
You are the first one to ask for it ;-)
Really, I have sent it in the past (without the timer call back),
along with a bug fix. But someone at MVista (Tom Rini, I think),
decided not to integrate it for now, since only a few (or no) people
were using it, and it did not follow extensive testing.

And BTW, Mr. Denx just asked me for the patch a few minutes ago.


Another cool thing I have added to the 8xx FEC driver is the standard IOCTL
interface,
to manipulate the PHY through the mii-tool program (net-tools package).
If someone wants it, I will prepare a patch.

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
