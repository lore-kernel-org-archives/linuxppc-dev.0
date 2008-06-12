Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5B4ADE22C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 06:37:13 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5CKb7PG023315
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:37:07 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5CKb74x225566
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:37:07 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5CKb7Eq025580
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:37:07 -0400
Date: Thu, 12 Jun 2008 16:36:15 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] powerpc/4xx: Workaround for PPC440EPx/GRx PCI_28 Errata
Message-ID: <20080612163615.1ba71e36@zod.rchland.ibm.com>
In-Reply-To: <200806121624.13577.sr@denx.de>
References: <20080611104549.45836929@zod.rchland.ibm.com>
	<200806121624.13577.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 12 Jun 2008 16:24:13 +0200
Stefan Roese <sr@denx.de> wrote:

> On Wednesday 11 June 2008, Josh Boyer wrote:
> > The 440EPx/GRx chips don't support PCI MRM commands.  Drivers determine
> > this by looking for a zero value in the PCI cache line size register. 
> > However, some drivers write to this register upon initialization.  This can
> > cause MRMs to be used on these chips, which may cause deadlocks on PLB4.
> >
> > The workaround implemented here introduces a new indirect_type flag, called
> > PPC_INDIRECT_TYPE_BROKEN_MRM.  This is set in the pci_controller structure
> > in the pci fixup function for 4xx PCI bridges by determining if the bridge
> > is compatible with 440EPx/GRx.  The flag is checked in the
> > indirect_write_config function, and forces any writes to the
> > PCI_CACHE_LINE_SIZE register to be zero, which will disable MRMs for these
> > chips.
> >
> > A similar workaround has been tested by AMCC on various PCI cards, such as
> > the Silicon Image ATA card and Intel E1000 GIGE card.  Hangs were seen with
> > the Silicon Image card, and MRMs were seen on the bus with a PCI analyzer.
> > With the workaround in place, the card functioned properly and only Memory
> > Reads were seen on the bus with the analyzer.
> >
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Acked-by: Stefan Roese <sr@denx.de>
> 
> I manually applied your patch (since it doesn't apply clean as discussed on 
> IRC) and tested it on my Sequoia with a modified PCI USB driver changing 
> PCI_CACHE_LINE_SIZE.

Thanks.  I blame git for being dumb.  I guess I'll have to switch to
using git-format-patch instead of quilt.

In the meantime, I'll queue this up for .27.

josh
