Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 9952EDDDE9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 15:44:49 +1100 (EST)
Date: Tue, 19 Feb 2008 20:45:25 -0800 (PST)
Message-Id: <20080219.204525.193731674.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] [LMB]: Fix lmb_add_region if region should be added at
	the head
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0802192227170.2215@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0802192227170.2215@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 19 Feb 2008 22:27:48 -0600 (CST)

> We introduced a bug in fixing lmb_add_region to handle an initial
> region being non-zero.  Before that fix it was impossible to insert
> a region at the head of the list since the first region always started
> at zero.
> 
> Now that its possible for the first region to be non-zero we need to
> check to see if the new region should be added at the head and if so
> actually add it.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
 ...
> @@ -184,6 +184,11 @@ static long __init lmb_add_region(struct lmb_region *rgn, u64 base, u64 size)
>  			break;
>  		}
>  	}
> +
> +	if (base < rgn->region[0].base) {
> +		rgn->region[0].base = base;
> +		rgn->region[0].size = size;
> +	}
>  	rgn->cnt++;
> 
>  	return 0;

Are you sure this is sufficient?

It seems to me, to handle this properly, you'll need to handle
the case where the lower addressed entry you are inserting is
not contiguous with the existing entry 0.

Therefore, you need to move all existing entries up a slot,
then you can set the 0 entry to 'base' and 'size'.

What do you think?
