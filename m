Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C20E0DDEF8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 07:50:57 +1100 (EST)
Subject: Re: [PATCH] maple: improve CPC9x5 host bridge detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20070103185628.GE6279@localdomain>
References: <20070103185628.GE6279@localdomain>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 07:50:46 +1100
Message-Id: <1167857446.6165.155.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-03 at 12:56 -0600, Nathan Lynch wrote:
> Identify CPC9x5 PCI Express, AGP, and HT host bridges using
> device_type and compatible properties, which is a more flexible method
> than using the name property (which can differ between firmwares and
> models).
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>

Do that work on js20/js21 with SLOF ?

Ben.

> ---
>  arch/powerpc/platforms/maple/pci.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
> index 3f6a69f..011f0f1 100644
> --- a/arch/powerpc/platforms/maple/pci.c
> +++ b/arch/powerpc/platforms/maple/pci.c
> @@ -560,13 +560,16 @@ void __init maple_pci_init(void)
>  		return;
>  	}
>  	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;) {
> -		if (np->name == NULL)
> +		if (!np->type)
>  			continue;
> -		if (!strcmp(np->name, "pci") || !strcmp(np->name, "pcie")) {
> -			if (add_bridge(np) == 0)
> -				of_node_get(np);
> -		}
> -		if (strcmp(np->name, "ht") == 0) {
> +		if (strcmp(np->type, "pci") && strcmp(np->type, "ht"))
> +			continue;
> +		if ((device_is_compatible(np, "u4-pcie") ||
> +		     device_is_compatible(np, "u3-agp")) &&
> +		    add_bridge(np) == 0)
> +			of_node_get(np);
> +
> +		if (device_is_compatible(np, "u3-ht")) {
>  			of_node_get(np);
>  			ht = np;
>  		}
