Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC12E1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 12:25:36 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 20 Aug 2014 12:25:33 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B6CEF2BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 12:25:30 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7K280QD66125852
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 12:08:01 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7K2PSZ1021299
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 12:25:29 +1000
Date: Wed, 20 Aug 2014 10:25:20 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V7 01/17] PCI/IOV: Export interface for retrieve VF's BDF
Message-ID: <20140820022520.GA6904@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1406182947-11302-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140819213726.GB6295@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140819213726.GB6295@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com, yan@linux.vnet.ibm.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 19, 2014 at 03:37:26PM -0600, Bjorn Helgaas wrote:
>On Thu, Jul 24, 2014 at 02:22:11PM +0800, Wei Yang wrote:
>> When implementing the SR-IOV on PowerNV platform, some resource reservation is
>> needed for VFs which don't exist at the bootup stage. To do the match between
>> resources and VFs, the code need to get the VF's BDF in advance.
>
>Ben started explaining this whole hardware PE/VF/etc stuff to me, but it
>hasn't all sunk in yet.  We need to describe it somewhere (it sounds pretty
>involved, so maybe an extended description in Documentation/ would be
>appropriate).

Yes, this is not that easy to understand the whole stuff. I'd like to write a
file in Documentation/. By scaning the directory, I am not sure which one
would be proper, the Documentation/powerpc/ would be fine?

>
>What I'm concerned about is that PCI resource assignment is a huge mess,
>and this obviously complicates it even more.  That's necessary and OK, but
>I want to at least preserve the possibility that somebody could rework it
>to make it manageable, and that means we need to know what the special
>constraints of PowerNV are.

Sure, let me try my best to explain it, my English is not that good, hope it
is understandable. :-)

