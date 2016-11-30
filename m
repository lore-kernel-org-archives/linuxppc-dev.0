Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTCXV580dzDt1n
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 19:00:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/8xx: xmon compile fix
In-Reply-To: <20161129085654.1967-1-npiggin@gmail.com>
References: <20161129085654.1967-1-npiggin@gmail.com>
Date: Wed, 30 Nov 2016 19:00:57 +1100
Message-ID: <87fum9pfba.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

What's the actual error? mode/badaddr defined but not used?

I'm just curious why I've never hit it?

cheers

> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 7605455..435f5f5 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -1213,10 +1213,13 @@ bpt_cmds(void)
>  {
>  	int cmd;
>  	unsigned long a;
> -	int mode, i;
> +	int i;
>  	struct bpt *bp;
> +#ifndef CONFIG_8xx
> +	int mode;
>  	const char badaddr[] = "Only kernel addresses are permitted "
>  		"for breakpoints\n";
> +#endif
>  
>  	cmd = inchar();
>  	switch (cmd) {
> -- 
> 2.10.2
