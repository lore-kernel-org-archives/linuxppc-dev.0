Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F7E22C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 06:35:25 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 21 Mar 2013 01:01:21 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2ACE2125805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 01:06:28 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2KJZELe19922962
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 01:05:14 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2KJZIpx020845
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 19:35:18 GMT
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V4 00/25] THP support for PPC64
Date: Thu, 21 Mar 2013 01:04:45 +0530
Message-Id: <1363808110-25748-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patchset adds transparent hugepage support for PPC64.

TODO:
* hash preload support in update_mmu_cache_pmd (we don't do that for hugetlb)

Some numbers:

The latency measurements code from Anton  found at
http://ozlabs.org/~anton/junkcode/latency2001.c

THP disabled 64K page size
------------------------
[root@llmp24l02 ~]# ./latency2001 8G
 8589934592    731.73 cycles    205.77 ns
[root@llmp24l02 ~]# ./latency2001 8G
 8589934592    743.39 cycles    209.05 ns
[root@llmp24l02 ~]#

THP disabled large page via hugetlbfs
-------------------------------------
[root@llmp24l02 ~]# ./latency2001  -l 8G
 8589934592    416.09 cycles    117.01 ns
[root@llmp24l02 ~]# ./latency2001  -l 8G
 8589934592    415.74 cycles    116.91 ns

THP enabled 64K page size.
----------------
[root@llmp24l02 ~]# ./latency2001 8G
 8589934592    405.07 cycles    113.91 ns
[root@llmp24l02 ~]# ./latency2001 8G
 8589934592    411.82 cycles    115.81 ns
[root@llmp24l02 ~]#

We are close to hugetlbfs in latency and we can achieve this with zero
config/page reservation. Most of the allocations above are fault allocated.
I haven't really measured the collapse alloc impact.

Another test that does 50000000 random access over 1GB area goes from
2.65 seconds to 1.07 seconds with this patchset.

Changes from V3:
* PowerNV boot fixes

Change from V2:
* Change patch "powerpc: Reduce PTE table memory wastage" to use much simpler approach
  for PTE page sharing.
* Changes to handle huge pages in KVM code.
* Address other review comments

Changes from V1
* Address review comments
* More patch split
* Add batch hpte invalidate for hugepages.

Changes from RFC V2:
* Address review comments
* More code cleanup and patch split

Changes from RFC V1:
* HugeTLB fs now works
* Compile issues fixed
* rebased to v3.8
* Patch series reorded so that ppc64 cleanups and MM THP changes are moved
  early in the series. This should help in picking those patches early.

Thanks,
-aneesh
