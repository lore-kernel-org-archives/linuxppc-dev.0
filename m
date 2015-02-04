Return-Path: <bhelgaas@google.com>
Received: from mail-ob0-x22b.google.com (mail-ob0-x22b.google.com
 [IPv6:2607:f8b0:4003:c01::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AB081A0EC6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 03:28:32 +1100 (AEDT)
Received: by mail-ob0-f171.google.com with SMTP id gq1so2265171obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 08:28:29 -0800 (PST)
Date: Wed, 4 Feb 2015 10:28:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] pci/iov: fix memory leak introduced in "PCI: Store
 individual VF BAR size in struct pci_sriov"
Message-ID: <20150204162826.GA7643@google.com>
References: <CAErSpo4nLEvL4XGvkvZbfy0dFQcRDHdn5aznkx2fRMMnt1_n4g@mail.gmail.com>
 <1423066130-8587-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423066130-8587-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 05, 2015 at 12:08:50AM +0800, Wei Yang wrote:
> Bjorn, this is an error introduced in the patch "PCI: Store individual VF BAR
> size in struct pci_sriov".
> 
> This patch is based on the pci/virtualization branch. I have tried, it could
> merge with the bad one cleanly.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Great, thanks.  I folded this into "PCI: Store individual VF BAR size in
struct pci_sriov".

> ---
>  drivers/pci/iov.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index d64b9df..721987b 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -430,10 +430,8 @@ found:
>  	pci_write_config_dword(dev, pos + PCI_SRIOV_SYS_PGSIZE, pgsz);
>  
>  	iov = kzalloc(sizeof(*iov), GFP_KERNEL);
> -	if (!iov) {
> -		rc = -ENOMEM;
> -		goto failed;
> -	}
> +	if (!iov)
> +		return -ENOMEM;
>  
>  	nres = 0;
>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> @@ -485,6 +483,8 @@ failed:
>  		res->flags = 0;
>  	}
>  
> +	kfree(iov);
> +
>  	return rc;
>  }
>  
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
