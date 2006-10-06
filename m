Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2439767D89
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 21:26:43 +1000 (EST)
In-Reply-To: <1160113201.22232.112.camel@localhost.localdomain>
References: <1160113201.22232.112.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <64BDCE50-03D6-44BA-97EA-AA4AE5B53F32@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: make U4 PCIe work (#2)
Date: Fri, 6 Oct 2006 13:26:25 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static unsigned int u4_pcie_cfa0(u8 devfn, u8 off)

"off" should be bigger than u8...

> +{
> +	return (1 << ((unsigned int)PCI_SLOT(devfn))) 	|
> +		(((unsigned int)PCI_FUNC(devfn)) << 8) |
> +		((((unsigned int)(off)) >> 8) << 28) 	|

...and the compiler told you about that here.

Make the parameters and return value all u32 and you won't
need casts anymore, the function call will implicitly do it.


Segher
