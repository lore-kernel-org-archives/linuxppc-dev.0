Date: Mon, 5 Jul 2004 11:18:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040705181831.GG2146@smtp.west.cox.net>
References: <20040614091530.GA18482@suse.de> <20040614162359.GA7798@smtp.west.cox.net> <20040614173841.GA3247@suse.de> <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040703222918.GA10425@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 04, 2004 at 12:29:18AM +0200, Olaf Hering wrote:

>  On Tue, Jun 15, Tom Rini wrote:
>
> > And yes, passing -many does work on all older supported versions of
> > binutils.  So perhaps we should just add -Wa,-many to our cflags and be
> > done with it now (and for future fixes of this sort).
>
> gcc 3.2 passes only -mppc, so all altive instructions will fail to
> compile without either -many or -maltivec

Yes, this is a _binutils_ problem however, as older binutils (2.14.* and
lower that we would allow anyhow) are fine.

> diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.7-bk16.orig/arch/ppc/Makefile linux-2.6.7-bk16/arch/ppc/Makefile
> --- linux-2.6.7-bk16.orig/arch/ppc/Makefile	2004-07-03 22:33:35.000000000 +0200
> +++ linux-2.6.7-bk16/arch/ppc/Makefile	2004-07-03 23:11:10.037787069 +0200
> @@ -24,6 +24,9 @@ ifndef CONFIG_E500
>  cflags-y	+= -mstring
>  endif
>
> +# gcc 3.2.3 passes -mppc,
> +# the altivec asm code will fail to compile with binutils newer than 2.15
> +cflags-$(CONFIG_6xx)		+= -Wa,-many

No.  We _always_ want to pass in -Wa,-many to future-proof ourself from
this being a problem again.

> --- linux-2.6.7-bk16.orig/arch/ppc/kernel/Makefile	2004-07-03 22:33:35.000000000 +0200
> +++ linux-2.6.7-bk16/arch/ppc/kernel/Makefile	2004-07-03 22:51:16.802332774 +0200
> @@ -8,6 +8,9 @@ endif
>  ifdef CONFIG_4xx
>  EXTRA_AFLAGS		:= -Wa,-m405
>  endif
> +ifdef CONFIG_6xx
> +EXTRA_AFLAGS		:= -Wa,-maltivec
> +endif

And this should become redundant.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
