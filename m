Return-Path: <jon.mason@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id 3D22C2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 10:39:09 +1000 (EST)
Date: Wed, 2 Oct 2013 17:39:05 -0700
From: Jon Mason <jon.mason@intel.com>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 01/77] PCI/MSI: Fix return value when
 populate_msi_sysfs() failed
Message-ID: <20131003003905.GK6768@jonmason-lab>
References: <cover.1380703262.git.agordeev@redhat.com>
 <3ff5236944aae69f2cd934b5b6da7c1c269df7c1.1380703262.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ff5236944aae69f2cd934b5b6da7c1c269df7c1.1380703262.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 stable@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, iss_storagedev@hp.com, linux-driver@qlogic.com,
 Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
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

On Wed, Oct 02, 2013 at 12:48:17PM +0200, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Since you are changing the behavior of the msix_capability_init
function on populate_msi_sysfs error, a comment describing why in this
commit would be nice.

> ---
>  drivers/pci/msi.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d5f90d6..b43f391 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -719,7 +719,7 @@ static int msix_capability_init(struct pci_dev *dev,
>  
>  	ret = arch_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
>  	if (ret)
> -		goto error;
> +		goto out_avail;
>  
>  	/*
>  	 * Some devices require MSI-X to be enabled before we can touch the
> @@ -732,10 +732,8 @@ static int msix_capability_init(struct pci_dev *dev,
>  	msix_program_entries(dev, entries);
>  
>  	ret = populate_msi_sysfs(dev);
> -	if (ret) {
> -		ret = 0;
> -		goto error;
> -	}
> +	if (ret)
> +		goto out_free;
>  
>  	/* Set MSI-X enabled bits and unmask the function */
>  	pci_intx_for_msi(dev, 0);
> @@ -746,7 +744,7 @@ static int msix_capability_init(struct pci_dev *dev,
>  
>  	return 0;
>  
> -error:
> +out_avail:
>  	if (ret < 0) {
>  		/*
>  		 * If we had some success, report the number of irqs
> @@ -763,6 +761,7 @@ error:
>  			ret = avail;
>  	}
>  
> +out_free:
>  	free_msi_irqs(dev);
>  
>  	return ret;
> -- 
> 1.7.7.6
> 
