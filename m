Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNrQX32t5zDr6Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 00:25:24 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7UEOOTi045930
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 10:25:22 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 255364futn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 10:25:22 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 31 Aug 2016 00:25:17 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 844A32CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 00:25:14 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7UEPEl42359664
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 00:25:14 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7UEPDVK016751
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 00:25:14 +1000
Date: Tue, 30 Aug 2016 19:55:08 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/34] mm, vmscan: make kswapd reclaim in terms of nodes
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1467970510-21195-1-git-send-email-mgorman@techsingularity.net>
 <1467970510-21195-8-git-send-email-mgorman@techsingularity.net>
 <20160829093844.GA2592@linux.vnet.ibm.com>
 <20160830120728.GV8119@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160830120728.GV8119@techsingularity.net>
Message-Id: <20160830142508.GA10514@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > 
> > This patch seems to hurt FA_DUMP functionality. This behaviour is not
> > seen on v4.7 but only after this patch.
> > 
> > So when a kernel on a multinode machine with memblock_reserve() such
> > that most of the nodes have zero available memory, kswapd seems to be
> > consuming 100% of the time.
> > 
> 
> Why is FA_DUMP specifically the trigger? If the nodes have zero available
> memory then is the zone_populated() check failing when FA_DUMP is enabled? If
> so, that would both allow kswapd to wake and stay awake.
> 

The trigger is memblock_reserve() for the complete node memory.  And
this is exactly what FA_DUMP does.  Here again the node has memory but
its all reserved so there is no free memory in the node.

Did you mean populated_zone() when you said zone_populated or have I
mistaken? populated_zone() does return 1 since it checks for
zone->present_pages.

Here is revelant log from the dmesg log at boot 

ppc64_pft_size    = 0x26
phys_mem_size     = 0x1e4600000000
dcache_bsize      = 0x80
icache_bsize      = 0x80
cpu_features      = 0x27fc7aec18500249
  possible        = 0x3fffffff18500649
  always          = 0x0000000018100040
