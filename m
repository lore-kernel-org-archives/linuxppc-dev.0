Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DBBE2C02BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:36 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 26 Feb 2013 17:56:05 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1BF672CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:26 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1Q85Nun3932556
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:23 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1Q85PFX007310
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:05:25 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V1 00/24] THP support for PPC64
Date: Tue, 26 Feb 2013 13:34:50 +0530
Message-Id: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patchset adds transparent huge page support for PPC64.

I am marking the series to linux-mm because the PPC64 implementation
required few interface changes to core THP code.

TODO:
* ppc64 KVM related changes
* batch support for hpte invalidate
* powernv still doesn't boot
* hash preload support in update_mmu_cache_pmd

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
