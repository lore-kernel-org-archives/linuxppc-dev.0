Message-ID: <40E75DC7.7070601@coditel.net>
Date: Sun, 04 Jul 2004 03:30:47 +0200
From: Stef Simoens <stefaan.simoens@coditel.net>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
References: <20040610001605.GH18212@smtp.west.cox.net> <20040614091530.GA18482@suse.de> <20040614162359.GA7798@smtp.west.cox.net> <20040614173841.GA3247@suse.de> <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de>
In-Reply-To: <20040703222918.GA10425@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf Hering wrote:

>  On Tue, Jun 15, Tom Rini wrote:
>
>
>>And yes, passing -many does work on all older supported versions of
>>binutils.  So perhaps we should just add -Wa,-many to our cflags and be
>>done with it now (and for future fixes of this sort).
>
>
> gcc 3.2 passes only -mppc, so all altive instructions will fail to
> compile without either -many or -maltivec

Are there altivec instructions when CONFIG_ALTIVEC is not set?

> diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.7-bk16.orig/arch/ppc/kernel/Makefile linux-2.6.7-bk16/arch/ppc/kernel/Makefile
> --- linux-2.6.7-bk16.orig/arch/ppc/kernel/Makefile	2004-07-03 22:33:35.000000000 +0200
> +++ linux-2.6.7-bk16/arch/ppc/kernel/Makefile	2004-07-03 22:51:16.802332774 +0200
> @@ -8,6 +8,9 @@ endif
>  ifdef CONFIG_4xx
>  EXTRA_AFLAGS		:= -Wa,-m405
>  endif
> +ifdef CONFIG_6xx
> +EXTRA_AFLAGS		:= -Wa,-maltivec
> +endif
>  ifdef CONFIG_E500
>  EXTRA_AFLAGS		:= -Wa,-me500
>  endif

So, shouldn't this be "ifdef CONFIG_ALTIVEC" ?

Stef


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
