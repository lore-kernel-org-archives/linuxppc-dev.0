Message-ID: <38250E46.DC6F9625@mirapoint.com>
Date: Sat, 06 Nov 1999 21:29:42 -0800
From: Jim Hickstein <jxh@mirapoint.com>
MIME-Version: 1.0
To: "Derrik Walker v2.0" <firebug@apk.net>
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: Physical disk size 65536 blocks for an 8G drive
References: <Pine.LNX.4.10.9911061719150.17987-100000@zzzt.apk.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I have a PBG3 Wallstreet and recently bought a new 8GB drive to put in
> > it, an IBM DYLA-28100.  MacOS 8.6, update the drivers, so far, so good.
> > I managed to get pdisk to make partitions (after umounting /mnt/cdrom
> > from /dev/hda to silence a warning in writing the partition table).
> > MacOS runs fine, with volumes in hda10 (5GB hfs+) and hda11 (600MB hfs),
> > _above_ Linux.  But Linux barfs mounting / on /dev/hda7 (and even worse
> > for /usr on /hda9), saying that the superblock reports a size of
> > so-and-so (~131000 for /) but the _physical size of the disk_ is 65536 blocks.
> >
> > Evidently something is reporting a block count of 0xffff, and it's
> > getting incremented to tell me the "length".  Yet, the drive probes
> > correctly (apparently) and reports a size of 7145MB or so.

Nevermind.  Someone told me about "cat /proc/partitions", which revealed
that 65536 _blocks_ (1K) was in fact the correct size of /dev/hda7, and
the ~900000-block size in the superblock was the wrong part.

I tried it all again, this time with no Jaz cart, and I told it to check
for bad blocks (not sure I had the patience for this last time), and for
some reason it worked.  I'm running it now.  Bizarre.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
