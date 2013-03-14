Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 23B9F2C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 05:52:39 +1100 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Thu, 14 Mar 2013 15:52:28 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 2FC381DC004E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 14:52:19 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2EIpU3c14549206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 15:51:30 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2EIqG6u026095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 15:52:17 -0300
Date: Thu, 14 Mar 2013 15:52:14 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: lucaskt@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] ppc64: Add arch-specific pcie_get_speed_cap_mask
Message-ID: <20130314185214.GA13230@oc0268524204.ibm.com>
References: <1363283147-8852-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1363283147-8852-3-git-send-email-lucaskt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363283147-8852-3-git-send-email-lucaskt@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, brking@linux.vnet.ibm.com,
 Alex Deucher <alexander.deucher@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 14, 2013 at 02:45:47PM -0300, lucaskt@linux.vnet.ibm.com wrote:
> From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
> 
> Betters support for gen2 speed detections on PCI buses on ppc64
> architectures.
> 
> Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/pci.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 0b580f4..58469fe 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -24,6 +24,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/string.h>
> +#include <linux/device.h>
> 
>  #include <asm/eeh.h>
>  #include <asm/pci-bridge.h>
> @@ -108,3 +109,34 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
>  			 fixup_winbond_82c105);
> +
> +int pcibios_get_speed_cap_mask(struct pci_dev *dev, u32 *mask)
> +{
> +	struct device_node *dn, *pdn;
> +	const uint32_t *pcie_link_speed_stats = NULL;
> +
> +	*mask = 0;
> +	dn = pci_bus_to_OF_node(dev->bus);
> +
> +	/* Find nearest ibm,pcie-link-speed-stats, walking up the device tree */
> +	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
> +		pcie_link_speed_stats = (const uint32_t *) of_get_property(pdn,
> +			"ibm,pcie-link-speed-stats", NULL);
> +		if (pcie_link_speed_stats != NULL)
> +			break;
> +	}
> +
> +	if (pcie_link_speed_stats == NULL) {
> +		dev_info(&dev->dev, "no ibm,pcie-link-speed-stats property\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (pcie_link_speed_stats[0]) {
> +		case 0x02:
> +		*mask |= PCIE_SPEED_50;
> +		case 0x01:
> +		*mask |= PCIE_SPEED_25;
> +	}

I recall seeing this returns 0x00 as well. Maybe you should include both
0x00 and a default case and return EINVAL.

Regards.
Cascardo.

> +
> +	return 0;
> +}
> -- 
> 1.7.4.4
> 
