Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNGff5J4WzF0xw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 21:05:30 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0JA4Rds049909
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 05:05:28 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fkcm6dfht-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 05:05:27 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 19 Jan 2018 10:05:25 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/mm: Fix growth direction for hugepages mmaps
 with slice
In-Reply-To: <87y3kuz559.fsf@linux.vnet.ibm.com>
References: <20180109101810.2471D6C6CF@localhost.localdomain>
 <87wp0haizf.fsf@linux.vnet.ibm.com>
 <d5f6060f-3061-dc3c-66f7-3cec05d50169@c-s.fr>
 <f5f2af23-f535-8fca-4edf-a0ec4107a7df@linux.vnet.ibm.com>
 <dd2e281e-0dea-8acf-30dc-b85d0d438cf3@c-s.fr>
 <87y3kuz559.fsf@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2018 15:35:21 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87mv1ayxi6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Did a reply instead of reply-all.

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> writes:

> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>
>> Le 17/01/2018 =C3=A0 04:19, Aneesh Kumar K.V a =C3=A9crit=C2=A0:
>>>=20
>>>=20
>>> On 01/16/2018 10:18 PM, Christophe LEROY wrote:
>>>>
>>>>
>>>> Le 16/01/2018 =C3=A0 17:03, Aneesh Kumar K.V a =C3=A9crit=C2=A0:
>>>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>>>
>>>>>> An application running with libhugetlbfs fails to allocate
>>>>>> additional pages to HEAP due to the hugemap being done
>>>>>> inconditionally as topdown mapping:
>>>>>>
>>>>>> mmap(0x10080000, 1572864, PROT_READ|PROT_WRITE,=20
>>>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) =3D 0x73e80000
>>>>>> [...]
>>>>>> mmap(0x74000000, 1048576, PROT_READ|PROT_WRITE,=20
>>>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) =3D 0x73d80000
>>>>>> munmap(0x73d80000, 1048576)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
>>>>>> [...]
>>>>>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE,=20
>>>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) =3D 0x73d00000
>>>>>> munmap(0x73d00000, 1572864)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
>>>>>> [...]
>>>>>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE,=20
>>>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) =3D 0x73d00000
>>>>>> munmap(0x73d00000, 1572864)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
>>>>>> [...]
>>>>>>
>>>>>
>>>>> Can you explain the failure details above. I am not sure I understand
>>>>> what to read from the above output.
>>>>
>>>> libhugetlbfs first requests an area of size 1.5Mbytes, at address=20
>>>> 0x10080000
>>>> mmap() returns an area at address 0x73e80000
>>>>
>>>> Then libhugetlbfs requests an additional area on top of that, ie at=20
>>>> address 0x74000000, to expand the heap.
>>>> But mmap() returns an area at address 0x73d80000, ie under the=20
>>>> previous area.
>>>>
>>>=20
>>>=20
>>> Can you share the test details?. Why does it not fail on book3s64? We=20
>>> use topdown search with book3s64.
>>
>> I don't know about book3s64, I only have 8xx.
>>
>> Here is my test app:
>>
>
> The test ran fine on ppc64.
>
> kvaneesh@ltctulc6a-p1:[~]$ HUGETLB_MORECORE=3Dyes ./a.out=20
> 10000000-10010000 r-xp 00000000 fc:00 9044312                            =
/home/kvaneesh/a.out
> 10010000-10020000 r--p 00000000 fc:00 9044312                            =
/home/kvaneesh/a.out
> 10020000-10030000 rw-p 00010000 fc:00 9044312                            =
/home/kvaneesh/a.out
> 7ffff7d60000-7ffff7f10000 r-xp 00000000 fc:00 9250090                    =
/lib/powerpc64le-linux-gnu/libc-2.23.so
> 7ffff7f10000-7ffff7f20000 r--p 001a0000 fc:00 9250090                    =
/lib/powerpc64le-linux-gnu/libc-2.23.so
> 7ffff7f20000-7ffff7f30000 rw-p 001b0000 fc:00 9250090                    =
/lib/powerpc64le-linux-gnu/libc-2.23.so
> 7ffff7f40000-7ffff7f60000 r-xp 00000000 fc:00 10754812                   =
/usr/lib/libhugetlbfs.so.0
> 7ffff7f60000-7ffff7f70000 r--p 00010000 fc:00 10754812                   =
/usr/lib/libhugetlbfs.so.0
> 7ffff7f70000-7ffff7f80000 rw-p 00020000 fc:00 10754812                   =
/usr/lib/libhugetlbfs.so.0
> 7ffff7f80000-7ffff7fa0000 r-xp 00000000 00:00 0                          =
[vdso]
> 7ffff7fa0000-7ffff7fe0000 r-xp 00000000 fc:00 9250107                    =
/lib/powerpc64le-linux-gnu/ld-2.23.so
> 7ffff7fe0000-7ffff7ff0000 r--p 00030000 fc:00 9250107                    =
/lib/powerpc64le-linux-gnu/ld-2.23.so
> 7ffff7ff0000-7ffff8000000 rw-p 00040000 fc:00 9250107                    =
/lib/powerpc64le-linux-gnu/ld-2.23.so
> 7ffffffd0000-800000000000 rw-p 00000000 00:00 0                          =
[stack]
>
>
> Allocated 1Mbytes at 0x10000000010
>
>
> Allocated 1Mbytes at 0x10002000020
>
>
> Allocated 1Mbytes at 0x10004000030
>
> 10000000-10010000 r-xp 00000000 fc:00 9044312                            =
/home/kvaneesh/a.out
> 10010000-10020000 r--p 00000000 fc:00 9044312                            =
/home/kvaneesh/a.out
> 10020000-10030000 rw-p 00010000 fc:00 9044312                            =
/home/kvaneesh/a.out
> 10000000000-10003000000 rw-p 00000000 00:0d 1041435                      =
/anon_hugepage (deleted)
> 10003000000-10005000000 rw-p 03000000 00:0d 1041436                      =
/anon_hugepage (deleted)
> 10005000000-10007000000 rw-p 05000000 00:0d 1041437                      =
/anon_hugepage (deleted)
> 7ffff7d60000-7ffff7f10000 r-xp 00000000 fc:00 9250090                    =
/lib/powerpc64le-linux-gnu/libc-2.23.so
> 7ffff7f10000-7ffff7f20000 r--p 001a0000 fc:00 9250090                    =
/lib/powerpc64le-linux-gnu/libc-2.23.so
> 7ffff7f20000-7ffff7f30000 rw-p 001b0000 fc:00 9250090                    =
/lib/powerpc64le-linux-gnu/libc-2.23.so
> 7ffff7f40000-7ffff7f60000 r-xp 00000000 fc:00 10754812                   =
/usr/lib/libhugetlbfs.so.0
> 7ffff7f60000-7ffff7f70000 r--p 00010000 fc:00 10754812                   =
/usr/lib/libhugetlbfs.so.0
> 7ffff7f70000-7ffff7f80000 rw-p 00020000 fc:00 10754812                   =
/usr/lib/libhugetlbfs.so.0
> 7ffff7f80000-7ffff7fa0000 r-xp 00000000 00:00 0                          =
[vdso]
> 7ffff7fa0000-7ffff7fe0000 r-xp 00000000 fc:00 9250107                    =
/lib/powerpc64le-linux-gnu/ld-2.23.so
> 7ffff7fe0000-7ffff7ff0000 r--p 00030000 fc:00 9250107                    =
/lib/powerpc64le-linux-gnu/ld-2.23.so
> 7ffff7ff0000-7ffff8000000 rw-p 00040000 fc:00 9250107                    =
/lib/powerpc64le-linux-gnu/ld-2.23.so
> 7ffffffd0000-800000000000 rw-p 00000000 00:00 0                          =
[stack]
>
>
>
> So i am definitely missing something. I understand that generic hugetlb
> get unmapped area always search bottom up and 8xx used to depend on that
> callback. But on ppc64 slice based get unmapped area always did topdown
> and I am not sure whether we should change that. More over I don't think
> MAP_GROWSDOWN is the right flag for selecting topdown/bottom up search.
>
>
> Is it that libhugetlbfs does something specific for 32 bit? Other option
> is to add huget_get_unmapped_area for 8xx that does bottom up search?
>
> If you are on ppc64 irc on freenode we can discuss this there.
> -aneesh
