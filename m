Message-ID: <389F09C2.18FD4AA5@agelectronics.co.uk>
Date: Mon, 07 Feb 2000 18:06:58 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Giuliano Pochini <pochini@denise.shiny.it>
CC: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>,
        Debian PowerPC <debian-powerpc@lists.debian.org>
Subject: Re: Altivec and binary compatibility
References: <389AAA06.CBCDB19A@agelectronics.co.uk> <389EE09A.571A6C26@denise.shiny.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Giuliano Pochini wrote:
Giuliano Pochini wrote:

> > As the jmp_buf is a different size in Altivec and non-Altivec code
>
> Because with Altivec we need to save V registers, right ?  Well, I suppose
> intel developers had the same problem with P-III "vector" unit. How did they
> solve the problem ?

As far as I can tell, by ignoring it, and making the assumption that
only low-level libraries will use the vector registers.  I plan to take
a similar approach, and warn users not to mix Altivec and exceptions.

> > To add to the problem, throwing exceptions on an error is just what a
> > modern C++ library is supposed to do.  Throwing or catching an exception
> > in Altivec code will produce sequences that cannot execute on a G3
>
> Why ?? (sorry for my ignorance...)

I haven't studied GCC's implementation of exceptions in great detail.
The compiler saves and restores all the non-transient registers as part
of the exception sequence. When generating Altivec code this produces
stvx and lvx instructions, which will cause an illegal instruction
exception on G3 processors.

- Adrian Cox

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
