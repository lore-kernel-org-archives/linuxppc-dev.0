Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 092051A024F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 21:41:39 +1000 (EST)
Message-ID: <5385CB6F.50300@suse.de>
Date: Wed, 28 May 2014 13:41:35 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401214527.3289.611.camel@ul30vt.home> <20140528005532.GA5528@shangw>
In-Reply-To: <20140528005532.GA5528@shangw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.05.14 02:55, Gavin Shan wrote:
> On Tue, May 27, 2014 at 12:15:27PM -0600, Alex Williamson wrote:
>> On Tue, 2014-05-27 at 18:40 +1000, Gavin Shan wrote:
>>> The patch adds new IOCTL commands for sPAPR VFIO container device
>>> to support EEH functionality for PCI devices, which have been passed
>>> through from host to somebody else via VFIO.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>   Documentation/vfio.txt              | 92 ++++++++++++++++++++++++++++++++++++-
>>>   drivers/vfio/pci/Makefile           |  1 +
>>>   drivers/vfio/pci/vfio_pci.c         | 20 +++++---
>>>   drivers/vfio/pci/vfio_pci_eeh.c     | 46 +++++++++++++++++++
>>>   drivers/vfio/pci/vfio_pci_private.h |  5 ++
>>>   drivers/vfio/vfio_iommu_spapr_tce.c | 85 ++++++++++++++++++++++++++++++++++
>>>   include/uapi/linux/vfio.h           | 66 ++++++++++++++++++++++++++
>>>   7 files changed, 308 insertions(+), 7 deletions(-)
>>>   create mode 100644 drivers/vfio/pci/vfio_pci_eeh.c

[...]

>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>> index cb9023d..c5fac36 100644
>>> --- a/include/uapi/linux/vfio.h
>>> +++ b/include/uapi/linux/vfio.h
>>> @@ -455,6 +455,72 @@ struct vfio_iommu_spapr_tce_info {
>>>   
>>>   #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
>>>   
>>> +/*
>>> + * EEH functionality can be enabled or disabled on one specific device.
>>> + * Also, the DMA or IO frozen state can be removed from the frozen PE
>>> + * if required.
>>> + */
>>> +struct vfio_eeh_pe_set_option {
>>> +	__u32 argsz;
>>> +	__u32 flags;
>>> +	__u32 option;
>>> +#define VFIO_EEH_PE_SET_OPT_DISABLE	0	/* Disable EEH	*/
>>> +#define VFIO_EEH_PE_SET_OPT_ENABLE	1	/* Enable EEH	*/
>>> +#define VFIO_EEH_PE_SET_OPT_IO		2	/* Enable IO	*/
>>> +#define VFIO_EEH_PE_SET_OPT_DMA		3	/* Enable DMA	*/
>> This is more of a "command" than an "option" isn't it?  Each of these
>> probably needs a more significant description.
>>
> Yeah, it would be regarded as "opcode" and I'll add more description about
> them in next revision.

Please just call them commands.

>
>>> +};
>>> +
>>> +#define VFIO_EEH_PE_SET_OPTION		_IO(VFIO_TYPE, VFIO_BASE + 21)
>>> +
>>> +/*
>>> + * Each EEH PE should have unique address to be identified. PE's
>>> + * sharing mode is also useful information as well.
>>> + */
>>> +#define VFIO_EEH_PE_GET_ADDRESS		0	/* Get address	*/
>>> +#define VFIO_EEH_PE_GET_MODE		1	/* Query mode	*/
>>> +#define VFIO_EEH_PE_MODE_NONE		0	/* Not a PE	*/
>>> +#define VFIO_EEH_PE_MODE_NOT_SHARED	1	/* Exclusive	*/
>>> +#define VFIO_EEH_PE_MODE_SHARED		2	/* Shared mode	*/
>>> +
>>> +/*
>>> + * EEH PE might have been frozen because of PCI errors. Also, it might
>>> + * be experiencing reset for error revoery. The following command helps
>>> + * to get the state.
>>> + */
>>> +struct vfio_eeh_pe_get_state {
>>> +	__u32 argsz;
>>> +	__u32 flags;
>>> +	__u32 state;
>>> +};
>> Should state be a union to better describe the value returned?  What
>> exactly is the address and why does the user need to know it?  Does this
>> need user input or could we just return the address and mode regardless?
>>
> Ok. I think you want enum (not union) for state. I'll have macros for the
> state in next revision as I did that for other cases.
>
> Those macros defined for "address" just for ABI stuff as Alex.G mentioned.
> There isn't corresponding ioctl command for host to get address any more
> because QEMU (user) will have to figure it out by himself. The "address"
> here means PE address and user has to figure it out according to PE
> segmentation.

Why would the user ever need the address?


Alex
