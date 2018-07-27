Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cQwk6LBdzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 21:00:22 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6RAxXYm136517
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 07:00:19 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kfy2f82sw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 07:00:19 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 27 Jul 2018 12:00:16 +0100
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
To: Will Deacon <will.deacon@arm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com, aik@ozlabs.ru,
 jasowang@redhat.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 jean-philippe.brucker@arm.com, paulus@samba.org, marc.zyngier@arm.com,
 joe@perches.com, robin.murphy@arm.com, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, haren@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 27 Jul 2018 16:28:33 +0530
MIME-Version: 1.0
In-Reply-To: <20180727095804.GA25592@arm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <0f123b95-7ac2-d1a2-80c9-732c7113d9c0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/27/2018 03:28 PM, Will Deacon wrote:
> Hi Anshuman,
> 
> On Fri, Jul 20, 2018 at 09:29:37AM +0530, Anshuman Khandual wrote:
>> This patch series is the follow up on the discussions we had before about
>> the RFC titled [RFC,V2] virtio: Add platform specific DMA API translation
>> for virito devices (https://patchwork.kernel.org/patch/10417371/). There
>> were suggestions about doing away with two different paths of transactions
>> with the host/QEMU, first being the direct GPA and the other being the DMA
>> API based translations.
>>
>> First patch attempts to create a direct GPA mapping based DMA operations
>> structure called 'virtio_direct_dma_ops' with exact same implementation
>> of the direct GPA path which virtio core currently has but just wrapped in
>> a DMA API format. Virtio core must use 'virtio_direct_dma_ops' instead of
>> the arch default in absence of VIRTIO_F_IOMMU_PLATFORM flag to preserve the
>> existing semantics. The second patch does exactly that inside the function
>> virtio_finalize_features(). The third patch removes the default direct GPA
>> path from virtio core forcing it to use DMA API callbacks for all devices.
>> Now with that change, every device must have a DMA operations structure
>> associated with it. The fourth patch adds an additional hook which gives
>> the platform an opportunity to do yet another override if required. This
>> platform hook can be used on POWER Ultravisor based protected guests to
>> load up SWIOTLB DMA callbacks to do the required (as discussed previously
>> in the above mentioned thread how host is allowed to access only parts of
>> the guest GPA range) bounce buffering into the shared memory for all I/O
>> scatter gather buffers to be consumed on the host side.
>>
>> Please go through these patches and review whether this approach broadly
>> makes sense. I will appreciate suggestions, inputs, comments regarding
>> the patches or the approach in general. Thank you.
> I just wanted to say that this patch series provides a means for us to
> force the coherent DMA ops for legacy virtio devices on arm64, which in turn
> means that we can enable the SMMU with legacy devices in our fastmodel
> emulation platform (which is slowly being upgraded to virtio 1.0) without
> hanging during boot. Patch below.
> 
> So:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Will Deacon <will.deacon@arm.com>

Thanks Will.
