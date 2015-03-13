Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 130331A04ED
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2015 09:38:01 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0114.outbound.protection.outlook.com [157.56.111.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 973651400B7
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2015 09:37:58 +1100 (AEDT)
Message-ID: <1426286261.27998.28.camel@freescale.com>
Subject: Re: [PATCH 3/4 RFC] fsl/msi: Add MSI bank allocation for kernel
 owned devices
From: Scott Wood <scottwood@freescale.com>
To: Bhushan Bharat-R65777 <Bharat.Bhushan@freescale.com>
Date: Fri, 13 Mar 2015 17:37:41 -0500
In-Reply-To: <CY1PR0301MB127628300C11CAF7ED4EE27390060@CY1PR0301MB1276.namprd03.prod.outlook.com>
References: <1425359866-31049-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1425359866-31049-3-git-send-email-Bharat.Bhushan@freescale.com>
 <1426116178.30327.88.camel@freescale.com>
 <CY1PR0301MB127628300C11CAF7ED4EE27390060@CY1PR0301MB1276.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-12 at 10:46 -0500, Bhushan Bharat-R65777 wrote:
> 
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, March 12, 2015 4:53 AM
> > To: Bhushan Bharat-R65777
> > Cc: linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH 3/4 RFC] fsl/msi: Add MSI bank allocation for kernel
> > owned devices
> > 
> > With the patchset as is, how would one indicate whether kernel devices
> > should get a bank?
> 
> For kernel owned device, in fsl_setup_msi_irqs() we check if there is
> a reserved MSI bank, if not then reserve a msi bank. If reserve fails
> then setup_msi_irq() fails. I think there is no fallback to Legacy
> interrupt.

If enabling MSI fails, it's up to the driver to fall back to legacy
interrupts (grep drivers for pci_enable_msi for examples).

> >  Specifically, when the kernel does have an MSI-
> > capable device but we'd prefer to use legacy interrupts to keep MSIs
> > available to VFIO.
> 
> Do we want this?

You'd previously raised concern about wanting to give all MSI banks to
VFIO.  The kernel might still have PCIe devices that are not
performance-critical.  That said, I'm not going to nack the patchset if
it requires the kernel to allocate a bank for itself.

> > > @@ -231,15 +304,12 @@ static int fsl_setup_msi_irqs(struct pci_dev
> > *pdev, int nvec, int type)
> > >  		if (specific_msi_bank) {
> > >  			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
> > >  		} else {
> > > -			/*
> > > -			 * Loop over all the MSI devices until we find one that
> > has an
> > > -			 * available interrupt.
> > > -			 */
> > > -			list_for_each_entry(msi_data, &msi_head, list) {
> > > -				hwirq = msi_bitmap_alloc_hwirqs(&msi_data-
> > >bitmap, 1);
> > > -				if (hwirq >= 0)
> > > -					break;
> > > +			msi_data = fsl_msi_get_reserved_msi_bank(pdev);
> > > +			if (!msi_data) {
> > > +				dev_err(&pdev->dev, "No MSI Bank allocated\n");
> > > +				goto out_free;
> > 
> > Is this really an error?  Seems like dev_info() would be more appropriate
> > to indicate the absence of a resource where you can fall back to another
> > option.
> 
> There is no fallback in fsl_setup_msi_irqs(), We have to error out from fsl_setup_msi_irqs(), no?

I meant as far as the user is concerned, not whether you return an error from the function.

-Scott
