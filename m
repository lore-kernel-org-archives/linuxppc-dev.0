To: Julien Eyries <julien.eyries@thales-bm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: some question on root filesystems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 28 Mar 2002 14:15:46 +0100."
             <3CA31782.8020301@thales-bm.com>
Date: Thu, 28 Mar 2002 18:31:32 +0100
Message-Id: <20020328173137.883F111246@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CA31782.8020301@thales-bm.com> you wrote:
>
> here is my situation : i first intented to use NFS as the root
> filesystem for our embedded MPC8260 linux but they may be some
> hardware design error which stop us to use the intel LXT971A
> ethernet controller we have on our custom board.

How about fixing the problem? Network is something  which  is  REALLY
nice to have...

> therefore, i have removed all the network interface in our kernel, and i
> try now to use the flash memory (4MB) we have. my question is : what
> kind of filesystem is typically used in this case : initrd, cramfs, romfs ?

Yeas, any of these. And/or MTD + JFFS/JFFS2...

> it seems to me that initrd is a little bit different in the way the
> kernel boot over it than the other fs (using /linuxrc , pivot_root and
> so on ...), why ?

Forget about /linuxrc or pivot_root; these are not  needed  for  what
you are going to do.

See our "Simple Embedded Linux Framework" at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/ for a start

> and for the cramfs and romfs filesystem, how does the sytem "guess" the
> memory range where your filesystem lives in ?

It doesn't guess, you have to tell it.

> can you give me some feedback on the choice you may have made ??

The choice depends on the project requirements.

A compressed initrd image is a frequently  used  solution  that  fits
many needs; in some cases cramfs may be more appropriate; if you need
a writable filesystem (for persistent storage of some data) MTD+JFFS2
is quite useful...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A meeting is an event at which the minutes are kept and the hours are
lost.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
