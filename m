Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A651DDF13
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 02:22:04 +1100 (EST)
In-Reply-To: <20070111112507.E775CDDF0E@ozlabs.org>
References: <20070111112507.E775CDDF0E@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b359a2c351f628252dc385285911d37e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/7] Enable MSI mappings for MPIC
Date: Thu, 11 Jan 2007 16:22:22 +0100
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Olof Johannsson <olof@lixom.net>,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	flags = readb(base + HT_MSI_FLAGS);
> +	if (!(flags & HT_MSI_FLAGS_FIXED)) {
> +		addr = readl(base + HT_MSI_ADDR_LO) & HT_MSI_ADDR_LO_MASK;
> +		addr = addr | ((u64)readl(base + HT_MSI_ADDR_HI) << 32);
> +	}
> +
> +	printk(KERN_INFO "mpic:   - HT:%02x.%x %s MSI mapping found @ 
> 0x%lx\n",
> +		PCI_SLOT(devfn), PCI_FUNC(devfn),
> +		flags & HT_MSI_FLAGS_ENABLE ? "enabled" : "disabled", addr);

It's not safe in general to just take what the hardware
is currently set to.

Perhaps it is best to just always program 0xfee00000 (it's
a per-bus thing so you can use the same address everywhere),
since that address *has* to not conflict with other mappings
already, it being the standard fixed address and everything.


Segher
