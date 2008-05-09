Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 295C3DDE06
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 14:31:29 +1000 (EST)
Subject: Re: [PATCH] POWERPC: Support ISA legacy addresses in
	of_address_to_resource()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1210289192.13845.281.camel@localhost.localdomain>
References: <1210289192.13845.281.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 09 May 2008 14:31:20 +1000
Message-Id: <1210307480.1421.132.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-05-08 at 18:26 -0500, Nate Case wrote:
> When mapping an open firmware device tree node to a resource,
> check if the device is on the "isa" legacy bus.  In this case,
> pci_address_to_pio() should not be used since that function is only
> for addresses above the 64KB reserved region.
> 
> This was necessary to get IPMI working on a board that accesses
> the IPMI controller via the legacy I/O region.

I don't understand that fix. Can you tell us more about the exact
failure mode ? Especially, show us the device-tree bits and the
addresses returned.

I suspect the bug is in your device-tree that is forwarding IO addresses
all the way without converting them to memory or something like that.

> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
>  arch/powerpc/kernel/prom_parse.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
> index 90eb3a3..28d354d 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -622,7 +622,15 @@ static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
>  	memset(r, 0, sizeof(struct resource));
>  	if (flags & IORESOURCE_IO) {
>  		unsigned long port;
> -		port = pci_address_to_pio(taddr);
> +		struct device_node *parent;
> +
> +		parent = of_get_parent(dev);
> +		if (of_bus_isa_match(parent))
> +			port = (unsigned long) taddr;
> +		else
> +			port = pci_address_to_pio(taddr);
> +		of_node_put(parent);
> +
>  		if (port == (unsigned long)-1)
>  			return -EINVAL;
>  		r->start = port;
