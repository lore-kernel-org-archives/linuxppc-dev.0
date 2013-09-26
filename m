Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id B36D82C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 20:43:47 +1000 (EST)
Date: Thu, 26 Sep 2013 12:45:48 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130926104548.GB16774@dhcp-26-207.brq.redhat.com>
References: <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org>
 <20130925180220.GB26273@google.com>
 <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
 <20130925210016.GA8926@htj.dyndns.org>
 <20130926074646.GA16774@dhcp-26-207.brq.redhat.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B735D@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B735D@saturn3.aculab.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, Jan Beulich <JBeulich@suse.com>,
 Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 26, 2013 at 09:58:53AM +0100, David Laight wrote:
> Would it be possible to do some kind of 2-stage allocation.
> In the first pass the driver would pass a minimum and desired
> number of MSI-X interrupts, but not actually be given any.

Repeated calls to msi_enable_msi/msix() is what we are trying to avoid.

> Interrupts could then be allocated after it is known how many
> are required and how many are available.

Yep, that what we are heading to. So basic pattern I see would be like this:

	int foo_driver_enable_msix(struct pci_dev *pdev, int nvec)
	{
		...

		rc = pci_msix_table_size(pdev);
		if (rc < 0)
			return rc;

		nvec = min(nvec, rc);
		if (nvec < FOO_DRIVER_MINIMUM_NVEC)
			goto single_msi;

		for (i = 0; i < nvec; i++)
			entries[i].entry = i;

		rc = pci_enable_msix(pdev, entries, nvec);
		if (rc)
			goto single_msi;

		return 0;

	single_msi:
		...

	}

But this will break pSeries and we might end up with something like this:

	int foo_driver_enable_msix(struct pci_dev *pdev, int nvec)
	{
		...

		rc = pci_msix_table_size(pdev);
		if (rc < 0)
			return rc;

		nvec = min(nvec, rc);
		if (nvec < FOO_DRIVER_MINIMUM_NVEC)
			goto single_msi;

		rc = pci_get_msix_limit(pdev, nvec);
		if (rc < 0)
			return rc;

		nvec = min(nvec, rc);
		if (nvec < FOO_DRIVER_MINIMUM_NVEC)
			goto single_msi;

		for (i = 0; i < nvec; i++)
			entries[i].entry = i;

		rc = pci_enable_msix(pdev, entries, nvec);
		if (rc)
			goto single_msi;

		return 0;

	single_msi:
		...

	}

> 	David

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
