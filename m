Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 413EF68637
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 14:42:32 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: maz@misterjones.org
In-Reply-To: <wrpll0of535.fsf@wild-wind.fr.eu.org>
References: <wrpll0of535.fsf@wild-wind.fr.eu.org>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 14:38:29 +1000
Message-Id: <1129869509.6265.32.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: v2.6.13.4 : Bad page state at prep_new_page when booting with
	quik
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-10-20 at 19:53 +0200, Marc Zyngier wrote:
> List,
> 
> I finally managed to bring back to life an old Apus 3000/200 (PowerMac
> 6400 clone, 603e@200, no L2 cache, 144MB RAM). Kernel is vanilla
> 2.6.13.4, userland is Debian Sarge.
> 
> The strange thing is : while the machine boots perfectly with BootX,
> it fills the console with messages like this when booted from quik :

Well, it definitely looks like something is wrong :) Not sure what's up
at this point. Could be cache coherency not properly enabled on PSX
memory controller by Open Firmware maybe ...

It would be useful if you could dump the memory controller registers
between an OF boot and a BootX boot.

Look at this bit in pmac_setup.c:

	sysctrl_regs = (volatile u32 *) ioremap(0xf8000000, 0x1000);
	ohare_init();

The first line maps those registers, the second line enables the L2
cache on PSX memory controller. (The name "ohare_init() is actually a
bit bogus here, since that has nothing to do with ohare, but we do it in
ohare based machines only... go figure, that's pre-historical code,
certainly predates my involvement here :).

I'd suggest dumping to 8 or so first words of sysctrl_regs and checking
what difference is there.

Then, there is another blob that enables cache coherency on the PCI side
of Bandit/PSX in pmac_pci.c in init_bandit(). But this code seems to be
called for you ...

It could be something else tho ... like some problem with quik...

Ben.
