Message-ID: <004b01c290df$3b4e7720$0280a8c0@emil>
Reply-To: "Tord Andersson" <tordson@algonet.se>
From: "Tord Andersson" <tordson@algonet.se>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Cross compiling pppd 2.4.1 with ELDK 2.0
Date: Wed, 20 Nov 2002 22:53:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am currently trying to crosscompile pppd with the ELDK 2.0 toolchain.
To build in a native Intel RedHat 7.2 environment was no problem.
However, when trying to crosscompile it seems that there are more things than CC and the PATH to be altered. By changing the include file search path, I was able to build chat, but pppd seems to be a little harder. Is there anyone out there that might have some clues?

Kind regards,

Tord

Some results:
[root@ronja ppp-2.4.1]# printenv | grep PATH
PATH=/opt/eldk/usr/bin:/opt/eldk/bin:/usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin
:/home/root/bin
[root@ronja ppp-2.4.1]# export CC=ppc_8xx-gcc
[root@ronja ppp-2.4.1]# make
cd chat; make  all
make[1]: Entering directory `/home/tord/proj/StarSafe/pppd/ppp-2.4.1/chat'
ppc_8xx-gcc -c -O2 -g -pipe -DTERMIOS                    -DSIGTYPE=void
         -UNO_SLEEP                      -DFNDELAY=O_NDELAY              -o chat
.o chat.c
In file included from /opt/eldk/usr/../ppc_8xx/usr/include/signal.h:307,
                 from chat.c:97:
/opt/eldk/usr/../ppc_8xx/usr/include/bits/sigcontext.h:28: asm/sigcontext.h: No
such file or directory
In file included from /opt/eldk/usr/../ppc_8xx/usr/include/errno.h:36,
                 from chat.c:98:
/opt/eldk/usr/../ppc_8xx/usr/include/bits/errno.h:25: linux/errno.h: No such fil
e or directory
In file included from chat.c:97:
/opt/eldk/usr/../ppc_8xx/usr/include/signal.h:310: warning: `struct sigcontext'
declared inside parameter list
/opt/eldk/usr/../ppc_8xx/usr/include/signal.h:310: warning: its scope is only th
is definition or declaration, which is probably not what you want.
chat.c: In function `write_char':
chat.c:1257: `EINTR' undeclared (first use in this function)
chat.c:1257: (Each undeclared identifier is reported only once
chat.c:1257: for each function it appears in.)
chat.c:1257: `EWOULDBLOCK' undeclared (first use in this function)
make[1]: *** [chat.o] Error 1
make[1]: Leaving directory `/home/tord/proj/star/pppd/ppp-2.4.1/chat'
make: *** [all] Error 2
[root@ronja ppp-2.4.1]#


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
