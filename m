Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQmMP6yDHzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:28:49 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 17 Mar 2016 16:58:45 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2HBSfFG27394248
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 16:58:42 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2HBSdw1013681
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 16:58:41 +0530
Subject: Re: [RFC PATCH v4 4/7] PCI: Modify resource_alignment to support
 multiple devices
To: Alex Williamson <alex.williamson@redhat.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1457336918-3893-5-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160316103022.246edf22@t450s.home>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <56EA94E2.1010502@linux.vnet.ibm.com>
Date: Thu, 17 Mar 2016 19:28:34 +0800
MIME-Version: 1.0
In-Reply-To: <20160316103022.246edf22@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/3/17 0:30, Alex Williamson wrote:
> On Mon,  7 Mar 2016 15:48:35 +0800
> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
>
>> When vfio passthrough a PCI device of which MMIO BARs
>> are smaller than PAGE_SIZE, guest will not handle the
>> mmio accesses to the BARs which leads to mmio emulations
>> in host.
>>
>> This is because vfio will not allow to passthrough one
>> BAR's mmio page which may be shared with other BARs.
>>
>> To solve this performance issue, this patch modifies
>> resource_alignment to support syntax where multiple
>> devices get the same alignment. So we can use something
>> like "pci=resource_alignment=*:*:*.*:noresize" to
>> enforce the alignment of all MMIO BARs to be at least
>> PAGE_SIZE so that one BAR's mmio page would not be
>> shared with other BARs.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   Documentation/kernel-parameters.txt |    2 +
>>   drivers/pci/pci.c                   |   90 ++++++++++++++++++++++++++++++-----
>>   include/linux/pci.h                 |    4 ++
>>   3 files changed, 85 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index 8028631..74b38ab 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -2918,6 +2918,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>   				aligned memory resources.
>>   				If <order of align> is not specified,
>>   				PAGE_SIZE is used as alignment.
>> +				<domain>, <bus>, <slot> and <func> can be set to
>> +				"*" which means match all values.
> I don't see anywhere that you're automatically enabling this for your
> platform, so presumably you're expecting users to determine on their
> own that they have a performance problem and hoping that they'll figure
> out that they need to use this option to resolve it.  The first irate
> question you'll get back is why doesn't this happen automatically?

Actually, I just want to make the code simple. Maybe it is
not a good idea to let users enable this option manually.
I will try to fix it like that:

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 6f8065a..6659752 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -30,6 +30,8 @@
  #define PCIBIOS_MIN_IO         0x1000
  #define PCIBIOS_MIN_MEM                0x10000000

+#define PCIBIOS_MIN_ALIGNMENT  PAGE_SIZE
+
  struct pci_dev;

  /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dadd28a..9f644e4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4593,6 +4593,8 @@ EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
  static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
  static DEFINE_SPINLOCK(resource_alignment_lock);

