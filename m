Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 024F367CC2
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 13:44:22 +1100 (EST)
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
	<m1mz727syy.fsf@ebiederm.dsl.xmission.com>
	<1162944905.28571.551.camel@localhost.localdomain>
	<m1ac327mer.fsf@ebiederm.dsl.xmission.com>
	<1162951680.28571.627.camel@localhost.localdomain>
Date: Tue, 07 Nov 2006 19:43:15 -0700
In-Reply-To: <1162951680.28571.627.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Wed, 08 Nov 2006 13:08:00 +1100")
Message-ID: <m1wt6664l8.fsf@ebiederm.dsl.xmission.com>
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

> My initial idea was that the msi_info structure would have a variable
> lenght, that is, would end with msi_desc[0] and would be allocated to
> the the right size, but it might suck a bit :-)

That could work.  The whole array of interrupts thing allocated on
device probe, I question a little bit.  I can just about see allocating
another interrupt if you can when a network device start getting another
flow through it.  But it is working well enough at the moment it doesn't
appear time to run out and change the drivers.

>> Hopefully I can look at this a little more this evening and see what we
>> need to do to harmonize the two msi implementations.
>
> Thanks !

I'm still having a hard time wrapping my head around the sanity of not letting
the kernel touch the hardware in the presence of a hypervisor.  How do you cope
with hardware that follows a specification the hypervisor is not aware of?

This seems to be a violation of the principle that the driver knows the hardware
better than some generic layer.

Eric
