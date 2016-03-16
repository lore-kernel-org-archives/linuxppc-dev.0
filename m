Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQH7h1N5mzDr39
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 03:32:00 +1100 (AEDT)
Date: Wed, 16 Mar 2016 10:31:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Subject: Re: [RFC PATCH v4 3/7] PCI: Ignore resource_alignment if
 PCI_PROBE_ONLY was set
Message-ID: <20160316103151.0269f0c5@t450s.home>
In-Reply-To: <1457336918-3893-4-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1457336918-3893-4-git-send-email-xyjxie@linux.vnet.ibm.com>
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

On Mon,  7 Mar 2016 15:48:34 +0800
Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:

> The resource_alignment will releases memory resources
> allocated by firmware so that kernel can reassign new
> resources later on. But this will cause the problem
> that no resources can be allocated by kernel if
> PCI_PROBE_ONLY was set, e.g. on pSeries platform
> because PCI_PROBE_ONLY force kernel to use firmware
> setup and not to reassign any resources.
> 
> To solve this problem, this patch ignores
> resource_alignment if PCI_PROBE_ONLY was set.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  Documentation/kernel-parameters.txt |    2 ++
>  drivers/pci/probe.c                 |    3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index d8b29ab..8028631 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2922,6 +2922,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  				windows need to be expanded.
>  				noresize: Don't change the resources' sizes when
>  				reassigning alignment.
> +				Note that this option will not work if
> +				PCI_PROBE_ONLY is set.

How would a user have any idea if this is set?

>  		ecrc=		Enable/disable PCIe ECRC (transaction layer
>  				end-to-end CRC checking).
>  				bios: Use BIOS/firmware settings. This is the
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6d7ab9b..bc31cad 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1719,7 +1719,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	pci_fixup_device(pci_fixup_header, dev);
>  
>  	/* moved out from quirk header fixup code */
> -	pci_reassigndev_resource_alignment(dev);
> +	if (!pci_has_flag(PCI_PROBE_ONLY))
> +		pci_reassigndev_resource_alignment(dev);
>  
>  	/* Clear the state_saved flag. */
>  	dev->state_saved = false;
