Subject: Re: loading the kernel and root FS separately from flash?
From: David Woodhouse <dwmw2@infradead.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Wolfgang Denk <wd@denx.de>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.60.0406280642220.4278@localhost.localdomain>
References: <20040628104159.87EEDC109F@atlas.denx.de>
	 <Pine.LNX.4.60.0406280642220.4278@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1088501514.4636.177.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 10:31:55 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-28 at 06:50 -0400, Robert P. J. Day wrote:
> On Mon, 28 Jun 2004, Wolfgang Denk wrote:
>
> > In message <Pine.LNX.4.60.0406280600140.3259@localhost.localdomain> you wrote:
>
> >> that it could be read-only).  how hard would it be to automatically
> >> have that root FS copied from JFFS2 to RAM and mounted from there?
> >
> > This makes just no sense to me.
>
> ok, i'm probably getting confused about something fundamental here.
> what i'm after is to have my root filesystem in persistent storage and
> available for updates on the fly, hence the notion of partitioning off
> a part of the system flash for the JFFS2 version of the root
> filesystem.  i've done that, so i've solved that problem -- i have a
> root filesystem i can mount from a running system and modify.
>
> now, i could just mount that JFFS2 version of the root fs straight out
> of flash, but i get the impression that that would cause a performance
> hit.

Why so? JFFS2 is relatively slow to mount, and obviously _writing_ to
flash can be slow -- but for normal operation it should be fine. Try it.

Personally, I'd just use a JFFS2 root file system for everything. Put
your kernel in it too -- RedBoot and u-boot can load kernels from JFFS2,
and that means you can atomically update the kernel at runtime too,
which you can't do if it's stored in a separate partition (unless you
play with having two partitions for it and teach the bootloader to work
out which one is valid).

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
