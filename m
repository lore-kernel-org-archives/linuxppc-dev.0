Message-ID: <3C0AA2AF.97E7FCB4@wanadoo.fr>
Date: Sun, 02 Dec 2001 22:11:09 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: paulus@samba.org
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
References: <20011127143058.R13091@cpe-24-221-152-185.az.sprintbbd.net>
		<3C08CFF0.18A1FBC7@wanadoo.fr> <15369.65261.546405.15780@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> Martin Costabel writes:
>
> > For the valkyriefb driver on my Pmac 6400, I can confirm from a first
> > short test that it still works. This is with your patch applied to
> > today's 2.4.17-pre1-ben0 kernel.
>
> Do you still have macos on the 6400?  If so can you confirm whether,

Yes, I still have MacOS 8.6. No 9.x, though.

> if you set the screen resolution and colour depth in macos, that the
> value you have set in macos is the default that linux will use?

I did some tests with the 2 useful modes of the 6400: 1024x768x8bit at
72Hz (vmode 15, cmode 8) and 800x600x16bit at 60Hz (vmode 10, cmode 16).

The results, with or without Tom's patch, were the same as they always
were:
The vmode of MacOS is used by the Linux console; the cmode 16 is not
recognized, so instead of vmode 10 16 one always gets vmode 10 8 as
default. The log says

kernel: Monitor sense value = 0x62b, <6>using video mode 10 and color
mode 0

I think I never saw this differently. For 16bit color, I always had to
either put video=valkyriefb:vmode:10,cmode:16 into the kernel args or
say vmode 10 16 at the console (and then startx -- -depth 15 to get the
right colors in X; -depth 16 gives weird colors).

P.S. Rebooting into MacOS (first time for almost a year) seems to have
cured the crashes I had yesterday, too. Weird.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
