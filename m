Date: Thu, 11 Feb 1999 19:48:31 -0500 (EST)
From: Fred Dushin <fadushin@blackcat.cat.syr.edu>
Reply-To: fadushin@blackcat.cat.syr.edu
To: linuxppc-dev@lists.linuxppc.org
Subject: Adventures with KDE-1.1
Message-ID: <Pine.LNX.4.00.9902111928330.4101-100000@blackcat.cat.syr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



In case anyone is interested...

I downloaded the kde 1.1 tarballs and had a go building.
But first I updated egcs as much as I could off of linuxppc.org.

BTW, is this the place to look for bleeding edge stuff?  Doesn't
look like it, by the dates.

[root@blackcat /downloads]# rpm -qa | grep egcs
egcs-as-gcc-1.1-0a
egcs-c++-1.1-0a
egcs-libstdc++-2.8.0-2b
egcs-1.1-0a
egcs-libstdc++-devel-2.8.0-2b
[root@blackcat /downloads]# rpm -qa | grep glibc
glibc-devel-0.961212-1l
glibc-info-0.961212-1h
glibc-static-0.961212-1l
glibc-0.961212-1l

qt-1.42 built without a hitch.

I started with kde-base, though, and ran into some problems.
The first problem was due to g++'s including string.h; apparently
the definition of strnlen involves an implicit cast to void *,
which ANSI C++ doesn't like (in an optimized version of strnlen).  
Got around that with a hack (what else?)
Turned off HAS_ARGZ in config.h.

Further down, I ran into a mess of problems, mostly around header
files in /opt/egcs/include/g++.  Haven't tracked them down,
but I figured I'd give the list a holler for suggestions
about compilers/libs, etc.

I'm on an ancient installation, going back to pre-DR2, I think,
though I have kept a lot up to date.  2.1.24 on a 7200/75.

Is our compiler out of date?  Or are KDE config scripts mangled?
Or should I get a new machine...?

Thanks,
Fred

--
Fred Dushin                      mailto:fadushin@blackcat.cat.syr.edu
PGP public key available at      http://blackcat.cat.syr.edu/~fadushin/pgp


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
