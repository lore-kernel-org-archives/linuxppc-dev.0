Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id D775D2C012E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 02:40:37 +1000 (EST)
Message-ID: <1380127227.3030.316.camel@ul30vt.home>
Subject: Re: [PATCH 5/7] iommu: supress loff_t compilation error on powerpc
From: Alex Williamson <alex.williamson@redhat.com>
To: Bharat Bhushan <r65777@freescale.com>
Date: Wed, 25 Sep 2013 10:40:27 -0600
In-Reply-To: <1379575763-2091-6-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379575763-2091-6-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: agraf@suse.de, linux-pci@vger.kernel.org, joro@8bytes.org,
 linux-kernel@vger.kernel.org, Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 iommu@lists.linux-foundation.org, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-19 at 12:59 +0530, Bharat Bhushan wrote:
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
>  drivers/vfio/pci/vfio_pci_rdwr.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 210db24..8a8156a 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -181,7 +181,8 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char __user *buf,
>  			       size_t count, loff_t *ppos, bool iswrite)
>  {
>  	int ret;
> -	loff_t off, pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +	loff_t off;
> +	u64 pos = (u64 )(*ppos & VFIO_PCI_OFFSET_MASK);
>  	void __iomem *iomem = NULL;
>  	unsigned int rsrc;
>  	bool is_ioport;

What's the compile error that this fixes?
