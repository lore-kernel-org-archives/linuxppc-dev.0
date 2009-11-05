Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28E67B7B9A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 07:00:34 +1100 (EST)
Subject: Re: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
	resources.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@suse.de>
In-Reply-To: <1257437226.2753.64.camel@mulgrave.site>
References: <1253053555-25097-1-git-send-email-pbathija@amcc.com>
	<20091105134330.GA30489@zod.rchland.ibm.com>
	<1257437226.2753.64.camel@mulgrave.site>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 Nov 2009 07:00:18 +1100
Message-ID: <1257451218.13611.114.camel@pasglop>
Mime-Version: 1.0
Cc: Eric.Moore@lsi.com, pbathija@amcc.com, linux-scsi@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-05 at 10:07 -0600, James Bottomley wrote:

> > > 	ioc->memmap = mem;
> > >-	dinitprintk(ioc, printk(MYIOC_s_INFO_FMT "mem = %p, mem_phys = %lx\n",
> > >-	    ioc->name, mem, mem_phys));
> > >+	dinitprintk(ioc, printk(MYIOC_s_INFO_FMT "mem = %p, mem_phys = %llx\n",
> > >+	    ioc->name, mem, (u64)mem_phys));
> > >
> > > 	ioc->mem_phys = mem_phys;
> > > 	ioc->chip = (SYSIF_REGS __iomem *)mem;
> > >
> > > 	/* Save Port IO values in case we need to do downloadboot */
> > >-	ioc->pio_mem_phys = port;
> > >+	port = ioremap(port_phys, psize);
> > >+	if (port == NULL) {
> > >+		printk(MYIOC_s_ERR_FMT " : ERROR - Unable to map adapter"
> > >+			" port !\n", ioc->name);
> > >+		return -EINVAL;
> 
> So this looks problematic on a few platforms ... what happens to
> platforms that have no IO space?  They automatically fail here and it
> looks like the adapter never attaches.

Yup, that part of the patch looks wrong.

However, a mechanical replacement of unsigned long's with
resource_size_t to hold physical addresses should be fine despite the
lack of feedback from LSI.

Pravin, that ioremap definitely seems like it has nothing to do there,
port IO is already remapped for you by the core PCI code and should work
"as is". Please respin without that change.

Cheers,
Ben.
