Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8520DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 02:04:07 +1100 (EST)
Message-ID: <493E88B7.5020702@freescale.com>
Date: Tue, 09 Dec 2008 09:03:19 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Guillaume Knispel <gknispel@proformatique.com>
Subject: Re: [PATCH] Fix corruption error in rh_alloc_fixed()
References: <20081209152834.1d6ff291@xilun.lan.proformatique.com>
In-Reply-To: <20081209152834.1d6ff291@xilun.lan.proformatique.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Pantelis Antoniou <pantelis@embeddedalley.com>,
	Li Yang <leoli@freescale.com>,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guillaume Knispel wrote:
> There is an error in rh_alloc_fixed() of the Remote Heap code:
> If there is at least one free block blk won't be NULL at the end of the
> search loop, so -ENOMEM won't be returned and the else branch of
> "if (bs == s || be == e)" will be taken, corrupting the management
> structures.
> 
> Signed-off-by: Guillaume Knispel <gknispel@proformatique.com>
> ---
> Fix an error in rh_alloc_fixed() that made allocations succeed when
> they should fail, and corrupted management structures.
> 
> diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
> index 29b2941..45907c1 100644
> --- a/arch/powerpc/lib/rheap.c
> +++ b/arch/powerpc/lib/rheap.c
> @@ -556,6 +556,7 @@ unsigned long rh_alloc_fixed(rh_info_t * info, unsigned long start, int size, co
>  		be = blk->start + blk->size;
>  		if (s >= bs && e <= be)
>  			break;
> +		blk = NULL;
>  	}
>  
>  	if (blk == NULL)

This is a good catch, however, wouldn't it be better to do this:

	list_for_each(l, &info->free_list) {
		blk = list_entry(l, rh_block_t, list);
		/* The range must lie entirely inside one free block */
		bs = blk->start;
		be = blk->start + blk->size;
		if (s >= bs && e <= be)
			break;
	}

-	if (blk == NULL)
+	if (blk == &info->free_list)
		return (unsigned long) -ENOMEM;

I haven't tested this, but the if-statement at the end of the loop is meant to
check whether the list_for_each() loop got to the end or not.

What do you think?

-- 
Timur Tabi
Linux kernel developer at Freescale
