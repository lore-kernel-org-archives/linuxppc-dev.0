Message-Id: <199907191808.OAA14312@hoover.gilbarco.com>
From: "Ringeman, Tim" <tim_ringeman@gilbarco.com>
Subject: Problem with compiling and linking separately
Date: Mon, 19 Jul 1999 14:07:34 -0400
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am running the embedded-2.2.5 kernel on a MBX860 board and using
http://members.home.net/mmporter/binutils-powerpc-linux-2.9.1.0.15-2.i386.rp
m
http://members.home.net/mmporter/egcs-powerpc-linux-1.1.1-2.i386.rpm
ftp://sourceware.cygnus.com/pub/glibc/glibc-2.1.tar.gz
ftp://sourceware.cygnus.com/pub/glibc/glibc-linuxthreads-2.1.tar.gz
ftp://ftp.funet.fi/pub/gnu/funet/glibc-crypt-2.1.tar.gz

When I try to compile and link seperately I get the following errors:

[root@ngdtst06 bin]# powerpc-linux-gcc -c hello.c

[root@ngdtst06 bin]# powerpc-linux-ld hello.o
powerpc-linux-ld: warning: cannot find entry symbol _start; defaulting to
01800074
hello.o: In function `main':
hello.o(.text+0x20): undefined reference to `printf'

[root@ngdtst06 bin]# powerpc-linux-ld hello.o -lc
powerpc-linux-ld: warning: cannot find entry symbol _start; defaulting to
01800188

[root@ngdtst06 bin]# powerpc-linux-ld hello.o -lc -static
powerpc-linux-ld: warning: cannot find entry symbol _start; defaulting to
01800188

When I link against the shared libraries as such: 
[root@ngdtst06 bin]# powerpc-linux-ld hello.o -lc -shared
it links but when I try to run it on the board, it hangs.

Any idea how I could get this to work?

Thanks,
Tim

Tim Ringeman
Gilbarco Inc.
Telephone 336-547-5946
e-mail: tim_ringeman@gilbarco.com
http://www.gilbarco.com





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
