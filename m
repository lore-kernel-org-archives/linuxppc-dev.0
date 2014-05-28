Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07C031A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 09:38:00 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 29 May 2014 09:37:57 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5AB022CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 09:37:54 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4SNGIEQ64159794
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 09:16:18 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4SNbri6023708
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 09:37:53 +1000
Date: Thu, 29 May 2014 09:37:53 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
Message-ID: <20140528233753.GA8150@shangw>
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401214527.3289.611.camel@ul30vt.home> <5385166A.5060404@suse.de>
 <1401237575.3289.676.camel@ul30vt.home> <53853155.60809@suse.de>
 <1401238674.3289.679.camel@ul30vt.home> <5385CA86.3010700@suse.de>
 <1401293853.2412.36.camel@ul30vt.home> <538665DA.8090000@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <538665DA.8090000@suse.de>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 29, 2014 at 12:40:26AM +0200, Alexander Graf wrote:
>On 28.05.14 18:17, Alex Williamson wrote:
>>On Wed, 2014-05-28 at 13:37 +0200, Alexander Graf wrote:
>>>On 28.05.14 02:57, Alex Williamson wrote:
>>>>On Wed, 2014-05-28 at 02:44 +0200, Alexander Graf wrote:
>>>>>On 28.05.14 02:39, Alex Williamson wrote:
>>>>>>On Wed, 2014-05-28 at 00:49 +0200, Alexander Graf wrote:
>>>>>>>On 27.05.14 20:15, Alex Williamson wrote:
>>>>>>>>On Tue, 2014-05-27 at 18:40 +1000, Gavin Shan wrote:
>>>>>>>>>The patch adds new IOCTL commands for sPAPR VFIO container device
>>>>>>>>>to support EEH functionality for PCI devices, which have been passed
>>>>>>>>>through from host to somebody else via VFIO.
>>>>>>>>>
>>>>>>>>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>>>>>>---
>>>>>>>>>     Documentation/vfio.txt              | 92 ++++++++++++++++++++++++++++++++++++-
>>>>>>>>>     drivers/vfio/pci/Makefile           |  1 +
>>>>>>>>>     drivers/vfio/pci/vfio_pci.c         | 20 +++++---
>>>>>>>>>     drivers/vfio/pci/vfio_pci_eeh.c     | 46 +++++++++++++++++++
>>>>>>>>>     drivers/vfio/pci/vfio_pci_private.h |  5 ++
>>>>>>>>>     drivers/vfio/vfio_iommu_spapr_tce.c | 85 ++++++++++++++++++++++++++++++++++
>>>>>>>>>     include/uapi/linux/vfio.h           | 66 ++++++++++++++++++++++++++
>>>>>>>>>     7 files changed, 308 insertions(+), 7 deletions(-)
>>>>>>>>>     create mode 100644 drivers/vfio/pci/vfio_pci_eeh.c
>>>>>>>[...]
>>>>>>>
>>>>>>>>>+
>>>>>>>>>+	return ret;
>>>>>>>>>+}
>>>>>>>>>+
>>>>>>>>>     static long tce_iommu_ioctl(void *iommu_data,
>>>>>>>>>     				 unsigned int cmd, unsigned long arg)
>>>>>>>>>     {
>>>>>>>>>@@ -283,6 +363,11 @@ static long tce_iommu_ioctl(void *iommu_data,
>>>>>>>>>     		tce_iommu_disable(container);
>>>>>>>>>     		mutex_unlock(&container->lock);
>>>>>>>>>     		return 0;
>>>>>>>>>+	case VFIO_EEH_PE_SET_OPTION:
>>>>>>>>>+	case VFIO_EEH_PE_GET_STATE:
>>>>>>>>>+	case VFIO_EEH_PE_RESET:
>>>>>>>>>+	case VFIO_EEH_PE_CONFIGURE:
>>>>>>>>>+		return tce_iommu_eeh_ioctl(iommu_data, cmd, arg);
>>>>>>>>This is where it would have really made sense to have a single
>>>>>>>>VFIO_EEH_OP ioctl with a data structure passed to indicate the sub-op.
>>>>>>>>AlexG, are you really attached to splitting these out into separate
>>>>>>>>ioctls?
>>>>>>>I don't see the problem. We need to forward 4 ioctls to a separate piece
>>>>>>>of code, so we forward 4 ioctls to a separate piece of code :). Putting
>>>>>>>them into one ioctl just moves the switch() into another function.
>>>>>>And uses an extra 3 ioctl numbers and gives us extra things to update if
>>>>>>we ever need to add more ioctls, etc.  ioctl numbers are an address
>>>>>>space, how much address space do we really want to give to EEH?  It's
>>>>>>not a big difference, but I don't think it's completely even either.
>>>>>>Thanks,
>>>>>Yes, that's the point. I by far prefer to have you push back on anyone
>>>>>who introduces useless ioctls rather than have a separate EEH number
>>>>>space that people can just throw anything in they like ;).
>>>>Well, I appreciate that, but having them as separate ioctls doesn't
>>>>really prevent that either.  Any one of these 4 could be set to take a
>>>>sub-option to extend and contort the EEH interface.  The only way to
>>>>prevent that would be to avoid the argsz+flags hack that make the ioctl
>>>>extendable.  Thanks,
>>>Sure, that's what patch review is about. I'm really more concerned about
>>>whose court the number space is in - you or Gavin. If we're talking
>>>about top level ioctls you will care a lot more.
>>>
>>>But I'm not religious about this. You're the VFIO maintainer, so it's
>>>your call. I just personally cringe when I see an ioctl that gets an
>>>"opcode" and a "parameter" argument where the "parameter" argument is a
>>>union with one struct for each opcode.
>>Well, what would it look like...
>>
>>struct vfio_eeh_pe_op {
>>	__u32 argsz;
>>	__u32 flags;
>>	__u32 op;
>>};
>>
>>Couldn't every single one of these be a separate "op"?  Are there any
>>cases where we can't use the ioctl return value?
>>
>>VFIO_EEH_PE_DISABLE
>>VFIO_EEH_PE_ENABLE
>>VFIO_EEH_PE_UNFREEZE_IO
>>VFIO_EEH_PE_UNFREEZE_DMA
>>VFIO_EEH_PE_GET_MODE
>>VFIO_EEH_PE_RESET_DEACTIVATE
>>VFIO_EEH_PE_RESET_HOT
>>VFIO_EEH_PE_RESET_FUNDAMENTAL
>>VFIO_EEH_PE_CONFIGURE
>>
>>It doesn't look that bad to me, what am I missing?  Thanks,
>
>Yup, that looks well to me as well :)
>

s/VFIO_EEH_PE_GET_MODE/VFIO_EEH_PE_GET_STATE.

I'll include this in next revision. Thanks, Alex.

Thanks,
Gavin