cpu_user_features = 0xdc0065c2 0xef000000
mmu_features      = 0x7c000001
firmware_features = 0x00000003c45bfc57
htab_hash_mask    = 0x7fffffff
-----------------------------------------------------
Node 0 Memory: 0x0-0x1fb50000000
Node 1 Memory: 0x1fb50000000-0x3fa90000000
Node 2 Memory: 0x3fa90000000-0x5f9b0000000
Node 3 Memory: 0x5f9b0000000-0x76850000000
Node 4 Memory: 0x76850000000-0x95020000000
Node 5 Memory: 0x95020000000-0xb37f0000000
Node 6 Memory: 0xb37f0000000-0xd1fc0000000
Node 7 Memory: 0xd1fc0000000-0xf0790000000
Node 8 Memory: 0xf0790000000-0x10ef60000000
Node 9 Memory: 0x10ef60000000-0x12d730000000
Node 10 Memory: 0x12d730000000-0x14bf00000000
Node 11 Memory: 0x14bf00000000-0x16a6d0000000
Node 12 Memory: 0x16a6d0000000-0x188ea0000000
Node 13 Memory: 0x188ea0000000-0x1a7660000000
Node 14 Memory: 0x1a7660000000-0x1c5e30000000
Node 15 Memory: 0x1c5e30000000-0x1e4600000000
numa: Initmem setup node 0 [mem 0x00000000-0x1fb4fffffff]
numa:   NODE_DATA [mem 0x1837fe23680-0x1837fe2d37f]
numa: Initmem setup node 1 [mem 0x1fb50000000-0x3fa8fffffff]
numa:   NODE_DATA [mem 0x1837fa19980-0x1837fa2367f]
numa:     NODE_DATA(1) on node 0
numa: Initmem setup node 2 [mem 0x3fa90000000-0x5f9afffffff]
numa:   NODE_DATA [mem 0x1837f60fc80-0x1837f61997f]
numa:     NODE_DATA(2) on node 0
numa: Initmem setup node 3 [mem 0x5f9b0000000-0x7684fffffff]
numa:   NODE_DATA [mem 0x1837f205f80-0x1837f20fc7f]
numa:     NODE_DATA(3) on node 0
numa: Initmem setup node 4 [mem 0x76850000000-0x9501fffffff]
numa:   NODE_DATA [mem 0x1837ef1c280-0x1837ef25f7f]
numa:     NODE_DATA(4) on node 0
numa: Initmem setup node 5 [mem 0x95020000000-0xb37efffffff]
numa:   NODE_DATA [mem 0x1837eb42580-0x1837eb4c27f]
numa:     NODE_DATA(5) on node 0
numa: Initmem setup node 6 [mem 0xb37f0000000-0xd1fbfffffff]
numa:   NODE_DATA [mem 0x1837e778880-0x1837e78257f]
numa:     NODE_DATA(6) on node 0
numa: Initmem setup node 7 [mem 0xd1fc0000000-0xf078fffffff]
numa:   NODE_DATA [mem 0x1837e39eb80-0x1837e3a887f]
numa:     NODE_DATA(7) on node 0
numa: Initmem setup node 8 [mem 0xf0790000000-0x10ef5fffffff]
numa:   NODE_DATA [mem 0x1837dfc4e80-0x1837dfceb7f]
numa:     NODE_DATA(8) on node 0
numa: Initmem setup node 9 [mem 0x10ef60000000-0x12d72fffffff]
numa:   NODE_DATA [mem 0x1837dbeb180-0x1837dbf4e7f]
numa:     NODE_DATA(9) on node 0
numa: Initmem setup node 10 [mem 0x12d730000000-0x14beffffffff]
numa:   NODE_DATA [mem 0x1837d811480-0x1837d81b17f]
numa:     NODE_DATA(10) on node 0
numa: Initmem setup node 11 [mem 0x14bf00000000-0x16a6cfffffff]
numa:   NODE_DATA [mem 0x1837d437780-0x1837d44147f]
numa:     NODE_DATA(11) on node 0
numa: Initmem setup node 12 [mem 0x16a6d0000000-0x188e9fffffff]
numa:   NODE_DATA [mem 0x1837d05da80-0x1837d06777f]
numa:     NODE_DATA(12) on node 0
numa: Initmem setup node 13 [mem 0x188ea0000000-0x1a765fffffff]
numa:   NODE_DATA [mem 0x1837cc83d80-0x1837cc8da7f]
numa:     NODE_DATA(13) on node 0
numa: Initmem setup node 14 [mem 0x1a7660000000-0x1c5e2fffffff]
numa:   NODE_DATA [mem 0x1837c8aa080-0x1837c8b3d7f]
numa:     NODE_DATA(14) on node 0
numa: Initmem setup node 15 [mem 0x1c5e30000000-0x1e45ffffffff]
numa:   NODE_DATA [mem 0x1837c4d0380-0x1837c4da07f]
numa:     NODE_DATA(15) on node 0
Section 99194 and 99199 (node 0) have a circular dependency on usemap and pgdat allocations
node 1 must be removed before remove section 99193
node 1 must be removed before remove section 99194
node 2 must be removed before remove section 99193
node 4 must be removed before remove section 99193
node 8 must be removed before remove section 99193
node 13 must be removed before remove section 99193
PCI host bridge /pci@800000020000032  ranges:
 MEM 0x00003fd480000000..0x00003fd4feffffff -> 0x0000000080000000 
 MEM 0x0000329000000000..0x0000329fffffffff -> 0x0003d29000000000 
PCI host bridge /pci@800000020000164  ranges:
 MEM 0x00003fc2e0000000..0x00003fc2efffffff -> 0x00000000e0000000 
 MEM 0x0000305800000000..0x0000305bffffffff -> 0x0003d05800000000 
