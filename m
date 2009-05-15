Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57572DE0D5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 08:28:14 +1000 (EST)
Subject: Re: [PATCH] powerpc/ftrace: fix constraint to be early clobber
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <alpine.DEB.2.00.0905141236420.30591@gandalf.stny.rr.com>
References: <alpine.DEB.2.00.0905141236420.30591@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sat, 16 May 2009 08:27:18 +1000
Message-Id: <1242426438.9691.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-05-15 at 10:33 -0400, Steven Rostedt wrote:
> After upgrading my distcc boxes from gcc 4.2.2 to 4.4.0, the function 
> graph tracer broke. This was discovered on my x86 boxes.
> 
> The issue is that gcc used the same register for an output as it did for 
> an input in an asm statement. I first thought this was a bug in gcc and 
> reported it. I was notified that gcc was correct and that the output had 
> to be flagged as an "early clobber".
> 
> I noticed that powerpc had the same issue and this patch fixes it.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Ack. You merge this or I do ?

Cheers,
Ben.

> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index 70e2a73..68fd74e 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -594,7 +594,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
>  			PPC_LONG "2b,4b\n"
>  		".previous"
>  
> -		: [old] "=r" (old), [faulted] "=r" (faulted)
> +		: [old] "=&r" (old), [faulted] "=r" (faulted)
>  		: [parent] "r" (parent), [return_hooker] "r" (return_hooker)
>  		: "memory"
>  	);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
