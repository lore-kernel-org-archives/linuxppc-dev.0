Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 780751400D3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 10:44:56 +1000 (EST)
Message-ID: <1398645801.8437.84.camel@pasglop>
Subject: Re: [PATCH 08/13] PCI, rpaphp: Use new pci_is_bridge() to simplify
 code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yijing Wang <wangyijing@huawei.com>
Date: Mon, 28 Apr 2014 10:43:21 +1000
In-Reply-To: <1398417515-8740-9-git-send-email-wangyijing@huawei.com>
References: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
 <1398417515-8740-9-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-04-25 at 17:18 +0800, Yijing Wang wrote:
> Now we can use new pci_is_bridge() helper function
> to simplify code.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/pci/hotplug/rpadlpar_core.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index 4fcdeed..7660232 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -157,8 +157,7 @@ static void dlpar_pci_add_bus(struct device_node *dn)
>  	}
>  
>  	/* Scan below the new bridge */
> -	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
> -	    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
> +	if (pci_is_bridge(dev))
>  		of_scan_pci_bridge(dev);
>  
>  	/* Map IO space for child bus, which may or may not succeed */
