Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnwCj2cGGzDqwf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 16:28:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Alistair Popple <alistair@popple.id.au>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 "# 4 . 1 . x-" <stable@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] tty/hvc: Use opal irqchip interface if available
In-Reply-To: <20160711033858.16172-2-sam@mendozajonas.com>
References: <20160711033858.16172-1-sam@mendozajonas.com>
 <20160711033858.16172-2-sam@mendozajonas.com>
Date: Mon, 11 Jul 2016 16:28:46 +1000
Message-ID: <871t30k7s1.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Samuel Mendoza-Jonas <sam@mendozajonas.com> writes:

> Update the hvc driver to use the OPAL irqchip if made available by the
> running firmware. If it is not present, the driver falls back to the
> existing OPAL event number.
>
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Cc: <stable@vger.kernel.org> # 4.1.x-
> ---
> v2: Always try irq_of_parse_and_map before falling back

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index b7cd0ae..5107993 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
> @@ -214,7 +214,13 @@ static int hvc_opal_probe(struct platform_device *dev)
>  		dev->dev.of_node->full_name,
>  		boot ? " (boot console)" : "");
>  
> -	irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
> +	irq = irq_of_parse_and_map(dev->dev.of_node, 0);
> +	if (!irq) {
> +		pr_info("hvc%d: No interrupts property, using OPAL event\n",
> +				termno);
> +		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
> +	}
> +
>  	if (!irq) {
>  		pr_err("hvc_opal: Unable to map interrupt for device %s\n",
>  			dev->dev.of_node->full_name);
> -- 
> 2.9.0
