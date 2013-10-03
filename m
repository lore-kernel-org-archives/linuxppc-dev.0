Return-Path: <jon.mason@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id 7B9F92C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 10:49:32 +1000 (EST)
Date: Wed, 2 Oct 2013 17:49:28 -0700
From: Jon Mason <jon.mason@intel.com>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 53/77] ntb: Fix missed call to pci_enable_msix()
Message-ID: <20131003004928.GM6768@jonmason-lab>
References: <cover.1380703262.git.agordeev@redhat.com>
 <0590d63c3432229a3824bada71e07a08fb955498.1380703263.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0590d63c3432229a3824bada71e07a08fb955498.1380703263.git.agordeev@redhat.com>
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

On Wed, Oct 02, 2013 at 12:49:09PM +0200, Alexander Gordeev wrote:
> Current MSI-X enablement code assumes MSI-Xs were successfully
> allocated in case less than requested vectors were available.
> That assumption is wrong, since MSI-Xs should be enabled with
> a repeated call to pci_enable_msix(). This update fixes this.

Good catch, I'll pull it in for my next NTB release.

Thanks,
Jon

> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  drivers/ntb/ntb_hw.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
> index 1cb6e51..de2062c 100644
> --- a/drivers/ntb/ntb_hw.c
> +++ b/drivers/ntb/ntb_hw.c
> @@ -1075,6 +1075,10 @@ static int ntb_setup_msix(struct ntb_device *ndev)
>  			 "Only %d MSI-X vectors.  Limiting the number of queues to that number.\n",
>  			 rc);
>  		msix_entries = rc;
> +
> +		rc = pci_enable_msix(pdev, ndev->msix_entries, msix_entries);
> +		if (rc)
> +			goto err1;
>  	}
>  
>  	for (i = 0; i < msix_entries; i++) {
> -- 
> 1.7.7.6
> 
