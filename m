Message-ID: <389AAA06.CBCDB19A@agelectronics.co.uk>
Date: Fri, 04 Feb 2000 10:29:26 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>,
        Debian PowerPC <debian-powerpc@lists.debian.org>
Subject: Altivec and binary compatibility
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Altivec raises an interesting question of binary compatibility, in the
area of C++ exceptions and C setjmp/longjmp.

As the jmp_buf is a different size in Altivec and non-Altivec code, it
is not possible to jump or pass exceptions between the two. This is a
problem, because:
1) Now would not be a good time to change the size of a jmp_buf.
2) We do not need two incompatible 32-bit PowerPC ABIs under Linux.
2a) Most libraries installed by a distribution will be non-Altivec code,
to avoid having both G[123] and G4 binary variants of the distribution.

To add to the problem, throwing exceptions on an error is just what a
modern C++ library is supposed to do.  Throwing or catching an exception
in Altivec code will produce sequences that cannot execute on a G3
(which is precisely what got me considering this).

Does anybody have any bright ideas, beyond ensuring that everybody
restricts the use of Altivec compilation to routines which only call
safe functions? As long as Altivec code requires the vector keyword,
that's probably a reasonable assumption.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
