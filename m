Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1512DDFB4
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 09:15:07 +1000 (EST)
Subject: Re: PCI IO range limitation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <46853CA2.2040203@genesi-usa.com>
References: <46838B54.2010806@semihalf.com>
	<1183052634.5521.284.camel@localhost.localdomain>
	<46844692.1040804@genesi-usa.com>
	<1183075997.5521.292.camel@localhost.localdomain>
	<46853CA2.2040203@genesi-usa.com>
Content-Type: text/plain
Date: Sat, 30 Jun 2007 09:14:59 +1000
Message-Id: <1183158899.5521.377.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Define "legacy device"? What should that entail? You mean like mapping
> most of those registers to the first couple of kilobytes of "IO"?

Anything that hard-decodes IOs in the low ISA range yes. That includes
VGA video cards.

> If they're just left as their own on their own as PCI devices, why would
> it matter what the window was?

Because quite a few of those things hard decodes (can't be moved around,
so -have- to be able to generate cycles to those low addresses to hit
them) and sometimes don't even fully decode the 32 bits addresses
(though that's more rare).

For example, a VGA video card in text mode hard decodes both IO and
Memory at the legacy VGA ranges.

Ben.
