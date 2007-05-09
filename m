Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F573DDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 10:44:56 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l490irtC003071
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 20:44:53 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l490irMS515010
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 20:44:53 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l490iqQM030448
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 20:44:53 -0400
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1178666385.14928.119.camel@localhost.localdomain>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de>
	<1178666385.14928.119.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 08 May 2007 19:39:09 -0500
Message-Id: <1178671149.3453.49.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-09 at 09:19 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2007-05-04 at 21:44 +0200, Arnd Bergmann wrote:
> 
> > > +void holly_show_cpuinfo(struct seq_file *m)
> > > +{
> > > +	seq_printf(m, "vendor\t\t: IBM\n");
> > > +	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
> > > +}
> > 
> > If it's an IBM product, it should come with a product code like 123-4567,
> > which fits in here, instead of just listing the CPU.
> 
> Should probably come from the device tree anyway.

It will with some cleanup patches I'm planning on.

> > > +	const struct exception_table_entry *entry;
> > > +
> > > +	/* Are we prepared to handle this fault */
> > > +	if ((entry = search_exception_tables(regs->nip)) != NULL) {
> > > +		tsi108_clear_pci_cfg_error();
> > > +		regs->msr |= MSR_RI;
> > > +		regs->nip = entry->fixup;
> > > +		return 1;
> > > +	}
> > > +	return 0;
> > > +}
> > 
> > Are you sure that you can use the generic exception table mechanism
> > like this? I can't see why it doesn't work, but it's something I haven't
> > seen anyone do like this.
> 
> Also, can't the TSI be configured to not generate MCE in that case ?

Not that I'm aware of.  They should only occur on the initial PCI bus
scan.

josh
