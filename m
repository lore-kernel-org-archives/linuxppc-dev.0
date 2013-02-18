Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 49DF62C02CB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:49 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 15:55:27 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 644E7E0058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:59:31 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IASVCd31457352
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:31 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IASYMR000961
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:35 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 00/17] THP support for PPC64
Date: Mon, 18 Feb 2013 15:57:58 +0530
Message-Id: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This is an early RFC version adding transparent huge page support for PPC64.
I am sharing the changes, so that we can have early review on the approach
taken. The TODOs include

*) Compile issues with different config option
*) HugeTLBfs is disabled now (mostly compile issues)
*) PPC32 and other sub architecture details need to be worked out.
*) 4K page size details need to be worked out
*) Closer review of PMD* flags.

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

Thanks,
-aneesh
