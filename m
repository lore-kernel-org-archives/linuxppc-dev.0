Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Re: Re: which is the best root File system in embed linux
	system?
From: David Woodhouse <dwmw2@infradead.org>
To: Wolfgang Denk <wd@denx.de>
Cc: jeffy <leo_guo@jisung.cn>,
	"linuxppc-embedded@lists.linuxppc" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040422093955.1D74BC109F@atlas.denx.de>
References: <20040422093955.1D74BC109F@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1083483737.32758.146.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Sun, 02 May 2004 08:42:17 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-04-22 at 11:39 +0200, Wolfgang Denk wrote:
> You asked adbout a filesystem for flash before - this is NOT the same
> as DOC or  even  CompacfFlash,  as  these  devices  use  an  internal
> controller  which  may  perfom certain operations like wear levelling
> etc. So what do you want  to  know  -  filesystems  for  plain  flash
> memory, or for DOC?

Er, no. The DiskOnChip 2000 does not have an internal controller like
that. Its ASIC is basically just a FIFO and some hardware ECC support.
The host system gets access directly to the NAND flash, and we can do
what we like with it. That includes using JFFS2/NAND on it.

Normally, however, people use the same 'Translation Layer' as is used
under DOS (presumably because it's easier to provide an INT 13h handler
under DOS than to provide a proper file system). This is a kind of
pseudo-filesystem which operates directly on the NAND flash and pretends
to be a block device. You then put a 'normal' file system on top of
that. (I've ranted about how pointless and stupid and inefficient this
gratuitous extra layer is before; I can't be bothered to repeat myself
here.)

Don't use JFFS2 on the existing DiskOnChip hardware driver; in MTD CVS
there's a new DiskOnChip driver which uses the generic NAND code,
although I haven't yet done the hardware ECC support (we use software
ecc) or the support for their bad block table (we use the standard
layout instead). Those things are easy enough to fix up if you want to,
but I just haven't got round to it yet. I've had it working with DMA on
systems with a sufficiently versatile DMA engine too.

The DiskOnModule has a more complicated controller and is as you
suggest; likewise the DiskOnKey. Those are like CompactFlash and what
you say is true there. Using ext3, the inefficiency
journalling-on-journalling is just the same as with ext3 on a
translation layer implemented on the host system -- it's just that you
get to think about it a little less so it _may_ offend you less.

> The ext2 filesystem is extremley well tested and can be considered to
> be very stable. Howebver, it was not designed to  be  used  like  you
> attempt  to  do - i. e. just powering off the device. You must always
> unmount an ext2 filesystem  (or  at  least  remount  it  read-only_)_
> before shutting doen the system.

The failure mode described seemed a little worse than one might
reasonably expect from ext2 alone. It could be the result of a bug in
our NFTL 'translation layer' code, which really should be capable of
retaining its state over power failure and treating 512-byte sector
writes as 'atomic' by means of its own internal journalling.

More details would be useful.

> > In any time when the linux is starting, you turn off the power,
> > maybe the root file system will crash!
>
> Yes, this is the logical consequence of your mis-use.

For many classes of embedded system I don't consider unannounced power
failure to be 'mis-use'. That's why we run powerfail tests on JFFS2 and
that's why it can even cope with the bizarre things which happen if you
power off a flash chip in the middle of an erase while bits _appear_ to
be erased but are in fact going to suddenly change state when you write
to the other bits near them.

If you can get JFFS2 to confuse itself on power failure, even if you're
doing it by automatically cycling power every five minutes while running
file system stress tests, I'd like to know about it. Assuming you're
using the current JFFS2 code, that is.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
