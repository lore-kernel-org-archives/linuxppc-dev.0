Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC8BCDDE36
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:19:53 +1000 (EST)
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705042144.31194.arnd@arndb.de>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 09 May 2007 09:19:45 +1000
Message-Id: <1178666385.14928.119.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-04 at 21:44 +0200, Arnd Bergmann wrote:

> > +void holly_show_cpuinfo(struct seq_file *m)
> > +{
> > +	seq_printf(m, "vendor\t\t: IBM\n");
> > +	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
> > +}
> 
> If it's an IBM product, it should come with a product code like 123-4567,
> which fits in here, instead of just listing the CPU.

Should probably come from the device tree anyway.

> > +static int ppc750_machine_check_exception(struct pt_regs *regs)
> > +{
> > +	extern void tsi108_clear_pci_cfg_error(void);
> 
> move declaration to header file.
> 
> > +	const struct exception_table_entry *entry;
> > +
> > +	/* Are we prepared to handle this fault */
> > +	if ((entry = search_exception_tables(regs->nip)) != NULL) {
> > +		tsi108_clear_pci_cfg_error();
> > +		regs->msr |= MSR_RI;
> > +		regs->nip = entry->fixup;
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> 
> Are you sure that you can use the generic exception table mechanism
> like this? I can't see why it doesn't work, but it's something I haven't
> seen anyone do like this.

Also, can't the TSI be configured to not generate MCE in that case ?
