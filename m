Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5F9C1A058F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 23:12:44 +1000 (EST)
Message-ID: <5385E0C3.8020000@suse.de>
Date: Wed, 28 May 2014 15:12:35 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401214527.3289.611.camel@ul30vt.home> <20140528005532.GA5528@shangw>
 <5385CB6F.50300@suse.de> <20140528124947.GA19346@shangw>
In-Reply-To: <20140528124947.GA19346@shangw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.05.14 14:49, Gavin Shan wrote:
> On Wed, May 28, 2014 at 01:41:35PM +0200, Alexander Graf wrote:
>> On 28.05.14 02:55, Gavin Shan wrote:
>>> On Tue, May 27, 2014 at 12:15:27PM -0600, Alex Williamson wrote:
>>>> On Tue, 2014-05-27 at 18:40 +1000, Gavin Shan wrote:
>>>>> The patch adds new IOCTL commands for sPAPR VFIO container device
>>>>> to support EEH functionality for PCI devices, which have been passed
>>>>> through from host to somebody else via VFIO.
>>>>>
>>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>> ---
>>>>>   Documentation/vfio.txt              | 92 ++++++++++++++++++++++++++++++++++++-
>>>>>   drivers/vfio/pci/Makefile           |  1 +
>>>>>   drivers/vfio/pci/vfio_pci.c         | 20 +++++---
>>>>>   drivers/vfio/pci/vfio_pci_eeh.c     | 46 +++++++++++++++++++
>>>>>   drivers/vfio/pci/vfio_pci_private.h |  5 ++
>>>>>   drivers/vfio/vfio_iommu_spapr_tce.c | 85 ++++++++++++++++++++++++++++++++++
>>>>>   include/uapi/linux/vfio.h           | 66 ++++++++++++++++++++++++++
>>>>>   7 files changed, 308 insertions(+), 7 deletions(-)
>>>>>   create mode 100644 drivers/vfio/pci/vfio_pci_eeh.c
>> [...]
>>
>>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>>> index cb9023d..c5fac36 100644
>>>>> --- a/include/uapi/linux/vfio.h
>>>>> +++ b/include/uapi/linux/vfio.h
>>>>> @@ -455,6 +455,72 @@ struct vfio_iommu_spapr_tce_info {
>>>>>   #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
>>>>> +/*
>>>>> + * EEH functionality can be enabled or disabled on one specific device.
>>>>> + * Also, the DMA or IO frozen state can be removed from the frozen PE
>>>>> + * if required.
>>>>> + */
>>>>> +struct vfio_eeh_pe_set_option {
>>>>> +	__u32 argsz;
>>>>> +	__u32 flags;
>>>>> +	__u32 option;
>>>>> +#define VFIO_EEH_PE_SET_OPT_DISABLE	0	/* Disable EEH	*/
>>>>> +#define VFIO_EEH_PE_SET_OPT_ENABLE	1	/* Enable EEH	*/
>>>>> +#define VFIO_EEH_PE_SET_OPT_IO		2	/* Enable IO	*/
>>>>> +#define VFIO_EEH_PE_SET_OPT_DMA		3	/* Enable DMA	*/
>>>> This is more of a "command" than an "option" isn't it?  Each of these
>>>> probably needs a more significant description.
>>>>
>>> Yeah, it would be regarded as "opcode" and I'll add more description about
>>> them in next revision.
>> Please just call them commands.
>>
> Ok. I guess you want me to change the macro names like this ?
>
> #define VFIO_EEH_CMD_DISABLE	0	/* Disable EEH functionality	*/
> #define VFIO_EEH_CMD_ENABLE	1	/* Enable EEH functionality	*/
> #define VFIO_EEH_CMD_ENABLE_IO	2	/* Enable IO for frozen PE	*/
> #define VFIO_EEH_CMD_ENABLE_DMA	3	/* Enable DMA for frozen PE	*/

Yes, the ioctl name too.

>
>>>>> +};
>>>>> +
>>>>> +#define VFIO_EEH_PE_SET_OPTION		_IO(VFIO_TYPE, VFIO_BASE + 21)
>>>>> +
>>>>> +/*
>>>>> + * Each EEH PE should have unique address to be identified. PE's
>>>>> + * sharing mode is also useful information as well.
>>>>> + */
>>>>> +#define VFIO_EEH_PE_GET_ADDRESS		0	/* Get address	*/
>>>>> +#define VFIO_EEH_PE_GET_MODE		1	/* Query mode	*/
>>>>> +#define VFIO_EEH_PE_MODE_NONE		0	/* Not a PE	*/
>>>>> +#define VFIO_EEH_PE_MODE_NOT_SHARED	1	/* Exclusive	*/
>>>>> +#define VFIO_EEH_PE_MODE_SHARED		2	/* Shared mode	*/
>>>>> +
>>>>> +/*
>>>>> + * EEH PE might have been frozen because of PCI errors. Also, it might
>>>>> + * be experiencing reset for error revoery. The following command helps
>>>>> + * to get the state.
>>>>> + */
>>>>> +struct vfio_eeh_pe_get_state {
>>>>> +	__u32 argsz;
>>>>> +	__u32 flags;
>>>>> +	__u32 state;
>>>>> +};
>>>> Should state be a union to better describe the value returned?  What
>>>> exactly is the address and why does the user need to know it?  Does this
>>>> need user input or could we just return the address and mode regardless?
>>>>
>>> Ok. I think you want enum (not union) for state. I'll have macros for the
>>> state in next revision as I did that for other cases.
>>>
>>> Those macros defined for "address" just for ABI stuff as Alex.G mentioned.
>>> There isn't corresponding ioctl command for host to get address any more
>>> because QEMU (user) will have to figure it out by himself. The "address"
>>> here means PE address and user has to figure it out according to PE
>>> segmentation.
>> Why would the user ever need the address?
>>
> I will remove those "address" related macros in next revision because it's
> user-level bussiness, not related to host kernel any more.

Ok, so the next question is whether there will be any state outside of 
GET_MODE left in the future.


Alex

> If the user is QEMU + guest, we need the address to identify the PE though PHB
> BUID could be used as same purpose to get PHB, which is one-to-one mapping with
> IOMMU group on sPAPR platform. However, once the PE address is built and returned
> to guest, guest will use the PE address as input parameter in subsequent RTAS
> calls.
>
> If the user is some kind of application who just uses the ioctl() without supporting
> RTAS calls. We don't need care about PE address.
>
> Thanks,
> Gavin
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