>
>Code question below.
>
>> In this patch, it exports the interface to retrieve VF's BDF:
>>    * Make the virtfn_bus as an interface
>>    * Make the virtfn_devfn as an interface
>>    * rename them with more specific name
>>    * code cleanup in pci_sriov_resource_alignment()
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/iov.c   |   26 +++++++-------------------
>>  drivers/pci/pci.h   |   19 -------------------
>>  include/linux/pci.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 51 insertions(+), 38 deletions(-)
>> 
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index cb6f247..7566238 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -19,18 +19,6 @@
>>  
>>  #define VIRTFN_ID_LEN	16
>>  
>> -static inline u8 virtfn_bus(struct pci_dev *dev, int id)
>> -{
>> -	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
>> -				    dev->sriov->stride * id) >> 8);
>> -}
>> -
>> -static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
>> -{
>> -	return (dev->devfn + dev->sriov->offset +
>> -		dev->sriov->stride * id) & 0xff;
>> -}
>> -
>>  static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
>>  {
>>  	struct pci_bus *child;
>> @@ -69,7 +57,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>>  	struct pci_bus *bus;
>>  
>>  	mutex_lock(&iov->dev->sriov->lock);
>> -	bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
>> +	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
>>  	if (!bus)
>>  		goto failed;
>>  
>> @@ -77,7 +65,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>>  	if (!virtfn)
>>  		goto failed0;
>>  
>> -	virtfn->devfn = virtfn_devfn(dev, id);
>> +	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
>>  	virtfn->vendor = dev->vendor;
>>  	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
>>  	pci_setup_device(virtfn);
>> @@ -140,8 +128,8 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
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
>> @@ -216,7 +204,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>  	iov->offset = offset;
>>  	iov->stride = stride;
>>  
>> -	if (virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
>> +	if (pci_iov_virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
>>  		dev_err(&dev->dev, "SR-IOV: bus number out of range\n");
>>  		return -ENOMEM;
>>  	}
>> @@ -516,7 +504,7 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
>>  	if (!reg)
>>  		return 0;
>>  
>> -	 __pci_read_base(dev, type, &tmp, reg);
>> +	__pci_read_base(dev, type, &tmp, reg);
>>  	return resource_alignment(&tmp);
>>  }
>>  
>> @@ -546,7 +534,7 @@ int pci_iov_bus_range(struct pci_bus *bus)
>>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>>  		if (!dev->is_physfn)
>>  			continue;
>> -		busnr = virtfn_bus(dev, dev->sriov->total_VFs - 1);
>> +		busnr = pci_iov_virtfn_bus(dev, dev->sriov->total_VFs - 1);
>>  		if (busnr > max)
>>  			max = busnr;
>>  	}
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 0601890..a3158b2 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -221,25 +221,6 @@ static inline int pci_ari_enabled(struct pci_bus *bus)
>>  void pci_reassigndev_resource_alignment(struct pci_dev *dev);
>>  void pci_disable_bridge_window(struct pci_dev *dev);
>>  
>> -/* Single Root I/O Virtualization */
>> -struct pci_sriov {
>> -	int pos;		/* capability position */
>> -	int nres;		/* number of resources */
>> -	u32 cap;		/* SR-IOV Capabilities */
>> -	u16 ctrl;		/* SR-IOV Control */
>> -	u16 total_VFs;		/* total VFs associated with the PF */
>> -	u16 initial_VFs;	/* initial VFs associated with the PF */
>> -	u16 num_VFs;		/* number of VFs available */
>> -	u16 offset;		/* first VF Routing ID offset */
>> -	u16 stride;		/* following VF stride */
>> -	u32 pgsz;		/* page size for BAR alignment */
>> -	u8 link;		/* Function Dependency Link */
>> -	u16 driver_max_VFs;	/* max num VFs driver supports */
>> -	struct pci_dev *dev;	/* lowest numbered PF */
>> -	struct pci_dev *self;	/* this PF */
>> -	struct mutex lock;	/* lock for VF bus */
>> -};
>> -
>>  #ifdef CONFIG_PCI_ATS
>>  void pci_restore_ats_state(struct pci_dev *dev);
>>  #else
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 466bcd1..194db52 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -245,6 +245,27 @@ struct pci_vpd;
>>  struct pci_sriov;
>>  struct pci_ats;
>>  
>> +/* Single Root I/O Virtualization */
>> +struct pci_sriov {
>> +	int pos;		/* capability position */
>> +	int nres;		/* number of resources */
>> +	u32 cap;		/* SR-IOV Capabilities */
>> +	u16 ctrl;		/* SR-IOV Control */
>> +	u16 total_VFs;		/* total VFs associated with the PF */
>> +	u16 initial_VFs;	/* initial VFs associated with the PF */
>> +	u16 num_VFs;		/* number of VFs available */
>> +	u16 offset;		/* first VF Routing ID offset */
>> +	u16 stride;		/* following VF stride */
>> +	u32 pgsz;		/* page size for BAR alignment */
>> +	u8 link;		/* Function Dependency Link */
>> +	u16 driver_max_VFs;	/* max num VFs driver supports */
>> +	struct pci_dev *dev;	/* lowest numbered PF */
>> +	struct pci_dev *self;	/* this PF */
>> +	struct mutex lock;	/* lock for VF bus */
>> +	struct work_struct mtask; /* VF Migration task */
>> +	u8 __iomem *mstate;	/* VF Migration State Array */
>> +};
>> +
>>  /*
>>   * The pci_dev structure is used to describe PCI devices.
>>   */
>> @@ -1616,6 +1637,21 @@ int pci_ext_cfg_avail(void);
>>  void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
>>  
>>  #ifdef CONFIG_PCI_IOV
>> +static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
>> +{
>> +	if (!dev->is_physfn)
>> +		return -EINVAL;
>> +	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
>> +				    dev->sriov->stride * id) >> 8);
>> +}
>> +static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
>> +{
>> +	if (!dev->is_physfn)
>> +		return -EINVAL;
>> +	return (dev->devfn + dev->sriov->offset +
>> +		dev->sriov->stride * id) & 0xff;
>> +}
>
>Do these really need to be inline?  If they weren't inline, we wouldn't
>have to move struct pci_sriov to the public header file.
>

Not necessary to be inline, I think.

I will rework it and hide pci_sriov from public.

>> +
>>  int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
>>  void pci_disable_sriov(struct pci_dev *dev);
>>  int pci_num_vf(struct pci_dev *dev);
>> @@ -1623,6 +1659,14 @@ int pci_vfs_assigned(struct pci_dev *dev);
>>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
>>  #else
>> +static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
>> +{
>> +	return -ENXIO;
>> +}
>> +static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
>> +{
>> +	return -ENXIO;
>> +}
>>  static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
>>  { return -ENODEV; }
>>  static inline void pci_disable_sriov(struct pci_dev *dev) { }
>> -- 
>> 1.7.9.5
>> 

-- 
Richard Yang
Help you, Help me