+#define DISABLE_ARCH_ALIGNMENT -1
+#define DEFAULT_ALIGNMENT      -2
  /**
   * pci_specified_resource_alignment - get resource alignment specified 
by user.
   * @dev: the PCI device to get
@@ -4609,6 +4611,9 @@ static resource_size_t 
pci_specified_resource_alignment(struct pci_dev *dev,
         char *p;
         bool invalid = false;

+#ifdef PCIBIOS_MIN_ALIGNMENT
+       align = PCIBIOS_MIN_ALIGNMENT;
+#endif
         spin_lock(&resource_alignment_lock);
         p = resource_alignment_param;
         while (*p) {
@@ -4617,7 +4622,7 @@ static resource_size_t 
pci_specified_resource_alignment(struct pci_dev *dev,
                                                         p[count] == '@') {
                         p += count + 1;
                 } else {
-                       align_order = -1;
+                       align_order = DEFAULT_ALIGNMENT;
                 }
                 if (p[0] == '*' && p[1] == ':') {
                         seg = -1;
@@ -4673,8 +4678,10 @@ static resource_size_t 
pci_specified_resource_alignment(struct pci_dev *dev,
                         (bus == dev->bus->number || bus == -1) &&
                         (slot == PCI_SLOT(dev->devfn) || slot == -1) &&
                         (func == PCI_FUNC(dev->devfn) || func == -1)) {
-                       if (align_order == -1)
+                       if (align_order == DEFAULT_ALIGNMENT)
                                 align = PAGE_SIZE;
+                       else if (align_order == DISABLE_ARCH_ALIGNMENT)
+                               align = 0;
                         else
                                 align = 1 << align_order;
                         if (!pci_resources_page_aligned &&
>>   				PCI-PCI bridge can be specified, if resource
>>   				windows need to be expanded.
>>   				noresize: Don't change the resources' sizes when
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 760cce5..44ab59f 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -102,6 +102,8 @@ unsigned int pcibios_max_latency = 255;
>>   /* If set, the PCIe ARI capability will not be used. */
>>   static bool pcie_ari_disabled;
>>   
>> +bool pci_resources_page_aligned;
>> +
>>   /**
>>    * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
>>    * @bus: pointer to PCI bus structure to search
>> @@ -4604,6 +4606,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>>   	int seg, bus, slot, func, align_order, count;
>>   	resource_size_t align = 0;
>>   	char *p;
>> +	bool invalid = false;
>>   
>>   	spin_lock(&resource_alignment_lock);
>>   	p = resource_alignment_param;
>> @@ -4615,16 +4618,49 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>>   		} else {
>>   			align_order = -1;
>>   		}
>> -		if (sscanf(p, "%x:%x:%x.%x%n",
>> -			&seg, &bus, &slot, &func, &count) != 4) {
>> +		if (p[0] == '*' && p[1] == ':') {
>> +			seg = -1;
>> +			count = 1;
>> +		} else if (sscanf(p, "%x%n", &seg, &count) != 1 ||
>> +				p[count] != ':') {
>> +			invalid = true;
>> +			break;
>> +		}
>> +		p += count + 1;
>> +		if (*p == '*') {
>> +			bus = -1;
>> +			count = 1;
>> +		} else if (sscanf(p, "%x%n", &bus, &count) != 1) {
>> +			invalid = true;
>> +			break;
>> +		}
>> +		p += count;
>> +		if (*p == '.') {
>> +			slot = bus;
>> +			bus = seg;
>>   			seg = 0;
>> -			if (sscanf(p, "%x:%x.%x%n",
>> -					&bus, &slot, &func, &count) != 3) {
>> -				/* Invalid format */
>> -				printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n",
>> -					p);
>> +			p++;
>> +		} else if (*p == ':') {
>> +			p++;
>> +			if (p[0] == '*' && p[1] == '.') {
>> +				slot = -1;
>> +				count = 1;
>> +			} else if (sscanf(p, "%x%n", &slot, &count) != 1 ||
>> +					p[count] != '.') {
>> +				invalid = true;
>>   				break;
>>   			}
>> +			p += count + 1;
>> +		} else {
>> +			invalid = true;
>> +			break;
>> +		}
>> +		if (*p == '*') {
>> +			func = -1;
>> +			count = 1;
>> +		} else if (sscanf(p, "%x%n", &func, &count) != 1) {
>> +			invalid = true;
>> +			break;
>>   		}
>>   		p += count;
>>   		if (!strncmp(p, ":noresize", 9)) {
>> @@ -4632,23 +4668,34 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>>   			p += 9;
>>   		} else
>>   			*resize = true;
>> -		if (seg == pci_domain_nr(dev->bus) &&
>> -			bus == dev->bus->number &&
>> -			slot == PCI_SLOT(dev->devfn) &&
>> -			func == PCI_FUNC(dev->devfn)) {
>> +		if ((seg == pci_domain_nr(dev->bus) || seg == -1) &&
>> +			(bus == dev->bus->number || bus == -1) &&
>> +			(slot == PCI_SLOT(dev->devfn) || slot == -1) &&
>> +			(func == PCI_FUNC(dev->devfn) || func == -1)) {
>>   			if (align_order == -1)
>>   				align = PAGE_SIZE;
>>   			else
>>   				align = 1 << align_order;
>> +			if (!pci_resources_page_aligned &&
>> +				(align >= PAGE_SIZE &&
>> +				seg == -1 && bus == -1 &&
>> +				slot == -1 && func == -1))
>> +				pci_resources_page_aligned = true;
>>   			/* Found */
>>   			break;
>>   		}
>>   		if (*p != ';' && *p != ',') {
>>   			/* End of param or invalid format */
>> +			invalid = true;
>>   			break;
>>   		}
>>   		p++;
>>   	}
>> +	if (invalid == true) {
>> +		/* Invalid format */
>> +		printk(KERN_ERR "PCI: Can't parse resource_alignment parameter:%s\n",
>> +				p);
>> +	}
>>   	spin_unlock(&resource_alignment_lock);
>>   	return align;
>>   }
>> @@ -4769,6 +4816,27 @@ static int __init pci_resource_alignment_sysfs_init(void)
>>   }
>>   late_initcall(pci_resource_alignment_sysfs_init);
>>   
>> +/*
>> + * This function checks whether PCI BARs' mmio page will be shared
>> + * with other BARs.
>> + */
>> +bool pci_resources_share_page(struct pci_dev *dev, int resno)
>> +{
>> +	struct resource *res = dev->resource + resno;
>> +
>> +	if (resource_size(res) >= PAGE_SIZE)
>> +		return false;
>> +	if (pci_resources_page_aligned && !(res->start & ~PAGE_MASK) &&
>> +		res->flags & IORESOURCE_MEM) {
>> +		if (res->sibling)
>> +			return (res->sibling->start & ~PAGE_MASK);
>> +		else
>> +			return false;
>> +	}
>> +	return true;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_resources_share_page);
> This should be a separate patch, there's no mention of this part of the
> change at all in the commitlog.  Also, pci_resource_page_aligned is
> only set if we use the magic wildcards to set alignment for all
> devices, it's not set if we use a specific seg:bus:dev.fn.  That's
> not consistent.  Can't we make use of the STARTALIGN flag for this or
> did that get removed when resources were assigned?

