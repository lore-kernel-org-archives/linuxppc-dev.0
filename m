Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C702AB6FBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 08:29:13 +1000 (EST)
Subject: Re: Pegasos i8042 broken again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20110404222637.GA4633@iram.es>
References: <20101010013755.1697.qmail@kosh.dhis.org>
	<1286696147.2463.499.camel@pasglop>  <20110404222637.GA4633@iram.es>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 08:28:50 +1000
Message-ID: <1301956130.2549.93.camel@pasglop>
Mime-Version: 1.0
Cc: pacman@kosh.dhis.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Ok, I got fed up about it. The patch referred above is obviously wrong since
> it leaves interrupts at 0 when a device_type or name of 8042 is found,
> so what about the following? 
> 
> I can ship it with a signed-off-by and proper comments a bit later if people agree.
> 
> Compiled and tested, otherwise I couldn't even type this message :-)

Shouldn't that be a pegasos specific quirk in chrp/setup.c ?

Cheers,
Ben.

> 	Regards,
> 	Gabriel
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 9d4882a..06865ac 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -599,6 +599,10 @@ int check_legacy_ioport(unsigned long base_port)
>  		 * name instead */
>  		if (!np)
>  			np = of_find_node_by_name(NULL, "8042");
> +		if (np) {
> +			of_i8042_kbd_irq = 1;
> +			of_i8042_aux_irq = 12;
> +		}
>  		break;
>  	case FDC_BASE: /* FDC1 */
>  		np = of_find_node_by_type(NULL, "fdc");
