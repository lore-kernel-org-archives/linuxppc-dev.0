Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 92ECA2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 19:39:43 +1100 (EST)
Date: Fri, 11 Oct 2013 10:41:09 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Mark Lord <kernel@start.ca>
Subject: Re: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
Message-ID: <20131011084108.GA25702@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <5254D397.9030307@zytor.com> <1381292648.645.259.camel@pasglop>
 <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
 <5256D5AB.4050105@zytor.com>
 <20131010180704.GA15719@dhcp-26-207.brq.redhat.com>
 <5257357E.8080506@start.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5257357E.8080506@start.ca>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, iss_storagedev@hp.com, linux-driver@qlogic.com,
 Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 10, 2013 at 07:17:18PM -0400, Mark Lord wrote:
> Just to help us all understand "the loop" issue..
> 
> Here's an example of driver code which uses the existing MSI-X interfaces,
> for a device which can work with either 16, 8, 4, 2, or 1 MSI-X interrupt.
> This is from a new driver I'm working on right now:
> 
> 
> static int xx_alloc_msix_irqs (struct xx_dev *dev, int nvec)
> {
>         xx_disable_all_irqs(dev);
>         do {
>                 if (nvec < 2)
>                         xx_prep_for_1_msix_vector(dev);
>                 else if (nvec < 4)
>                         xx_prep_for_2_msix_vectors(dev);
>                 else if (nvec < 8)
>                         xx_prep_for_4_msix_vectors(dev);
>                 else if (nvec < 16)
>                         xx_prep_for_8_msix_vectors(dev);
>                 else
>                         xx_prep_for_16_msix_vectors(dev);
>                 nvec = pci_enable_msix(dev->pdev, dev->irqs, dev->num_vectors);
>         } while (nvec > 0);
> 
>         if (nvec) {
>                 kerr(dev->name, "pci_enable_msix() failed, err=%d", nvec);
>                 dev->num_vectors = 0;
>                 return nvec;
>         }
>         return 0;       /* success */
> }

Yeah, that is a very good example.

I would move all xx_prep_for_<pow2>_msix_vector() functions to a single
helper i.e. xx_prep_msix_vectors(dev, ndev).

Considering also (a) we do not want to waste unused platform resources
associated with MSI-Xs and pull more quota than needed and (b) fixing
couple of bugs, this function could look like this:

static int xx_alloc_msix_irqs(struct xx_dev *dev, int nvec_in)
{
	int nvec = roundup_pow_of_two(nvec_in);	/* assume 0 > nvec_in <= 16 */
	int rc;

	xx_disable_all_irqs(dev);

retry:
       	xx_prep_for_msix_vectors(dev, nvec);

	rc = pci_enable_msix(dev->pdev, dev->irqs, nvec);	/* (b) */
	if (rc > 0) {
		nvec = rounddown_pow_of_two(nvec);		/* (a) */
		goto retry;
	}

	if (rc) {
		kerr(dev->name, "pci_enable_msix() failed, err=%d", rc);
		dev->num_vectors = 0;
		return rc;
	}

	dev->num_vectors = nvec;				/* (b) */
	return 0;       /* success */
}

Now, this is a loop-free alternative:

static int xx_alloc_msix_irqs(struct xx_dev *dev, int nvec)
{
	nvec = roundup_pow_of_two(nvec);	/* assume 0 > nvec <= 16 */

	xx_disable_all_irqs(dev);

	pci_lock_msi(dev->pdev);

	rc = pci_get_msix_limit(dev->pdev, nvec);
	if (rc < 0)
		goto err;

	nvec = min(nvec, rc);		/* if limit is more than requested */
	nvec = rounddown_pow_of_two(nvec);	/* (a) */

	xx_prep_for_msix_vectors(dev, nvec);

	rc = pci_enable_msix(dev->pdev, dev->irqs, nvec);	/* (b)	*/
	if (rc < 0)
		goto err;

	pci_unlock_msi(dev->pdev);

	dev->num_vectors = nvec;		/* (b) */
	return 0;

err:
	pci_unlock_msi(dev->pdev);

        kerr(dev->name, "pci_enable_msix() failed, err=%d", rc);
        dev->num_vectors = 0;
        return rc;
}

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
