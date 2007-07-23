Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0B1BDDDEC6
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 08:35:08 +1000 (EST)
Date: Mon, 23 Jul 2007 17:27:25 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@tux.tmfweb.nl
Subject: Re: [PATCH] Re: 2.6.22-git hangs during boot on PowerBook G3 in 0.0
	seconds
Message-Id: <20070723172725.b1c14885.kim.phillips@freescale.com>
In-Reply-To: <20070721212845.GA30977@nospam.com>
References: <20070721192143.GA12144@nospam.com>
	<20070721212845.GA30977@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rutger Nijlunsing <rutger@nospam.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 21 Jul 2007 23:28:45 +0200
Rutger Nijlunsing <rutger@nospam.com> wrote:

> On Sat, Jul 21, 2007 at 09:21:43PM +0200, Rutger Nijlunsing wrote:
> > Hi,
> > 
> > I'm trying to boot a new git kernel (2.6.22-g589f1e81), but it hangs
> > very early (the timestamp is still on 0.000000).
> 
> After hours bisecting, I found the one-liner which results in the
> hang. Now it takes someone else to find out _why_ it causes a hang :)
> 

hmm..I hadn't seen this of_translate_address comment:

 * Note: We consider that crossing any level with #size-cells == 0 to mean
 * that translation is impossible (that is we are not dealing with a value
 * that can be mapped to a cpu physical address). This is not really specified
 * that way, but this is traditionally the way IBM at least do things

so I guess even though size-cells can == 0, of_translate_address should
remain oblivious.

> 
> From 6c13e1b55c1f87ed19f3c4623de3df881779edd7 Mon Sep 17 00:00:00 2001
> From: Rutger Nijlunsing <git-commit@tux.tmfweb.nl>
> Date: Sat, 21 Jul 2007 23:01:22 +0200
> Subject: [PATCH] Revert "[POWERPC] Don't complain if size-cells == 0 in prom_parse()"
> Status: RO
> Content-Length: 866
> Lines: 24
> 
> After hours of fun git bisecting, finally found the commit to revert
> to make my PowerBook G3 Lombard boot again. This does not result in
> the complains the reverted commit was revering to.

..but it does on my MPC8360.

> 
> This reverts commit fd6e9d3945ee122eb513ada8b17296d243c1ce5e.
> ---
>  arch/powerpc/kernel/prom_parse.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
> index 3786dcc..b5c96af 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -24,7 +24,7 @@
>  /* Max address size we deal with */
>  #define OF_MAX_ADDR_CELLS	4
>  #define OF_CHECK_COUNTS(na, ns)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS && \
> -			(ns) >= 0)
> +			(ns) > 0)
>  
>  static struct of_bus *of_match_bus(struct device_node *np);
>  static int __of_address_to_resource(struct device_node *dev,
> -- 
> 1.5.2.2

yes, we can revert it, and perhaps do something like:

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 3786dcc..92b7177 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -503,7 +503,7 @@ u64 of_translate_address(struct device_node *dev, const u32 
        /* Cound address cells & copy address locally */
        bus->count_cells(dev, &na, &ns);
        if (!OF_CHECK_COUNTS(na, ns)) {
-               printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
+               DBG("prom_parse: Bad cell count for %s\n",
                       dev->full_name);
                goto bail;
        }
@@ -531,7 +531,7 @@ u64 of_translate_address(struct device_node *dev, const u32 
                pbus = of_match_bus(parent);
                pbus->count_cells(dev, &pna, &pns);
                if (!OF_CHECK_COUNTS(pna, pns)) {
-                       printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
+                       DBG("prom_parse: Bad cell count for %s\n",
                               dev->full_name);
                        break;
                }

Ben?

Kim
