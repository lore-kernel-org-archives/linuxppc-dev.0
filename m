Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMlHX4KT5zDr5T
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 17:31:36 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v727T4M7089604
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 03:31:33 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c3469h9cy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 03:31:33 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 17:31:30 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v727VSuY28180568
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 17:31:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v727VQJ1005158
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 17:31:27 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 Scott Wood <oss@buserror.net>
Subject: Re: [PATCH v4 2/3] powerpc/mm/hugetlb: Add support for reserving
 gigantic huge pages via kernel command line
In-Reply-To: <64014b48-a04f-92a7-f561-7ffd386fabc6@c-s.fr>
References: <20170728050127.28338-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170728050127.28338-2-aneesh.kumar@linux.vnet.ibm.com>
 <64014b48-a04f-92a7-f561-7ffd386fabc6@c-s.fr>
Date: Wed, 02 Aug 2017 13:01:21 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <877eym1l4m.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Hi,
>
> Le 28/07/2017 =C3=A0 07:01, Aneesh Kumar K.V a =C3=A9crit :
>> With commit aa888a74977a8 ("hugetlb: support larger than MAX_ORDER") we =
added
>> support for allocating gigantic hugepages via kernel command line. Switch
>> ppc64 arch specific code to use that.
>>=20
>> W.r.t FSL support, we now limit our allocation range using BOOTMEM_ALLOC=
_ACCESSIBLE.
>>=20
>> We use the kernel command line to do reservation of hugetlb pages on pow=
ernv
>> platforms. On pseries hash mmu mode the supported gigantic huge page siz=
e is
>> 16GB and that can only be allocated with hypervisor assist. For pseries =
the
>> command line option doesn't do the allocation. Instead pseries does giga=
ntic
>> hugepage allocation based on hypervisor hint that is specified via
>> "ibm,expected#pages" property of the memory node.
>
> It looks like it doesn't work on the 8xx:
>
> root@vgoip:~# dmesg | grep -i huge
> [    0.000000] Kernel command line: console=3DttyCPM0,115200N8=20
> ip=3D172.25.231.25:172.25.231.1::255.0.0.0:vgoip:eth0:off hugepagesz=3D8M=
=20
> hugepages=3D4
> [    0.416722] HugeTLB registered 8.00 MiB page size, pre-allocated 4 pag=
es
> [    0.423184] HugeTLB registered 512 KiB page size, pre-allocated 0 pages
> root@vgoip:~# cat /proc/meminfo
> MemTotal:         123388 kB
> MemFree:           77900 kB
> MemAvailable:      78412 kB
> Buffers:               0 kB
> Cached:             3964 kB
> SwapCached:            0 kB
> Active:             3788 kB
> Inactive:           1680 kB
> Active(anon):       1636 kB
> Inactive(anon):       20 kB
> Active(file):       2152 kB
> Inactive(file):     1660 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:                 0 kB
> Writeback:             0 kB
> AnonPages:          1552 kB
> Mapped:             2404 kB
> Shmem:               152 kB
> Slab:                  0 kB
> SReclaimable:          0 kB
> SUnreclaim:            0 kB
> KernelStack:         304 kB
> PageTables:          208 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:       45308 kB
> Committed_AS:      16664 kB
> VmallocTotal:     866304 kB
> VmallocUsed:           0 kB
> VmallocChunk:          0 kB
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:        512 kB

But you are printing above the default hugepaeg details. You haven't
changed that in kernel command line. What does
/sys/kernel/mm/hugepages/<hugepages-size>/nr_hugepages show ?

To change the default hugepage size you may want to use
default_hugepagesz=3D8M

-aneesh
