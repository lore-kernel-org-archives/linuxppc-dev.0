Date: Sun, 6 Dec 1998 19:18:18 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Elgin Lee <ehl@funghi.com>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux? 
In-Reply-To: <199812060154.RAA01357@porcini.funghi.com>
Message-ID: <Pine.LNX.3.96.981206190751.2542E-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 5 Dec 1998, Elgin Lee wrote:

> Recent (non-official) MkLinux kernels support /dev/adbmouse (busmouse

I wouldn't call them non-official... they're just non-Apple.  They're at
least somewhat sanctioned.  :-)


<snip>

> >   1. Add frame buffer devices to MkLinux. This requires many kernel
> >      changes to MkLinux and forces people to upgrade their kernel.

This would be a better long-term solution, though I would find it more
palatable to add an FB-style interface to the existing drivers, adding
whatever additional functionality is necessary rather than dumping the
existing drivers (since switching to the LinuxPPC drivers would probably
mean dropping x100 support, or else rewriting those drivers from scratch). 
Note that this is a couple of notches down in priority for me (as far as
my time goes), but anyone else interested in working on it can feel free.


> >   2. Adopt XF68_FBdev so it can use the MkLinux video mode ioctl stuff.

vmode ioctl stuff?  Since when does MkLinux support detecting or changing
video modes?  This is where we're going to run into trouble either way.
This particular support code needs to be written.  In the process, it
would be logical to make it support both a framebuffer interface and the
traditional interface for compatibility with older vmlinux servers.

> >      This requires no kernel changes. In XF68_FBDev, the video ioctl
> >      and mmap stuff has to be changed slightly.

And the mach kernel has to have a small amount of code added to map that
physical space into the vmlinux server's address space, I believe, or
probably more like additional code in the vmlinux server to request it....
I'm not sure where the line is drawn... I'm still learning the
Mach/vmlinux io mapping stuff, the hard way... by coding something and
then poking around to see why it doesn't work.  :-)

Personally, I don't have any problem with requiring people to upgrade
their kernel for enhanced performance, though adding traditional ioctl
support for people who don't want to upgrade would be a nice touch.  With
the amount of kernel development happening right now, and the number of
bugs being fixed, people would be well advised to try to stay current if
they're using MkLinux anyway.  ;-)


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624

-----BEGIN GEEK CODE BLOCK-----
Version 3.1
GCS/CC/FA/H/L/MC/M/MU/PA/TW d-@ s:>- a-- C++ ++>$ UBLAS*++ ++>$
P+?>$ L++ +>$ !E--- W++ +>$ N++(++ +)>++ +$ !o? K-? !w--- !O
M++>$ !V-- PS+>$ !PE- Y+>$ PGP+>$ t++ +>$ 5+>++ ++$ !X- !R tv+>$
b++>$ !DI !D- G++(++ +)>$ e>++ ++ h--! r--- !y-
------END GEEK CODE BLOCK------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
