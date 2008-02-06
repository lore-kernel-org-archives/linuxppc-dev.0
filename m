Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 588FADDE08
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 11:09:14 +1100 (EST)
Subject: Re: [PATCH] Fix legacy serial search for opb bus ports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <9efb8c0e313840ccb1bdf918406cdc812ec5de94.1202212897.git.michael@ellerman.id.au>
References: <9efb8c0e313840ccb1bdf918406cdc812ec5de94.1202212897.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Wed, 06 Feb 2008 11:08:51 +1100
Message-Id: <1202256531.7079.76.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paul.gortmaker@windriver.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-05 at 23:01 +1100, Michael Ellerman wrote:
> The patch to legacy_serial.c (1a7507c7da2df6856e085e0fbb0c9ea8c12ac4e,
> Reduce code duplication in legacy_serial, add UART parent types) changed
> the semantics for opb ports from type = "opb" || compatible = "ibm,opb"
> to type = "opb" && compatible = "ibm,opb".
> 
> The result is serial ports on our QS21s (Cell blades) don't get found,
> and for some reason the machine doesn't boot at all - possibly it's
> panicking due to lack of a console?
> 
> The fix is to add two entries to the of_device_id table, one that looks
> for type = "opb" and the other compatible = "ibm,opb".
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

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
