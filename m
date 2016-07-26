Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryzjP3hvdzDqZk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 10:37:29 +1000 (AEST)
Message-ID: <1469493443.3419.4.camel@russell.cc>
Subject: Re: [PATCH] powernv/pci: Add PHB register dump debugfs handle
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Date: Tue, 26 Jul 2016 10:37:23 +1000
In-Reply-To: <20160722063655.GA28438@gwshan>
References: <20160722052336.3340-1-ruscur@russell.cc>
 <20160722063655.GA28438@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-07-22 at 16:36 +1000, Gavin Shan wrote:
> On Fri, Jul 22, 2016 at 03:23:36PM +1000, Russell Currey wrote:
> > 
> > On EEH events the kernel will print a dump of relevant registers.
> > If EEH is unavailable (i.e. CONFIG_EEH is disabled, a new platform
> > doesn't have EEH support, etc) this information isn't readily available.
> > 
> > Add a new debugfs handler to trigger a PHB register dump, so that this
> > information can be made available on demand.
> > 
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> 
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Hi Gavin, thanks for the review.

> 
> > 
> > ---
> > arch/powerpc/platforms/powernv/pci-ioda.c | 35
> > +++++++++++++++++++++++++++++++
> > 1 file changed, 35 insertions(+)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> > b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 891fc4a..ada2f3c 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -3018,6 +3018,38 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe
> > *pe)
> > 	}
> > }
> > 
> > +#ifdef CONFIG_DEBUG_FS
> > +static ssize_t pnv_pci_debug_write(struct file *filp,
> > +				   const char __user *user_buf,
> > +				   size_t count, loff_t *ppos)
> > +{
> > +	struct pci_controller *hose = filp->private_data;
> > +	struct pnv_phb *phb;
> > +	int ret = 0;
> 
> Needn't initialize @ret in advance. The code might be simpler, but it's
> only a personal preference:
> 
> 	struct pci_controller *hose = filp->private_data;
> 	struct pnv_phb *phb = hose ? hose->private_data : NULL;
> 
> 	if (!phb)
> 		return -ENODEV;
> 
> > 
> > +
> > +	if (!hose)
> > +		return -EFAULT;
> > +
> > +	phb = hose->private_data;
> > +	if (!phb)
> > +		return -EFAULT;
> > +
> > +	ret = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
> > +					  PNV_PCI_DIAG_BUF_SIZE);
> > +
> > +	if (!ret)
> > +		pnv_pci_dump_phb_diag_data(phb->hose, phb->diag.blob);
> > +
> > +	return ret < 0 ? ret : count;
> 
> return ret == OPAL_SUCCESS ? count : -EIO;

Yeah, that's much better.

> 
> > 
> > +}
> > +
> > +static const struct file_operations pnv_pci_debug_ops = {
> > +	.open	= simple_open,
> > +	.llseek	= no_llseek,
> > +	.write	= pnv_pci_debug_write,
> 
> It might be reasonable to dump the diag-data on read if it is trying
> to do it on write.

I'm not sure about this one.  I went with write since (at least, in my mind)
writing to a file feels like triggering an action, although we're not actually
reading any input.  It also means that it works the same way as the other PHB
debugfs entries (i.e. errinjct).

I could rework it into a read that said something like "PHB#%x diag data dumped,
check the kernel log", what do you think?

> 
> > 
> > +};
> > +#endif /* CONFIG_DEBUG_FS */
> > +
> > static void pnv_pci_ioda_create_dbgfs(void)
> > {
> > #ifdef CONFIG_DEBUG_FS
> > @@ -3036,6 +3068,9 @@ static void pnv_pci_ioda_create_dbgfs(void)
> > 		if (!phb->dbgfs)
> > 			pr_warning("%s: Error on creating debugfs on PHB#%x\n",
> > 				__func__, hose->global_number);
> > +
> > +		debugfs_create_file("regdump", 0200, phb->dbgfs, hose,
> > +				    &pnv_pci_debug_ops);
> 
> "diag-data" might be indicating or a better one you can name :)
> 
> Thanks,
> Gavin
> 
> > 
> > 	}
> > #endif /* CONFIG_DEBUG_FS */
> > }
> > -- 
> > 2.9.0
> > 
