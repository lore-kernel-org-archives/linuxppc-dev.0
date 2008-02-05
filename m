Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [209.5.119.169])
	by ozlabs.org (Postfix) with ESMTP id 830C4DDED0
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 01:50:10 +1100 (EST)
Date: Tue, 5 Feb 2008 09:50:09 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix legacy serial search for opb bus ports
Message-ID: <20080205145008.GA5306@windriver.com>
References: <9efb8c0e313840ccb1bdf918406cdc812ec5de94.1202212897.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9efb8c0e313840ccb1bdf918406cdc812ec5de94.1202212897.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: [PATCH] Fix legacy serial search for opb bus ports
on 05/02/2008 Michael Ellerman wrote:

> The patch to legacy_serial.c (1a7507c7da2df6856e085e0fbb0c9ea8c12ac4e,
> Reduce code duplication in legacy_serial, add UART parent types) changed
> the semantics for opb ports from type = "opb" || compatible = "ibm,opb"
> to type = "opb" && compatible = "ibm,opb".

Ah.  I'd originally coded it as an ||   -- but then Arnd suggested I
condense it further by using of_match_node() -- which was a good idea,
but that is where it accidentally changed to && without me catching it.
Thanks for finding this, and sorry for the debug adventure (I know
vanishing uarts isn't fun).

Paul.

Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>

> 
> The result is serial ports on our QS21s (Cell blades) don't get found,
> and for some reason the machine doesn't boot at all - possibly it's
> panicking due to lack of a console?
> 
> The fix is to add two entries to the of_device_id table, one that looks
> for type = "opb" and the other compatible = "ibm,opb".
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/kernel/legacy_serial.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
> index 76b862b..61dd174 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -36,7 +36,8 @@ static struct legacy_serial_info {
>  static struct __initdata of_device_id parents[] = {
>  	{.type = "soc",},
>  	{.type = "tsi-bridge",},
> -	{.type = "opb", .compatible = "ibm,opb",},
> +	{.type = "opb", },
> +	{.compatible = "ibm,opb",},
>  	{.compatible = "simple-bus",},
>  	{.compatible = "wrs,epld-localbus",},
>  };
> -- 
> 1.5.2.rc1.1884.g59b20
> 
