Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F3BC1A0198
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 17:06:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 2 Mar 2015 16:06:05 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1F6453578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 17:06:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2265s7m24313866
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 17:06:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2265Sfg007912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 17:05:29 +1100
Date: Mon, 2 Mar 2015 14:05:12 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V11 01/17] PCI/IOV: Export interface for retrieve VF's BDF
Message-ID: <20150302060512.GA21571@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150220230904.GB21131@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150220230904.GB21131@google.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 20, 2015 at 05:09:04PM -0600, Bjorn Helgaas wrote:
>On Thu, Jan 15, 2015 at 10:27:51AM +0800, Wei Yang wrote:
>> When implementing the SR-IOV on PowerNV platform, some resource reservation
>> is needed for VFs which don't exist at the bootup stage. To do the match
>> between resources and VFs, the code need to get the VF's BDF in advance.
>> 
>> In this patch, it exports the interface to retrieve VF's BDF:
>>    * Make the virtfn_bus as an interface
>>    * Make the virtfn_devfn as an interface
>>    * Rename them with more specific name
>>    * Code cleanup in pci_sriov_resource_alignment()
>
>You use these in this path:
>
>    pci_enable_sriov
>      sriov_enable
>	pcibios_sriov_enable
>	  add_dev_pci_info
>	    for (i = 0; i < pci_sriov_get_totalvfs(pdev))
>	      add_one_dev_pci_info(..., pci_iov_virtfn_bus(), ...)  <---
>		pdn = kzalloc
>		pdn->busno = busno
>		pdn->devfn = devfn
>		list_add_tail(&pdn->list, &parent->child_list)
>
>It looks like this sets up a struct pci_dn for each VF.
>
>Could the struct pci_dn setup be done in pcibios_add_device() instead?
>Then each VF we enumerate would set up its own struct pci_dn.  That would
>be a lot nicer than using this hook to iterate over all possible VFs.
>

Looks no.

Current powernv platform use pdn->busno/devfn to access the configuration
space of a device.

    virtfn_add
        pci_setup_device(virtfn)     ---  (1)
	pci_device_add()
	    pcibios_add_device()     ---  (2)

So you suggest to fixup the pdn in (2), right? 

By doing so, it needs to access the configuration space of virtfn in (1),
which will fail since not enough information in pdn at this moment.

This means pdn->busno/devfn must be initialized before kernel could access the
device on powernv platform. Originally this step is down in
update_dn_pci_infor() for PFs. Those information is retrieved from device
node. But currently there is no device node for VF, that is why we need to
create it.

>You also use them in some PE setup in a similar path:
>
>    pci_enable_sriov
>      sriov_enable
>        pcibios_sriov_enable
>          pnv_pci_sriov_enable
>            pnv_pci_vf_assign_m64
>            pnv_pci_vf_resource_shift
>            pnv_ioda_setup_vf_PE
>              for (i = 0; i < vf_num; i++)
>                pe->rid = pci_iov_virtfn_bus(...)  <---
>                pnv_ioda_configure_pe(phb, pe)
>                pe->tce32_table = kzalloc
>                pnv_pci_ioda2_setup_dma_pe
>
>Could this PE setup also be done in pcibios_device() when the VF device
>itself is enumerated?  I think that would be a nicer design if it's
>possible.

Hmm... looks possible, while I need to do some investigation.

>
>I'd prefer to avoid exporting pci_iov_virtfn_bus() and
>pci_iov_virtfn_devfn() if possible, because they're only safe to call when
>VFs are enabled (because offset & stride depend on numVFs).

Yep, I know your concern.

pci_enable_sriov
    sriov_enable
        pci_iov_set_numvfs(dev, nr_virtfn);
	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
	pcibios_sriov_enable(dev, initial)

So in current implementation, these two functions will be called after VFs are
enabled. But, yes, we can't guarantee other people won't use them improperly.

