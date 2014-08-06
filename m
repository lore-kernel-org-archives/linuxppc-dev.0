Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33E3C1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 13:44:27 +1000 (EST)
Message-ID: <1407296659.316.78.camel@ul30vt.home>
Subject: Re: [PATCH v2 4/4] vfio_pci: spapr: Enable VFIO if EEH is not
 supported
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 05 Aug 2014 21:44:19 -0600
In-Reply-To: <1407293313-24894-5-git-send-email-aik@ozlabs.ru>
References: <1407293313-24894-1-git-send-email-aik@ozlabs.ru>
 <1407293313-24894-5-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-06 at 12:48 +1000, Alexey Kardashevskiy wrote:
> The existing vfio_pci_open() fails if there is no EEH support for PCI.
> This breaks POWER7's P5IOC2 PHB support which this patch brings back.
> 
> It is a warning because this should not normally happen on supported
> configurations such as POWER8+IODA so we always want to see it in dmesg.
> It is _once() as the message may be triggered by non-privileged userspace
> and we do not want to pollute dmesg.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * discussed with Ben Herrenschmidt and did s/pr_warn/pr_warn_once/
> * updated commit log
> ---
>  drivers/vfio/pci/vfio_pci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index e2ee80f..68dc8da 100644
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
> +			pr_warn_once("EEH is not supported\n");
>  	}
>  
>  	return 0;

Now the next question, what's the point of vfio_spapr_pci_eeh_open()
returning a value?  Couldn't it return void now and this warning can go
into eeh specific code?  Thanks,

Alex
