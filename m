Return-Path: <tie-fei.zang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0151.outbound.protection.outlook.com [207.46.163.151])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 96F092C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 10:38:51 +1100 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: Scott Wood <scottwood@freescale.com>, "Minghuan.Lian@freescale.com"
 <Minghuan.Lian@freescale.com>
Subject: RE: [02/12,v3] pci: fsl: add structure fsl_pci
Date: Wed, 22 Jan 2014 23:38:44 +0000
Message-ID: <8e74276365a14c8dae10d12cf57edc7e@BLUPR03MB165.namprd03.prod.outlook.com>
References: <1382524894-15164-2-git-send-email-Minghuan.Lian@freescale.com>
 <20140103221923.GB22546@home.buserror.net>
In-Reply-To: <20140103221923.GB22546@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, January 03, 2014 4:19 PM
> To: Lian Minghuan-B31939
> Cc: linuxppc-dev@lists.ozlabs.org; linux-pci@vger.kernel.org; Zang Roy-
> R61911; Bjorn Helgaas
> Subject: Re: [02/12,v3] pci: fsl: add structure fsl_pci
>=20
> On Wed, Oct 23, 2013 at 06:41:24PM +0800, Minghuan Lian wrote:
> > PowerPC uses structure pci_controller to describe PCI controller, but
> > ARM uses structure pci_sys_data. In order to support PowerPC and ARM
> > simultaneously, the patch adds a structure fsl_pci that contains most
> > of the members of the pci_controller and pci_sys_data.
> > Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
> > be implemented in architecture-specific PCI controller driver to
> > convert pci_controller or pci_sys_data to fsl_pci.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> >
> > ---
> > change log:
> > v1-v3:
> > Derived from http://patchwork.ozlabs.org/patch/278965/
> >
> > Based on upstream master.
> > Based on the discussion of RFC version here
> > http://patchwork.ozlabs.org/patch/274487/
> >
> >  include/linux/fsl/pci-common.h | 41
> > +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/include/linux/fsl/pci-common.h
> > b/include/linux/fsl/pci-common.h index 5e4f683..e56a040 100644
> > --- a/include/linux/fsl/pci-common.h
> > +++ b/include/linux/fsl/pci-common.h
> > @@ -102,5 +102,46 @@ struct ccsr_pci {
> >
> >  };
> >
> > +/*
> > + * Structure of a PCI controller (host bridge)  */ struct fsl_pci {
> > +	struct list_head node;
> > +	bool is_pcie;
> > +	struct device_node *dn;
> > +	struct device *dev;
> > +
> > +	int first_busno;
> > +	int last_busno;
> > +	int self_busno;
> > +	struct resource busn;
> > +
> > +	struct pci_ops *ops;
> > +	struct ccsr_pci __iomem *regs;
> > +
> > +	u32 indirect_type;
> > +
> > +	struct resource io_resource;
> > +	resource_size_t io_base_phys;
> > +	resource_size_t pci_io_size;
> > +
> > +	struct resource mem_resources[3];
> > +	resource_size_t mem_offset[3];
> > +
> > +	int global_number;	/* PCI domain number */
> > +
> > +	resource_size_t dma_window_base_cur;
> > +	resource_size_t dma_window_size;
> > +
> > +	void *sys;
> > +};
>=20
> I don't like the extent to which this duplicates (not moves) PPC's struct
> pci_controller.  Also this leaves some fields like "indirect_type"
> unexplained (PPC_INDIRECT_TYPE_xxx is only in the PPC header).
INDIRECT type is for configuration space access, I do not think it is ppc h=
eader specific.
It is good to put it to freescale pci common code.
Roy
