Date: Wed, 13 Oct 1999 09:19:45 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: linuxppc-dev@lists.linuxppc.org
cc: debian-powerpc@lists.debian.org, mysql@lists.mysql.com
Subject: MySQL at Linux/PPC
In-Reply-To: <v04205500b4268e121b94@[38.26.1.185]>
Message-ID: <Pine.LNX.4.10.9910102158200.793-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




After looking at Bug#: 5732 in RedHat's bugzilla, 
(http://developer.redhat.com/bugzilla/show_bug.cgi?id=5732)
i found out why enabling LFS makes a bad mysql binary, quoting from the
description of the patch bug:

   The configure scripts of patch-2.5 detect the LFS support in 
   glibc-2.1, but due to the lack of a definition of 
   _GNU_SOURCE, no prototypes for fseeko are declared. That way 
   the compiler thinks fseeko is taking a 32bit argument for 
   the offset, when in reality it takes a 64bit offset.

After compiling MySQL with -D_GNU_SOURCE (with LFS enabled) the problems
went away, i am not sure if defining _LARGEFILE_SOURCE is supposed to give
the fseeko declarations but if it is then its a bug in the glibc headers.

  Kostas Gewrgiou.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
