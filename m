Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLsn62tSHzF0Tw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 14:21:13 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0H3LAN9060770
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 22:21:11 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fhsfyacff-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 22:21:09 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 Jan 2018 20:19:11 -0700
Subject: Re: [PATCH v2] powerpc/mm: Fix growth direction for hugepages mmaps
 with slice
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180109101810.2471D6C6CF@localhost.localdomain>
 <87wp0haizf.fsf@linux.vnet.ibm.com>
 <d5f6060f-3061-dc3c-66f7-3cec05d50169@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 17 Jan 2018 08:49:03 +0530
MIME-Version: 1.0
In-Reply-To: <d5f6060f-3061-dc3c-66f7-3cec05d50169@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f5f2af23-f535-8fca-4edf-a0ec4107a7df@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/16/2018 10:18 PM, Christophe LEROY wrote:
> 
> 
> Le 16/01/2018 à 17:03, Aneesh Kumar K.V a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> An application running with libhugetlbfs fails to allocate
>>> additional pages to HEAP due to the hugemap being done
>>> inconditionally as topdown mapping:
>>>
>>> mmap(0x10080000, 1572864, PROT_READ|PROT_WRITE, 
>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x73e80000
>>> [...]
>>> mmap(0x74000000, 1048576, PROT_READ|PROT_WRITE, 
>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d80000
>>> munmap(0x73d80000, 1048576)             = 0
>>> [...]
>>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, 
>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>>> munmap(0x73d00000, 1572864)             = 0
>>> [...]
>>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, 
>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>>> munmap(0x73d00000, 1572864)             = 0
>>> [...]
>>>
>>
>> Can you explain the failure details above. I am not sure I understand
>> what to read from the above output.
> 
> libhugetlbfs first requests an area of size 1.5Mbytes, at address 
> 0x10080000
> mmap() returns an area at address 0x73e80000
> 
> Then libhugetlbfs requests an additional area on top of that, ie at 
> address 0x74000000, to expand the heap.
> But mmap() returns an area at address 0x73d80000, ie under the previous 
> area.
> 


Can you share the test details?. Why does it not fail on book3s64? We 
use topdown search with book3s64.

> This is not the behaviour when using the generic (ie without mm_slices) 
> hugepages code, and this is not what libhugetlbfs expects for expending 
> the heap.
> 
>

-aneesh
