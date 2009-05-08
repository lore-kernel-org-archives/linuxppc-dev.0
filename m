Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id E2811DE956
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 00:17:22 +1000 (EST)
Date: Fri, 8 May 2009 16:17:21 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mpc5121/clocks: make debug output more readable
In-Reply-To: <20090508123413.GC3100@pengutronix.de>
Message-ID: <alpine.LRH.2.00.0905081616510.7964@vixen.sonytel.be>
References: <20090508123413.GC3100@pengutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 8 May 2009, Wolfram Sang wrote:
> - Drop KERN_ levels for printks which print to the same line

Those should use KERN_CONT nowadays.

> - use '=' in output to connect key/value pairs
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: John Rigby <jcrigby@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> 
> ---
>  arch/powerpc/platforms/512x/clock.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Index: .kernel/arch/powerpc/platforms/512x/clock.c
> ===================================================================
> --- .kernel.orig/arch/powerpc/platforms/512x/clock.c
> +++ .kernel/arch/powerpc/platforms/512x/clock.c
> @@ -83,12 +83,11 @@ static void dump_clocks(void)
>  	mutex_lock(&clocks_mutex);
>  	printk(KERN_INFO "CLOCKS:\n");
>  	list_for_each_entry(p, &clocks, node) {
> -		printk(KERN_INFO "  %s %ld", p->name, p->rate);
> +		printk(KERN_INFO "  %s=%ld", p->name, p->rate);
>  		if (p->parent)
> -			printk(KERN_INFO " %s %ld", p->parent->name,
> -			       p->parent->rate);
> +			printk(" %s=%ld", p->parent->name, p->parent->rate);
>  		if (p->flags & CLK_HAS_CTRL)
> -			printk(KERN_INFO " reg/bit %d/%d", p->reg, p->bit);
> +			printk(" reg/bit=%d/%d", p->reg, p->bit);
                               ^
			       KERN_CONT

>  		printk("\n");
>  	}
>  	mutex_unlock(&clocks_mutex);

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
