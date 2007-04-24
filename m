Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 096AEDDE45
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 23:27:53 +1000 (EST)
In-Reply-To: <20070424223245.78f4fdfb.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug .org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
Date: Tue, 24 Apr 2007 15:27:42 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +int of_n_addr_cells(struct device_node *np)
> +{
> +	const int *ip;
> +
> +	do {
> +		if (np->parent)
> +			np = np->parent;
> +		ip = of_get_property(np, "#address-cells", NULL);
> +		if (ip)
> +			return *ip;
> +	} while (np->parent);
> +	/* No #address-cells property for the root node */
> +	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
> +}
> +EXPORT_SYMBOL(of_n_addr_cells);

While I realise your patch is just moving stuff around,
can this be fixed please?  A missing "#address-cells"
property means "two cells", not "inherit from parent".
The few platforms with a broken tree should just be
fixed (patch the tree in the bootwrapper, or perhaps
_do_ use this workaround, but only on the affected
platforms).

> +int of_n_size_cells(struct device_node *np)

Same here (the default is one cell though).

> --- a/include/asm-powerpc/prom.h
> +++ b/include/asm-powerpc/prom.h
> @@ -21,6 +21,9 @@
>  #include <asm/irq.h>
>  #include <asm/atomic.h>
>
> +#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
> +#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1

Even worse!

> --- a/include/asm-sparc/prom.h
> +++ b/include/asm-sparc/prom.h
> @@ -20,6 +20,9 @@
>  #include <linux/proc_fs.h>
>  #include <asm/atomic.h>
>
> +#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
> +#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1

Those are the defaults for all nodes, not just the
root node.


Segher
