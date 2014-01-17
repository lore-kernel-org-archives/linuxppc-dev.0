Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 119562C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 16:09:56 +1100 (EST)
Received: by mail-pa0-f50.google.com with SMTP id kp14so3664811pab.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 21:09:54 -0800 (PST)
Message-ID: <52D8BB1D.1080309@ozlabs.ru>
Date: Fri, 17 Jan 2014 16:09:49 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] pci: add "fundamental reset" quirk
References: <1389935328-22588-1-git-send-email-aik@ozlabs.ru>
 <1389935328-22588-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1389935328-22588-2-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: aik@ozlabs.ru, Paul Mackerras <paulus@samba.org>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rats. Please ignore this patchset.


On 01/17/2014 04:08 PM, Alexey Kardashevskiy wrote:
> From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> ---
>  drivers/pci/quirks.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f6c31fa..f3eedbf 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3271,6 +3271,19 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +static int reset_fundamental(struct pci_dev *dev, int probe)
> +{
> +	if (probe)
> +		return 0;
> +
> +	pci_set_pcie_reset_state(dev, pcie_hot_reset);
> +	msleep(250);
> +	pci_set_pcie_reset_state(dev, pcie_deassert_reset);
> +	msleep(1800);
> +
> +	return 0;
> +}
> +
>  #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
>  #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
>  #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
> @@ -3286,6 +3299,14 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_intel_generic_dev },
>  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  		reset_chelsio_generic_dev },
> +
> +	{ PCI_VENDOR_ID_IBM, PCI_ANY_ID,
> +		reset_fundamental },
> +	{ PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
> +		reset_fundamental },
> +	{ PCI_VENDOR_ID_TI, PCI_ANY_ID,
> +		reset_fundamental },
> +
>  	{ 0 }
>  };
>  
> 


-- 
Alexey
