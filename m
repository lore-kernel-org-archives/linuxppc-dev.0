Mime-Version: 1.0
Message-Id: <v04220801b513d68f9145@[192.168.0.2]>
Date: Fri, 7 Apr 2000 20:50:48 +0200
To: linuxppc-dev@lists.linuxppc.org
From: "Michael A. Peters" <mpeters@mac.com>
Subject: Building X 3.3.6 (non-distributor environment)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm running the Linux From Scratch project
(http://www.linuxfromscratch.org) and its all working swell except X
won't build.

When I unpack X3.3.6 and try "make World" it very quickly quits with
an error from gcc. Funny thing is, the build *does* complete under
LinuxPPC (gcc 2.95.2, glibc 2.1.3 if it matters) from the same source.

Everything on the LFS system was compiled from source, first the
basics were compiled statically under LinuxPPC and then LFS was
booted, rebuilding everything shared and (of course) then building
the rest of the system. Other than not being able to build X
everything works well and properly.

Both systems boot off of the same kernel (2.2.14)

I looked at the environmental variable from both systems, no major
differences (I'm running bash 2.0.4 under LFS, 2.0.3 under LinuxPPC).
I looked at the end of /usr/lib/gcc-lib/<host>/2.95.2/specs on both
systems (looking for differences in the *cpp_os_linux predefines) and
there is no differences, at least not towards the end of the specs
file.

What seems to be happening is that make World under the LFS system is
passing instructions to the compiler that gcc doesn't like- the error
message when it quits:

gcc: cannot specify -o with -c or -S and multiple compilations
make[2]: *** [imake.o] Error 1
make[2]: Leaving directory `/usr/src/xc/config/imake'
make[1]: *** [imake.bootstrap] Error 2
make[1]: Leaving directory `/usr/src/xc'
make: *** [World] Error 2

Opinion among people who have used the LFS howto on x86 and also
built X on other platforms is that my problem is that the make World
script doesn't know my compiler is gcc. Yes, I do have cc symlinked
to gcc

I've even tried make CC=gcc World with same result.

However, under LinuxPPC it compiles no problem.

Any of you know what the problem is (if its something else) or how to
set up the non-distribution linux so that it DOES know the compiler
is gcc?

Sorry for the lengthy post, and thanks for your time!



-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Michael A. Peters                  http://216.22.163.20/
Linux Pages (new)                  http://216.22.163.20/Linux_Pages/
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
