From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gareth Hughes <gareth@valinux.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, <linux-fbdev@vuser.vu.union.edu>
Subject: Re: r128 DRI driver now fully functional on PPC
Date: Wed, 31 Jan 2001 12:49:49 +0100
Message-Id: <19341226052133.13170@mailhost.mipsys.com>
In-Reply-To: <3A76769B.87242FAA@valinux.com>
References: <3A76769B.87242FAA@valinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I've just committed the last of the updates required to get full hardware
>accelerated 3D rendering with the ATI Rage 128 on PowerPC.  Many thanks
>to Paul
>Mackerras for allowing me to hack away on his machine over the last week!
>
>The code is available on the ati-pcigart-0-0-1-branch in the DRI CVS
>repository.  Please feel free to check it out and report any problems you
>have.

I've done a first try and encountered a show-stopper (on this machine).
The machine is a PowerBook G3 with a r128 M3 (mobility), 8Mb video mem.
The issues are:

 - DRI support works only in 16 and 24/32 bits. However, 16 bits is
broken with UseFBDev and I can't use it without fbdev (see below). The
colors are screwed up (but the server works. I didn't yet try 3D since I
have not yet compiled a GL app to test with). 15 bits works fine with the
kernel driver but it's unuspported for DRI.
I beleive the aty128fb kernel driver need to be fixed for 16 bits.

 - I can't use 32 bits (it needs 9.4Mb of VRAM, I have only 8)

 - If I try to use the r128 driver without UseFBDev, the ATI chip locks
up (the LCD loose sync, the machine is hard locked up). This used to work
with earlier 4.0.1 servers, we need to figure out what changed. That
match what other people already noticed.

I'll do some tests with the broken 16 bits mode to see if I get 3D
working properly. I'll then see if I can figure out what cause the chip
to lockup without UseFBDev.

Except for those (minor hopefully) issues, its a nice work ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
