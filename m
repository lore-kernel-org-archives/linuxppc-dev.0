Return-Path: <schwidefsky@de.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp17.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB8F22C0354
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 17:41:28 +1000 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Fri, 4 Oct 2013 08:41:24 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6EE68219005F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 08:41:22 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r947dtha21495854
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Oct 2013 07:39:55 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r947e6WR031598
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Oct 2013 01:40:07 -0600
Date: Fri, 4 Oct 2013 09:39:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 03/77] PCI/MSI/s390: Fix single MSI only check
Message-ID: <20131004093956.183f6901@mschwide>
In-Reply-To: <8c9811b13fd93e73641dab8e3bd1bd5b2dc37a61.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <8c9811b13fd93e73641dab8e3bd1bd5b2dc37a61.1380703262.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 stable@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, iss_storagedev@hp.com, linux-driver@qlogic.com,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Tejun Heo <tj@kernel.org>, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  2 Oct 2013 12:48:19 +0200
Alexander Gordeev <agordeev@redhat.com> wrote:

> Multiple MSIs have never been supported on s390 architecture,
> but the platform code fails to report single MSI only.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  arch/s390/pci/pci.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index f17a834..c79c6e4 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -427,6 +427,8 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	pr_debug("%s: requesting %d MSI-X interrupts...", __func__, nvec);
>  	if (type != PCI_CAP_ID_MSIX && type != PCI_CAP_ID_MSI)
>  		return -EINVAL;
> +	if (type == PCI_CAP_ID_MSI && nvec > 1)
> +		return 1;
>  	msi_vecs = min(nvec, ZPCI_MSI_VEC_MAX);
>  	msi_vecs = min_t(unsigned int, msi_vecs, CONFIG_PCI_NR_MSI);
> 

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
