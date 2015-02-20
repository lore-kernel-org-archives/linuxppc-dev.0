Return-Path: <bhelgaas@google.com>
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com
 [IPv6:2607:f8b0:4003:c01::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 807151A13DA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 10:09:10 +1100 (AEDT)
Received: by mail-ob0-f178.google.com with SMTP id uz6so27211992obc.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 15:09:08 -0800 (PST)
Date: Fri, 20 Feb 2015 17:09:04 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V11 01/17] PCI/IOV: Export interface for retrieve VF's BDF
Message-ID: <20150220230904.GB21131@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421288887-7765-2-git-send-email-weiyang@linux.vnet.ibm.com>
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

On Thu, Jan 15, 2015 at 10:27:51AM +0800, Wei Yang wrote:
> When implementing the SR-IOV on PowerNV platform, some resource reservation
> is needed for VFs which don't exist at the bootup stage. To do the match
> between resources and VFs, the code need to get the VF's BDF in advance.
> 
> In this patch, it exports the interface to retrieve VF's BDF:
>    * Make the virtfn_bus as an interface
>    * Make the virtfn_devfn as an interface
>    * Rename them with more specific name
>    * Code cleanup in pci_sriov_resource_alignment()

You use these in this path:

    pci_enable_sriov
      sriov_enable
	pcibios_sriov_enable
	  add_dev_pci_info
	    for (i = 0; i < pci_sriov_get_totalvfs(pdev))
	      add_one_dev_pci_info(..., pci_iov_virtfn_bus(), ...)  <---
		pdn = kzalloc
		pdn->busno = busno
		pdn->devfn = devfn
		list_add_tail(&pdn->list, &parent->child_list)

It looks like this sets up a struct pci_dn for each VF.

Could the struct pci_dn setup be done in pcibios_add_device() instead?
Then each VF we enumerate would set up its own struct pci_dn.  That would
be a lot nicer than using this hook to iterate over all possible VFs.

You also use them in some PE setup in a similar path:

    pci_enable_sriov
      sriov_enable
        pcibios_sriov_enable
          pnv_pci_sriov_enable
            pnv_pci_vf_assign_m64
            pnv_pci_vf_resource_shift
            pnv_ioda_setup_vf_PE
              for (i = 0; i < vf_num; i++)
                pe->rid = pci_iov_virtfn_bus(...)  <---
                pnv_ioda_configure_pe(phb, pe)
                pe->tce32_table = kzalloc
                pnv_pci_ioda2_setup_dma_pe

Could this PE setup also be done in pcibios_device() when the VF device
itself is enumerated?  I think that would be a nicer design if it's
possible.

I'd prefer to avoid exporting pci_iov_virtfn_bus() and
pci_iov_virtfn_devfn() if possible, because they're only safe to call when
VFs are enabled (because offset & stride depend on numVFs).

> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/iov.c   |   22 +++++++++++++---------
>  include/linux/pci.h |   11 +++++++++++
>  2 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index ea3a82c..e76d1a0 100644
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
> @@ -62,7 +66,7 @@ static inline void pci_iov_max_bus_range(struct pci_dev *dev)
>  
>  	for ( ; total >= 0; total--) {
>  		pci_iov_set_numvfs(dev, total);
> -		busnr = virtfn_bus(dev, iov->total_VFs - 1);
> +		busnr = pci_iov_virtfn_bus(dev, iov->total_VFs - 1);
>  		if (busnr > max)
>  			max = busnr;
>  	}
> @@ -108,7 +112,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>  	struct pci_bus *bus;
>  
>  	mutex_lock(&iov->dev->sriov->lock);
> -	bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
> +	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
>  	if (!bus)
>  		goto failed;
>  
> @@ -116,7 +120,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>  	if (!virtfn)
>  		goto failed0;
>  
> -	virtfn->devfn = virtfn_devfn(dev, id);
> +	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
>  	virtfn->vendor = dev->vendor;
>  	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
>  	pci_setup_device(virtfn);
> @@ -179,8 +183,8 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>  	struct pci_sriov *iov = dev->sriov;
>  
>  	virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
> -					     virtfn_bus(dev, id),
> -					     virtfn_devfn(dev, id));
> +					     pci_iov_virtfn_bus(dev, id),
> +					     pci_iov_virtfn_devfn(dev, id));
>  	if (!virtfn)
>  		return;
>  
> @@ -255,7 +259,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	iov->offset = offset;
>  	iov->stride = stride;
>  
> -	if (virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
> +	if (pci_iov_virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
>  		dev_err(&dev->dev, "SR-IOV: bus number out of range\n");
>  		return -ENOMEM;
>  	}
> @@ -551,7 +555,7 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
>  	if (!reg)
>  		return 0;
>  
> -	 __pci_read_base(dev, pci_bar_unknown, &tmp, reg);
> +	__pci_read_base(dev, pci_bar_unknown, &tmp, reg);
>  	return resource_alignment(&tmp);
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 360a966..74ef944 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1658,6 +1658,9 @@ int pci_ext_cfg_avail(void);
>  void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
>  
>  #ifdef CONFIG_PCI_IOV
> +int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
> +int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
> +
>  int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
>  void pci_disable_sriov(struct pci_dev *dev);
>  int pci_num_vf(struct pci_dev *dev);
> @@ -1665,6 +1668,14 @@ int pci_vfs_assigned(struct pci_dev *dev);
>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
>  #else
> +static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
> +{
> +	return -ENOSYS;
> +}
> +static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
> +{
> +	return -ENOSYS;
> +}
>  static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
>  { return -ENODEV; }
>  static inline void pci_disable_sriov(struct pci_dev *dev) { }
> -- 
> 1.7.9.5
> 
