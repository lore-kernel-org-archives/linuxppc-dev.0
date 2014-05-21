Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B90811A085D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 07:56:43 +1000 (EST)
Message-ID: <1400709391.29150.24.camel@pasglop>
Subject: Re: [PATCH v5 3/4] drivers/vfio: EEH support for VFIO PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 22 May 2014 07:56:31 +1000
In-Reply-To: <537CA50E.9090404@suse.de>
References: <1400648623-9127-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400648623-9127-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <537CA50E.9090404@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-05-21 at 15:07 +0200, Alexander Graf wrote:

> > +#ifdef CONFIG_VFIO_PCI_EEH
> > +int eeh_vfio_open(struct pci_dev *pdev)
> 
> Why vfio? Also that config option will not be set if vfio is compiled as 
> a module.
> 
> > +{
> > +	struct eeh_dev *edev;
> > +
> > +	/* No PCI device ? */
> > +	if (!pdev)
> > +		return -ENODEV;
> > +
> > +	/* No EEH device ? */
> > +	edev = pci_dev_to_eeh_dev(pdev);
> > +	if (!edev || !edev->pe)
> > +		return -ENODEV;
> > +
> > +	eeh_dev_set_passed(edev, true);
> > +	eeh_pe_set_passed(edev->pe, true);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(eeh_vfio_open);

Additionally, shouldn't we have some locking here ? (and in release too)

I don't like relying on the caller locking (if it does it at all).

> > +	/* Device existing ? */
> > +	ret = eeh_vfio_check_dev(pdev, &edev, &pe);
> > +	if (ret) {
> > +		pr_debug("%s: Cannot find device %s\n",
> > +			__func__, pdev ? pci_name(pdev) : "NULL");
> > +		*retval = -7;
> 
> What are these? Please use proper kernel internal return values for 
> errors. I don't want to see anything even remotely tied to RTAS in any 
> of these patches.

Hint: -ENODEV

Cheers,
Ben.
