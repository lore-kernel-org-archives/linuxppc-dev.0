Subject: Re: Changes I would like to get into the 2_4_devel
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <86C2D453-E83F-11D6-A4F1-0003931C2BFA@control.lth.se>
References: <86C2D453-E83F-11D6-A4F1-0003931C2BFA@control.lth.se>
Date: 25 Oct 2002 12:46:08 -0500
Message-Id: <1035567969.6937.5.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2002-10-25 at 12:30, Anders Blomdell wrote:
>
> in arch/ppc/Makefile:
>    add -D__powerpc__ to CPPFLAGS and CFLAGS (just like it is on  kernel.org)
>      This makes drivers/char/serial.c compile correctly (no more 5 bit
>      characters)
>
> in Makefile:
>    add -D__linux__ to CPPFLAGS
>      This makes coda.h compile correctly (u_quad_t)

<snip>

> I know that you think I have an incorrectly configured gcc, but I think
> that it's a nice feature if the kernel compiles with a gcc that has been
> configured according to the 'http://penguinppc.org/embedded/cross-compiling/
> ', even though it warns about gcc-3.x (3.2 generates working code with the
> above changes)...

This is a handy one-liner for seeing what defines gcc has:
	echo | powerpc-linux-gcc -E -dM -
When I run it with a cross-compiled gcc 2.95.3 *and* 3.2, I see both
	#define __linux__ 1
	#define __powerpc__ 1
The 2.95.3 was compiled with exactly the directions you refer to above.
3.2 was slightly different, but in both cases --target=powerpc-linux .

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