Could we return an error code when (iov->num_VFs == 0) or !(iov->ctrl |
PCI_SRIOV_CTRL_VFE) in these two functions? These two fields could reflect
whether VFs are enabled or not.

>
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/iov.c   |   22 +++++++++++++---------
>>  include/linux/pci.h |   11 +++++++++++
>>  2 files changed, 24 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index ea3a82c..e76d1a0 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -19,14 +19,18 @@
>>  
>>  #define VIRTFN_ID_LEN	16
>>  
>> -static inline u8 virtfn_bus(struct pci_dev *dev, int id)
>> +int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
>>  {
>> +	if (!dev->is_physfn)
>> +		return -EINVAL;
>>  	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
>>  				    dev->sriov->stride * id) >> 8);
>>  }
>>  
>> -static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
>> +int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
>>  {
>> +	if (!dev->is_physfn)
>> +		return -EINVAL;
>>  	return (dev->devfn + dev->sriov->offset +
>>  		dev->sriov->stride * id) & 0xff;
>>  }
>> @@ -62,7 +66,7 @@ static inline void pci_iov_max_bus_range(struct pci_dev *dev)
>>  
>>  	for ( ; total >= 0; total--) {
>>  		pci_iov_set_numvfs(dev, total);
>> -		busnr = virtfn_bus(dev, iov->total_VFs - 1);
>> +		busnr = pci_iov_virtfn_bus(dev, iov->total_VFs - 1);
>>  		if (busnr > max)
>>  			max = busnr;
>>  	}
>> @@ -108,7 +112,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>>  	struct pci_bus *bus;
>>  
>>  	mutex_lock(&iov->dev->sriov->lock);
>> -	bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
>> +	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
>>  	if (!bus)
>>  		goto failed;
>>  
>> @@ -116,7 +120,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>>  	if (!virtfn)
>>  		goto failed0;
>>  
>> -	virtfn->devfn = virtfn_devfn(dev, id);
>> +	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
>>  	virtfn->vendor = dev->vendor;
>>  	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
>>  	pci_setup_device(virtfn);
>> @@ -179,8 +183,8 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>>  	struct pci_sriov *iov = dev->sriov;
>>  
>>  	virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
>> -					     virtfn_bus(dev, id),
>> -					     virtfn_devfn(dev, id));
>> +					     pci_iov_virtfn_bus(dev, id),
>> +					     pci_iov_virtfn_devfn(dev, id));
>>  	if (!virtfn)
>>  		return;
>>  
>> @@ -255,7 +259,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>  	iov->offset = offset;
>>  	iov->stride = stride;
>>  
>> -	if (virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
>> +	if (pci_iov_virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
>>  		dev_err(&dev->dev, "SR-IOV: bus number out of range\n");
>>  		return -ENOMEM;
>>  	}
>> @@ -551,7 +555,7 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
>>  	if (!reg)
>>  		return 0;
>>  
>> -	 __pci_read_base(dev, pci_bar_unknown, &tmp, reg);
>> +	__pci_read_base(dev, pci_bar_unknown, &tmp, reg);
>>  	return resource_alignment(&tmp);
>>  }
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 360a966..74ef944 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1658,6 +1658,9 @@ int pci_ext_cfg_avail(void);
>>  void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
>>  
>>  #ifdef CONFIG_PCI_IOV
>> +int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
>> +int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
>> +
>>  int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
>>  void pci_disable_sriov(struct pci_dev *dev);
>>  int pci_num_vf(struct pci_dev *dev);
>> @@ -1665,6 +1668,14 @@ int pci_vfs_assigned(struct pci_dev *dev);
>>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
>>  #else
>> +static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
>> +{
>> +	return -ENOSYS;
>> +}
>> +static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
>> +{
>> +	return -ENOSYS;
>> +}
>>  static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
>>  { return -ENODEV; }
>>  static inline void pci_disable_sriov(struct pci_dev *dev) { }
>> -- 
>> 1.7.9.5
>> 
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me
