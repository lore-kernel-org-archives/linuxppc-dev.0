From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Failsafe bootloader
Date: Tue, 3 Jun 2003 23:47:22 -0700
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A8012E39C8@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We had a similar scheme for upgrades.  There was an "approved" image, and a "current" image.  If the current image wasn't working it would revert to the approved image automatically.  If the running image appeared to be ok, the operator could then mark it as the "approved" version.  In addition, there was a "factory installed" image that could be used if the operator messed the system up badly.

The drawback is that this takes more Flash space, which can be important when the goals turn from "make a product that works" into "save an extra $5 on the board cost".  Thus, for a later product we got rid of the factory image.

It also could be very nice if you could upgrade the lowest level of software, the boot loader or system initializer (ppcboot, etc).  We had found a bug in our loader at one point, and because many registers are "write once" it was difficult to fix these settings from the application software.  But finding a foolproof and reliable way to upgrade the boot loader software is difficult, especially if you are relying on customers and operators to do the upgrading.

Darin Johnson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
