From: Michael Norton <mnorton@cisco.com>
Message-Id: <200010231922.MAA20122@cisco.com>
Subject: More Makefile Questions...
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 23 Oct 2000 12:22:25 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

I am still have problems with my linker. When I compile I see the  following problem:

[mnorton@b9 console]#make
gcc     -I/usr/X11R6/include -I/usr/X11R6/include/GL     glConsole.o /usr/lib/libglut.so.3.7.0 -L/usr/X11R6/lib -L/usr/local/lib -lXext -lX11    -o      gameCon
/usr/bin/ld: cannot find -lXext
collect2: ld returned 1 exit status
make: *** [gameCon] Error 1

Apparently I am experiencing difficulty with my lib path. Here is my Makefile:

C = gcc
CFLAGS = -g
INCLUDE = -I/usr/X11R6/include -I/usr/X11R6/include/GL

GLUT = /usr/lib/libglut.so.3.7.0

LIBPATH = -L/usr/X11R6/lib -L/usr/local/lib

#LDLIBS = -lMesaGLU -lMesaGL -lm -lXmu -lX11 -lXext -lXi -lXt
LDLIBS = -lXext -lX11

PROG = gameCon
SRCS = glConsole.c
OBJS = $(SRCS:.c=.o)

$(PROG) : $(OBJS)
	$(CC)	$(INCLUDE)	 $(OBJS) $(GLUT) $(LIBPATH)	$(LDLIBS)	-o	$(PROG)

Now for my libraries, for instance -lXext:
[mnorton@b9 glheretic-1.1]#ls /usr/X11R6/lib/*ext*
/usr/X11R6/lib/libXext.so.6  /usr/X11R6/lib/libXext.so.6.3


I experienced similar problems trying to link Mesa libs:
[mnorton@b9 console]#make
gcc     -I/usr/X11R6/include -I/usr/X11R6/include/GL    glConsole.o /usr/lib/libglut.so.3.7.0 -L/usr/X11R6/lib -L/usr/local/lib    -lMesaGLU -lMesaGL -lm -lXmu -lX11 -lXext -lXi -lXt   -o   gameCon
/usr/bin/ld: cannot find -lMesaGLU
collect2: ld returned 1 exit status
make: *** [gameCon] Error 1

I do have these libraries installed for Mesa:
[mnorton@b9 lib]#ls /usr/lib/*GL*
/usr/lib/libGL.a     /usr/lib/libGL.so.1.2.030100  /usr/lib/libGLU.so.1
/usr/lib/libGL.so    /usr/lib/libGLU.a             /usr/lib/libGLU.so.1.2.030100
/usr/lib/libGL.so.1  /usr/lib/libGLU.so            /usr/lib/libMesaGLw.a


Any ideas?

thanks,

Mike


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
