Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9F09B7C53
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 07:38:50 +1100 (EST)
Subject: Re: PCI-PCI bridge scanning broken on 460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <4B49CE8A.7000609@embedded-sol.com>
References: <4B388D9D.7010404@embedded-sol.com>
	<1262584539.2173.335.camel@pasglop> <4B41ADF1.1000400@embedded-sol.com>
	<4B49CE8A.7000609@embedded-sol.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Jan 2010 07:38:26 +1100
Message-ID: <1263155906.724.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-01-10 at 14:56 +0200, Felix Radensky wrote:

> I now have a custom board with 460EX and the same PLX bridge, running 
> 2.6.23-rc3
> Things look better here, as u-boot is now able to properly detect PLX 
> and device behind
> it, but kernel still has problems. First, I'm still getting hard reset on
> 
> pci_write_config_dword(dev, PCI_PRIMARY_BUS,
>                                buses & ~0xffffff);
> 
> If this line is removed, PLX is detected twice, see below. I also get 
> hard reset
> if pass test is modified as you requested and broken test removed.
> 
> Any ideas how to fix this ? I was suspecting PLX evaluation board, but
> PLX on our custom board seems to be OK, so it looks like kernel needs 
> fixing.

I have no idea no. It looks like something is wrong with the PLX bridge
but again, I don't know why that would cause the 460EX to hard reset
like that, unless some of the PCIe error handling of the 460 has been
configured to cause such a reset on some kind of errors (which it
shouldn't at least not in host mode).

Can you try instead of writing all the bus number related registers in
one single dword write above, writing them byte by byte ? Which one is
causing the reset ? Does it reset whatever the value you write there
is ?

It looks like something is causing a hard reset as soon as you try to
configure the PLX bridge and without configuring it properly I fail to
see how you'll get things working.

Cheers,
Ben.
