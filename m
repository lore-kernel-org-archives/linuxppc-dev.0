Message-ID: <396ED231.3C3AA5B5@wtal.de>
Date: Fri, 14 Jul 2000 10:41:21 +0200
From: Christof Petig <christof.petig@wtal.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, Chris Backas <cbackas@rcn.com>
Subject: Re: iBook woes
References: <200007140459.XAA07142@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Chris,

> Date: Thu, 13 Jul 2000 01:32:24 -0400 (EDT)
> From: "Chris Backas" <cbackas@rcn.com>
> Subject: iBook woes
>
> Hello all,
>
> I'm having sound & video trouble with my iBook.. before I start, here's the machine's info:
>
> Original iBook, 160MB RAM, modified with a 12GB HD, and it has an AirPort card.  I have a working tri-boot setup with MacOS 9.0.4, Mac OS X DP4, and Yellow Dog Linux
> Champion Server 1.2.  I'm using yaBoot to boot the machine (BootX causes it to lockup instantly, and often it simply turns off when I try to use BootX) and as on now, Kernel
> is 2.2.17pre10-ben1

I'm using a 64MB iBook (192MB RAM, 6GB HD) without an AirPort card. And I'm facing different troubles:

> First, the video trouble.  Using the version of XFree that came with YellowDog, X runs in 800x600x8, which is very ugly.  After about 15-30minutes of using X, the screen
> would polarize and the computer would lock up hard (dead to pings etc).  So, I decided to upgrade to XFree 4, because that was listed as a solution for iMac trouble on
> Yellow Dog's page.  I installed XFree 4, and although the lockups are now gone, I have a new (odd) problem.  The left 1/4inch of the image is displayed on the right
> 1/4inch of the screen =)  (Slightly raised up too)  There's no overlap, the entire screen is shifted to the left like this, and I'm still not able to get anything better than 8bit color.
> In XFree's messages, I can see a message indicating that it thinks the video card has 468K of RAM.

This sounds like it is still using offb (atyfb reports 4MB for me, offb 800x600 bytes ;-).
The screen move is due to a wrong base address calculation in XFree, I heard some rumors it was fixed in more recent XFree drivers (maybe even in 4.0.1).

Looks strange. What about video=ofonly? Does this work for you. IMHO a stable video system is better than a fast video system.

You might even give SuSE's beta XFree:
-----
XFree86 Version 3.3.5 / X Window System
(protocol Version 11, revision 0, vendor release 6300)
Release Date: August 23 1999
        If the server is older than 6-12 months, or if your card is newer
        than the above date, look for a newer version before reporting
        problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.14pre9SuSE ppc [ELF] SuSE
Configured drivers:
   FBDev: Server for frame buffer device
   (Patchlevel 10): mfb, afb, cfb8, cfb16, cfb32, NCR 77C32BLT (accel), ATI Mach
(using VT number 7)
---
a try. It does it's work here for three months and has never crashed my machine (8h/day use). Though with 16/32bpp the server restarts once the screensaver activates.

> There's a few other minor troubles (mainly with making MacOS not unbless my yaboot partition...) but these two ar e the big ones =)  Any help is appreciated.

Try changing the type (delete, recreate via 'C', worked for me) to Apple_Bootstrap. After this it booted well (for me), before this I saw the MacOS logo again. What about Open Firmware (see
my recent communication with Ben H., he has good points on this)

   Christof

PS: You may not be able to reach me within the next three weeks, I'm leaving for holiday 18:00 CEST.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
