Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 92C1667FF5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 02:30:17 +1000 (EST)
Date: Tue, 9 Aug 2005 09:30:14 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: John Otken <jotken@softadvances.com>
Message-ID: <20050809163014.GB22053@gate.ebshome.net>
References: <42F89B89.2050000@softadvances.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42F89B89.2050000@softadvances.com>
Cc: roffermanns@sysgo.com, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Support 440EP On-Chip OHCI USB Host Controller (v2)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 07:03:21AM -0500, John Otken wrote:
> This updated patch adds support for the AMCC 440EP on-chip
> OHCI USB host controller.  I tested it on the Bamboo board
> using the 2.6.13-rc6 kernel.
> 

> @@ -194,8 +194,37 @@ static struct resource usb_gadget_resour
> 	},
> };
> 
> +static struct resource ohci_usb_resources[] = {
> +	[0] = {
> +		.start	= 0x0EF601000,
> +		.end	= 0x0EF60107F,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= 40,
> +		.end	= 40,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> static u64 dma_mask = 0xffffffffULL;
> 
> +#include <asm/usb.h>

Let's place #include directives at the top of the source file.

-- 
Eugene
