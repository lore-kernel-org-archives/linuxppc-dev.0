Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A2BAB7D51
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 07:27:42 +1000 (EST)
Subject: Re: [PATCH] Correct PowerPC Parport interrupt parsing.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martyn Welch <martyn.welch@ge.com>
In-Reply-To: <20100426110810.22131.46466.stgit@ES-J7S4D2J.amer.consind.ge.com>
References: <20100426110810.22131.46466.stgit@ES-J7S4D2J.amer.consind.ge.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 07:27:05 +1000
Message-ID: <1272317225.29889.1.camel@pasglop>
Mime-Version: 1.0
Cc: tim@cyberelk.demon.co.uk, linuxppc-dev@ozlabs.org,
	Michael Neuling <mikey@neuling.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-04-26 at 12:15 +0100, Martyn Welch wrote:
> Currently the parsing of the device tree in
> arch/powerpc/include/asm/parport.h assumes that the interrupt provided in
> the parallel port node is a valid virtual irq. The values for the
> interrupts provided in the device tree should have meaning in the context
> of the driver for the specific interrupt controller to which the interrupt
> is connected and irq_of_parse_and_map() should be used to determine the
> correct virtual irq.
> 
> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
> ---
> 
> I believe this is the correct way to discover interrupt numbering. I assume
> this has worked in the past as the interrupt routing hasn't been as
> "interesting" as the board I'm currently working on.
> 
> I also don't have any other targets I could test this on, can anyone tell
> me if this will break support on existing devices?
> 
>  arch/powerpc/include/asm/parport.h |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/parport.h b/arch/powerpc/include/asm/parport.h
> index 94942d6..aa3f7bc 100644
> --- a/arch/powerpc/include/asm/parport.h
> +++ b/arch/powerpc/include/asm/parport.h
> @@ -19,6 +19,8 @@ static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
>  	u32 io1, io2;
>  	int propsize;
>  	int count = 0;
> +	int virq;
> +
>  	for (np = NULL; (np = of_find_compatible_node(np,
>  						      "parallel",
>  						      "pnpPNP,400")) != NULL;) {
> @@ -26,10 +28,13 @@ static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
>  		if (!prop || propsize > 6*sizeof(u32))
>  			continue;
>  		io1 = prop[1]; io2 = prop[2];
> -		prop = of_get_property(np, "interrupts", NULL);
> -		if (!prop)
> +
> +		virq = irq_of_parse_and_map(np, 1);

It looks good overall except the above, "1" should be "0".

I suspect it worked by luck so far because the few machines with a
parallel port also have a 8259 irq controller using legacy interrupts
and the virq layer keeps those mapped 1:1.

Cheers,
Ben.

> +		if (virq == NO_IRQ)
>  			continue;
> -		if (parport_pc_probe_port(io1, io2, prop[0], autodma, NULL, 0) != NULL)
> +
> +		if (parport_pc_probe_port(io1, io2, virq, autodma, NULL, 0)
> +				!= NULL)
>  			count++;
>  	}
>  	return count;
> 
> 
> --
> Martyn Welch (Principal Software Engineer)   |   Registered in England and
> GE Intelligent Platforms                     |   Wales (3828642) at 100
> T +44(0)127322748                            |   Barbirolli Square, Manchester,
> E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
