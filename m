Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B49EEDDFCD
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 09:27:39 +1100 (EST)
Date: Thu, 11 Dec 2008 14:26:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: Re[2]: [PATCH][v2] fork_init: fix division by zero
Message-Id: <20081211142611.1790a62a.akpm@linux-foundation.org>
In-Reply-To: <483237973.20081212012232@emcraft.com>
References: <200812101950.51958.yur@emcraft.com>
	<20081211121635.ff58193f.akpm@linux-foundation.org>
	<483237973.20081212012232@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: wd@denx.de, dzu@denx.de, linux-kernel@vger.kernel.org, miltonm@bga.com,
	linuxppc-dev@ozlabs.org, viro@zeniv.linux.org.uk,
	Geert.Uytterhoeven@sonycom.com, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 12 Dec 2008 01:22:32 +0300
Yuri Tikhonov <yur@emcraft.com> wrote:

> > so how about avoiding the nasty ifdefs and doing
> 
>  I'm OK with the approach below, but, leading resulting to the same, 
> this involves some overhead to the code where there was no this 
> overhead before this patch: e.g. your implementation is finally boils 
> down to ~5 times more processor instructions than there were before,
> plus operations with stack for the 'm' variable.
> 
>  On the other hand, my approach with nasty (I agree) ifdefs doesn't 
> lead to overheads to the code which does not need this: i.e. the most 
> common situation of small PAGE_SIZEs. Big PAGE_SIZE is the exception, 
> so I believe that the more common cases should not suffer because of 
> this.

yes, but...

> > --- a/kernel/fork.c~fork_init-fix-division-by-zero
> > +++ a/kernel/fork.c
> > @@ -69,6 +69,7 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/tlbflush.h>
> > +#include <asm/div64.h>
> >  
> >  /*
> >   * Protected counters by write_lock_irq(&tasklist_lock)
> > @@ -185,10 +186,15 @@ void __init fork_init(unsigned long memp

This is __init code and it gets thrown away after bootup.
