Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 285E667C9E
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 13:08:39 +1100 (EST)
Subject: Re: [RFC/PATCH 4/7] Powerpc MSI implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1ac327mer.fsf@ebiederm.dsl.xmission.com>
References: <1162884080.585336.70559261997.qpush@cradle>
	<20061107072125.68E9F67CA7@ozlabs.org>
	<20061107200730.GY27140@parisc-linux.org>
	<20061107201436.GE9533@flint.arm.linux.org.uk>
	<20061107204432.GZ27140@parisc-linux.org>
	<20061107204853.GF9533@flint.arm.linux.org.uk>
	<20061107210202.GA27140@parisc-linux.org>
	<20061107222514.GG9533@flint.arm.linux.org.uk>
	<1162938562.28571.531.camel@localhost.localdomain>
	<m1mz727syy.fsf@ebiederm.dsl.xmission.com>
	<1162944905.28571.551.camel@localhost.localdomain>
	<m1ac327mer.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 13:08:00 +1100
Message-Id: <1162951680.28571.627.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Matthew Wilcox <matthew@wil.cx>, Greg Kroah-Hartman <greg@kroah.com>,
	Ingo Molnar <mingo@elte.hu>,
	Russell King <rmk-pci@arm.linux.org.uk>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-11-07 at 18:33 -0700, Eric W. Biederman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> >> For message signalled interrupts and hyptertransport interrupts we probably
> > want
> >> to add an additional field for pointing to their per irq state.  Per device
> >> interrupt controllers are truly peculiar.
> >
> > A per-irq addition field for the MSI data might indeed be useful. I
> > still want to store it in the pci_dev, but it would be good to have a
> > pointer to it in the irq_desc.
> 
> The msi_info in pci_dev is reasonable.  But storing all 4096 possible
> msi_desc's in pci_dev seems a little much.

My initial idea was that the msi_info structure would have a variable
lenght, that is, would end with msi_desc[0] and would be allocated to
the the right size, but it might suck a bit :-)

> Hopefully I can look at this a little more this evening and see what we
> need to do to harmonize the two msi implementations.

Thanks !

Ben.
