Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id E25D3DDE26
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 17:47:29 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH v6] PPC440EPx gpio driver
Date: Fri, 10 Oct 2008 08:44:54 +0200
References: <48EE6408.3020006@harris.com>
In-Reply-To: <48EE6408.3020006@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810100844.54672.sr@denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 09 October 2008, Steven A. Falco wrote:
> This patch adds support for the GPIO functions of PPC40x and PPC44x
> SOCs.

Thanks. Tested successfully on 405EP board.

I only have one comment below left.

> Signed-off-by: Steve Falco <sfalco at harris.com>
> ---
>
> I looked more closely at the datasheet.  Stefan is correct that the
> shadow registers are not needed for these processors, because they have
> separate registers for input and output.
>
> I've incorporated the other changes, with one exception.  I want
> ppc4xx_gpio_get() to return 0 or 1 (rather than Anton's comment that any
> non-zero value is ok), because when you use the new "export feature" in
> sysfs, you see the raw value returned from ppc4xx_gpio_get().  So, without
> the !!  in the return statement, you would see a strange value, like 32768
> instead of 1:
>
> 	# cd gpio208
> 	# cat value
> 	32768
>
> So, I think it is worth sanitizing the return value here.

<snip>

> +static int __init ppc4xx_add_gpiochips(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_compatible_node(np, NULL, "amcc,ppc4xx-gpio") {

Since the GPIO IP-core implementation is from IBM and not AMCC I suggest to 
use a different compatible property:

	for_each_compatible_node(np, NULL, "ibm,ppc4xx-gpio") {

Other than this:

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
