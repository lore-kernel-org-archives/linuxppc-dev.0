Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTSq86gBQzDrpq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 12:59:16 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u872wHb5119975
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 22:59:14 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25a2m7j1s4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 22:59:14 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 7 Sep 2016 12:59:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 502E02BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 12:59:08 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u872x8CL1507612
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 12:59:08 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u872x7jb010085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 12:59:08 +1000
Subject: Re: [PATCH v4 5/5] PCI: Add a macro to set default alignment for all
 PCI devices
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1470980546-2918-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160906165930.GF1214@localhost>
Cc: zhong@linux.vnet.ibm.com, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, alex.williamson@redhat.com,
 paulus@samba.org, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Wed, 7 Sep 2016 10:59:08 +0800
MIME-Version: 1.0
In-Reply-To: <20160906165930.GF1214@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f7f87471-1e5a-4a9e-8d04-19f2733baa43@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/9/7 0:59, Bjorn Helgaas wrote:

> On Fri, Aug 12, 2016 at 01:42:26PM +0800, Yongji Xie wrote:
>> When vfio passthroughs a PCI device of which MMIO BARs are
>> smaller than PAGE_SIZE, guest will not handle the mmio
>> accesses to the BARs which leads to mmio emulations in host.
>>
>> This is because vfio will not allow to passthrough one BAR's
>> mmio page which may be shared with other BARs. Otherwise,
>> there will be a backdoor that guest can use to access BARs
>> of other guest.
>>
>> This patch adds a macro to set default alignment for all
>> PCI devices. Then we could solve this issue on some platforms
>> which would easily hit this issue because of their 64K page
>> such as PowerNV platform by defining this macro as PAGE_SIZE.
> Just to clarify, I think the issue happens on any arch, whenever
> device BARs are smaller than PAGE_SIZE.  This is obviously more
> *likely* when PAGE_SIZE is large, but could still happen even with
> 4K pages.

Yes, that's true.

Thanks,
Yongji

>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/pci.h |    4 ++++
>>   drivers/pci/pci.c              |    4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
>> index e9bd6cf..5e31bc2 100644
>> --- a/arch/powerpc/include/asm/pci.h
>> +++ b/arch/powerpc/include/asm/pci.h
>> @@ -28,6 +28,10 @@
>>   #define PCIBIOS_MIN_IO		0x1000
>>   #define PCIBIOS_MIN_MEM		0x10000000
>>   
>> +#ifdef CONFIG_PPC_POWERNV
>> +#define PCIBIOS_DEFAULT_ALIGNMENT	PAGE_SIZE
>> +#endif
>> +
>>   struct pci_dev;
>>   
>>   /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d895be7..feae59e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4959,6 +4959,10 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>>   	resource_size_t align = 0;
>>   	char *p;
>>   
>> +#ifdef PCIBIOS_DEFAULT_ALIGNMENT
>> +	align = PCIBIOS_DEFAULT_ALIGNMENT;
>> +	*resize = false;
>> +#endif
>>   	spin_lock(&resource_alignment_lock);
>>   	p = resource_alignment_param;
>>   	if (pci_has_flag(PCI_PROBE_ONLY)) {
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
