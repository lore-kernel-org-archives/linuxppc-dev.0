Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18412.10838.984230.869068@cargo.ozlabs.ibm.com>
Date: Fri, 28 Mar 2008 10:14:30 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Clean up some linker and symbol usage
In-Reply-To: <Pine.LNX.4.64.0803271452540.12382@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0803271452540.12382@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> @@ -1124,7 +1124,7 @@ void __init early_init_devtree(void *params)
>  	parse_early_param();
> 
>  	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
> -	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
> +	lmb_reserve(__pa(_stext), _end - _stext);

In the kdump case where the kernel starts at the 32MB point
(physical), wouldn't we want to reserve the first 32MB of RAM so that
it can't get allocated and used for random things?  Doesn't that first
32MB contain the old kernel that we want to write out?

Or do we only have the 32MB starting at the 32MB point in the lmb
system in that case?

Paul.
