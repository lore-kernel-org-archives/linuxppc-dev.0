Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BBB0D100806
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 16:44:12 +1000 (EST)
Subject: Re: [PATCH 4/5] of/address: little-endian fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100608141013.25879.34892.stgit@angua>
References: <20100608140917.25879.67745.stgit@angua>
	<20100608141013.25879.34892.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 16:43:57 +1000
Message-ID: <1276152237.1962.60.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-06-08 at 08:10 -0600, Grant Likely wrote:
> Fix some endian issues in the OF address translation code.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: Michal Simek <monstr@monstr.eu>
> CC: Wolfram Sang <w.sang@pengutronix.de>
> CC: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> CC: microblaze-uclinux@itee.uq.edu.au
> CC: linuxppc-dev@ozlabs.org
> ---
>  drivers/of/address.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 2a905d5..0b04137 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -22,7 +22,7 @@ static void of_dump_addr(const char *s, const u32 *addr, int na)
>  {
>  	printk(KERN_DEBUG "%s", s);
>  	while (na--)
> -		printk(" %08x", *(addr++));
> +		printk(" %08x", be32_to_cpu(*(addr++)));
>  	printk("\n");
>  }
>  #else
> @@ -79,8 +79,8 @@ static int of_bus_default_translate(u32 *addr, u64 offset, int na)
>  	memset(addr, 0, na * 4);
>  	a += offset;
>  	if (na > 1)
> -		addr[na - 2] = a >> 32;
> -	addr[na - 1] = a & 0xffffffffu;
> +		addr[na - 2] = cpu_to_be32(a >> 32);
> +	addr[na - 1] = cpu_to_be32(a & 0xffffffffu);
>  
>  	return 0;
>  }
> @@ -190,14 +190,16 @@ const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
>  	psize /= 4;
>  
>  	onesize = na + ns;
> -	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
> -		if ((prop[0] & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
> +	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++) {
> +		u32 val = be32_to_cpu(prop[0]);
> +		if ((val & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
>  			if (size)
>  				*size = of_read_number(prop + na, ns);
>  			if (flags)
>  				*flags = bus->get_flags(prop);
>  			return prop;
>  		}
> +	}
>  	return NULL;
>  }
>  EXPORT_SYMBOL(of_get_pci_address);
