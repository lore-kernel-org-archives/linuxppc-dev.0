Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DD4767D05
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 10:24:46 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/7] Powerpc MSI implementation
References: <1162884080.585336.70559261997.qpush@cradle>
	<20061107072125.68E9F67CA7@ozlabs.org>
	<20061107200730.GY27140@parisc-linux.org>
	<20061107201436.GE9533@flint.arm.linux.org.uk>
	<20061107204432.GZ27140@parisc-linux.org>
	<20061107204853.GF9533@flint.arm.linux.org.uk>
	<20061107210202.GA27140@parisc-linux.org>
	<20061107222514.GG9533@flint.arm.linux.org.uk>
	<1162938562.28571.531.camel@localhost.localdomain>
Date: Tue, 07 Nov 2006 16:11:17 -0700
In-Reply-To: <1162938562.28571.531.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Wed, 08 Nov 2006 09:29:22 +1100")
Message-ID: <m1mz727syy.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> I guess we'll just have to add __force casts all over the code. ;(
>
> Or just do it in a single accessor function/macro...

Or treat struct irq_desc like struct page and have a members that
depend on features that you enable or disable depending on the architecture
dependent tradeoffs.

We already have a few members depend on things like SMP.

With the cache line alignment of each array entry we take up a fair amount of
space, so we don't have to micro optimize just do a decent job of not having
anything to terrible.

For message signalled interrupts and hyptertransport interrupts we probably want
to add an additional field for pointing to their per irq state.  Per device
interrupt controllers are truly peculiar.

Eric
