Message-Id: <200007311629.LAA29846@jen.americas.sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Thomas Graichen <graichen@innominate.de>, thomas.graichen@innominate.de,
        linuxppc-dev@lists.linuxppc.org, linux-xfs@oss.sgi.com
Subject: Re: SGI XFS on ppc 
In-Reply-To: Message from Geert Uytterhoeven <geert@linux-m68k.org>
   of "Mon, 31 Jul 2000 13:59:57 +0200." <Pine.LNX.4.10.10007311357070.442-100000@cassiopeia.home>
Mime-Version: 1.0
Date: Mon, 31 Jul 2000 11:29:36 -0500
From: Steve Lord <lord@sgi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On 31 Jul 2000, Thomas Graichen wrote:
> > * how to test the xfs filesystem without the tools? - i just made
> >   a small 32mb xfs filesystem on an x86 and dd'ed to a file which
> >   you can easily dd onto any partition and mount it as xfs fs there
> >   (verified to work on x86)
> > * trying to mount the dd'ed filesystem just hangs the machine - no
> >   output so far (xfs is compiled with debug and vnode tracing and
> >   syslog will give *.* to the console) ...
> =

> Is XFS now always big endian (as we discussed about at Linux-Kongre=DF =
1999),
> or is it still native endian, so you cannot use an x86 image on big end=
ian
> machines?
> =

> Gr{oetje,eeting}s,
> =

> 						Geert
> =



XFS is now always bigendian - it should be possible to move a disk image
between systems. =


As for debugging this hang - it is a little tricky without something like=

kdb. Getting a stack trace for the mount process would be critical to wor=
king
out what went wrong. I suspect some read of a block from disk did not wak=
e
up the requesting thread. There is tracing in the pagebuf module, but it
relied on kdb to dump the results, mapping these trace calls onto printk
messages, or some other mechanism may help.

Steve


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
