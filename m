Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20A7E1A0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 13:51:58 +1000 (AEST)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 61CBC14032B
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 13:51:57 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so120373532pab.0
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 20:51:55 -0700 (PDT)
Date: Tue, 11 Aug 2015 13:52:49 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Subject: Re: [PATCH v2 04/10] cxl: Clean up adapter MMIO unmap path.
Message-ID: <20150811135249.4fdacf75@camb691>
In-Reply-To: <1438061323-20710-5-git-send-email-dja@axtens.net>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-5-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jul 2015 15:28:37 +1000
Daniel Axtens <dja@axtens.net> wrote:

>  - MMIO pointer unmapping is guarded by a null pointer check.
>    However, iounmap doesn't null the pointer, just invalidate it.
>    Therefore, explicitly null the pointer after unmapping.
> 
>  - afu_desc_mmio also needs to be unmapped.
> 
>  - PCI regions are allocated in cxl_map_adapter_regs.
>    Therefore they should be released in unmap, not elsewhere.
> 

You've changed the order in which cxl_remove_adapter() does its work, which,
I'm sure you've considered and it's fine, best to check.

Acked-by: Cyril Bur <cyrilbur@gmail.com>

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/misc/cxl/pci.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 1849c1785b49..adcf938f2fdb 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -539,10 +539,18 @@ err:
>  
>  static void cxl_unmap_slice_regs(struct cxl_afu *afu)
>  {
> -	if (afu->p2n_mmio)
> +	if (afu->p2n_mmio) {
>  		iounmap(afu->p2n_mmio);
> -	if (afu->p1n_mmio)
> +		afu->p2n_mmio = NULL;
> +	}
> +	if (afu->p1n_mmio) {
>  		iounmap(afu->p1n_mmio);
> +		afu->p1n_mmio = NULL;
> +	}
> +	if (afu->afu_desc_mmio) {
> +		iounmap(afu->afu_desc_mmio);
> +		afu->afu_desc_mmio = NULL;
> +	}
>  }
>  
>  static void cxl_release_afu(struct device *dev)
> @@ -920,10 +928,16 @@ err1:
>  
>  static void cxl_unmap_adapter_regs(struct cxl *adapter)
>  {
> -	if (adapter->p1_mmio)
> +	if (adapter->p1_mmio) {
>  		iounmap(adapter->p1_mmio);
> -	if (adapter->p2_mmio)
> +		adapter->p1_mmio = NULL;
> +		pci_release_region(to_pci_dev(adapter->dev.parent), 2);
> +	}
> +	if (adapter->p2_mmio) {
>  		iounmap(adapter->p2_mmio);
> +		adapter->p2_mmio = NULL;
> +		pci_release_region(to_pci_dev(adapter->dev.parent), 0);
> +	}
>  }
>  
>  static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
> @@ -1132,8 +1146,6 @@ static void cxl_remove_adapter(struct cxl *adapter)
>  
>  	device_unregister(&adapter->dev);
>  
> -	pci_release_region(pdev, 0);
> -	pci_release_region(pdev, 2);
>  	pci_disable_device(pdev);
>  }
>  
