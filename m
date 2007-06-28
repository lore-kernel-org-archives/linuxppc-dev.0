Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 558C4DDF84
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 19:18:55 +1000 (EST)
In-Reply-To: <20070628002342.GA15298@localhost.localdomain>
References: <11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
	<1182907014549-git-send-email-galak@kernel.crashing.org>
	<1182907015126-git-send-email-galak@kernel.crashing.org>
	<11829070192461-git-send-email-galak@kernel.crashing.org>
	<C84F154C-EBC9-471F-A1E1-635A385E684A@freescale.com>
	<8fa84ed4810eb9aca18739bf709e71d9@kernel.crashing.org>
	<20070628002342.GA15298@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a1ed95f1e363e3a939817b19e4d60e44@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 09/15] [POWERPC] 86xx: Add uli1575 pci-bridge sector to
	MPC8641HPCN dts file.
Date: Thu, 28 Jun 2007 11:18:49 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> This can't be right, and I suspect it will break any kernel access to
>>> the first 0x1000 bytes of the CCSR_BAR space.  reg should actually
>>> describe the register space of the SOC.  If ranges needs to specify
>>> that, too, they should be able to be redundant.  But this looks like
>>> a big hack, to me.  Am I missing something?
>>
>> "reg" and "ranges" can never overlap really.
>
> Is this really true, always?

Well think about it.  "reg" is the addresses your bridge
device's registers sit at.  "ranges" is the addresses your
bridge translates to its child bus.

> What about something like a PReP PCI bridge, which has the registers
> for indirect config-space access in the same range as the ISA IO
> space?

Yeah there are always nasty corner cases that are hard
to express.  Like a PHB that is visible as a device on
its own PCI bus -- it would have to be its own child in
the device tree!  Such devices are best dealt with on
a one-by-one basis.


Segher
