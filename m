Message-Id: <200010240543.HAA00666@piglet.grunz.lu>
Date: Tue, 24 Oct 2000 07:42:59 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: More Makefile Questions...
To: mnorton@cisco.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200010231922.MAA20122@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  23 Oct, this message from Michael Norton echoed through cyberspace:
> [mnorton@b9 console]#make
> gcc     -I/usr/X11R6/include -I/usr/X11R6/include/GL     glConsole.o /usr/lib/libglut.so.3.7.0 -L/usr/X11R6/lib -L/usr/local/lib -lXext -lX11    -o      gameCon
> /usr/bin/ld: cannot find -lXext
> collect2: ld returned 1 exit status
> make: *** [gameCon] Error 1
>
> Now for my libraries, for instance -lXext:
> [mnorton@b9 glheretic-1.1]#ls /usr/X11R6/lib/*ext*
> /usr/X11R6/lib/libXext.so.6  /usr/X11R6/lib/libXext.so.6.3

You're missing the static lib (libXext.a) and the libXext.so symlink.
Here is what I have:
[mlan@piglet ~]$ ll /usr/X11R6/lib/*ext*
-rw-r--r--   1 root root   92144 Jul 22 02:27 /usr/X11R6/lib/libXext.a
lrwxrwxrwx   1 root root      14 Jun  1 10:53 /usr/X11R6/lib/libXext.so -> libXext.so.6.4
lrwxrwxrwx   1 root root      14 Jun  1 10:53 /usr/X11R6/lib/libXext.so.6 -> libXext.so.6.4
-rwxr-xr-x   1 root root   69916 Jul 22 02:30 /usr/X11R6/lib/libXext.so.6.4

To recreate the missing link, make sure all directories where you have
libraries are listed in /etc/ld.so.conf, and then run ldconfig as root.
For the static lib, you'll have to reinstall X (the XFree86-devel RPM).

> I experienced similar problems trying to link Mesa libs:
> [mnorton@b9 console]#make
> gcc     -I/usr/X11R6/include -I/usr/X11R6/include/GL    glConsole.o /usr/lib/libglut.so.3.7.0 -L/usr/X11R6/lib -L/usr/local/lib    -lMesaGLU -lMesaGL -lm -lXmu -lX11 -lXext -lXi -lXt   -o   gameCon
> /usr/bin/ld: cannot find -lMesaGLU
> collect2: ld returned 1 exit status
> make: *** [gameCon] Error 1
>
> I do have these libraries installed for Mesa:
> [mnorton@b9 lib]#ls /usr/lib/*GL*
> /usr/lib/libGL.a     /usr/lib/libGL.so.1.2.030100  /usr/lib/libGLU.so.1
> /usr/lib/libGL.so    /usr/lib/libGLU.a             /usr/lib/libGLU.so.1.2.030100
> /usr/lib/libGL.so.1  /usr/lib/libGLU.so            /usr/lib/libMesaGLw.a

Something's fishy here too: you're telling ld to look for the MesaGLU
library, which will (according to the convention), be called
libMesaGLU.so (shared lib) or libMesaGLU.a (static library). Both are
missing. The same is true for -lMesaGL: neither static nor shared is
present. I suppose (but I could be wrong) that your program should be
looking for libGL and libGLU.


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
