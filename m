Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011708b4ec4b0ae554@[129.116.196.236]>
Date: Wed, 8 Mar 2000 12:59:29 -0600
To: linuxppc-dev@lists.linuxppc.org
From: Greg Allen <gallen@arlut.utexas.edu>
Subject: AltiVec on Linux
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


So I've been playing with Motorola's new "AltiVec" compiler, and here are
some observataions I thought I might share:

It's not a "Linux" compiler -- it's strictly a cross-compiler. It creates
the toolset "powerpc-eabisim-*". The binaries that it generates do not run
on Linux.

The included gdb has a simulator that can run these binaries.

It is possible to generate a library with powerpc-eabisim-gcc (lib*.a) and
then link to it with native gcc and get an executable. However, libc
function calls are problematic -- Linux is glibc based and
powerpc-eabisim-gcc is newlib based. e.g. "printf" called from the
powerpc-eabisim-gcc causes link errors with native gcc.

Motorola chose to "extend the C language" for the AltiVec API. They added a
new modifier "vector":

    vector float a, b, c;
    c = vec_add(a,b);

To make powerpc-eabisim-gcc recognize "vector", you compile with "-fvec".

Unfortunately, powerpc-eabisim-g++ doesn't recognize "vector" at all.
That's right, boys and girls, NO C++ SUPPORT WITH ALTIVEC!

So we have to patch g++ the same way gcc was patched -- to extend the C++
language for AltiVec.

When I saw that Motorola was "changing C" for AltiVec, I thought it was a
mistake. Now I'm certain.

What's wrong with:
    typedef float[4] vector_float;
    vector_float a, b, c;
    c = vec_add(a,b);

That works fine with VIS and MMX (in integer modes).

</rant>

In any case, the AltiVec package gives a few hints on what needs to be done
to make a LinuxPPC native compiler. We're not there yet.

I guess I'll be looking into that, too...

-Greg
----------------------------------------------------------------------
| Gregory E. Allen, MSEE Research Engineer <gallen@arlut.utexas.edu> |
|    Advanced Technology Laboratory, Sonar Development Division      |
|  Applied Research Laboratories: The University of Texas at Austin  |
----------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
