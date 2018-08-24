Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xyRK1ymCzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 09:39:08 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7ONYEt1059825
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 19:39:06 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m2u5th5sd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 19:39:06 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 24 Aug 2018 17:39:05 -0600
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
 <20180824025933.24319-11-bauerman@linux.ibm.com>
 <20180824060055.GB13689@lst.de>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Anshuman Khandual <anshuman.linux@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mike Anderson <andmike@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 10/11] powerpc/svm: Force the use of bounce buffers
In-reply-to: <20180824060055.GB13689@lst.de>
Date: Fri, 24 Aug 2018 20:38:54 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9drxrld.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello Christoph,

Thanks for your quick review.

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Aug 23, 2018 at 11:59:32PM -0300, Thiago Jung Bauermann wrote:
>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>
>> SWIOTLB checks range of incoming CPU addresses to be bounced and see if the
>> device can access it through it's DMA window without requiring bouncing. In
>> such cases it just chooses to skip bouncing. But for cases like secure
>> guests on powerpc platform all addresses need to be bounced into the shared
>> pool of memory because the host cannot access it otherwise. Hence the need
>> to do the bouncing is not related to device's DMA window. Hence force the
>> use of bouncing by setting the swiotlb_force variable on secure guests.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  arch/powerpc/kernel/svm.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
>> index 1af5caa955f5..f0576ad65cd0 100644
>> --- a/arch/powerpc/kernel/svm.c
>> +++ b/arch/powerpc/kernel/svm.c
>> @@ -17,6 +17,7 @@ static int __init init_svm(void)
>>  		return 0;
>>
>>  	ppc_swiotlb_enable = 1;
>> +	swiotlb_force = SWIOTLB_FORCE;
>>  	swiotlb_update_mem_attributes();
>
> This needs a comment.

Good point. Will add one.

If in the new scheme of things (with bus_dma_mask?) dma_capable() on a
virtio device running in a secure guest returns false, then this patch
becomes unnecessary and can be dropped.

--
Thiago Jung Bauermann
IBM Linux Technology Center
