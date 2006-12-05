Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8139367CC5
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 09:30:32 +1100 (EST)
Subject: Re: [POWERPC] fix cell pmu initialisation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1165357316.4785.0.camel@concordia.ozlabs.ibm.com>
References: <20061205155414.4afdcc77.sfr@canb.auug.org.au>
	<200612051434.07917.arnd@arndb.de>
	<1165349272.29784.69.camel@localhost.localdomain>
	<1165357316.4785.0.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 09:31:15 +1100
Message-Id: <1165357875.5469.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	Arnd Bergmann <arnd@arndb.de>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-06 at 09:21 +1100, Michael Ellerman wrote:
> On Wed, 2006-12-06 at 07:07 +1100, Benjamin Herrenschmidt wrote:
> > > 1. export a method from cbe_regs.c to find out whether the pmd 
> > >    regs are available and test that in cbe_init_pm_irq().
> > > 2. take you patch as is, with a comment hinting to fix it up
> > >    when needed.
> > > 3. change cbe_init_pm_irq to be called explicitly from cbe_regs_init(),
> > >    which already scans the device tree correctly.
> > 
> > cbe_regs_init() is called from setup_arch(), which is _very_ early.
> > 
> > cbe_init_pm_irq() must be called much later as it requests irqs.
> > 
> > Right now, we should stick to the machine_is() solution. We'll look into
> > doing something better eventually when the need occurs.
> 
> 4. Add a FIRMWARE_FEATURE for it.

Not sure yet ... it's not really a firmware feature... Let's keep the
machine_is(cell) for now.

Ben.
