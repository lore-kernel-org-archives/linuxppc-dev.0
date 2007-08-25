Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5D2EDDE22
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 19:50:11 +1000 (EST)
In-Reply-To: <20070825092954.4087.95333.stgit@localhost.localdomain>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825092954.4087.95333.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <67f53d72d17c98f2b8a76ec42195c0aa@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Add pci node to sequoia dts
Date: Sat, 25 Aug 2007 11:49:58 +0200
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +		pci {
> +    			reg = <1 eec00000 40 1 ef400000 40>;  /* phb cfg, phb reg */

First component of reg is the unit address, so: pci@1eec00000 .

"phb cfg" is how you access PCI configuration space?  It wouldn't
hurt to document that, either in a little binding or just here in
the code.

> +			bus-range = <0 0>;

Can't you have subordinate PCI busses?  Or are there no slots :-)

> +			/*
> +			 * mem is at 80000000 set up indirectly
> +			 * io is at 0001_e800_0000
> +			 */
> +			ranges = <02000000 0 80000000 1 80000000 0 10000000
> +				01000000 0 00000000 1 e8000000 0 00100000>;

Comment doesn't match code for the memory space.  What does "set
up indirectly" mean here?  Oh wait, you want to say that the host
addresses 1_8000_0000..1_8fff_ffff are translated to PCI addresses
8000_0000..8fff_ffff.

What about PCI DMA, is that identity mapped?

> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;

The reverse order of these is more conventional.  Not that it
actually matters ;-)

> +			compatible = "ibm, 440epx";

Stray space.  And you need to say it is the PCI host, so something
like "ibm,440epx-pci".


Segher
