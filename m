Date: Thu, 8 Jul 2004 17:58:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jean-Christophe Dubois <jdubois@mc.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: proposed patch for cross compiling from Solaris 2.8
Message-ID: <20040709005832.GJ23135@smtp.west.cox.net>
References: <1089105643.31278.228.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1089105643.31278.228.camel@fr-jdubois1.ad.mc.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 06, 2004 at 11:20:51AM +0200, Jean-Christophe Dubois wrote:

> I got into several issues while trying to cross-compile a Linux 2.6 PPC
> kernel from a Solaris 2.8 host (beside getting a valid cross compilation
> chain). Mainly some programs compiled on the host are not planned to be
> compiled on anything but Linux (The host has to run Linux).
[snip]
> --- linux-2.6.7/arch/ppc/boot/utils/mkbugboot.c Wed Jun 16 01:19:36 2004
> +++ linux-2.6.7.work/arch/ppc/boot/utils/mkbugboot.c    Tue Jul  6
> 03:27:50 2004
> @@ -49,10 +49,12 @@
>  /* size of read buffer */
>  #define SIZE 0x1000
>
> +#ifdef __linux__
>  /* typedef long int32_t; */
>  typedef unsigned long uint32_t;
>  typedef unsigned short uint16_t;
>  typedef unsigned char uint8_t;
> +#endif
>
>  /* PPCBUG ROM boot header */
>  typedef struct bug_boot_header {

This, and possibly the rest, should probably be #ifndef __sun__.  Or at
least mkbugboot.c is OK with that on cygwin (haven't heard of a 2.6 compile
on cygwin yet so I can't say for certain if the other two are OK there).
I'll change and push up.  Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
