Message-ID: <394DFFEF.162E7785@agelectronics.co.uk>
Date: Mon, 19 Jun 2000 12:11:43 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: th@visuelle-maschinen.de
CC: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CTFB 0.30 now availiable (CT65554...CT69000)
References: <Pine.LNX.4.05.10006161312290.5039-100000@callisto.of.borg> <00061912275000.10856@iris>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thomas Hhenleitner wrote:
>
> The driver works now quite well with my hw.
>
> Check the ctfb_README for limits and features.
>
> What about a merge with the old chipsfb.o?

I'm working on my 69030 driver as a separate driver currently, because
of the requirement to use memory mapped IO and avoid all fixed IO
addresses, which makes it incompatible with the 65550. I did look at
your driver, but I decided to base mine on the existing chipsfb.c
because I needed PowerPC support, and because the coding style of your
driver was quite different to existing frame buffer drivers.

My priorities are:
1) Not assume any BIOS setup, as BIOS setup only occurs on x86 hosts,
and only on the primary display.
2) Avoid use of the big-endian region in the chip, while still
supporting big-endian hosts. This is necessary to support the
twin-pipeline mode of the 69030 in future.
3) Support multiple displays. This requires use of memory mapping.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
