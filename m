From: Michael Widenius <monty@monty.pp.sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Oct 1999 22:27:35 +0300 (EEST)
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org,
        mysql@lists.mysql.com
Subject: MySQL at Linux/PPC
In-Reply-To: <Pine.LNX.4.10.9910102158200.793-100000@idd-01.imbc.gr>
References: <v04205500b4268e121b94@[38.26.1.185]>
	<Pine.LNX.4.10.9910102158200.793-100000@idd-01.imbc.gr>
Message-ID: <14342.11583.486814.996737@monty.pp.sci.fi>
Reply-To: monty@tcx.se
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Kostas" == Kostas Gewrgiou <gewrgiou@imbc.gr> writes:

Kostas> After looking at Bug#: 5732 in RedHat's bugzilla, 
Kostas> (http://developer.redhat.com/bugzilla/show_bug.cgi?id=5732)
Kostas> i found out why enabling LFS makes a bad mysql binary, quoting from the
Kostas> description of the patch bug:

Kostas>    The configure scripts of patch-2.5 detect the LFS support in 
Kostas>    glibc-2.1, but due to the lack of a definition of 
Kostas>    _GNU_SOURCE, no prototypes for fseeko are declared. That way 
Kostas>    the compiler thinks fseeko is taking a 32bit argument for 
Kostas>    the offset, when in reality it takes a 64bit offset.

Kostas> After compiling MySQL with -D_GNU_SOURCE (with LFS enabled) the problems
Kostas> went away, i am not sure if defining _LARGEFILE_SOURCE is supposed to give
Kostas> the fseeko declarations but if it is then its a bug in the glibc headers.

Kostas>   Kostas Gewrgiou.

Hi!

MySQL 3.22.27 and MySQL 3.23.4 and above we now detect the glibc
version and will not use LFS if glibc < 2.1

We have successfully compiled MySQL on RedHat 6.0 without having to
patch anything, so it looks like this is now fixed.

If you still get the problem on your machine with the above MySQL
version, please mail me and we will look at it once more!

Regards,
Monty

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
