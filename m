Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Paul Ruhland <pruhland@rochester.rr.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: powerpc cross tools question
Date: Mon, 25 Mar 2002 17:03:13 -0500
References: <668950F487446B4FB0CEAE9760FD2D62124F02@taurus.primary.local>
In-Reply-To: <668950F487446B4FB0CEAE9760FD2D62124F02@taurus.primary.local>
MIME-Version: 1.0
Message-Id: <200203251703.13296.pruhland@rochester.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Keith,

What ppc target are you using?  The docs you referenced may work for ppc with
hardware floating point but definitely not for those without...like mpc860.

I have finally got the cross environment built and working for 860...in fact I
had just got my target booted and running sash when your post came in. :)

I used the penguinppc docs and Wolfgang Denks CDK
( ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz ) for reference.  Mostly
just adapting the denx stuff to the package versions I was using.

I used the following packages:
  binutils-2.12.90.0.1
  gcc-core-2.95.3
  gcc-2.95.3
  glibc-2.2.5
  linux-2.4.4-2001-07-23 ( from ftp://ftp.denx.de )

The denx CDK makefiles and patches require a little modification to work with
these packages.  Specifically, the gcc specs patch, and the floating point
mods in 'Makefile.glibc'.  The specs patch needed a little tweak due to minor
changes in the second hunk, while most of the floating point mods were
already in the glibc-2.2.5 package...I just removed what was already
incorporated.

The only thing I'm not satisfied with at this point is I still need to make a
link on my target file system with the full path to the CDK lib directory as
on my host...

from target filesystem root:
   mkdir -p /home/paulr/linuxppc/CDK
   cd /home/paulr/linuxppc/CDK
   ln -s /lib

The path is hardcoded into 'ld-2.2.5.so'.
This was a 'feature' of HHL 1.2 but fixed in HHL 2.0 ( which is no longer
available from their website ).  I have the 2.0 source disk somewhere and the
required patch to glibc may be in there...or someone who knows what the fix
is may chime in here :)

If you still need help I would be happy to send you my scripts ( yes, I did
the whole thing in bash scripts...as a exercise mostly...would be just as
easy/easier to modify the denx makefiles.

--
Paul Ruhland

On Monday 25 March 2002 02:34 pm, Keith Outwater wrote:
> Greetings all -
> I built the powerpc-linux cross toolset from source using the
> cross-compiling mini-howto on www.penguinppc.org.  I am running x86
> linux (RH 7.2).
>
> I followed the mini-howto to the letter, but I have two problems:
> 1. I must manually edit /usr/local/powerpc-linux/lib/libc.so to change
> the paths from /lib/... to /usr/local/powerpc-linux/lib...
>
> 2. When I compile applications, certain #defines are missing such as
> PATH_MAX.  It appears that /usr/local/powerpc-linux/include is not in
> the compilers default search path (manually adding it allows the
> application to compile successfully).
>
> Has anyone used the mini-howto to build the cross tool chain?  Any
> pointers?
>
> Thanks!
>
> Keith Outwater
> Sr. Staff Engineer
> Microvision, Inc.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
