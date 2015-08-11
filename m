Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0EE21A01FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 15:56:13 +1000 (AEST)
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46E891401AD
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 15:56:13 +1000 (AEST)
Received: by pawu10 with SMTP id u10so156600408paw.1
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 22:56:11 -0700 (PDT)
Date: Tue, 11 Aug 2015 15:57:02 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Subject: Re: [PATCH v2 07/10] cxl: Don't remove AFUs/vPHBs in cxl_reset
Message-ID: <20150811155702.41b63c38@camb691>
In-Reply-To: <1438061323-20710-8-git-send-email-dja@axtens.net>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-8-git-send-email-dja@axtens.net>
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

On Tue, 28 Jul 2015 15:28:40 +1000
Daniel Axtens <dja@axtens.net> wrote:

> If the driver doesn't participate in EEH, the AFUs will be removed
> by cxl_remove, which will be invoked by EEH.
> 
> If the driver does particpate in EEH, the vPHB needs to stick around
> so that the it can particpate.
> 
> In both cases, we shouldn't remove the AFU/vPHB.
> 

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/misc/cxl/pci.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 98a8207da88d..0acf9e62733e 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -877,11 +877,6 @@ int cxl_reset(struct cxl *adapter)
>  
>  	dev_info(&dev->dev, "CXL reset\n");
>  
> -	for (i = 0; i < adapter->slices; i++) {
> -		cxl_pci_vphb_remove(adapter->afu[i]);
> -		cxl_remove_afu(adapter->afu[i]);
> -	}
> -
>  	/* pcie_warm_reset requests a fundamental pci reset which includes a
>  	 * PERST assert/deassert.  PERST triggers a loading of the image
>  	 * if "user" or "factory" is selected in sysfs */
