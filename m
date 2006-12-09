Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59A4E67A39
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 13:14:56 +1100 (EST)
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200612090100.09380.arnd@arndb.de>
References: <20061207172259.64168f8c@localhost>
	<20061208185902.GA14675@localdomain>
	<1165618236.1103.87.camel@localhost.localdomain>
	<200612090100.09380.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 13:14:18 +1100
Message-Id: <1165630458.1103.109.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-12-09 at 01:00 +0100, Arnd Bergmann wrote:
> On Friday 08 December 2006 23:50, Benjamin Herrenschmidt wrote:
> > 
> > > 
> > > +     info->io.regsize        = resource0.end - resource0.start + 1;
> > > +     info->io.regspacing     = resource1.start - resource0.start;
> > > 
> > > Are you sure this is a reliable way to check the register spacing and
> > > register size?  Register size means "how big is a register (8, 16, 32
> > > bits)".  Register spacing means (how many bytes are there between
> > > registers.  If you had two registers that were 8 bits and 4 bytes
> > > apart, for instance, I don't believe the above calculations would work.
> > 
> > How many registers do we expect here ? Might be better to have one
> > resource represent the whole MMIO area, and have a separate property
> > that indicates the stride between 2 registers.
> 
> I think the current representation is perfect. AFAICS, there are always
> two registers, but depending on the HW implementation, they may be
> between 1 and 4 bytes wide, and can have a different spacing.
> 
> By having two separate areas in the reg property, the driver can
> easily determine both the size and the spacing. It will then do
> a single ioremap that spans both anyway.

For only 2 registers, it makes sense yes.

Ben.
