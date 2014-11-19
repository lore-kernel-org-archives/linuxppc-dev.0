Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x229.google.com (mail-ig0-x229.google.com
 [IPv6:2607:f8b0:4001:c05::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D50721A0061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 10:35:08 +1100 (AEDT)
Received: by mail-ig0-f169.google.com with SMTP id hl2so6502374igb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 15:35:05 -0800 (PST)
Date: Wed, 19 Nov 2014 16:35:02 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V9 01/18] PCI/IOV: Export interface for retrieve VF's BDF
Message-ID: <20141119233502.GG23467@google.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414942894-17034-2-git-send-email-weiyang@linux.vnet.ibm.com>
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

On Sun, Nov 02, 2014 at 11:41:17PM +0800, Wei Yang wrote:
> When implementing the SR-IOV on PowerNV platform, some resource reservation is
> needed for VFs which don't exist at the bootup stage. To do the match between
> resources and VFs, the code need to get the VF's BDF in advance.
> 
> In this patch, it exports the interface to retrieve VF's BDF:
>    * Make the virtfn_bus as an interface
>    * Make the virtfn_devfn as an interface
>    * Rename them with more specific name
>    * Code cleanup in pci_sriov_resource_alignment()
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/iov.c   |   22 +++++++++++++---------
>  include/linux/pci.h |   11 +++++++++++
>  2 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4d109c0..5e8091b 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -19,14 +19,18 @@
>  
>  #define VIRTFN_ID_LEN	16
>  
> -static inline u8 virtfn_bus(struct pci_dev *dev, int id)
> +int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
>  {
> +	if (!dev->is_physfn)
> +		return -EINVAL;
>  	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
>  				    dev->sriov->stride * id) >> 8);
>  }
>  
> -static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
> +int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
>  {
> +	if (!dev->is_physfn)
> +		return -EINVAL;
>  	return (dev->devfn + dev->sriov->offset +
>  		dev->sriov->stride * id) & 0xff;
>  }

I'm concerned about exporting these because they depend on First VF Offset
and VF Stride from the SR-IOV Capability, and those values change when the
ARI Capability Hierarchy setting or the NumVFs setting change (SR-IOV spec
sec 3.3.9, 3.3.10).  The caller doesn't necessarily know about this
connection and may not be able to deal with the change.

I outlined one possible problem with this in patch 08/18.

Bjorn
