Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxHy61j7SzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 01:42:22 +1000 (AEST)
Date: Fri, 29 Apr 2016 09:42:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dan Carpenter
 <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>, David Gibson
 <david@gibson.dropbear.id.au>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v4 01/11] vfio_pci: Test for extended
 capabilities if config space > 256 bytes
Message-ID: <20160429094220.6c7413ae@t450s.home>
In-Reply-To: <1461920124-21719-2-git-send-email-aik@ozlabs.ru>
References: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
 <1461920124-21719-2-git-send-email-aik@ozlabs.ru>
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

On Fri, 29 Apr 2016 18:55:14 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> PCI-Express spec says that reading 4 bytes at offset 100h should return
> zero if there is no extended capability so VFIO reads this dword to
> know if there are extended capabilities.
> 
> However it is not always possible to access the extended space so
> generic PCI code in pci_cfg_space_size_ext() checks if
> pci_read_config_dword() can read beyond 100h and if the check fails,
> it sets the config space size to 100h.
> 
> VFIO does its own extended capabilities check by reading at offset 100h
> which may produce 0xffffffff which VFIO treats as the extended config
> space presense and calls vfio_ecap_init() which fails to parse
> capabilities (which is expected) but right before the exit, it writes
> zero at offset 100h which is beyond the buffer allocated for
> vdev->vconfig (which is 256 bytes) which leads to random memory
> corruption.
> 
> This makes VFIO only check for the extended capabilities if
> the discovered config size is more than 256 bytes.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * instead of checking for 0xffffffff, this only does the check if
> device's config size is big enough
> ---

I'll take this patch separately, please drop from this series.  Thanks,

Alex

>  drivers/vfio/pci/vfio_pci_config.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 142c533..d0c4358 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1124,9 +1124,12 @@ static int vfio_cap_len(struct vfio_pci_device *vdev, u8 cap, u8 pos)
>  			return pcibios_err_to_errno(ret);
>  
>  		if (PCI_X_CMD_VERSION(word)) {
> -			/* Test for extended capabilities */
> -			pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &dword);
> -			vdev->extended_caps = (dword != 0);
> +			if (pdev->cfg_size > PCI_CFG_SPACE_SIZE) {
> +				/* Test for extended capabilities */
> +				pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE,
> +						&dword);
> +				vdev->extended_caps = (dword != 0);
> +			}
>  			return PCI_CAP_PCIX_SIZEOF_V2;
>  		} else
>  			return PCI_CAP_PCIX_SIZEOF_V0;
> @@ -1138,9 +1141,11 @@ static int vfio_cap_len(struct vfio_pci_device *vdev, u8 cap, u8 pos)
>  
>  		return byte;
>  	case PCI_CAP_ID_EXP:
> -		/* Test for extended capabilities */
> -		pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &dword);
> -		vdev->extended_caps = (dword != 0);
> +		if (pdev->cfg_size > PCI_CFG_SPACE_SIZE) {
> +			/* Test for extended capabilities */
> +			pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &dword);
> +			vdev->extended_caps = dword != 0;
> +		}
>  
>  		/* length based on version */
>  		if ((pcie_caps_reg(pdev) & PCI_EXP_FLAGS_VERS) == 1)
