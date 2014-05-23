Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A32981A0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 10:37:40 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 23 May 2014 10:37:40 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B6AAF357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 10:37:37 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4N0bMru6357248
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 10:37:22 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4N0baDv009918
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 10:37:37 +1000
Date: Fri, 23 May 2014 10:37:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
Message-ID: <20140523003737.GA15136@shangw>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <537DC991.9010401@suse.de> <20140523001730.GA12584@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140523001730.GA12584@shangw>
Cc: aik@ozlabs.ru, Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 23, 2014 at 10:17:30AM +1000, Gavin Shan wrote:
>On Thu, May 22, 2014 at 11:55:29AM +0200, Alexander Graf wrote:
>>On 22.05.14 10:23, Gavin Shan wrote:

.../...

>>>diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>index cb9023d..ef55682 100644
>>>--- a/include/uapi/linux/vfio.h
>>>+++ b/include/uapi/linux/vfio.h
>>>@@ -455,6 +455,59 @@ struct vfio_iommu_spapr_tce_info {
>>>  #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
>>>+/*
>>>+ * EEH functionality can be enabled or disabled on one specific device.
>>>+ * Also, the DMA or IO frozen state can be removed from the frozen PE
>>>+ * if required.
>>>+ */
>>>+struct vfio_eeh_pe_set_option {
>>>+	__u32 argsz;
>>
>>What is this argsz thing? Is this your way of maintaining backwards
>>compatibility when we introduce new fields? A new field will change
>>the ioctl number, so I don't think that makes a lot of sense :).
>>
>>Just make the ioctl have a u32 as incoming argument. No fancy
>>structs, no complicated code.
>>
>>The same applies for a number of structs below.
>>
>
>ok. Will do in next revision.
>

Rechecked include/uapi/linux/vfio.h, the data struct for each ioctl command
always has "argsz". I guess it was used as checker by Alex.W. Do you really
want remove "argsz" ?

>>>+	__u32 option;
>>>+};
>>>+
>>>+#define VFIO_EEH_PE_SET_OPTION		_IO(VFIO_TYPE, VFIO_BASE + 21)
>>>+
>>>+/*
>>>+ * Each EEH PE should have unique address to be identified. The command
>>>+ * helps to retrieve the address and the sharing mode of the PE.
>>>+ */
>>>+struct vfio_eeh_pe_get_addr {
>>>+	__u32 argsz;
>>>+	__u32 option;
>>>+	__u32 info;
>>
>>Any particular reason you need the info field? Can't the return value
>>of the ioctl hold this? Then you only have a single u32 argument left
>>to the ioctl again.
>>
>
>ok. Will do in next revision.
>

If we eventually remove "argsz" and let ioctl() return value to hold
information (or negative number for errors), we don't need any data
struct because the 3rd parameter of ioctl() would be used as input
and I only need one input parameter. Do you want see this ?

Hopefully, Alex.W saw this and hasn't objections :)

Thanks,
Gavin
