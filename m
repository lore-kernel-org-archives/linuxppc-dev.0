Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7C962C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 01:31:50 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 2 Jul 2013 20:55:31 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 58399E0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 21:01:21 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r62FW5Ra23199940
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jul 2013 21:02:06 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r62FVcVp016356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jul 2013 01:31:40 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH -V3 2/4] powerpc/kvm: Contiguous memory allocator based
 hash page table allocation
In-Reply-To: <51D2EDD7.9060205@suse.de>
References: <1372743918-12293-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1372743918-12293-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <51D2EDD7.9060205@suse.de>
Date: Tue, 02 Jul 2013 21:01:37 +0530
Message-ID: <87wqp9yo4m.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kvm@vger.kernel.org, mina86@mina86.com, linux-mm@kvack.org,
 paulus@samba.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 m.szyprowski@samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 07/02/2013 07:45 AM, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V"<aneesh.kumar@linux.vnet.ibm.com>
>>
>> Powerpc architecture uses a hash based page table mechanism for mapping virtual
>> addresses to physical address. The architecture require this hash page table to
>> be physically contiguous. With KVM on Powerpc currently we use early reservation
>> mechanism for allocating guest hash page table. This implies that we need to
>> reserve a big memory region to ensure we can create large number of guest
>> simultaneously with KVM on Power. Another disadvantage is that the reserved memory
>> is not available to rest of the subsystems and and that implies we limit the total
>> available memory in the host.
>>
>> This patch series switch the guest hash page table allocation to use
>> contiguous memory allocator.
>>
>> Signed-off-by: Aneesh Kumar K.V<aneesh.kumar@linux.vnet.ibm.com>
>
> Is CMA a mandatory option in the kernel? Or can it be optionally 
> disabled? If it can be disabled, we should keep the preallocated 
> fallback case around for systems that have CMA disabled.
>

CMA is not a mandatory option. But we have 

config KVM_BOOK3S_64_HV
	bool "KVM support for POWER7 and PPC970 using hypervisor mode in host"
	depends on KVM_BOOK3S_64
	select MMU_NOTIFIER
	select CMA

ie, for book3s HV we select CMA and only this CMA needs is memblock
which we already support

-aneesh
