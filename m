Message-ID: <3A7858DD.F61F1506@iiic.ethz.ch>
Date: Wed, 31 Jan 2001 19:26:37 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: r128 DRI driver now fully functional on PPC
References: <3A76769B.87242FAA@valinux.com> <19341226052133.13170@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

>  - DRI support works only in 16 and 24/32 bits. However, 16 bits is
> broken with UseFBDev and I can't use it without fbdev (see below). The
> colors are screwed up (but the server works. I didn't yet try 3D since I
> have not yet compiled a GL app to test with). 15 bits works fine with the
> kernel driver but it's unuspported for DRI.
> I beleive the aty128fb kernel driver need to be fixed for 16 bits.

Indeed. (More on that in another post from me) But even if it was fixed, I'm
afraid the DRI won't work with UseFBDev - it messed up the display (even more
;) when I tried. Some strange interaction between aty128fb and DRI I guess.


>  - If I try to use the r128 driver without UseFBDev, the ATI chip locks
> up (the LCD loose sync, the machine is hard locked up). This used to work
> with earlier 4.0.1 servers, we need to figure out what changed. That
> match what other people already noticed.

The server works for me without UseFBDev but with Option "ProgramFPRegs" "No".

We need to look at the changes to the flat panel code shortly before 4.0.2 .


Beware that I have other problems with my Pismo; windowed GL apps lock up
sooner rather than later. Fullscreen stuff works great. Even Intel users with
Mobility chips reported such problems on the Xpert list; I'm curious how it
fares on desktop machines.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
