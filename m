Return-Path: <brking@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3538D2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 05:31:48 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Wed, 2 Oct 2013 13:31:46 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5C7E8C9005E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2013 15:31:39 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r92JVdPo59506778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Oct 2013 19:31:39 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r92JVa1n025858
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Oct 2013 16:31:39 -0300
Message-ID: <524C748D.8080803@linux.vnet.ibm.com>
Date: Wed, 02 Oct 2013 14:31:25 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 36/77] ipr: Enable MSI-X when IPR_USE_MSIX type is
 set, not IPR_USE_MSI
References: <cover.1380703262.git.agordeev@redhat.com>
 <2d4272136269f3cb3b1a5ac53b12aa45c7ea65c0.1380703263.git.agordeev@redhat.com>
In-Reply-To: <2d4272136269f3cb3b1a5ac53b12aa45c7ea65c0.1380703263.git.agordeev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, stable@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 iss_storagedev@hp.com, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 Wendy Xiong <wenxiong@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 e1000-devel@lists.sourceforge.net, linux-driver@qlogic.com,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/02/2013 05:48 AM, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  drivers/scsi/ipr.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index fb57e21..762a93e 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -9527,7 +9527,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
>  		ipr_number_of_msix = IPR_MAX_MSIX_VECTORS;
>  	}
> 
> -	if (ioa_cfg->ipr_chip->intr_type == IPR_USE_MSI &&
> +	if (ioa_cfg->ipr_chip->intr_type == IPR_USE_MSIX &&
>  			ipr_enable_msix(ioa_cfg) == 0)
>  		ioa_cfg->intr_flag = IPR_USE_MSIX;
>  	else if (ioa_cfg->ipr_chip->intr_type == IPR_USE_MSI &&
> 

Nack. ioa_cfg->ipr_chip->intr_type gets initialized from the ipr_chip table
at the top of the driver which never sets intr_type to IPR_USE_MSIX, so this
will break MSI-X support for ipr. 

We indicate at the chip level only whether we want to force LSI or whether
we want to enable MSI / MSI-X and then try enabling MSI-X and fall back to
MSI if MSI-X is not available or does not work. We then set intr_flag to indicate
what we are actually using on the specific adapter.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
