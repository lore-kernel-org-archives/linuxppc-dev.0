Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQ4DG17mNzF0ZW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 19:22:20 +1100 (AEDT)
Subject: Re: [PATCH v2] powerpc/mm: Fix growth direction for hugepages mmaps
 with slice
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20180109101810.2471D6C6CF@localhost.localdomain>
 <87wp0haizf.fsf@linux.vnet.ibm.com>
 <d5f6060f-3061-dc3c-66f7-3cec05d50169@c-s.fr>
 <f5f2af23-f535-8fca-4edf-a0ec4107a7df@linux.vnet.ibm.com>
 <dd2e281e-0dea-8acf-30dc-b85d0d438cf3@c-s.fr>
 <87y3kuz559.fsf@linux.vnet.ibm.com> <87mv1ayxi6.fsf@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <9ac743f8-a3ac-4e54-af75-8af8d56f00b6@c-s.fr>
Date: Mon, 22 Jan 2018 09:22:15 +0100
MIME-Version: 1.0
In-Reply-To: <87mv1ayxi6.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/01/2018 à 11:05, Aneesh Kumar K.V a écrit :
> 
> Did a reply instead of reply-all.
> 
> Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>>
>>> Le 17/01/2018 à 04:19, Aneesh Kumar K.V a écrit :
>>>>
>>>>
>>>> On 01/16/2018 10:18 PM, Christophe LEROY wrote:
>>>>>
>>>>>
>>>>> Le 16/01/2018 à 17:03, Aneesh Kumar K.V a écrit :
>>>>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>>>>
>>>>>>> An application running with libhugetlbfs fails to allocate
>>>>>>> additional pages to HEAP due to the hugemap being done
>>>>>>> inconditionally as topdown mapping:
>>>>>>>
>>>>>>> mmap(0x10080000, 1572864, PROT_READ|PROT_WRITE,
>>>>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x73e80000
>>>>>>> [...]
>>>>>>> mmap(0x74000000, 1048576, PROT_READ|PROT_WRITE,
>>>>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d80000
>>>>>>> munmap(0x73d80000, 1048576)             = 0
>>>>>>> [...]
>>>>>>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE,
>>>>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>>>>>>> munmap(0x73d00000, 1572864)             = 0
>>>>>>> [...]
>>>>>>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE,
>>>>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>>>>>>> munmap(0x73d00000, 1572864)             = 0
>>>>>>> [...]
>>>>>>>
>>>>>>
>>>>>> Can you explain the failure details above. I am not sure I understand
>>>>>> what to read from the above output.
>>>>>
>>>>> libhugetlbfs first requests an area of size 1.5Mbytes, at address
>>>>> 0x10080000
>>>>> mmap() returns an area at address 0x73e80000
>>>>>
>>>>> Then libhugetlbfs requests an additional area on top of that, ie at
>>>>> address 0x74000000, to expand the heap.
>>>>> But mmap() returns an area at address 0x73d80000, ie under the
>>>>> previous area.
>>>>>
>>>>
>>>>
>>>> Can you share the test details?. Why does it not fail on book3s64? We
>>>> use topdown search with book3s64.
>>>
>>> I don't know about book3s64, I only have 8xx.
>>>
>>> Here is my test app:
>>>
>>
>> The test ran fine on ppc64.
>>
>> kvaneesh@ltctulc6a-p1:[~]$ HUGETLB_MORECORE=yes ./a.out
>> 10000000-10010000 r-xp 00000000 fc:00 9044312                            /home/kvaneesh/a.out
>> 10010000-10020000 r--p 00000000 fc:00 9044312                            /home/kvaneesh/a.out
>> 10020000-10030000 rw-p 00010000 fc:00 9044312                            /home/kvaneesh/a.out
>> 7ffff7d60000-7ffff7f10000 r-xp 00000000 fc:00 9250090                    /lib/powerpc64le-linux-gnu/libc-2.23.so
>> 7ffff7f10000-7ffff7f20000 r--p 001a0000 fc:00 9250090                    /lib/powerpc64le-linux-gnu/libc-2.23.so
>> 7ffff7f20000-7ffff7f30000 rw-p 001b0000 fc:00 9250090                    /lib/powerpc64le-linux-gnu/libc-2.23.so
>> 7ffff7f40000-7ffff7f60000 r-xp 00000000 fc:00 10754812                   /usr/lib/libhugetlbfs.so.0
>> 7ffff7f60000-7ffff7f70000 r--p 00010000 fc:00 10754812                   /usr/lib/libhugetlbfs.so.0
>> 7ffff7f70000-7ffff7f80000 rw-p 00020000 fc:00 10754812                   /usr/lib/libhugetlbfs.so.0
>> 7ffff7f80000-7ffff7fa0000 r-xp 00000000 00:00 0                          [vdso]
>> 7ffff7fa0000-7ffff7fe0000 r-xp 00000000 fc:00 9250107                    /lib/powerpc64le-linux-gnu/ld-2.23.so
>> 7ffff7fe0000-7ffff7ff0000 r--p 00030000 fc:00 9250107                    /lib/powerpc64le-linux-gnu/ld-2.23.so
>> 7ffff7ff0000-7ffff8000000 rw-p 00040000 fc:00 9250107                    /lib/powerpc64le-linux-gnu/ld-2.23.so
>> 7ffffffd0000-800000000000 rw-p 00000000 00:00 0                          [stack]
>>
>>
>> Allocated 1Mbytes at 0x10000000010
>>
>>
>> Allocated 1Mbytes at 0x10002000020
>>
>>
>> Allocated 1Mbytes at 0x10004000030
>>
>> 10000000-10010000 r-xp 00000000 fc:00 9044312                            /home/kvaneesh/a.out
>> 10010000-10020000 r--p 00000000 fc:00 9044312                            /home/kvaneesh/a.out
>> 10020000-10030000 rw-p 00010000 fc:00 9044312                            /home/kvaneesh/a.out
>> 10000000000-10003000000 rw-p 00000000 00:0d 1041435                      /anon_hugepage (deleted)
>> 10003000000-10005000000 rw-p 03000000 00:0d 1041436                      /anon_hugepage (deleted)
>> 10005000000-10007000000 rw-p 05000000 00:0d 1041437                      /anon_hugepage (deleted)
>> 7ffff7d60000-7ffff7f10000 r-xp 00000000 fc:00 9250090                    /lib/powerpc64le-linux-gnu/libc-2.23.so
>> 7ffff7f10000-7ffff7f20000 r--p 001a0000 fc:00 9250090                    /lib/powerpc64le-linux-gnu/libc-2.23.so
>> 7ffff7f20000-7ffff7f30000 rw-p 001b0000 fc:00 9250090                    /lib/powerpc64le-linux-gnu/libc-2.23.so
>> 7ffff7f40000-7ffff7f60000 r-xp 00000000 fc:00 10754812                   /usr/lib/libhugetlbfs.so.0
>> 7ffff7f60000-7ffff7f70000 r--p 00010000 fc:00 10754812                   /usr/lib/libhugetlbfs.so.0
>> 7ffff7f70000-7ffff7f80000 rw-p 00020000 fc:00 10754812                   /usr/lib/libhugetlbfs.so.0
>> 7ffff7f80000-7ffff7fa0000 r-xp 00000000 00:00 0                          [vdso]
>> 7ffff7fa0000-7ffff7fe0000 r-xp 00000000 fc:00 9250107                    /lib/powerpc64le-linux-gnu/ld-2.23.so
>> 7ffff7fe0000-7ffff7ff0000 r--p 00030000 fc:00 9250107                    /lib/powerpc64le-linux-gnu/ld-2.23.so
>> 7ffff7ff0000-7ffff8000000 rw-p 00040000 fc:00 9250107                    /lib/powerpc64le-linux-gnu/ld-2.23.so
>> 7ffffffd0000-800000000000 rw-p 00000000 00:00 0                          [stack]
>>
>>
>>
>> So i am definitely missing something. I understand that generic hugetlb
>> get unmapped area always search bottom up and 8xx used to depend on that
>> callback. But on ppc64 slice based get unmapped area always did topdown
>> and I am not sure whether we should change that. More over I don't think
>> MAP_GROWSDOWN is the right flag for selecting topdown/bottom up search.
>>
>>
>> Is it that libhugetlbfs does something specific for 32 bit? Other option
>> is to add huget_get_unmapped_area for 8xx that does bottom up search?

I think I identified the difference. In my run you have the following 
warning:

libhugetlbfs: WARNING: Heap originates at 0x73e80000 instead of 0x10080000

In your run, there is no such warning.

I tried running the test with HUGETLB_MORECORE_HEAPBASE=0x30000000, and 
it works without the patch:

root@vgoip:~# HUGETLB_MORECORE=yes HUGETLB_MORECORE_HEAPBASE=0x30000000 
./huge_m
alloc_test
00100000-00108000 r-xp 00000000 00:00 0          [vdso]
0fde4000-0fde8000 r-xp 00000000 00:0f 168        /lib/libdl-2.23.so
0fde8000-0fe00000 ---p 00004000 00:0f 168        /lib/libdl-2.23.so
0fe00000-0fe04000 r--p 0000c000 00:0f 168        /lib/libdl-2.23.so
0fe04000-0fe08000 rwxp 00010000 00:0f 168        /lib/libdl-2.23.so
0fe18000-0ff88000 r-xp 00000000 00:0f 191        /lib/libc-2.23.so
0ff88000-0ffa4000 ---p 00170000 00:0f 191        /lib/libc-2.23.so
0ffa4000-0ffa8000 r--p 0017c000 00:0f 191        /lib/libc-2.23.so
0ffa8000-0ffac000 rwxp 00180000 00:0f 191        /lib/libc-2.23.so
0ffac000-0ffb0000 rwxp 00000000 00:00 0
0ffc0000-0ffd4000 r-xp 00000000 00:0f 90         /lib/libhugetlbfs.so
0ffd4000-0ffe0000 ---p 00014000 00:0f 90         /lib/libhugetlbfs.so
0ffe0000-0ffe4000 rwxp 00010000 00:0f 90         /lib/libhugetlbfs.so
0ffe4000-0fff0000 rwxp 00000000 00:00 0
10000000-10004000 r-xp 00000000 00:0f 3076       /root/huge_malloc_test
10010000-10014000 rwxp 00000000 00:0f 3076       /root/huge_malloc_test
77ee0000-77f04000 r-xp 00000000 00:0f 171        /lib/ld-2.23.so
77f1c000-77f20000 r--p 0002c000 00:0f 171        /lib/ld-2.23.so
77f20000-77f24000 rwxp 00030000 00:0f 171        /lib/ld-2.23.so
7f830000-7f854000 rw-p 00000000 00:00 0          [stack]


Allocated 1Mbytes at 0x30000008


Allocated 1Mbytes at 0x30100010


Allocated 1Mbytes at 0x30200018

00100000-00108000 r-xp 00000000 00:00 0          [vdso]
0fde4000-0fde8000 r-xp 00000000 00:0f 168        /lib/libdl-2.23.so
0fde8000-0fe00000 ---p 00004000 00:0f 168        /lib/libdl-2.23.so
0fe00000-0fe04000 r--p 0000c000 00:0f 168        /lib/libdl-2.23.so
0fe04000-0fe08000 rwxp 00010000 00:0f 168        /lib/libdl-2.23.so
0fe18000-0ff88000 r-xp 00000000 00:0f 191        /lib/libc-2.23.so
0ff88000-0ffa4000 ---p 00170000 00:0f 191        /lib/libc-2.23.so
0ffa4000-0ffa8000 r--p 0017c000 00:0f 191        /lib/libc-2.23.so
0ffa8000-0ffac000 rwxp 00180000 00:0f 191        /lib/libc-2.23.so
0ffac000-0ffb0000 rwxp 00000000 00:00 0
0ffc0000-0ffd4000 r-xp 00000000 00:0f 90         /lib/libhugetlbfs.so
0ffd4000-0ffe0000 ---p 00014000 00:0f 90         /lib/libhugetlbfs.so
0ffe0000-0ffe4000 rwxp 00010000 00:0f 90         /lib/libhugetlbfs.so
0ffe4000-0fff0000 rwxp 00000000 00:00 0
10000000-10004000 r-xp 00000000 00:0f 3076       /root/huge_malloc_test
10010000-10014000 rwxp 00000000 00:0f 3076       /root/huge_malloc_test
30000000-30180000 rw-p 00000000 00:0b 7682       /anon_hugepage (deleted)
30180000-30280000 rw-p 00180000 00:0b 7683       /anon_hugepage (deleted)
30280000-30380000 rw-p 00280000 00:0b 7684       /anon_hugepage (deleted)
77ee0000-77f04000 r-xp 00000000 00:0f 171        /lib/ld-2.23.so
77f1c000-77f20000 r--p 0002c000 00:0f 171        /lib/ld-2.23.so
77f20000-77f24000 rwxp 00030000 00:0f 171        /lib/ld-2.23.so
7f830000-7f854000 rw-p 00000000 00:00 0          [stack]


On your side, could you try and see with 
HUGETLB_MORECORE_HEAPBASE=0x11000000 ?

Christophe


>>
>> If you are on ppc64 irc on freenode we can discuss this there.
>> -aneesh