I only set pci_resource_page_aligned when using magic wildcards
because I must make sure pci_resources_share_page() can return
correctly when a hotplug event happens.

For example, there is only one half-page resource in the system.
And we use a specific seg:bus:dev.fn to force it to be page aligned.
So we set pci_resource_page_aligned because all devices are page
aligned now. It will return false when we call
pci_resources_share_page() for this resource. But this return value
will be not correct if we hot add a new device which also have
a half-page resource which will share one page with the previous
resource.

> The test itself is not entirely reassuring, I'd like some positive
> indication that the device has been aligned, not simply that it should
> have been and the start alignment appears that it might have happened.
> Apparently you don't trust pci_resources_page_aligned either since you
> still test the start alignment.

Yes, I don't trust pci_resources_page_aligned. Because
resource_alignment will not work in some case, e.g.
PCI_PROBE_ONLY or IORESOURCE_PCI_FIXED is set.

But I think *start* of the resource can give the positive
indication. The resource should not share page with
others if the start of the resource and its sibling are both
page aligned.

>> +
>>   static void pci_no_domains(void)
>>   {
>>   #ifdef CONFIG_PCI_DOMAINS
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 2771625..064a1b6 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1511,6 +1511,10 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>>   	 (pci_resource_end((dev), (bar)) -		\
>>   	  pci_resource_start((dev), (bar)) + 1))
>>   
>> +extern bool pci_resources_page_aligned;
> I'm not seeing why this shouldn't have been static since you're
> providing a function that tests it, there shouldn't really be any
> external consumers.

I made a mistake here. I will fix it in next version.

Thanks,
Yongji Xie.
