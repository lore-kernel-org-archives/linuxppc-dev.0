Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 01677DDE3D
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 04:16:25 +1100 (EST)
Message-ID: <45A7C260.3010101@am.sony.com>
Date: Fri, 12 Jan 2007 09:16:16 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ps3_free_io_irq: inverted error check
References: <Pine.LNX.4.62.0612211355150.20731@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0612211355150.20731@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> ps3_free_io_irq: Fix inverted error check after calling
> lv1_destruct_io_irq_outlet()
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> ---
>  arch/powerpc/platforms/ps3/interrupt.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- ps3-linux-src.orig/arch/powerpc/platforms/ps3/interrupt.c
> +++ ps3-linux-src/arch/powerpc/platforms/ps3/interrupt.c
> @@ -71,7 +71,7 @@ int ps3_free_io_irq(unsigned int virq)
>  
>  	result = lv1_destruct_io_irq_outlet(virq_to_hw(virq));
>  
> -	if (!result)
> +	if (result)
>  		pr_debug("%s:%d: lv1_destruct_io_irq_outlet failed: %s\n",
>  			__func__, __LINE__, ps3_result(result));
>  
> 

Paul,

If you don't see any trouble, it would be nice for this to go in
for 2.6.20, as it fixes a problem currently in Linus' tree.

Sorry it took so long to merge in and test.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>

-Geoff
