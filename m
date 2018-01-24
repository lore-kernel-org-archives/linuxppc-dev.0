Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRL6Q5B4fzDqrL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 20:51:42 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0O9nXfh024203
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 04:51:40 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fpq391s6u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 04:51:40 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 24 Jan 2018 02:51:39 -0700
Subject: Re: [PATCH v3 5/5] powerpc/mm: Fix growth direction for hugepages
 mmaps with slice
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <6920f6efe2dcdabf59350b2d31ee6bd4bdef57f4.1516783089.git.christophe.leroy@c-s.fr>
 <362a93307a09b521878c47a8999a39a228184293.1516783089.git.christophe.leroy@c-s.fr>
 <c6eff627-9d86-dab1-e91e-9ea5a98c4c55@linux.vnet.ibm.com>
 <c532efa7-33a4-1f4f-e83a-5eaeba65b799@c-s.fr>
 <9aea8b6f-0d1a-b700-efe4-8efcebc5d16d@linux.vnet.ibm.com>
 <c6ca42a1-eae3-8f07-79e5-a71b3cdfea81@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 24 Jan 2018 15:21:32 +0530
MIME-Version: 1.0
In-Reply-To: <c6ca42a1-eae3-8f07-79e5-a71b3cdfea81@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <47bbd8be-7b2e-245b-08d9-24958eec2ed2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/24/2018 03:09 PM, Christophe LEROY wrote:
> 
> 
> Le 24/01/2018 à 10:35, Aneesh Kumar K.V a écrit :
>>

>>> Did you try with HUGETLB_MORECORE_HEAPBASE=0x11000000 on PPC64 as I 
>>> suggested in my last email on this subject (22/01/2018 9:22) ?
>>
>>
>> yes. The test ran fine for me
> 
> You tried with 0x30000000, it works as well on PPC32.
> 
> I'd really like you to try with 0x11000000 which is in the same slice as 
> the 10020000-10030000 range.
> 
> 

Now that explains is better. But then the requested HEAPBASE was not 
free and hence topdown search got an address in the below range.

7efffd000000-7f0000000000 rw-p 00000000 00:0d 1082770 
/anon_hugepage (deleted)


The new range allocated is such that there is no scope for expansion of 
heap if we do a topdown search. But why should that require us to change 
from topdown/bottomup search?


10000000-10010000 r-xp 00000000 fc:00 9044312 
/home/kvaneesh/a.out
10010000-10020000 r--p 00000000 fc:00 9044312 
/home/kvaneesh/a.out
10020000-10030000 rw-p 00010000 fc:00 9044312 
/home/kvaneesh/a.out
7efffd000000-7f0000000000 rw-p 00000000 00:0d 1082770 
/anon_hugepage (deleted)
7ffff2d40000-7ffff7d60000 rw-p 00000000 00:00 0
7ffff7d60000-7ffff7f10000 r-xp 00000000 fc:00 9250090 
/lib/powerpc64le-linux-gnu/libc-2.23.so
7ffff7f10000-7ffff7f20000 r--p 001a0000 fc:00 9250090 
/lib/powerpc64le-linux-gnu/libc-2.23.so
7ffff7f20000-7ffff7f30000 rw-p 001b0000 fc:00 9250090 
/lib/powerpc64le-linux-gnu/libc-2.23.so
7ffff7f40000-7ffff7f60000 r-xp 00000000 fc:00 10754812 
/usr/lib/libhugetlbfs.so.0
7ffff7f60000-7ffff7f70000 r--p 00010000 fc:00 10754812 
/usr/lib/libhugetlbfs.so.0
7ffff7f70000-7ffff7f80000 rw-p 00020000 fc:00 10754812 
/usr/lib/libhugetlbfs.so.0
7ffff7f80000-7ffff7fa0000 r-xp 00000000 00:00 0 
[vdso]
7ffff7fa0000-7ffff7fe0000 r-xp 00000000 fc:00 9250107 
/lib/powerpc64le-linux-gnu/ld-2.23.so
7ffff7fe0000-7ffff7ff0000 r--p 00030000 fc:00 9250107 
/lib/powerpc64le-linux-gnu/ld-2.23.so
7ffff7ff0000-7ffff8000000 rw-p 00040000 fc:00 9250107 
/lib/powerpc64le-linux-gnu/ld-2.23.so
7ffffffd0000-800000000000 rw-p 00000000 00:00 0 
[stack]


For the specific test, one should pass the HEAPBASE value such that it 
can be expanded if required isn't it ?

-aneesh
