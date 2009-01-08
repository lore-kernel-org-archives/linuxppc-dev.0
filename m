Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 679EA474C3
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 07:59:53 +1100 (EST)
Date: Thu, 8 Jan 2009 23:59:51 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Liu Dave <DaveLiu@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/fsl_pci: Add MPC83xx PCI-E controller RC
	modesupport
Message-ID: <20090108205951.GA24829@oksana.dev.rtsoft.ru>
References: <20090108013006.GA31653@oksana.dev.rtsoft.ru>
	<20090108013110.GA11165@oksana.dev.rtsoft.ru>
	<D7CCA83BB0796C49BC0BB53B6AB12089056CC6@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB12089056CC6@zch01exm21.fsl.freescale.net>
Cc: Huang Changming-R66093 <Chang-Ming.Huang@freescale.com>,
	Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 08, 2009 at 03:27:10PM +0800, Liu Dave wrote:
> > +static void __iomem *mpc83xx_pcie_remap_cfg(struct pci_bus *bus,
> > +					    unsigned int devfn, 
> 
> [snip]
> 
> > +	if (pcie->dev_base == dev_base)
> > +		goto mapped;
> > +
> > +	out_le32(hose->cfg_data + PEX_OUTWIN0_TAL, dev_base);
> > +
> > +	pcie->dev_base = dev_base;
> 
> Do we need local_irq_save/local_irq_restore between them?

No, I don't think we need it. drivers/pci/access.c hold an
irqsave spinlock for ->read and ->write callbacks.

> out_le32(PEX_OUTWIN0_TAL,...) and pcie->dev_base = dev_base;

> > +mapped:
> > +	return pcie->cfg_map + offset;
> > +}

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
