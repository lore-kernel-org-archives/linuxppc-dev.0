Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15DE467E9C
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2006 07:29:22 +1000 (EST)
Subject: Re: [PATCH] powerpc: make U4 PCIe work (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <64BDCE50-03D6-44BA-97EA-AA4AE5B53F32@kernel.crashing.org>
References: <1160113201.22232.112.camel@localhost.localdomain>
	<64BDCE50-03D6-44BA-97EA-AA4AE5B53F32@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 07:29:02 +1000
Message-Id: <1160170142.22232.132.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Fri, 2006-10-06 at 13:26 +0200, Segher Boessenkool wrote:
> > +static unsigned int u4_pcie_cfa0(u8 devfn, u8 off)
> 
> "off" should be bigger than u8...

Right

> > +{
> > +	return (1 << ((unsigned int)PCI_SLOT(devfn))) 	|
> > +		(((unsigned int)PCI_FUNC(devfn)) << 8) |
> > +		((((unsigned int)(off)) >> 8) << 28) 	|
> 
> ...and the compiler told you about that here.

No it didn't...

> Make the parameters and return value all u32 and you won't
> need casts anymore, the function call will implicitly do it.

Ben.
