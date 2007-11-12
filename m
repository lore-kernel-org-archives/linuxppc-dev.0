Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 49113DDEB9
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Nov 2007 16:14:55 +1100 (EST)
Date: Sun, 11 Nov 2007 23:15:32 -0600
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Silence an annoying boot message
Message-ID: <20071112051532.GA28394@lixom.net>
References: <20071112135339.9a01b115.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071112135339.9a01b115.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stephen,

On Mon, Nov 12, 2007 at 01:53:39PM +1100, Stephen Rothwell wrote:
> vmemmap_populate will printk (with KERN_WARNING) for a lot of pages
> if CONFIG_SPARSEMEM_VMEMMAP is enabled (at least it does on iSeries).
> Turn it into a DEBUG message.
[...]
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index d9c82d3..ee0e0cc 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -239,7 +239,7 @@ int __meminit vmemmap_populate(struct page *start_page,
>  		if (!p)
>  			return -ENOMEM;
>  
> -		printk(KERN_WARNING "vmemmap %08lx allocated at %p, "
> +		DBG(KERN_DEBUG "vmemmap %08lx allocated at %p, "
>  		                    "physical %08lx.\n", start, p, __pa(p));

Please use pr_debug() instead.

Feel free to change the only other DBG() user in the file as well,
and take out the define of it


-Olof
