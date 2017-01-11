Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzLkd2z7mzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 07:55:21 +1100 (AEDT)
Date: Wed, 11 Jan 2017 14:55:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rahul Krishnan <mrahul.krishnan@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: hotplug: This patch removes unnecessary return
 statement using spatch tool
Message-ID: <20170111205514.GI14532@bhelgaas-glaptop.roam.corp.google.com>
References: <20161224093800.GA24893@rahul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161224093800.GA24893@rahul>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 24, 2016 at 03:08:00PM +0530, Rahul Krishnan wrote:
> 
> This patch removes unnecessary return statement using spatch tool
> 
> Signed-off-by: Rahul Krishnan <mrahul.krishnan@gmail.com>

Applied to pci/hotplug for v4.11 with Tyrel's Reviewed-by, thanks!

Are there other similar instances elsewhere in drivers/pci?  If so,
can you fix them all at once?

> ---
>  drivers/pci/hotplug/rpadlpar_core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index dc67f39..78ce2c7 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -455,7 +455,6 @@ static inline int is_dlpar_capable(void)
>  
>  int __init rpadlpar_io_init(void)
>  {
> -	int rc = 0;
>  
>  	if (!is_dlpar_capable()) {
>  		printk(KERN_WARNING "%s: partition not DLPAR capable\n",
> @@ -463,8 +462,7 @@ int __init rpadlpar_io_init(void)
>  		return -EPERM;
>  	}
>  
> -	rc = dlpar_sysfs_init();
> -	return rc;
> +	return dlpar_sysfs_init();
>  }
>  
>  void rpadlpar_io_exit(void)
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
