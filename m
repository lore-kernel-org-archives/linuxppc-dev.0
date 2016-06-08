Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPkPp1g8WzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 19:57:34 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u589rfIM029106
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 05:57:32 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m3p0ae-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 05:57:32 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 19:57:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4AA772CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 19:57:02 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u589upZ68782054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 19:56:51 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u589udXW010887
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 19:56:41 +1000
Subject: Re: [RESEND PATCH v2 0/6] vfio-pci: Add support for mmapping MSI-X
 table
To: Auger Eric <eric.auger@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
References: <1464847803-22756-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <e03d36bb-c8ff-ec95-780e-5f625bdaf78e@redhat.com>
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, alistair@popple.id.au, ruscur@russell.cc,
 kevin.tian@intel.com, David.Laight@ACULAB.COM
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Wed, 8 Jun 2016 17:56:49 +0800
MIME-Version: 1.0
In-Reply-To: <e03d36bb-c8ff-ec95-780e-5f625bdaf78e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8ccf0165-da3e-9709-6cf2-ccab82eb55fb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Eric

On 2016/6/8 15:41, Auger Eric wrote:

> Hi Yongji,
>
> Le 02/06/2016 à 08:09, Yongji Xie a écrit :
>> Current vfio-pci implementation disallows to mmap the page
>> containing MSI-X table in case that users can write directly
>> to MSI-X table and generate an incorrect MSIs.
>>
>> However, this will cause some performance issue when there
>> are some critical device registers in the same page as the
>> MSI-X table. We have to handle the mmio access to these
>> registers in QEMU emulation rather than in guest.
>>
>> To solve this issue, this series allows to expose MSI-X table
>> to userspace when hardware enables the capability of interrupt
>> remapping which can ensure that a given PCI device can only
>> shoot the MSIs assigned for it. And we introduce a new bus_flags
>> PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
>> for different archs.
>>
>> The patch 3 are based on the proposed patchset[1].
> You may have noticed I sent a respin of [1] yesterday:
> http://www.gossamer-threads.com/lists/linux/kernel/2455187.
>
> Unfortunately you will see I removed the patch defining the new
> msi_domain_info MSI_FLAG_IRQ_REMAPPING flag you rely on in this series.
> I did so because I was not using it anymore. At the beginning this was
> used to detect whether the MSI assignment was safe but this
> method was covering cases where the MSI controller was
> upstream to the IOMMU. So now I rely on a mechanism where MSI controller
> are supposed to register their MSI doorbells and tag whether it is safe.
>
> I don't know yet how this change will be welcomed though. Depending
> on reviews/discussions, might happen we revert to the previous flag.
>
> If you need the feature you can embed the used patches in your series and
> follow the review process separately. Sorry for the setback.

Thanks for your notification. I'd better wait until your patches get
settled. Then I could exactly know which way we should use to test the
capability of interrupt remapping on ARM in my series.

Thanks,
Yongji
