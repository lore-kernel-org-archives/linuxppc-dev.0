Date: Sun, 18 Jan 2004 13:17:54 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Debian PowerPC List <debian-powerpc@lists.debian.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.21-ben2 issues: RTC, Thermal and RTAS
Message-ID: <20040118121754.GA4916@iliana>
References: <20031217011849.GA26643@iliana> <Pine.GSO.4.58.0312171042530.24864@waterleaf.sonytel.be> <20031217095241.GD2283@iliana> <Pine.GSO.4.58.0312171056030.24864@waterleaf.sonytel.be> <20031217100358.GA2655@iliana> <Pine.GSO.4.58.0312171112040.24864@waterleaf.sonytel.be> <20040113151230.GA12089@iliana> <Pine.GSO.4.58.0401131806560.9060@waterleaf.sonytel.be> <20040113171606.GA13923@iliana> <Pine.GSO.4.58.0401181310240.2808@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.GSO.4.58.0401181310240.2808@waterleaf.sonytel.be>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 18, 2004 at 01:14:07PM +0100, Geert Uytterhoeven wrote:
> On Tue, 13 Jan 2004, Sven Luther wrote:
> > On Tue, Jan 13, 2004 at 06:09:38PM +0100, Geert Uytterhoeven wrote:
> > > On Tue, 13 Jan 2004, Sven Luther wrote:
> > > > On Wed, Dec 17, 2003 at 11:13:58AM +0100, Geert Uytterhoeven wrote:
> > > > > On Wed, 17 Dec 2003, Sven Luther wrote:
> > > > > > On Wed, Dec 17, 2003 at 10:57:07AM +0100, Geert Uytterhoeven wrote:
> > > > > > > It uses the PC-style RTC driver (genrtc.o is not loaded).
> > > > > >
> > > > > > Mmm, what was your box again ? a chrp no ?
> > > > >
> > > > > Yep, CHRP LongTrail. It has a Winbond/Symphony Labs W83C553 SouthBridge.
> > > >
> > > > Could you tell me the content of your rtc OF node ? In particular i am
> > > > interested in the reg value (probably 70/71 in isa space or so), and of
> > > > the compatible stuff (i have ds1385-rtc).
> > >
> > > /proc/device-tree/pci/isa@1/rtc/ has:
> > >
> > > total 0
> > > -r--r--r--    1 root     root           11 Jan 13 18:06 compatible
> > > -r--r--r--    1 root     root            4 Jan 13 18:06 device_type
> > > -r--r--r--    1 root     root            4 Jan 13 18:06 linux,phandle
> > > -r--r--r--    1 root     root            4 Jan 13 18:06 name
> > > -r--r--r--    1 root     root           12 Jan 13 18:06 reg
> > >
> > > compatible:	pnpPNP,b00			(ASCII)
> > > device_type:	rtc				(ASCII)
> > > linux,phandle:	ff86 2aa4			(hexdump)
> > > name:		rtc				(ASCII)
> > > reg:		0000 0001 0000 0070 0000 0002	(hexdump)
> >
> > Ok. So, this is almost the same as me, except i have a ds1385-rtc
> > compatible version, and some interrupt stuff.
> >
> > Can you confirm that the GEN_RTC driver works for you ?
>
> To my surprise, genrtc in 2.4.23 does not work on my LongTrail!
> The kernel crashes in init/do_mounts.c:mount_block_root() right after the call
> to sys_chdir(), because current->fs is a NULL pointer. Weird, and it doesn't
> really look genrtc-related, although the same source tree works fine if I
> disable genrtc and build in rtc.

Weird, it works fine for me, what tree are you using ?

I think i remember some part of patch concerning the rtc clock or
something in the linuxppc diff. Could you try 2.4.24 ?

> I also tried 2.6.0, and there it works fine, both in the builtin and modular
> case: the kernel got the correct time, and hwclock works.

Ok.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
