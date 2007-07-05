Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 5FA09DDF15
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 04:51:22 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 5 Jul 2007 20:50:21 +0200
To: Olof Johansson <olof@lixom.net>
Subject: Re: [patch 27/35] Work around errata 4290
Message-ID: <20070705185021.GA26069@iram.es>
References: <20070705170233.258351000@lixom.net>
	<20070705170240.803460000@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070705170240.803460000@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 05, 2007 at 12:03:00PM -0500, Olof Johansson wrote:
> Workaround for errata 4290: The decrementer ticks at half the expected rate
> so load it with half the value it would otherwise be loaded with.
> 
> 
> Index: 2.6.21/include/asm-powerpc/time.h
> ===================================================================
> --- 2.6.21.orig/include/asm-powerpc/time.h
> +++ 2.6.21/include/asm-powerpc/time.h
> @@ -173,6 +173,13 @@ static inline unsigned int get_dec(void)
>  
>  static inline void set_dec(int val)
>  {
> +#ifdef CONFIG_PPC_PASEMI
> +	/* PA6T rev Ax have decrementer ticking at 1/2 tb rate */
> +	val >>= 2;

Comment does not match code: looks like a divide by 4 to me!

> +	if (!val)
> +		val = 1;
> +#endif
> +
>  #if defined(CONFIG_40x)
>  	return;		/* Have to let it auto-reload */
>  #elif defined(CONFIG_8xx_CPU6)

	Gabriel
