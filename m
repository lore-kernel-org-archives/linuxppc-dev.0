Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 75E9167B85
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 17:11:31 +1000 (EST)
Date: Mon, 15 May 2006 00:08:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix ide-pmac sysfs entry
Message-Id: <20060515000810.487b834e.akpm@osdl.org>
In-Reply-To: <1147676318.21291.105.camel@localhost.localdomain>
References: <1147676318.21291.105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Pete Popov <ppopov@embeddedalley.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> It looks like the generic ide code now wants ide_init_hwif_ports() to
> set the parent struct device into the ide_hw structure (new field ?).
> Without this, the mac ide code can cause the ide probing code to explode
> in flames in sysfs registration due to what looks like a stale pointer
> in there (happens when removing/re-inserting one of the hotswap media
> bays on some laptops).
> 

You don't sound very confident.

> ---
> 
> Andew: That's a 2.6.17 candidate 
> 
> Index: linux-work/drivers/ide/ppc/pmac.c
> ===================================================================
> --- linux-work.orig/drivers/ide/ppc/pmac.c	2006-04-19 15:04:47.000000000 +1000
> +++ linux-work/drivers/ide/ppc/pmac.c	2006-05-15 16:43:20.000000000 +1000
> @@ -553,6 +553,8 @@
>  
>  	if (irq != NULL)
>  		*irq = pmac_ide[ix].irq;
> +
> +	hw->dev = &pmac_ide[ix].mdev->ofdev.dev;
>  }
>  
>  #define PMAC_IDE_REG(x) ((void __iomem *)(IDE_DATA_REG+(x)))
>  

afaict things went bad in October last year.  hw_regs_t.dev was added here:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=26a940e21752e0de8f068f77dad606a7d1986937

but that only converted one driver to initialse ->dev.

How come things didn't break then?  Did some later change cause the
problems?
