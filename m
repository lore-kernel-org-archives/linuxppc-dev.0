Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D2EB2C02F0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 03:48:03 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 21 Feb 2013 22:16:08 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CD3CA394004F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2013 22:17:57 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1LGlfIh13959190
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2013 22:17:42 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1LGleXW009772
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 03:47:44 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH -V2 00/21] THP support for PPC64
Date: Thu, 21 Feb 2013 22:17:07 +0530
Message-Id: <1361465248-10867-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
required few interface changes to core THP code. I still have considerable
number of FIXME!! in the patchset mostly related to PPC64 mm susbsytem.
Those would require closer review and once we are clear on those changes,
I will drop those FIXME!! with necessary comments.

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

Changes from RFC V1:
* HugeTLB fs now works
* Compile issues fixed
* rebased to v3.8
* Patch series reorded so that ppc64 cleanups and MM THP changes are moved
  early in the series. This should help in picking those patches early.

Thanks,
-aneesh
