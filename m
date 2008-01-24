Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B33A2DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 18:07:02 +1100 (EST)
Subject: Re: [PATCH v2][POWERPC] Always build setup-bus.c on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0801240037380.22221@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0801240006380.21347@blarg.am.freescale.net>
	<1201156120.6815.48.camel@pasglop>
	<8642742F-E8BF-43C7-9FE4-AAF54855ECF7@kernel.crashing.org>
	<Pine.LNX.4.64.0801240037380.22221@blarg.am.freescale.net>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 18:06:35 +1100
Message-Id: <1201158395.6815.50.camel@pasglop>
Mime-Version: 1.0
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-01-24 at 00:38 -0600, Kumar Gala wrote:
> The common arch/powerpc code calls in to functions in setup-bus.c
> so some builds of ppc32 would fail.
> 
> Note, ppc32 usage of setup-irq.c is limited to arch/ppc and should be
> removed when arch/ppc goes away.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Ack. Funny I didn't catch it on my 4xx testing, I must have always had
HOTPLUG enabled.

> ---
> 
> Here's the proper diff, will send this via paulus.
> 
>  drivers/pci/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 5550556..f697f3d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -32,7 +32,7 @@ obj-$(CONFIG_ARM) += setup-bus.o setup-irq.o
>  obj-$(CONFIG_PARISC) += setup-bus.o
>  obj-$(CONFIG_SUPERH) += setup-bus.o setup-irq.o
>  obj-$(CONFIG_PPC32) += setup-irq.o
> -obj-$(CONFIG_PPC64) += setup-bus.o
> +obj-$(CONFIG_PPC) += setup-bus.o
>  obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
>  obj-$(CONFIG_X86_VISWS) += setup-irq.o
> 
