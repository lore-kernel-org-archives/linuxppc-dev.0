Date: Mon, 2 Feb 2004 11:49:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefan Nickl <Stefan.Nickl@kontron.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gcc for ppc/predefined macros
Message-ID: <20040202184939.GC932@smtp.west.cox.net>
References: <1075715340.19857.14.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075715340.19857.14.camel@lucy.pep-kaufbeuren.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Feb 02, 2004 at 10:49:01AM +0100, Stefan Nickl wrote:

>
> I just had to find out very painfully that
> my cross-gcc-3.3.2 doesn't have __powerpc__
> as a predefined macro anymore:
>
> (SuSE-built-) gcc 2.95.3:
> .../powerpc-linux-cpp -dM ~/foo.h |grep -i pc
>
> #define powerpc 1
> #define __PPC__ 1
> #define PPC 1
> #define _ARCH_PPC 1
> #define __PPC 1
> #define __powerpc__ 1
> #define __powerpc 1
>
>
> (gentoo-crossdev-build-) gcc 3.3.2:
> .../powerpc-unknown-eabi-cpp -dM ~/foo.h |grep -i pc
>
> #define _ARCH_PPC 1
> #define __PPC 1
> #define PPC 1
> #define __PPC__ 1
>
> The kernel relies on __powerpc__ in some places,
> in fact, the serial console won't work anymore
> since the LCR gets setup incorrectly in
> serial_console_setup located in serial.c.

I belive the problem is that you did not compile your cross-compiler
correctly:
$ ppc_7xx-cpp -dM /tmp/foo.h  | grep pc
#define __powerpc__ 1
#define __powerpc 1
#define powerpc 1

Make sure you do --target=powerpc-foo-linux when configuring gcc.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
