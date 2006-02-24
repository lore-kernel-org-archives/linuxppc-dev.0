Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4FFCD679F5
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Feb 2006 08:04:02 +1100 (EST)
In-Reply-To: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1816f5bfb606df0641c199fe13b2ad88@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix mem= cmdline handling on arch/powerpc for
	!MULTIPLATFORM
Date: Fri, 24 Feb 2006 22:04:07 +0100
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I can confirm this works on systems with "real" OF, too.  Furthermore,
the patch looks sane to me.

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

> mem= command line option was being ignored in arch/powerpc if we were 
> not
> a CONFIG_MULTIPLATFORM (which is handled via prom_init stub). The 
> initial
> command line extraction and parsing needed to be moved earlier in the 
> boot
> process and have code to actual parse mem= and do something about it.
>
> Also, fixed a compile warning in the file.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> ---
> commit 625f68c82bae16c53f684c5512b0176c243c6068
> tree 5657155434c9a44fa9ee3e0329756e354daf4845
> parent 820ac48b82821c6d38747ea49f98aeca05ca2e2b
> author Kumar Gala <galak@kernel.crashing.org> Fri, 24 Feb 2006 
> 11:03:12 -0600
> committer Kumar Gala <galak@kernel.crashing.org> Fri, 24 Feb 2006 
> 11:03:12 -0600
>
>  arch/powerpc/kernel/prom.c |   54 
> +++++++++++++++++++++++++++++++-------------
>  1 files changed, 38 insertions(+), 16 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 294832a..6dbd217 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -816,8 +816,6 @@ void __init unflatten_device_tree(void)
>  {
>  	unsigned long start, mem, size;
>  	struct device_node **allnextp = &allnodes;
> -	char *p = NULL;
> -	int l = 0;
>
>  	DBG(" -> unflatten_device_tree()\n");
>
> @@ -857,19 +855,6 @@ void __init unflatten_device_tree(void)
>  	if (of_chosen == NULL)
>  		of_chosen = of_find_node_by_path("/chosen@0");
>
> -	/* Retreive command line */
> -	if (of_chosen != NULL) {
> -		p = (char *)get_property(of_chosen, "bootargs", &l);
> -		if (p != NULL && l > 0)
> -			strlcpy(cmd_line, p, min(l, COMMAND_LINE_SIZE));
> -	}
> -#ifdef CONFIG_CMDLINE
> -	if (l == 0 || (l == 1 && (*p) == 0))
> -		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> -#endif /* CONFIG_CMDLINE */
> -
> -	DBG("Command line is: %s\n", cmd_line);
> -
>  	DBG(" <- unflatten_device_tree()\n");
>  }
>
> @@ -940,6 +925,8 @@ static int __init early_init_dt_scan_cho
>  {
>  	u32 *prop;
>  	unsigned long *lprop;
> +	unsigned long l;
> +	char *p;
>
>  	DBG("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
>
> @@ -1004,6 +991,41 @@ static int __init early_init_dt_scan_cho
>                 crashk_res.end = crashk_res.start + *lprop - 1;
>  #endif
>
> +	/* Retreive command line */
> + 	p = of_get_flat_dt_prop(node, "bootargs", &l);
> +	if (p != NULL && l > 0)
> +		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
> +
> +#ifdef CONFIG_CMDLINE
> +	if (l == 0 || (l == 1 && (*p) == 0))
> +		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +#endif /* CONFIG_CMDLINE */
> +
> +	DBG("Command line is: %s\n", cmd_line);
> +
> +	if (strstr(cmd_line, "mem=")) {
> +		char *p, *q;
> +		unsigned long maxmem = 0;
> +
> +		for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
> +			q = p + 4;
> +			if (p > cmd_line && p[-1] != ' ')
> +				continue;
> +			maxmem = simple_strtoul(q, &q, 0);
> +			if (*q == 'k' || *q == 'K') {
> +				maxmem <<= 10;
> +				++q;
> +			} else if (*q == 'm' || *q == 'M') {
> +				maxmem <<= 20;
> +				++q;
> +			} else if (*q == 'g' || *q == 'G') {
> +				maxmem <<= 30;
> +				++q;
> +			}
> +		}
> +		memory_limit = maxmem;
> +	}
> +
>  	/* break now */
>  	return 1;
>  }
> @@ -1124,7 +1146,7 @@ static void __init early_reserve_mem(voi
>  			size_32 = *(reserve_map_32++);
>  			if (size_32 == 0)
>  				break;
> -			DBG("reserving: %lx -> %lx\n", base_32, size_32);
> +			DBG("reserving: %x -> %x\n", base_32, size_32);
>  			lmb_reserve(base_32, size_32);
>  		}
>  		return;
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
