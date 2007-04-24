Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 580B6DDF0D
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 19:51:57 +1000 (EST)
Subject: Re: [PATCH 6/7] MPIC MSI allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <dbba27bc913250681a57be91605e25f2@kernel.crashing.org>
References: <1176968125.531108.326168797246.qpush@cradle>
	<20070419073555.D2C3EDDEFD@ozlabs.org>
	<20070423035025.GA29839@lixom.net>
	<1177378169.14873.46.camel@localhost.localdomain>
	<f5dd623fbb338d38bc05567ee178b886@kernel.crashing.org>
	<1177407551.14873.105.camel@localhost.localdomain>
	<dbba27bc913250681a57be91605e25f2@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 19:51:45 +1000
Message-Id: <1177408305.14873.107.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-24 at 11:44 +0200, Segher Boessenkool wrote:
> >> First-gen G5's need that just as well, they just don't
> >> have such interrupts on the default system configuration,
> >> as far as I remember.
> >
> > They didn't have an HT APIC or if they had one, they didn't enable it
> > (they probably did in the tunnel).
> 
> Yes, the two HT APICs on the tunnel were enabled.
> 
> > They didn't use the U3 MPIC as an HT
> > IRQ master, thus it's irrelevant.
> 
> They did for the plugin PCI-X slots (well, it's chained
> to another MPIC, but you still need the workaround).

No you didn't. The slots IRQ lines were physically routed to GPIOs on
the southbridge MPIC. The -only- thing the northbridge MPIC was useful
for was the NB internal interrupts (like the i2c one).

> > Anyway, there is no point in this
> > discussion :-)
> 
> Yeah, the new name for CONFIG_BROKEN_U3 is fine
> no matter what :-)
> 
> 
> Segher