PPC64 nvram contains 15360 bytes
Top of RAM: 0x1e4600000000, Total RAM: 0x1e4600000000
Memory hole size: 0MB
Zone ranges:
  DMA      [mem 0x0000000000000000-0x00001e45ffffffff]
  DMA32    empty
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x000001fb4fffffff]
  node   1: [mem 0x000001fb50000000-0x000003fa8fffffff]
  node   2: [mem 0x000003fa90000000-0x000005f9afffffff]
  node   3: [mem 0x000005f9b0000000-0x000007684fffffff]
  node   4: [mem 0x0000076850000000-0x000009501fffffff]
  node   5: [mem 0x0000095020000000-0x00000b37efffffff]
  node   6: [mem 0x00000b37f0000000-0x00000d1fbfffffff]
  node   7: [mem 0x00000d1fc0000000-0x00000f078fffffff]
  node   8: [mem 0x00000f0790000000-0x000010ef5fffffff]
  node   9: [mem 0x000010ef60000000-0x000012d72fffffff]
  node  10: [mem 0x000012d730000000-0x000014beffffffff]
  node  11: [mem 0x000014bf00000000-0x000016a6cfffffff]
  node  12: [mem 0x000016a6d0000000-0x0000188e9fffffff]
  node  13: [mem 0x0000188ea0000000-0x00001a765fffffff]
  node  14: [mem 0x00001a7660000000-0x00001c5e2fffffff]
  node  15: [mem 0x00001c5e30000000-0x00001e45ffffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x000001fb4fffffff]
On node 0 totalpages: 33247232
  DMA zone: 32468 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 33247232 pages, LIFO batch:1
Initmem setup node 1 [mem 0x000001fb50000000-0x000003fa8fffffff]
On node 1 totalpages: 33505280
  DMA zone: 32720 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 33505280 pages, LIFO batch:1
Initmem setup node 2 [mem 0x000003fa90000000-0x000005f9afffffff]
On node 2 totalpages: 33497088
  DMA zone: 32712 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 33497088 pages, LIFO batch:1
Initmem setup node 3 [mem 0x000005f9b0000000-0x000007684fffffff]
On node 3 totalpages: 24027136
  DMA zone: 23464 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 24027136 pages, LIFO batch:1
Initmem setup node 4 [mem 0x0000076850000000-0x000009501fffffff]
On node 4 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1
Initmem setup node 5 [mem 0x0000095020000000-0x00000b37efffffff]
On node 5 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1
Initmem setup node 6 [mem 0x00000b37f0000000-0x00000d1fbfffffff]
On node 6 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1
Initmem setup node 7 [mem 0x00000d1fc0000000-0x00000f078fffffff]
On node 7 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1
Initmem setup node 8 [mem 0x00000f0790000000-0x000010ef5fffffff]
On node 8 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1
Initmem setup node 9 [mem 0x000010ef60000000-0x000012d72fffffff]
On node 9 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1
Initmem setup node 10 [mem 0x000012d730000000-0x000014beffffffff]
On node 10 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1
Initmem setup node 11 [mem 0x000014bf00000000-0x000016a6cfffffff]
On node 11 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1
Initmem setup node 12 [mem 0x000016a6d0000000-0x0000188e9fffffff]
On node 12 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1
Initmem setup node 13 [mem 0x0000188ea0000000-0x00001a765fffffff]
On node 13 totalpages: 31965184
  DMA zone: 31216 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31965184 pages, LIFO batch:1
Initmem setup node 14 [mem 0x00001a7660000000-0x00001c5e2fffffff]
On node 14 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1
Initmem setup node 15 [mem 0x00001c5e30000000-0x00001e45ffffffff]
On node 15 totalpages: 31969280
  DMA zone: 31220 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 31969280 pages, LIFO batch:1

-- 
Thanks and Regards
Srikar Dronamraju
