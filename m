Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10DC9DDDF7
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 16:47:48 +1000 (EST)
Subject: Re: [PATCH] [V2] powerpc: legacy_serial: reg-offset & shift aren't
	used
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Linn <john.linn@xilinx.com>
In-Reply-To: <20080701175250.E0BA41CE804D@mail117-va3.bigfish.com>
References: <20080701175250.E0BA41CE804D@mail117-va3.bigfish.com>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 16:47:08 +1000
Message-Id: <1215413228.8970.106.camel@pasglop>
Mime-Version: 1.0
Cc: dwg@au1.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-01 at 10:52 -0700, John Linn wrote:
> The legacy serial driver does not work with an 8250
> type UART that uses reg-offset and reg-shift. This
> change updates the driver so it doesn't find the UART
> when those properties are present on the UART in the
> device tree for soc devices.
> 
> Signed-off-by: John Linn <john.linn@xilinx.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> V2
> 
> Corrected logic to use "||" rather than "&&".

I have some problems with this patch:

 - First if the properties are present but their value match the
register layout of a standard UART, we will bail out... not nice.

 - Why don't we just implement support for the reg-shift and
offset instead ?

Cheers,
Ben.

>  arch/powerpc/kernel/legacy_serial.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
> index 61dd174..cf37f5c 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -136,6 +136,11 @@ static int __init add_legacy_soc_port(struct device_node *np,
>  	if (of_get_property(np, "clock-frequency", NULL) == NULL)
>  		return -1;
>  
> +	/* if reg-shift or offset, don't try to use it */
> +	if ((of_get_property(np, "reg-shift", NULL) != NULL) ||
> +		(of_get_property(np, "reg-offset", NULL) != NULL))
> +		return -1;
> +
>  	/* if rtas uses this device, don't try to use it as well */
>  	if (of_get_property(np, "used-by-rtas", NULL) != NULL)
>  		return -1;
