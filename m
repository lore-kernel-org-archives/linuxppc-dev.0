Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id AF73D2C038C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 18:46:58 +1100 (EST)
Date: Tue, 8 Oct 2013 09:48:26 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC 07/77] PCI/MSI: Re-design MSI/MSI-X interrupts
 enablement pattern
Message-ID: <20131008074826.GD10669@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <d8c36203ada6efbfa9f7ce92c2f713ee3b6d6b8d.1380703262.git.agordeev@redhat.com>
 <20131007181749.GB27396@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131007181749.GB27396@htj.dyndns.org>
Cc: linux-mips@linux-mips.org, linux-doc@vger.kernel.org, "VMware,
 Inc." <pv-drivers@vmware.com>, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, iss_storagedev@hp.com, linux-driver@qlogic.com,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
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

On Mon, Oct 07, 2013 at 02:17:49PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Wed, Oct 02, 2013 at 12:48:23PM +0200, Alexander Gordeev wrote:
> > +static int foo_driver_enable_msi(struct foo_adapter *adapter, int nvec)
> > +{
> > +	rc = pci_get_msi_cap(adapter->pdev);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	nvec = min(nvec, rc);
> > +	if (nvec < FOO_DRIVER_MINIMUM_NVEC) {
> > +		return -ENOSPC;
> > +
> > +	rc = pci_enable_msi_block(adapter->pdev, nvec);
> > +	return rc;
> > +}
> 
> If there are many which duplicate the above pattern, it'd probably be
> worthwhile to provide a helper?  It's usually a good idea to reduce
> the amount of boilerplate code in drivers.

I wanted to limit discussion in v1 to as little changes as possible.
I 'planned' those helper(s) for a separate effort if/when the most
important change is accepted and soaked a bit.

> > @@ -975,7 +951,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
> >  	if (nr_entries < 0)
> >  		return nr_entries;
> >  	if (nvec > nr_entries)
> > -		return nr_entries;
> > +		return -EINVAL;
> >  
> >  	/* Check for any invalid entries */
> >  	for (i = 0; i < nvec; i++) {
> 
> If we do things this way, it breaks all drivers using this interface
> until they're converted, right?

Right. And the rest of the series does it.

> Also, it probably isn't the best idea
> to flip the behavior like this as this can go completely unnoticed (no
> compiler warning or anything, the same function just behaves
> differently).  Maybe it'd be a better idea to introduce a simpler
> interface that most can be converted to?

Well, an *other* interface is a good idea. What do you mean with the
simpler here?

> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
