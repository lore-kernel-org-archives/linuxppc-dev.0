Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8434C1A019A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 04:09:56 +1000 (EST)
Message-ID: <1407261588.316.49.camel@ul30vt.home>
Subject: Re: [PATCH 4/4] vfio_pci: spapr: Enable VFIO if EEH is not supported
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 05 Aug 2014 11:59:48 -0600
In-Reply-To: <1407241785-30111-5-git-send-email-aik@ozlabs.ru>
References: <1407241785-30111-1-git-send-email-aik@ozlabs.ru>
 <1407241785-30111-5-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-05 at 22:29 +1000, Alexey Kardashevskiy wrote:
> The existing vfio_pci_open() fails if there is no EEH support for PCI.
> This breaks POWER7's P5IOC2 PHB support which this patch brings back.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/pci/vfio_pci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index e2ee80f..63a73c0 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -179,10 +179,8 @@ static int vfio_pci_open(void *device_data)
>  			goto error;
>  
>  		ret = vfio_spapr_pci_eeh_open(vdev->pdev);
> -		if (ret) {
> -			vfio_pci_disable(vdev);
> -			goto error;
> -		}
> +		if (ret)
> +			pr_warn("EEH is not supported\n");

Is this really deserving of a warn?  Does it need a warning every time?
pr_warn_once?  pr_info?  pr_info_once?

PS - kvm is the official vfio mailing list; suggest keeping it cc'd

>  	}
>  
>  	return 0;
