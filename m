Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65BF7DDE43
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 07:39:57 +1000 (EST)
Subject: Re: Problem with OF interrupt parsing code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20071001211120.156280@gmx.net>
References: <20071001210025.314240@gmx.net>  <20071001211120.156280@gmx.net>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 07:39:47 +1000
Message-Id: <1191274787.6310.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-01 at 23:11 +0200, Gerhard Pircher wrote:
>         pci@80000000 {
>                 device_type = "pci";
>                 compatible = "mai-logic,articia-s";
>                 bus-frequency = <01fca055>;             // 33.3MHz
>                 bus-range = <0 ff>;
>                 ranges = <01000000 0 00000000 fe000000 0
> 00c00000       // PCI I/O
>                           02000000 0 80000000 80000000 0
> 7d000000       // PCI memory
>                           02000000 0 fd000000 fd000000 0
> 01000000>;     // PCI alias memory
>                 8259-interrupt-acknowledge = <fef00000>;
>                 interrupt-parent = <&i8259>;
>                 #interrupt-cells = <1>;
>                 #address-cells = <3>;
>                 #size-cells = <2>;
> 

Part of your problem is that interrupt-parent property. You shouldn't
have such a property in a PCI host bridge. It's not technically illegal,
but it's triggering the "loop" you've been experiencing.

If you want the parsing to fail for PCI devices (to get the fallback to
config space values), you need to make sure it does fail. 

Another option is to put an empty interrupt-map in there. That will
guarantee failure.

But that's all very ugly. I don't understand why you don't setup a
proper map either from your bootloader, zImage wrapper or even prom_init
or platform code.

Ben.
