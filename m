Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AFF21A0CAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:14 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:12 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B4C1A1258059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:07:27 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13b9bw52101262
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:09 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13b8od021714
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:09 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 00/35]  powerpc/mm: Update page table format for book3s 64
Date: Tue,  1 Dec 2015 09:06:25 +0530
Message-Id: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

This patch series attempt to update book3s 64 linux page table format to
make it more flexible. Our current pte format is very restrictive and we
overload multiple pte bits. This is due to the non-availability of free bits
in pte_t. We use pte_t to track the validity of 4K subpages. This patch
series free up pte_t of 11 bits by tracking 4 4k subpage using one bit.
The pte format is updated such that we have a better method for identifying
a pte entry at pmd level. This will also enable us to implement hugetlb
migration(not yet done in this series). Before making the changes to the
pte format, I am splitting the pte header definition such that we now have
the below layout for headers

book3s
   32
     hash.h pgtable.h
   64
     hash.h  pgtable.h hash-4k.h hash-64k.h
booke
  32
     pgtable.h pte-40x.h pte-44x.h pte-8xx.h pte-fsl-booke.h
  64
    pgtable-4k.h  pgtable-64k.h  pgtable.h

I have done the header split such that booke headers and modified to the minimum so as to avoid
causing breakage in booke.

The patch series can also be found at
https://github.com/kvaneesh/linux.git book3s-pte-format-v2
https://github.com/kvaneesh/linux/commits/book3s-pte-format-v2

Changes from V5:
* We need a min pte frag size to be 4096 bytes, This is needed to track
  base page information with a THP config with 4K hash pte. Hence drop the
  changes to free up second half of pgtable_t. This implies we don't make
  any change to the size of pte fragment in this series.

Changes from V4:
* rebase to latest linus
* Add mmtest numbers

Changes from V3:
* Add missing #define pgprot_*
* Add Acked-by

Changes from V2:
* rebase to -next for powerpc tree

Changes from V1:
1) Build fix with STRICT_MM_TYPES enabled
2) pte_mkwrite fix for nohash
3) rebase to latest linus tree.


Performance numbers with and without patch series.

-------------- 4k hash pte guest config start--------------------
aim9
                                         4.3.0                       4.3.0
                          13672-gc669d35-dirty        13708-g8e488c2-dirty
Min      page_test   460586.67 (  0.00%)   435200.00 ( -5.51%)
Min      brk_test   4155429.71 (  0.00%)  4231312.46 (  1.83%)
Min      exec_test      960.69 (  0.00%)      904.33 ( -5.87%)
Min      fork_test     2142.38 (  0.00%)     2059.80 ( -3.85%)
Hmean    page_test   467906.57 (  0.00%)   445186.92 ( -4.86%)
Hmean    brk_test   4260526.41 (  0.00%)  4257237.07 ( -0.08%)
Hmean    exec_test     1013.71 (  0.00%)      966.27 ( -4.68%)
Hmean    fork_test     2292.90 (  0.00%)     2257.22 ( -1.56%)
Stddev   page_test     4416.83 (  0.00%)     4694.17 ( -6.28%)
Stddev   brk_test     72844.41 (  0.00%)    12520.81 ( 82.81%)
Stddev   exec_test       27.23 (  0.00%)       30.88 (-13.41%)
Stddev   fork_test       76.29 (  0.00%)      106.89 (-40.10%)
CoeffVar page_test        0.94 (  0.00%)        1.05 (-11.70%)
CoeffVar brk_test         1.71 (  0.00%)        0.29 ( 82.79%)
CoeffVar exec_test        2.68 (  0.00%)        3.19 (-18.94%)
CoeffVar fork_test        3.32 (  0.00%)        4.72 (-42.16%)
Max      page_test   473053.33 (  0.00%)   452426.67 ( -4.36%)
Max      brk_test   4366733.33 (  0.00%)  4272666.67 ( -2.15%)
Max      exec_test     1056.67 (  0.00%)     1014.67 ( -3.97%)
Max      fork_test     2396.80 (  0.00%)     2441.78 (  1.88%)

               4.3.0       4.3.0
        13672-gc669d35-dirty13708-g8e488c2-dirty
User            0.24        0.23
System          0.47        0.51
Elapsed       723.43      723.04

                                 4.3.0       4.3.0
                          13672-gc669d35-dirty13708-g8e488c2-dirty
Minor Faults                  37700464    36522147
Major Faults                        25          25
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                    12485233    11996182
DMA32 allocs                         0           0
Normal allocs                        0           0
Movable allocs                       0           0
Direct pages scanned                 0           0
Kswapd pages scanned                 0           0
Kswapd pages reclaimed               0           0
Direct pages reclaimed               0           0
Kswapd efficiency                 100%        100%
Kswapd velocity                  0.000       0.000
Direct efficiency                 100%        100%
Direct velocity                  0.000       0.000
Percentage direct scans             0%          0%
Zone normal velocity             0.000       0.000
Zone dma32 velocity              0.000       0.000
Zone dma velocity                0.000       0.000
Page writes by reclaim           0.000       0.000
Page writes file                     0           0
Page writes anon                     0           0
Page reclaim immediate               0           0
Sector Reads                      4224        4224
Sector Writes                    69944       69296
Page rescued immediate               0           0
Slabs scanned                        0           0
Direct inode steals                  0           0
Kswapd inode steals                  0           0
Kswapd skipped wait                  0           0
THP fault alloc                      0           0
THP collapse alloc                   0           0
THP splits                           0           0
THP fault fallback                   0           0
THP collapse fail                    0           0
Compaction stalls                    0           0
Compaction success                   0           0
Compaction failures                  0           0
Page migrate success                 0           0
Page migrate failure                 0           0
Compaction pages isolated            0           0
Compaction migrate scanned           0           0
Compaction free scanned              0           0
Compaction cost                      0           0
NUMA alloc hit                12482507    11993566
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local              12482507    11993566
NUMA base PTE updates              647         643
NUMA huge PMD updates                0           0
NUMA page range updates            647         643
NUMA hint faults                844060      873604
NUMA hint local faults          844060      873604
NUMA hint local percent            100         100
NUMA pages migrated                  0           0
AutoNUMA cost                    4220%       4368%

pft timings
                                         4.3.0                       4.3.0
                          13672-gc669d35-dirty        13708-g8e488c2-dirty
Min      system-1        0.0700 (  0.00%)       0.0700 (  0.00%)
Min      system-3        0.1400 (  0.00%)       0.1300 (  7.14%)
Min      system-5        0.2400 (  0.00%)       0.2300 (  4.17%)
Min      system-7        0.2500 (  0.00%)       0.2800 (-12.00%)
Min      system-8        0.2800 (  0.00%)       0.2900 ( -3.57%)
Min      elapsed-1       0.0900 (  0.00%)       0.0800 ( 11.11%)
Min      elapsed-3       0.0600 (  0.00%)       0.0600 (  0.00%)
Min      elapsed-5       0.0600 (  0.00%)       0.0600 (  0.00%)
Min      elapsed-7       0.0600 (  0.00%)       0.0600 (  0.00%)
Min      elapsed-8       0.0600 (  0.00%)       0.0600 (  0.00%)
Amean    system-1        0.1677 (  0.00%)       0.1574 (  6.18%)
Amean    system-3        0.1714 (  0.00%)       0.1575 (  8.10%)
Amean    system-5        0.3611 (  0.00%)       0.2919 ( 19.18%)
Amean    system-7        0.3364 (  0.00%)       0.3396 ( -0.97%)
Amean    system-8        0.4108 (  0.00%)       0.3704 (  9.83%)
Amean    elapsed-1       0.2040 (  0.00%)       0.1929 (  5.45%)
Amean    elapsed-3       0.0733 (  0.00%)       0.0686 (  6.31%)
Amean    elapsed-5       0.0968 (  0.00%)       0.0779 ( 19.51%)
Amean    elapsed-7       0.0656 (  0.00%)       0.0665 ( -1.33%)
Amean    elapsed-8       0.0690 (  0.00%)       0.0622 (  9.78%)
Stddev   system-1        0.3338 (  0.00%)       0.3156 (  5.45%)
Stddev   system-3        0.0203 (  0.00%)       0.0150 ( 26.29%)
Stddev   system-5        0.2636 (  0.00%)       0.0340 ( 87.11%)
Stddev   system-7        0.0343 (  0.00%)       0.0316 (  7.83%)
Stddev   system-8        0.2066 (  0.00%)       0.0386 ( 81.31%)
Stddev   elapsed-1       0.4417 (  0.00%)       0.4287 (  2.95%)
Stddev   elapsed-3       0.0085 (  0.00%)       0.0072 ( 15.09%)
Stddev   elapsed-5       0.0706 (  0.00%)       0.0089 ( 87.39%)
Stddev   elapsed-7       0.0063 (  0.00%)       0.0071 (-12.63%)
Stddev   elapsed-8       0.0335 (  0.00%)       0.0042 ( 87.54%)
CoeffVar system-1      198.9598 (  0.00%)     200.5134 ( -0.78%)
CoeffVar system-3       11.8421 (  0.00%)       9.4973 ( 19.80%)
CoeffVar system-5       72.9902 (  0.00%)      11.6450 ( 84.05%)
CoeffVar system-7       10.1931 (  0.00%)       9.3046 (  8.72%)
CoeffVar system-8       50.2929 (  0.00%)      10.4259 ( 79.27%)
CoeffVar elapsed-1     216.5224 (  0.00%)     222.2603 ( -2.65%)
CoeffVar elapsed-3      11.5790 (  0.00%)      10.4938 (  9.37%)
CoeffVar elapsed-5      72.9538 (  0.00%)      11.4303 ( 84.33%)
CoeffVar elapsed-7       9.5902 (  0.00%)      10.6597 (-11.15%)
CoeffVar elapsed-8      48.5886 (  0.00%)       6.7081 ( 86.19%)
Max      system-1        2.6900 (  0.00%)       2.7500 ( -2.23%)
Max      system-3        0.2600 (  0.00%)       0.2300 ( 11.54%)
Max      system-5        1.4800 (  0.00%)       0.3800 ( 74.32%)
Max      system-7        0.4300 (  0.00%)       0.4400 ( -2.33%)
Max      system-8        2.2000 (  0.00%)       0.4300 ( 80.45%)
Max      elapsed-1       3.4200 (  0.00%)       3.7200 ( -8.77%)
Max      elapsed-3       0.1100 (  0.00%)       0.0900 ( 18.18%)
Max      elapsed-5       0.4200 (  0.00%)       0.1000 ( 76.19%)
Max      elapsed-7       0.0800 (  0.00%)       0.0800 (  0.00%)
Max      elapsed-8       0.3600 (  0.00%)       0.0700 ( 80.56%)

pft faults
                                            4.3.0                       4.3.0
                             13672-gc669d35-dirty        13708-g8e488c2-dirty
Min      faults/cpu-1    4826.3370 (  0.00%)    4724.0920 ( -2.12%)
Min      faults/cpu-3   48054.3130 (  0.00%)   52057.8790 (  8.33%)
Min      faults/cpu-5    8657.3530 (  0.00%)   32656.8230 (277.21%)
Min      faults/cpu-7   28499.3350 (  0.00%)   28117.8470 ( -1.34%)
Min      faults/cpu-8    5785.6660 (  0.00%)   28468.9430 (392.06%)
Min      faults/sec-1    3818.0350 (  0.00%)    3503.7170 ( -8.23%)
Min      faults/sec-3  115163.0990 (  0.00%)  142861.2660 ( 24.05%)
Min      faults/sec-5   31307.4700 (  0.00%)  126644.8950 (304.52%)
Min      faults/sec-7  161275.0230 (  0.00%)  154987.8940 ( -3.90%)
Min      faults/sec-8   36175.2080 (  0.00%)  181500.8080 (401.73%)
Hmean    faults/cpu-1   73887.2577 (  0.00%)   78026.1722 (  5.60%)
Hmean    faults/cpu-3   71522.1756 (  0.00%)   77089.5360 (  7.78%)
Hmean    faults/cpu-5   34277.6489 (  0.00%)   42103.7728 ( 22.83%)
Hmean    faults/cpu-7   36418.2317 (  0.00%)   36054.2105 ( -1.00%)
Hmean    faults/cpu-8   29741.2065 (  0.00%)   33195.0525 ( 11.61%)
Hmean    faults/sec-1   63979.9276 (  0.00%)   67449.3892 (  5.42%)
Hmean    faults/sec-3  175991.8241 (  0.00%)  189556.4239 (  7.71%)
Hmean    faults/sec-5  134694.5971 (  0.00%)  167086.7980 ( 24.05%)
Hmean    faults/sec-7  196906.4585 (  0.00%)  194505.0606 ( -1.22%)
Hmean    faults/sec-8  190635.0992 (  0.00%)  210558.9780 ( 10.45%)
Stddev   faults/cpu-1   28421.3218 (  0.00%)   31119.8455 ( -9.49%)
Stddev   faults/cpu-3    7433.8195 (  0.00%)    7024.7950 (  5.50%)
Stddev   faults/cpu-5   10013.2881 (  0.00%)    4757.1716 ( 52.49%)
Stddev   faults/cpu-7    3856.6692 (  0.00%)    3128.6064 ( 18.88%)
Stddev   faults/cpu-8    4506.9641 (  0.00%)    3753.0081 ( 16.73%)
Stddev   faults/sec-1   27405.3207 (  0.00%)   29714.3764 ( -8.43%)
Stddev   faults/sec-3   16581.7614 (  0.00%)   16406.9053 (  1.05%)
Stddev   faults/sec-5   41735.1309 (  0.00%)   18896.6954 ( 54.72%)
Stddev   faults/sec-7   13126.2068 (  0.00%)   16315.6539 (-24.30%)
Stddev   faults/sec-8   26939.6466 (  0.00%)   11738.7089 ( 56.43%)
CoeffVar faults/cpu-1      25.6278 (  0.00%)      26.5666 ( -3.66%)
CoeffVar faults/cpu-3      10.2707 (  0.00%)       9.0358 ( 12.02%)
CoeffVar faults/cpu-5      24.5397 (  0.00%)      11.1592 ( 54.53%)
CoeffVar faults/cpu-7      10.4800 (  0.00%)       8.6127 ( 17.82%)
CoeffVar faults/cpu-8      14.3209 (  0.00%)      11.1754 ( 21.96%)
CoeffVar faults/sec-1      26.0287 (  0.00%)      26.7416 ( -2.74%)
CoeffVar faults/sec-3       9.3294 (  0.00%)       8.5905 (  7.92%)
CoeffVar faults/sec-5      25.7575 (  0.00%)      11.1747 ( 56.62%)
CoeffVar faults/sec-7       6.6347 (  0.00%)       8.3276 (-25.52%)
CoeffVar faults/sec-8      13.3650 (  0.00%)       5.5575 ( 58.42%)
Max      faults/cpu-1  169773.9820 (  0.00%)  173628.2170 (  2.27%)
Max      faults/cpu-3   87876.0920 (  0.00%)   95342.5620 (  8.50%)
Max      faults/cpu-5   52178.9930 (  0.00%)   53589.5550 (  2.70%)
Max      faults/cpu-7   49544.2420 (  0.00%)   43912.2830 (-11.37%)
Max      faults/cpu-8   42351.8250 (  0.00%)   42866.1120 (  1.21%)
Max      faults/sec-1  153006.2870 (  0.00%)  159219.3870 (  4.06%)
Max      faults/sec-3  213038.1300 (  0.00%)  222970.7520 (  4.66%)
Max      faults/sec-5  216193.7690 (  0.00%)  216955.0470 (  0.35%)
Max      faults/sec-7  219260.6940 (  0.00%)  229234.7670 (  4.55%)
Max      faults/sec-8  232367.7020 (  0.00%)  229220.0190 ( -1.35%)

               4.3.0       4.3.0
        13672-gc669d35-dirty13708-g8e488c2-dirty
User           13.47       10.80
System        138.78      134.16
Elapsed        48.68       46.84

                                 4.3.0       4.3.0
                          13672-gc669d35-dirty13708-g8e488c2-dirty
Minor Faults                   5478166     5478364
Major Faults                         0           0
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                     5269869     5270049
DMA32 allocs                         0           0
Normal allocs                        0           0
Movable allocs                       0           0
Direct pages scanned                 0           0
Kswapd pages scanned                 0           0
Kswapd pages reclaimed               0           0
Direct pages reclaimed               0           0
Kswapd efficiency                 100%        100%
Kswapd velocity                  0.000       0.000
Direct efficiency                 100%        100%
Direct velocity                  0.000       0.000
Percentage direct scans             0%          0%
Zone normal velocity             0.000       0.000
Zone dma32 velocity              0.000       0.000
Zone dma velocity                0.000       0.000
Page writes by reclaim           0.000       0.000
Page writes file                     0           0
Page writes anon                     0           0
Page reclaim immediate               0           0
Sector Reads                        72          72
Sector Writes                      560         500
Page rescued immediate               0           0
Slabs scanned                        0           0
Direct inode steals                  0           0
Kswapd inode steals                  0           0
Kswapd skipped wait                  0           0
THP fault alloc                      0           0
THP collapse alloc                   0           0
THP splits                           0           0
THP fault fallback                   0           0
THP collapse fail                    0           0
Compaction stalls                    0           0
Compaction success                   0           0
Compaction failures                  0           0
Page migrate success                 0           0
Page migrate failure                 0           0
Compaction pages isolated            0           0
Compaction migrate scanned           0           0
Compaction free scanned              0           0
Compaction cost                      0           0
NUMA alloc hit                 5269751     5269915
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local               5269751     5269915
NUMA base PTE updates            23119       11610
NUMA huge PMD updates                0           0
NUMA page range updates          23119       11610
NUMA hint faults                    16           7
NUMA hint local faults              16           7
NUMA hint local percent            100         100
NUMA pages migrated                  0           0
AutoNUMA cost                       0%          0%

ebizzy Overall Throughput
                                       4.3.0                       4.3.0
                        13672-gc669d35-dirty        13708-g8e488c2-dirty
Min      Rsec-1      6486.00 (  0.00%)     6153.00 ( -5.13%)
Min      Rsec-3      9821.00 (  0.00%)    10083.00 (  2.67%)
Min      Rsec-5     10688.00 (  0.00%)    10576.00 ( -1.05%)
Min      Rsec-7     11359.00 (  0.00%)    10870.00 ( -4.30%)
Min      Rsec-12    14925.00 (  0.00%)    13443.00 ( -9.93%)
Min      Rsec-18    12493.00 (  0.00%)    11553.00 ( -7.52%)
Min      Rsec-24    13696.00 (  0.00%)    12764.00 ( -6.80%)
Min      Rsec-30    13669.00 (  0.00%)    13299.00 ( -2.71%)
Min      Rsec-32    14852.00 (  0.00%)    13008.00 (-12.42%)
Hmean    Rsec-1      6574.40 (  0.00%)     6230.95 ( -5.22%)
Hmean    Rsec-3     10005.71 (  0.00%)    10403.25 (  3.97%)
Hmean    Rsec-5     11064.39 (  0.00%)    10999.12 ( -0.59%)
Hmean    Rsec-7     11793.27 (  0.00%)    11044.37 ( -6.35%)
Hmean    Rsec-12    15130.50 (  0.00%)    13929.85 ( -7.94%)
Hmean    Rsec-18    13396.79 (  0.00%)    12284.36 ( -8.30%)
Hmean    Rsec-24    13981.41 (  0.00%)    13493.87 ( -3.49%)
Hmean    Rsec-30    14127.08 (  0.00%)    13482.65 ( -4.56%)
Hmean    Rsec-32    15170.35 (  0.00%)    13493.89 (-11.05%)
Stddev   Rsec-1        62.81 (  0.00%)       52.93 ( 15.73%)
Stddev   Rsec-3       152.04 (  0.00%)      267.01 (-75.62%)
Stddev   Rsec-5       260.81 (  0.00%)      290.26 (-11.29%)
Stddev   Rsec-7       540.61 (  0.00%)      266.96 ( 50.62%)
Stddev   Rsec-12      203.42 (  0.00%)      314.95 (-54.83%)
Stddev   Rsec-18      607.51 (  0.00%)      456.19 ( 24.91%)
Stddev   Rsec-24      182.90 (  0.00%)      698.10 (-281.69%)
Stddev   Rsec-30      500.28 (  0.00%)      194.07 ( 61.21%)
Stddev   Rsec-32      247.90 (  0.00%)      405.56 (-63.60%)
CoeffVar Rsec-1         0.96 (  0.00%)        0.85 ( 11.08%)
CoeffVar Rsec-3         1.52 (  0.00%)        2.56 (-68.84%)
CoeffVar Rsec-5         2.36 (  0.00%)        2.64 (-11.94%)
CoeffVar Rsec-7         4.57 (  0.00%)        2.42 ( 47.19%)
CoeffVar Rsec-12        1.34 (  0.00%)        2.26 (-68.11%)
CoeffVar Rsec-18        4.53 (  0.00%)        3.71 ( 18.05%)
CoeffVar Rsec-24        1.31 (  0.00%)        5.16 (-294.54%)
CoeffVar Rsec-30        3.54 (  0.00%)        1.44 ( 59.31%)
CoeffVar Rsec-32        1.63 (  0.00%)        3.00 (-83.81%)
Max      Rsec-1      6679.00 (  0.00%)     6284.00 ( -5.91%)
Max      Rsec-3     10252.00 (  0.00%)    10865.00 (  5.98%)
Max      Rsec-5     11307.00 (  0.00%)    11337.00 (  0.27%)
Max      Rsec-7     12841.00 (  0.00%)    11582.00 ( -9.80%)
Max      Rsec-12    15509.00 (  0.00%)    14361.00 ( -7.40%)
Max      Rsec-18    14229.00 (  0.00%)    12792.00 (-10.10%)
Max      Rsec-24    14266.00 (  0.00%)    14826.00 (  3.93%)
Max      Rsec-30    15055.00 (  0.00%)    13840.00 ( -8.07%)
Max      Rsec-32    15508.00 (  0.00%)    14237.00 ( -8.20%)

ebizzy Per-thread
                                       4.3.0                       4.3.0
                        13672-gc669d35-dirty        13708-g8e488c2-dirty
Min      Rsec-1      6486.00 (  0.00%)     6153.00 ( -5.13%)
Min      Rsec-3      3100.00 (  0.00%)     3232.00 (  4.26%)
Min      Rsec-5      1940.00 (  0.00%)     2018.00 (  4.02%)
Min      Rsec-7      1532.00 (  0.00%)     1465.00 ( -4.37%)
Min      Rsec-12     1107.00 (  0.00%)     1012.00 ( -8.58%)
Min      Rsec-18      585.00 (  0.00%)      538.00 ( -8.03%)
Min      Rsec-24      459.00 (  0.00%)      431.00 ( -6.10%)
Min      Rsec-30      373.00 (  0.00%)      358.00 ( -4.02%)
Min      Rsec-32      372.00 (  0.00%)      332.00 (-10.75%)
Hmean    Rsec-1      6574.40 (  0.00%)     6230.95 ( -5.22%)
Hmean    Rsec-3      3328.16 (  0.00%)     3457.35 (  3.88%)
Hmean    Rsec-5      2209.26 (  0.00%)     2197.43 ( -0.54%)
Hmean    Rsec-7      1661.38 (  0.00%)     1576.23 ( -5.13%)
Hmean    Rsec-12     1248.27 (  0.00%)     1148.41 ( -8.00%)
Hmean    Rsec-18      692.79 (  0.00%)      639.55 ( -7.68%)
Hmean    Rsec-24      570.63 (  0.00%)      545.79 ( -4.35%)
Hmean    Rsec-30      461.30 (  0.00%)      439.45 ( -4.74%)
Hmean    Rsec-32      462.88 (  0.00%)      413.36 (-10.70%)
Stddev   Rsec-1        62.81 (  0.00%)       52.93 (-15.73%)
Stddev   Rsec-3       158.59 (  0.00%)      211.53 ( 33.38%)
Stddev   Rsec-5        96.83 (  0.00%)       88.33 ( -8.78%)
Stddev   Rsec-7       290.12 (  0.00%)       57.71 (-80.11%)
Stddev   Rsec-12      134.37 (  0.00%)      136.35 (  1.47%)
Stddev   Rsec-18      253.56 (  0.00%)      220.27 (-13.13%)
Stddev   Rsec-24       85.84 (  0.00%)      106.71 ( 24.32%)
Stddev   Rsec-30       76.73 (  0.00%)       72.81 ( -5.11%)
Stddev   Rsec-32       75.83 (  0.00%)       62.71 (-17.30%)
CoeffVar Rsec-1         0.96 (  0.00%)        0.85 ( 11.08%)
CoeffVar Rsec-3         4.75 (  0.00%)        6.10 (-28.23%)
CoeffVar Rsec-5         4.37 (  0.00%)        4.01 (  8.25%)
CoeffVar Rsec-7        17.19 (  0.00%)        3.66 ( 78.73%)
CoeffVar Rsec-12       10.66 (  0.00%)       11.75 (-10.19%)
CoeffVar Rsec-18       34.02 (  0.00%)       32.25 (  5.19%)
CoeffVar Rsec-24       14.74 (  0.00%)       18.95 (-28.52%)
CoeffVar Rsec-30       16.29 (  0.00%)       16.22 (  0.45%)
CoeffVar Rsec-32       16.01 (  0.00%)       14.88 (  7.07%)
Max      Rsec-1      6679.00 (  0.00%)     6284.00 ( -5.91%)
Max      Rsec-3      3602.00 (  0.00%)     3967.00 ( 10.13%)
Max      Rsec-5      2351.00 (  0.00%)     2433.00 (  3.49%)
Max      Rsec-7      3355.00 (  0.00%)     1737.00 (-48.23%)
Max      Rsec-12     1890.00 (  0.00%)     1787.00 ( -5.45%)
Max      Rsec-18     1448.00 (  0.00%)     1295.00 (-10.57%)
Max      Rsec-24      818.00 (  0.00%)      905.00 ( 10.64%)
Max      Rsec-30      771.00 (  0.00%)      724.00 ( -6.10%)
Max      Rsec-32      676.00 (  0.00%)      648.00 ( -4.14%)

ebizzy Thread spread
                                         4.3.0                       4.3.0
                          13672-gc669d35-dirty        13708-g8e488c2-dirty
Min      spread-1         0.00 (  0.00%)        0.00 (  0.00%)
Min      spread-3       272.00 (  0.00%)      342.00 (-25.74%)
Min      spread-5       119.00 (  0.00%)      132.00 (-10.92%)
Min      spread-7        90.00 (  0.00%)      101.00 (-12.22%)
Min      spread-12      278.00 (  0.00%)      112.00 ( 59.71%)
Min      spread-18      751.00 (  0.00%)      638.00 ( 15.05%)
Min      spread-24      192.00 (  0.00%)      260.00 (-35.42%)
Min      spread-30      307.00 (  0.00%)      260.00 ( 15.31%)
Min      spread-32      240.00 (  0.00%)      179.00 ( 25.42%)
Hmean    spread-1         0.00 (  0.00%)        0.00 (  0.00%)
Hmean    spread-3       315.55 (  0.00%)      411.86 (-30.52%)
Hmean    spread-5       179.34 (  0.00%)      172.47 (  3.83%)
Hmean    spread-7       121.46 (  0.00%)      134.77 (-10.96%)
Hmean    spread-12      331.88 (  0.00%)      263.00 ( 20.75%)
Hmean    spread-18      775.27 (  0.00%)      692.94 ( 10.62%)
Hmean    spread-24      267.67 (  0.00%)      351.87 (-31.46%)
Hmean    spread-30      339.24 (  0.00%)      304.50 ( 10.24%)
Hmean    spread-32      267.37 (  0.00%)      220.17 ( 17.65%)
Stddev   spread-1         0.00 (  0.00%)        0.00 (  0.00%)
Stddev   spread-3        76.63 (  0.00%)       63.98 ( 16.50%)
Stddev   spread-5        77.12 (  0.00%)       42.96 ( 44.30%)
Stddev   spread-7       689.22 (  0.00%)       24.63 ( 96.43%)
Stddev   spread-12      192.78 (  0.00%)      258.17 (-33.92%)
Stddev   spread-18       27.29 (  0.00%)       37.57 (-37.67%)
Stddev   spread-24       56.34 (  0.00%)       69.16 (-22.75%)
Stddev   spread-30       34.27 (  0.00%)       40.12 (-17.07%)
Stddev   spread-32       24.82 (  0.00%)       41.70 (-67.98%)
CoeffVar spread-1         0.00 (  0.00%)        0.00 (  0.00%)
CoeffVar spread-3        23.26 (  0.00%)       15.20 (-34.64%)
CoeffVar spread-5        38.03 (  0.00%)       23.71 (-37.66%)
CoeffVar spread-7       154.95 (  0.00%)       17.67 (-88.60%)
CoeffVar spread-12       49.76 (  0.00%)       60.89 ( 22.36%)
CoeffVar spread-18        3.52 (  0.00%)        5.41 ( 53.76%)
CoeffVar spread-24       20.12 (  0.00%)       18.90 ( -6.09%)
CoeffVar spread-30       10.00 (  0.00%)       12.96 ( 29.55%)
CoeffVar spread-32        9.21 (  0.00%)       18.31 ( 98.81%)
Max      spread-1         0.00 (  0.00%)        0.00 (  0.00%)
Max      spread-3       478.00 (  0.00%)      535.00 (-11.92%)
Max      spread-5       345.00 (  0.00%)      260.00 ( 24.64%)
Max      spread-7      1823.00 (  0.00%)      175.00 ( 90.40%)
Max      spread-12      772.00 (  0.00%)      751.00 (  2.72%)
Max      spread-18      827.00 (  0.00%)      746.00 (  9.79%)
Max      spread-24      351.00 (  0.00%)      448.00 (-27.64%)
Max      spread-30      387.00 (  0.00%)      366.00 (  5.43%)
Max      spread-32      304.00 (  0.00%)      278.00 (  8.55%)

               4.3.0       4.3.0
        13672-gc669d35-dirty13708-g8e488c2-dirty
User         1577.04     1520.68
System       6809.94     6864.08
Elapsed      1353.57     1353.80

                                 4.3.0       4.3.0
                          13672-gc669d35-dirty13708-g8e488c2-dirty
Minor Faults                 100301324    95014933
Major Faults                         0           0
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                   100222214    94935232
DMA32 allocs                         0           0
Normal allocs                        0           0
Movable allocs                       0           0
Direct pages scanned                 0           0
Kswapd pages scanned                 0           0
Kswapd pages reclaimed               0           0
Direct pages reclaimed               0           0
Kswapd efficiency                 100%        100%
Kswapd velocity                  0.000       0.000
Direct efficiency                 100%        100%
Direct velocity                  0.000       0.000
Percentage direct scans             0%          0%
Zone normal velocity             0.000       0.000
Zone dma32 velocity              0.000       0.000
Zone dma velocity                0.000       0.000
Page writes by reclaim           0.000       0.000
Page writes file                     0           0
Page writes anon                     0           0
Page reclaim immediate               0           0
Sector Reads                       440         560
Sector Writes                     4324        4156
Page rescued immediate               0           0
Slabs scanned                        0           0
Direct inode steals                  0           0
Kswapd inode steals                  0           0
Kswapd skipped wait                  0           0
THP fault alloc                      0           0
THP collapse alloc                   0           0
THP splits                           0           0
THP fault fallback                   0           0
THP collapse fail                    0           0
Compaction stalls                    0           0
Compaction success                   0           0
Compaction failures                  0           0
Page migrate success                 0           0
Page migrate failure                 0           0
Compaction pages isolated            0           0
Compaction migrate scanned           0           0
Compaction free scanned              0           0
Compaction cost                      0           0
NUMA alloc hit               100222248    94935323
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local             100222248    94935323
NUMA base PTE updates            43936       45000
NUMA huge PMD updates                0           0
NUMA page range updates          43936       45000
NUMA hint faults                 35295       36155
NUMA hint local faults           35295       36155
NUMA hint local percent            100         100
NUMA pages migrated                  0           0
AutoNUMA cost                     176%        181%
-------------- 4k hash pte guest config stop--------------------
-------------- 64k hash pte powernv config start--------------------

aim9
                                         4.3.0                       4.3.0
                                13672-gc669d35              13708-g8e488c2
Min      page_test  2256353.33 (  0.00%)  2225073.33 ( -1.39%)
Min      brk_test   4131000.00 (  0.00%)  4153666.67 (  0.55%)
Min      exec_test     1639.67 (  0.00%)     1635.00 ( -0.28%)
Min      fork_test     4636.91 (  0.00%)     4633.82 ( -0.07%)
Hmean    page_test  2281108.70 (  0.00%)  2282854.75 (  0.08%)
Hmean    brk_test   4178161.02 (  0.00%)  4190571.57 (  0.30%)
Hmean    exec_test     1666.34 (  0.00%)     1663.18 ( -0.19%)
Hmean    fork_test     4659.91 (  0.00%)     4665.26 (  0.11%)
Stddev   page_test    19681.94 (  0.00%)    23269.98 (-18.23%)
Stddev   brk_test     62136.33 (  0.00%)    41482.83 ( 33.24%)
Stddev   exec_test       14.09 (  0.00%)       11.74 ( 16.69%)
Stddev   fork_test        9.66 (  0.00%)       18.39 (-90.33%)
CoeffVar page_test        0.86 (  0.00%)        1.02 (-18.14%)
CoeffVar brk_test         1.49 (  0.00%)        0.99 ( 33.43%)
CoeffVar exec_test        0.85 (  0.00%)        0.71 ( 16.53%)
CoeffVar fork_test        0.21 (  0.00%)        0.39 (-90.11%)
Max      page_test  2323106.67 (  0.00%)  2307466.67 ( -0.67%)
Max      brk_test   4285133.33 (  0.00%)  4321400.00 (  0.85%)
Max      exec_test     1684.33 (  0.00%)     1678.33 ( -0.36%)
Max      fork_test     4676.88 (  0.00%)     4690.21 (  0.29%)

               4.3.0       4.3.0
        13672-gc669d3513708-g8e488c2
User            0.09        2.37
System          0.13        0.53
Elapsed       722.20      726.32

                                 4.3.0       4.3.0
                          13672-gc669d3513708-g8e488c2
Minor Faults                  84853683    84777713
Major Faults                        25         328
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                    38237729    38213150
DMA32 allocs                         0           0
Normal allocs                        0           0
Movable allocs                       0           0
Direct pages scanned                 0           0
Kswapd pages scanned                 0           0
Kswapd pages reclaimed               0           0
Direct pages reclaimed               0           0
Kswapd efficiency                 100%        100%
Kswapd velocity                  0.000       0.000
Direct efficiency                 100%        100%
Direct velocity                  0.000       0.000
Percentage direct scans             0%          0%
Zone normal velocity             0.000       0.000
Zone dma32 velocity              0.000       0.000
Zone dma velocity                0.000       0.000
Page writes by reclaim           0.000       0.000
Page writes file                     0           0
Page writes anon                     0           0
Page reclaim immediate               0           0
Sector Reads                      4744       22336
Sector Writes                    71712       71744
Page rescued immediate               0           0
Slabs scanned                        0           0
Direct inode steals                  0           0
Kswapd inode steals                  0           0
Kswapd skipped wait                  0           0
THP fault alloc                      0           2
THP collapse alloc                   0           0
THP splits                           0           0
THP fault fallback                   0           3
THP collapse fail                    0           0
Compaction stalls                    0           0
Compaction success                   0           0
Compaction failures                  0           0
Page migrate success                 0           0
Page migrate failure                 0           0
Compaction pages isolated            0           0
Compaction migrate scanned           0           0
Compaction free scanned              0           0
Compaction cost                      0           0
NUMA alloc hit                38231124    38206624
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local              38229247    38204174
NUMA base PTE updates              646         637
NUMA huge PMD updates                0           0
NUMA page range updates            646         637
NUMA hint faults               1803811     1756586
NUMA hint local faults         1803625     1756366
NUMA hint local percent             99          99
NUMA pages migrated                  0           0
AutoNUMA cost                    9019%       8782%

pft timings
                                           4.3.0                       4.3.0
                                  13672-gc669d35              13708-g8e488c2
Min      system-1          1.8600 (  0.00%)       1.8700 ( -0.54%)
Min      system-4          4.1900 (  0.00%)       4.1900 (  0.00%)
Min      system-7          6.5800 (  0.00%)       5.8500 ( 11.09%)
Min      system-12         9.3600 (  0.00%)      11.0400 (-17.95%)
Min      system-21        15.4700 (  0.00%)      16.2900 ( -5.30%)
Min      system-30        22.2600 (  0.00%)      21.4400 (  3.68%)
Min      system-48        30.7000 (  0.00%)      31.4000 ( -2.28%)
Min      system-79        55.4600 (  0.00%)      54.2300 (  2.22%)
Min      system-110       63.6400 (  0.00%)      61.8200 (  2.86%)
Min      system-141       66.8900 (  0.00%)      67.3400 ( -0.67%)
Min      system-160       69.5500 (  0.00%)      70.4900 ( -1.35%)
Min      elapsed-1         2.0300 (  0.00%)       2.0400 ( -0.49%)
Min      elapsed-4         1.3000 (  0.00%)       1.3100 ( -0.77%)
Min      elapsed-7         1.2300 (  0.00%)       0.9900 ( 19.51%)
Min      elapsed-12        0.8700 (  0.00%)       1.1500 (-32.18%)
Min      elapsed-21        0.9100 (  0.00%)       1.0100 (-10.99%)
Min      elapsed-30        0.8700 (  0.00%)       0.8700 (  0.00%)
Min      elapsed-48        0.8700 (  0.00%)       0.8800 ( -1.15%)
Min      elapsed-79        0.9000 (  0.00%)       0.8800 (  2.22%)
Min      elapsed-110       0.9500 (  0.00%)       0.9000 (  5.26%)
Min      elapsed-141       0.8800 (  0.00%)       0.9300 ( -5.68%)
Min      elapsed-160       0.8800 (  0.00%)       0.9200 ( -4.55%)
Amean    system-1          1.8881 (  0.00%)       1.9090 ( -1.11%)
Amean    system-4          6.5492 (  0.00%)       6.5650 ( -0.24%)
Amean    system-7         10.0890 (  0.00%)      10.1636 ( -0.74%)
Amean    system-12        14.7406 (  0.00%)      15.3927 ( -4.42%)
Amean    system-21        22.2554 (  0.00%)      25.3304 (-13.82%)
Amean    system-30        35.2691 (  0.00%)      29.8990 ( 15.23%)
Amean    system-48        45.8848 (  0.00%)      42.5765 (  7.21%)
Amean    system-79        65.6720 (  0.00%)      63.4805 (  3.34%)
Amean    system-110       77.0405 (  0.00%)      75.3361 (  2.21%)
Amean    system-141       83.8607 (  0.00%)      83.1904 (  0.80%)
Amean    system-160       84.8629 (  0.00%)      83.5491 (  1.55%)
Amean    elapsed-1         2.0836 (  0.00%)       2.1036 ( -0.96%)
Amean    elapsed-4         1.7204 (  0.00%)       1.7264 ( -0.35%)
Amean    elapsed-7         1.6176 (  0.00%)       1.6254 ( -0.48%)
Amean    elapsed-12        1.5135 (  0.00%)       1.5618 ( -3.19%)
Amean    elapsed-21        1.3556 (  0.00%)       1.5172 (-11.92%)
Amean    elapsed-30        1.5014 (  0.00%)       1.2959 ( 13.69%)
Amean    elapsed-48        1.2863 (  0.00%)       1.2243 (  4.82%)
Amean    elapsed-79        1.2315 (  0.00%)       1.1953 (  2.94%)
Amean    elapsed-110       1.1055 (  0.00%)       1.0705 (  3.17%)
Amean    elapsed-141       1.0494 (  0.00%)       1.0268 (  2.16%)
Amean    elapsed-160       1.0396 (  0.00%)       1.0375 (  0.20%)
Stddev   system-1          0.0758 (  0.00%)       0.0766 ( -1.03%)
Stddev   system-4          0.3702 (  0.00%)       0.2734 ( 26.16%)
Stddev   system-7          1.4758 (  0.00%)       1.4623 (  0.91%)
Stddev   system-12         2.1752 (  0.00%)       1.7466 ( 19.70%)
Stddev   system-21         5.2401 (  0.00%)       3.9628 ( 24.38%)
Stddev   system-30         6.4944 (  0.00%)       7.3898 (-13.79%)
Stddev   system-48        11.4237 (  0.00%)       9.5028 ( 16.81%)
Stddev   system-79         9.4485 (  0.00%)       6.2530 ( 33.82%)
Stddev   system-110        7.8213 (  0.00%)       6.6034 ( 15.57%)
Stddev   system-141        7.2452 (  0.00%)       6.5108 ( 10.14%)
Stddev   system-160        6.9865 (  0.00%)       6.5068 (  6.87%)
Stddev   elapsed-1         0.0778 (  0.00%)       0.0819 ( -5.36%)
Stddev   elapsed-4         0.0666 (  0.00%)       0.0470 ( 29.39%)
Stddev   elapsed-7         0.1404 (  0.00%)       0.1481 ( -5.50%)
Stddev   elapsed-12        0.1691 (  0.00%)       0.1135 ( 32.90%)
Stddev   elapsed-21        0.2723 (  0.00%)       0.1641 ( 39.75%)
Stddev   elapsed-30        0.2001 (  0.00%)       0.2761 (-37.99%)
Stddev   elapsed-48        0.2472 (  0.00%)       0.2112 ( 14.55%)
Stddev   elapsed-79        0.1377 (  0.00%)       0.1097 ( 20.36%)
Stddev   elapsed-110       0.0812 (  0.00%)       0.0808 (  0.46%)
Stddev   elapsed-141       0.0544 (  0.00%)       0.0557 ( -2.27%)
Stddev   elapsed-160       0.0637 (  0.00%)       0.0577 (  9.37%)
CoeffVar system-1          4.0135 (  0.00%)       4.0105 (  0.08%)
CoeffVar system-4          5.6527 (  0.00%)       4.1640 ( 26.34%)
CoeffVar system-7         14.6274 (  0.00%)      14.3878 (  1.64%)
CoeffVar system-12        14.7568 (  0.00%)      11.3470 ( 23.11%)
CoeffVar system-21        23.5452 (  0.00%)      15.6444 ( 33.56%)
CoeffVar system-30        18.4137 (  0.00%)      24.7158 (-34.22%)
CoeffVar system-48        24.8964 (  0.00%)      22.3194 ( 10.35%)
CoeffVar system-79        14.3874 (  0.00%)       9.8502 ( 31.54%)
CoeffVar system-110       10.1521 (  0.00%)       8.7653 ( 13.66%)
CoeffVar system-141        8.6396 (  0.00%)       7.8264 (  9.41%)
CoeffVar system-160        8.2327 (  0.00%)       7.7880 (  5.40%)
CoeffVar elapsed-1         3.7316 (  0.00%)       3.8941 ( -4.35%)
CoeffVar elapsed-4         3.8704 (  0.00%)       2.7235 ( 29.63%)
CoeffVar elapsed-7         8.6807 (  0.00%)       9.1146 ( -5.00%)
CoeffVar elapsed-12       11.1714 (  0.00%)       7.2646 ( 34.97%)
CoeffVar elapsed-21       20.0897 (  0.00%)      10.8143 ( 46.17%)
CoeffVar elapsed-30       13.3289 (  0.00%)      21.3093 (-59.87%)
CoeffVar elapsed-48       19.2176 (  0.00%)      17.2536 ( 10.22%)
CoeffVar elapsed-79       11.1827 (  0.00%)       9.1764 ( 17.94%)
CoeffVar elapsed-110       7.3416 (  0.00%)       7.5471 ( -2.80%)
CoeffVar elapsed-141       5.1854 (  0.00%)       5.4200 ( -4.53%)
CoeffVar elapsed-160       6.1260 (  0.00%)       5.5631 (  9.19%)
Max      system-1          2.3000 (  0.00%)       2.2800 (  0.87%)
Max      system-4          6.6900 (  0.00%)       6.7000 ( -0.15%)
Max      system-7         11.6800 (  0.00%)      11.7500 ( -0.60%)
Max      system-12        17.9100 (  0.00%)      18.4500 ( -3.02%)
Max      system-21        31.9700 (  0.00%)      31.7300 (  0.75%)
Max      system-30        43.3700 (  0.00%)      43.2700 (  0.23%)
Max      system-48        70.3200 (  0.00%)      70.1900 (  0.18%)
Max      system-79       106.7500 (  0.00%)      90.1600 ( 15.54%)
Max      system-110      102.1600 (  0.00%)     101.2100 (  0.93%)
Max      system-141      103.0400 (  0.00%)      96.7000 (  6.15%)
Max      system-160       98.4800 (  0.00%)      97.5000 (  1.00%)
Max      elapsed-1         2.4900 (  0.00%)       2.4800 (  0.40%)
Max      elapsed-4         1.7400 (  0.00%)       1.7500 ( -0.57%)
Max      elapsed-7         1.7500 (  0.00%)       1.7400 (  0.57%)
Max      elapsed-12        1.7400 (  0.00%)       1.7500 ( -0.57%)
Max      elapsed-21        1.7500 (  0.00%)       1.7000 (  2.86%)
Max      elapsed-30        1.7300 (  0.00%)       1.7100 (  1.16%)
Max      elapsed-48        1.7100 (  0.00%)       1.7000 (  0.58%)
Max      elapsed-79        1.7000 (  0.00%)       1.5300 ( 10.00%)
Max      elapsed-110       1.3500 (  0.00%)       1.3600 ( -0.74%)
Max      elapsed-141       1.1900 (  0.00%)       1.1800 (  0.84%)
Max      elapsed-160       1.2300 (  0.00%)       1.2300 (  0.00%)

pft faults
                                              4.3.0                       4.3.0
                                     13672-gc669d35              13708-g8e488c2
Min      faults/cpu-1    167962.7340 (  0.00%)  169258.4000 (  0.77%)
Min      faults/cpu-4     60713.3780 (  0.00%)   60626.9530 ( -0.14%)
Min      faults/cpu-7     35103.6480 (  0.00%)   34927.7700 ( -0.50%)
Min      faults/cpu-12    22960.1440 (  0.00%)   22309.4670 ( -2.83%)
Min      faults/cpu-21    12900.6920 (  0.00%)   13012.9840 (  0.87%)
Min      faults/cpu-30     9525.1380 (  0.00%)    9555.3660 (  0.32%)
Min      faults/cpu-48     5893.4010 (  0.00%)    5906.2790 (  0.22%)
Min      faults/cpu-79     3888.9070 (  0.00%)    4603.1070 ( 18.37%)
Min      faults/cpu-110    4062.4060 (  0.00%)    4100.8300 (  0.95%)
Min      faults/cpu-141    4028.4030 (  0.00%)    4292.1770 (  6.55%)
Min      faults/cpu-160    4212.2100 (  0.00%)    4256.9010 (  1.06%)
Min      faults/sec-1    167817.6050 (  0.00%)  168734.8460 (  0.55%)
Min      faults/sec-4    239459.5830 (  0.00%)  238660.6900 ( -0.33%)
Min      faults/sec-7    238787.6430 (  0.00%)  239458.0500 (  0.28%)
Min      faults/sec-12   240464.0970 (  0.00%)  238214.1180 ( -0.94%)
Min      faults/sec-21   238517.9660 (  0.00%)  245078.0380 (  2.75%)
Min      faults/sec-30   241525.0900 (  0.00%)  244625.2980 (  1.28%)
Min      faults/sec-48   244673.7080 (  0.00%)  245524.4950 (  0.35%)
Min      faults/sec-79   246298.3920 (  0.00%)  273087.1550 ( 10.88%)
Min      faults/sec-110  309127.0460 (  0.00%)  306026.2640 ( -1.00%)
Min      faults/sec-141  351861.9470 (  0.00%)  353729.4440 (  0.53%)
Min      faults/sec-160  338721.8730 (  0.00%)  339156.8390 (  0.13%)
Hmean    faults/cpu-1    201043.7845 (  0.00%)  198997.0168 ( -1.02%)
Hmean    faults/cpu-4     61948.9837 (  0.00%)   61760.6204 ( -0.30%)
Hmean    faults/cpu-7     40535.5843 (  0.00%)   40239.4941 ( -0.73%)
Hmean    faults/cpu-12    27836.2410 (  0.00%)   26689.3711 ( -4.12%)
Hmean    faults/cpu-21    18488.2448 (  0.00%)   16271.0796 (-11.99%)
Hmean    faults/cpu-30    11692.2366 (  0.00%)   13790.2478 ( 17.94%)
Hmean    faults/cpu-48     8998.8424 (  0.00%)    9697.2403 (  7.76%)
Hmean    faults/cpu-79     6298.5336 (  0.00%)    6516.3831 (  3.46%)
Hmean    faults/cpu-110    5375.1056 (  0.00%)    5497.3005 (  2.27%)
Hmean    faults/cpu-141    4942.4573 (  0.00%)    4983.7162 (  0.83%)
Hmean    faults/cpu-160    4884.7553 (  0.00%)    4962.4938 (  1.59%)
Hmean    faults/sec-1    200497.7126 (  0.00%)  198516.6748 ( -0.99%)
Hmean    faults/sec-4    242883.1475 (  0.00%)  241973.6927 ( -0.37%)
Hmean    faults/sec-7    258232.4571 (  0.00%)  256973.3980 ( -0.49%)
Hmean    faults/sec-12   275982.6468 (  0.00%)  267524.8543 ( -3.06%)
Hmean    faults/sec-21   308067.0715 (  0.00%)  275282.8535 (-10.64%)
Hmean    faults/sec-30   278272.5295 (  0.00%)  322318.2277 ( 15.83%)
Hmean    faults/sec-48   324712.2770 (  0.00%)  341047.4148 (  5.03%)
Hmean    faults/sec-79   339270.7201 (  0.00%)  349595.9658 (  3.04%)
Hmean    faults/sec-110  377555.4863 (  0.00%)  389982.2628 (  3.29%)
Hmean    faults/sec-141  398205.3191 (  0.00%)  407199.2710 (  2.26%)
Hmean    faults/sec-160  402260.8158 (  0.00%)  402662.2649 (  0.10%)
Stddev   faults/cpu-1      6579.0174 (  0.00%)    6939.5357 ( -5.48%)
Stddev   faults/cpu-4      5081.5381 (  0.00%)    3729.6536 ( 26.60%)
Stddev   faults/cpu-7      6863.0849 (  0.00%)    6915.7844 ( -0.77%)
Stddev   faults/cpu-12     4949.4091 (  0.00%)    3301.5541 ( 33.29%)
Stddev   faults/cpu-21     4556.4181 (  0.00%)    3091.1372 ( 32.16%)
Stddev   faults/cpu-30     2605.7291 (  0.00%)    3308.9108 (-26.99%)
Stddev   faults/cpu-48     2074.9654 (  0.00%)    1755.5029 ( 15.40%)
Stddev   faults/cpu-79      755.4743 (  0.00%)     570.7272 ( 24.45%)
Stddev   faults/cpu-110     518.6887 (  0.00%)     457.2601 ( 11.84%)
Stddev   faults/cpu-141     420.8814 (  0.00%)     399.1634 (  5.16%)
Stddev   faults/cpu-160     409.1068 (  0.00%)     389.8045 (  4.72%)
Stddev   faults/sec-1      6547.5672 (  0.00%)    6924.4985 ( -5.76%)
Stddev   faults/sec-4     12454.6505 (  0.00%)    8746.6168 ( 29.77%)
Stddev   faults/sec-7     25389.6889 (  0.00%)   29485.1401 (-16.13%)
Stddev   faults/sec-12    40255.2835 (  0.00%)   21610.2497 ( 46.32%)
Stddev   faults/sec-21    71662.3000 (  0.00%)   36438.3667 ( 49.15%)
Stddev   faults/sec-30    47102.8263 (  0.00%)   74717.8822 (-58.63%)
Stddev   faults/sec-48    66397.4011 (  0.00%)   58784.5253 ( 11.47%)
Stddev   faults/sec-79    37604.4314 (  0.00%)   33859.6768 (  9.96%)
Stddev   faults/sec-110   27245.1710 (  0.00%)   28753.8621 ( -5.54%)
Stddev   faults/sec-141   20904.0801 (  0.00%)   21653.4136 ( -3.58%)
Stddev   faults/sec-160   25264.6583 (  0.00%)   22119.1868 ( 12.45%)
CoeffVar faults/cpu-1         3.2684 (  0.00%)       3.4826 ( -6.55%)
CoeffVar faults/cpu-4         8.1660 (  0.00%)       6.0243 ( 26.23%)
CoeffVar faults/cpu-7        16.5350 (  0.00%)      16.7871 ( -1.52%)
CoeffVar faults/cpu-12       17.3398 (  0.00%)      12.2030 ( 29.62%)
CoeffVar faults/cpu-21       23.3188 (  0.00%)      18.4598 ( 20.84%)
CoeffVar faults/cpu-30       21.4245 (  0.00%)      22.6766 ( -5.84%)
CoeffVar faults/cpu-48       21.8405 (  0.00%)      17.4212 ( 20.23%)
CoeffVar faults/cpu-79       11.7968 (  0.00%)       8.6851 ( 26.38%)
CoeffVar faults/cpu-110       9.5579 (  0.00%)       8.2588 ( 13.59%)
CoeffVar faults/cpu-141       8.4542 (  0.00%)       7.9601 (  5.85%)
CoeffVar faults/cpu-160       8.3184 (  0.00%)       7.8078 (  6.14%)
CoeffVar faults/sec-1         3.2617 (  0.00%)       3.4834 ( -6.80%)
CoeffVar faults/sec-4         5.1176 (  0.00%)       3.6111 ( 29.44%)
CoeffVar faults/sec-7         9.7495 (  0.00%)      11.3571 (-16.49%)
CoeffVar faults/sec-12       14.3571 (  0.00%)       8.0310 ( 44.06%)
CoeffVar faults/sec-21       22.2373 (  0.00%)      13.0512 ( 41.31%)
CoeffVar faults/sec-30       16.5586 (  0.00%)      22.1067 (-33.51%)
CoeffVar faults/sec-48       19.6920 (  0.00%)      16.7508 ( 14.94%)
CoeffVar faults/sec-79       10.9508 (  0.00%)       9.6012 ( 12.32%)
CoeffVar faults/sec-110       7.1785 (  0.00%)       7.3326 ( -2.15%)
CoeffVar faults/sec-141       5.2355 (  0.00%)       5.3024 ( -1.28%)
CoeffVar faults/sec-160       6.2566 (  0.00%)       5.4766 ( 12.47%)
Max      faults/cpu-1    206718.3130 (  0.00%)  205567.6440 ( -0.56%)
Max      faults/cpu-4     95165.9670 (  0.00%)   94731.2700 ( -0.46%)
Max      faults/cpu-7     61266.2550 (  0.00%)   68833.4340 ( 12.35%)
Max      faults/cpu-12    43476.9210 (  0.00%)   37082.6580 (-14.71%)
Max      faults/cpu-21    26492.9770 (  0.00%)   25181.4640 ( -4.95%)
Max      faults/cpu-30    18445.4910 (  0.00%)   19158.5420 (  3.87%)
Max      faults/cpu-48    13377.7470 (  0.00%)   13082.6810 ( -2.21%)
Max      faults/cpu-79     7442.6860 (  0.00%)    7615.1420 (  2.32%)
Max      faults/cpu-110    6503.6080 (  0.00%)    6687.2100 (  2.82%)
Max      faults/cpu-141    6188.6650 (  0.00%)    6146.9070 ( -0.67%)
Max      faults/cpu-160    5950.8970 (  0.00%)    5871.3010 ( -1.34%)
Max      faults/sec-1    205979.4530 (  0.00%)  204798.6030 ( -0.57%)
Max      faults/sec-4    322267.9360 (  0.00%)  319804.0130 ( -0.76%)
Max      faults/sec-7    338997.6600 (  0.00%)  422940.9730 ( 24.76%)
Max      faults/sec-12   477630.1990 (  0.00%)  361992.2860 (-24.21%)
Max      faults/sec-21   460652.0560 (  0.00%)  414704.3010 ( -9.97%)
Max      faults/sec-30   481274.4730 (  0.00%)  479694.9450 ( -0.33%)
Max      faults/sec-48   478355.8440 (  0.00%)  475307.0260 ( -0.64%)
Max      faults/sec-79   461884.5660 (  0.00%)  473182.5810 (  2.45%)
Max      faults/sec-110  441502.3200 (  0.00%)  462415.9300 (  4.74%)
Max      faults/sec-141  473293.5230 (  0.00%)  447330.8000 ( -5.49%)
Max      faults/sec-160  475931.1320 (  0.00%)  453387.9520 ( -4.74%)

               4.3.0       4.3.0
        13672-gc669d3513708-g8e488c2
User         2202.96     2188.14
System      43841.77    43231.29
Elapsed      1363.37     1355.71

                                 4.3.0       4.3.0
                          13672-gc669d3513708-g8e488c2
Minor Faults                 370404167   370419290
Major Faults                         0          32
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                   368416400   368424912
DMA32 allocs                         0           0
Normal allocs                        0           0
Movable allocs                       0           0
Direct pages scanned                 0           0
Kswapd pages scanned                 0           0
Kswapd pages reclaimed               0           0
Direct pages reclaimed               0           0
Kswapd efficiency                 100%        100%
Kswapd velocity                  0.000       0.000
Direct efficiency                 100%        100%
Direct velocity                  0.000       0.000
Percentage direct scans             0%          0%
Zone normal velocity             0.000       0.000
Zone dma32 velocity              0.000       0.000
Zone dma velocity                0.000       0.000
Page writes by reclaim           0.000       0.000
Page writes file                     0           0
Page writes anon                     0           0
Page reclaim immediate               0           0
Sector Reads                       168        3696
Sector Writes                     7396        9136
Page rescued immediate               0           0
Slabs scanned                        0           0
Direct inode steals                  0           0
Kswapd inode steals                  0           0
Kswapd skipped wait                  0           0
THP fault alloc                      0           0
THP collapse alloc                   0           0
THP splits                           0           0
THP fault fallback                   0           0
THP collapse fail                    0           0
Compaction stalls                    0           0
Compaction success                   0           0
Compaction failures                  0           0
Page migrate success               452         442
Page migrate failure                 0           0
Compaction pages isolated            0           0
Compaction migrate scanned           0           0
Compaction free scanned              0           0
Compaction cost                      0           0
NUMA alloc hit               368352412   368362898
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local             249887344   239441708
NUMA base PTE updates         30421298    30252358
NUMA huge PMD updates                0           0
NUMA page range updates       30421298    30252358
NUMA hint faults                 39412       34328
NUMA hint local faults           28543       25263
NUMA hint local percent             72          73
NUMA pages migrated                452         442
AutoNUMA cost                     410%        383%

ebizzy Overall Throughput
                                        4.3.0                       4.3.0
                               13672-gc669d35              13708-g8e488c2
Min      Rsec-1      30631.00 (  0.00%)    27088.00 (-11.57%)
Min      Rsec-4      57821.00 (  0.00%)    47893.00 (-17.17%)
Min      Rsec-7      64229.00 (  0.00%)    62025.00 ( -3.43%)
Min      Rsec-12     75825.00 (  0.00%)    83296.00 (  9.85%)
Min      Rsec-21     81774.00 (  0.00%)    88602.00 (  8.35%)
Min      Rsec-30     92366.00 (  0.00%)    96488.00 (  4.46%)
Min      Rsec-48     98346.00 (  0.00%)   102081.00 (  3.80%)
Min      Rsec-79    107800.00 (  0.00%)   107806.00 (  0.01%)
Min      Rsec-110   115001.00 (  0.00%)   114767.00 ( -0.20%)
Min      Rsec-141   118423.00 (  0.00%)   120113.00 (  1.43%)
Min      Rsec-172   128361.00 (  0.00%)   126839.00 ( -1.19%)
Min      Rsec-203   128782.00 (  0.00%)   124506.00 ( -3.32%)
Min      Rsec-234   129973.00 (  0.00%)   125048.00 ( -3.79%)
Min      Rsec-265   129718.00 (  0.00%)   124645.00 ( -3.91%)
Min      Rsec-296   131203.00 (  0.00%)   124085.00 ( -5.43%)
Min      Rsec-327   136167.00 (  0.00%)    93782.00 (-31.13%)
Min      Rsec-358   132593.00 (  0.00%)   126162.00 ( -4.85%)
Min      Rsec-389   133791.00 (  0.00%)   125713.00 ( -6.04%)
Min      Rsec-420   132244.00 (  0.00%)   125662.00 ( -4.98%)
Min      Rsec-451   130741.00 (  0.00%)   131577.00 (  0.64%)
Min      Rsec-482   132991.00 (  0.00%)   133038.00 (  0.04%)
Min      Rsec-513   135247.00 (  0.00%)   132752.00 ( -1.84%)
Min      Rsec-544   133541.00 (  0.00%)   138052.00 (  3.38%)
Min      Rsec-575   134361.00 (  0.00%)   140407.00 (  4.50%)
Min      Rsec-606   136566.00 (  0.00%)   140320.00 (  2.75%)
Min      Rsec-637   136596.00 (  0.00%)    99349.00 (-27.27%)
Min      Rsec-640   101422.00 (  0.00%)    99561.00 ( -1.83%)
Hmean    Rsec-1      30824.32 (  0.00%)    28676.70 ( -6.97%)
Hmean    Rsec-4      64157.06 (  0.00%)    62294.92 ( -2.90%)
Hmean    Rsec-7      65651.01 (  0.00%)    69718.38 (  6.20%)
Hmean    Rsec-12     78873.91 (  0.00%)    91860.80 ( 16.47%)
Hmean    Rsec-21     86468.13 (  0.00%)    96639.75 ( 11.76%)
Hmean    Rsec-30     95530.97 (  0.00%)   103998.21 (  8.86%)
Hmean    Rsec-48    103374.48 (  0.00%)   108060.90 (  4.53%)
Hmean    Rsec-79    110468.40 (  0.00%)   111625.07 (  1.05%)
Hmean    Rsec-110   117068.12 (  0.00%)   117277.05 (  0.18%)
Hmean    Rsec-141   122303.78 (  0.00%)   123704.79 (  1.15%)
Hmean    Rsec-172   129919.04 (  0.00%)   127485.39 ( -1.87%)
Hmean    Rsec-203   129848.20 (  0.00%)   126836.53 ( -2.32%)
Hmean    Rsec-234   131271.19 (  0.00%)   126981.96 ( -3.27%)
Hmean    Rsec-265   130786.79 (  0.00%)   126195.37 ( -3.51%)
Hmean    Rsec-296   136679.24 (  0.00%)   125519.14 ( -8.17%)
Hmean    Rsec-327   136987.94 (  0.00%)   118013.15 (-13.85%)
Hmean    Rsec-358   134069.52 (  0.00%)   126610.36 ( -5.56%)
Hmean    Rsec-389   134492.50 (  0.00%)   126879.43 ( -5.66%)
Hmean    Rsec-420   134001.91 (  0.00%)   127656.60 ( -4.74%)
Hmean    Rsec-451   133772.89 (  0.00%)   133757.64 ( -0.01%)
Hmean    Rsec-482   135542.90 (  0.00%)   135620.98 (  0.06%)
Hmean    Rsec-513   137292.43 (  0.00%)   135231.99 ( -1.50%)
Hmean    Rsec-544   135299.06 (  0.00%)   141228.12 (  4.38%)
Hmean    Rsec-575   137473.02 (  0.00%)   140835.74 (  2.45%)
Hmean    Rsec-606   137456.90 (  0.00%)   143092.13 (  4.10%)
Hmean    Rsec-637   137146.14 (  0.00%)   129751.36 ( -5.39%)
Hmean    Rsec-640   131512.67 (  0.00%)   129329.67 ( -1.66%)
Stddev   Rsec-1        144.49 (  0.00%)     1292.15 (-794.30%)
Stddev   Rsec-4       4005.88 (  0.00%)     8292.35 (-107.00%)
Stddev   Rsec-7        959.09 (  0.00%)     5545.25 (-478.18%)
Stddev   Rsec-12      2728.12 (  0.00%)     7819.40 (-186.62%)
Stddev   Rsec-21      5449.55 (  0.00%)     8175.21 (-50.02%)
Stddev   Rsec-30      2577.87 (  0.00%)     4946.96 (-91.90%)
Stddev   Rsec-48      4972.04 (  0.00%)     4285.92 ( 13.80%)
Stddev   Rsec-79      1860.85 (  0.00%)     3294.02 (-77.02%)
Stddev   Rsec-110     2042.24 (  0.00%)     1385.94 ( 32.14%)
Stddev   Rsec-141     2275.70 (  0.00%)     2258.88 (  0.74%)
Stddev   Rsec-172     1003.21 (  0.00%)      679.57 ( 32.26%)
Stddev   Rsec-203      623.13 (  0.00%)     1220.15 (-95.81%)
Stddev   Rsec-234      723.22 (  0.00%)     1138.08 (-57.36%)
Stddev   Rsec-265      742.86 (  0.00%)     1321.18 (-77.85%)
Stddev   Rsec-296     2939.87 (  0.00%)      993.39 ( 66.21%)
Stddev   Rsec-327      604.06 (  0.00%)    12956.36 (-2044.87%)
Stddev   Rsec-358     1390.12 (  0.00%)      285.62 ( 79.45%)
Stddev   Rsec-389      847.67 (  0.00%)      855.57 ( -0.93%)
Stddev   Rsec-420     1151.99 (  0.00%)     1619.63 (-40.59%)
Stddev   Rsec-451     1570.06 (  0.00%)     1573.54 ( -0.22%)
Stddev   Rsec-482     1509.33 (  0.00%)     1984.46 (-31.48%)
Stddev   Rsec-513     1480.83 (  0.00%)     1873.63 (-26.53%)
Stddev   Rsec-544     1470.26 (  0.00%)     3914.73 (-166.26%)
Stddev   Rsec-575     1898.92 (  0.00%)      613.86 ( 67.67%)
Stddev   Rsec-606      694.98 (  0.00%)     2642.72 (-280.26%)
Stddev   Rsec-637      670.80 (  0.00%)    16535.67 (-2365.07%)
Stddev   Rsec-640    16352.20 (  0.00%)    16160.95 (  1.17%)
CoeffVar Rsec-1          0.47 (  0.00%)        4.50 (-859.37%)
CoeffVar Rsec-4          6.22 (  0.00%)       13.04 (-109.75%)
CoeffVar Rsec-7          1.46 (  0.00%)        7.90 (-441.04%)
CoeffVar Rsec-12         3.45 (  0.00%)        8.45 (-144.72%)
CoeffVar Rsec-21         6.28 (  0.00%)        8.40 (-33.83%)
CoeffVar Rsec-30         2.70 (  0.00%)        4.75 (-76.00%)
CoeffVar Rsec-48         4.80 (  0.00%)        3.96 ( 17.49%)
CoeffVar Rsec-79         1.68 (  0.00%)        2.95 (-75.08%)
CoeffVar Rsec-110        1.74 (  0.00%)        1.18 ( 32.25%)
CoeffVar Rsec-141        1.86 (  0.00%)        1.83 (  1.86%)
CoeffVar Rsec-172        0.77 (  0.00%)        0.53 ( 30.97%)
CoeffVar Rsec-203        0.48 (  0.00%)        0.96 (-100.45%)
CoeffVar Rsec-234        0.55 (  0.00%)        0.90 (-62.67%)
CoeffVar Rsec-265        0.57 (  0.00%)        1.05 (-84.31%)
CoeffVar Rsec-296        2.15 (  0.00%)        0.79 ( 63.19%)
CoeffVar Rsec-327        0.44 (  0.00%)       10.83 (-2354.96%)
CoeffVar Rsec-358        1.04 (  0.00%)        0.23 ( 78.24%)
CoeffVar Rsec-389        0.63 (  0.00%)        0.67 ( -6.99%)
CoeffVar Rsec-420        0.86 (  0.00%)        1.27 (-47.57%)
CoeffVar Rsec-451        1.17 (  0.00%)        1.18 ( -0.23%)
CoeffVar Rsec-482        1.11 (  0.00%)        1.46 (-31.39%)
CoeffVar Rsec-513        1.08 (  0.00%)        1.39 (-28.44%)
CoeffVar Rsec-544        1.09 (  0.00%)        2.77 (-154.92%)
CoeffVar Rsec-575        1.38 (  0.00%)        0.44 ( 68.44%)
CoeffVar Rsec-606        0.51 (  0.00%)        1.85 (-265.17%)
CoeffVar Rsec-637        0.49 (  0.00%)       12.50 (-2455.70%)
CoeffVar Rsec-640       12.21 (  0.00%)       12.27 ( -0.48%)
Max      Rsec-1      31000.00 (  0.00%)    30276.00 ( -2.34%)
Max      Rsec-4      69454.00 (  0.00%)    71739.00 (  3.29%)
Max      Rsec-7      67182.00 (  0.00%)    75573.00 ( 12.49%)
Max      Rsec-12     82739.00 (  0.00%)   106341.00 ( 28.53%)
Max      Rsec-21     95156.00 (  0.00%)   110486.00 ( 16.11%)
Max      Rsec-30     98859.00 (  0.00%)   109381.00 ( 10.64%)
Max      Rsec-48    113061.00 (  0.00%)   114346.00 (  1.14%)
Max      Rsec-79    113578.00 (  0.00%)   117539.00 (  3.49%)
Max      Rsec-110   119618.00 (  0.00%)   118806.00 ( -0.68%)
Max      Rsec-141   125009.00 (  0.00%)   126417.00 (  1.13%)
Max      Rsec-172   131250.00 (  0.00%)   128709.00 ( -1.94%)
Max      Rsec-203   130718.00 (  0.00%)   128025.00 ( -2.06%)
Max      Rsec-234   131856.00 (  0.00%)   128528.00 ( -2.52%)
Max      Rsec-265   132036.00 (  0.00%)   128059.00 ( -3.01%)
Max      Rsec-296   139572.00 (  0.00%)   126819.00 ( -9.14%)
Max      Rsec-327   138043.00 (  0.00%)   126581.00 ( -8.30%)
Max      Rsec-358   136616.00 (  0.00%)   126986.00 ( -7.05%)
Max      Rsec-389   136122.00 (  0.00%)   128050.00 ( -5.93%)
Max      Rsec-420   135873.00 (  0.00%)   129725.00 ( -4.52%)
Max      Rsec-451   134918.00 (  0.00%)   135687.00 (  0.57%)
Max      Rsec-482   137574.00 (  0.00%)   138546.00 (  0.71%)
Max      Rsec-513   139144.00 (  0.00%)   138358.00 ( -0.56%)
Max      Rsec-544   137415.00 (  0.00%)   148411.00 (  8.00%)
Max      Rsec-575   140015.00 (  0.00%)   142036.00 (  1.44%)
Max      Rsec-606   138658.00 (  0.00%)   148103.00 (  6.81%)
Max      Rsec-637   138429.00 (  0.00%)   143293.00 (  3.51%)
Max      Rsec-640   144351.00 (  0.00%)   141507.00 ( -1.97%)

ebizzy Per-thread
                                        4.3.0                       4.3.0
                               13672-gc669d35              13708-g8e488c2
Min      Rsec-1      30631.00 (  0.00%)    27088.00 (-11.57%)
Min      Rsec-4      12735.00 (  0.00%)    11127.00 (-12.63%)
Min      Rsec-7       7954.00 (  0.00%)     7116.00 (-10.54%)
Min      Rsec-12      4721.00 (  0.00%)     5315.00 ( 12.58%)
Min      Rsec-21      2410.00 (  0.00%)     2304.00 ( -4.40%)
Min      Rsec-30      1931.00 (  0.00%)     2093.00 (  8.39%)
Min      Rsec-48      1451.00 (  0.00%)     1403.00 ( -3.31%)
Min      Rsec-79       821.00 (  0.00%)      715.00 (-12.91%)
Min      Rsec-110      647.00 (  0.00%)      668.00 (  3.25%)
Min      Rsec-141      477.00 (  0.00%)      495.00 (  3.77%)
Min      Rsec-172      463.00 (  0.00%)      452.00 ( -2.38%)
Min      Rsec-203      367.00 (  0.00%)      314.00 (-14.44%)
Min      Rsec-234      304.00 (  0.00%)      290.00 ( -4.61%)
Min      Rsec-265      260.00 (  0.00%)      244.00 ( -6.15%)
Min      Rsec-296      211.00 (  0.00%)      205.00 ( -2.84%)
Min      Rsec-327      185.00 (  0.00%)      152.00 (-17.84%)
Min      Rsec-358      170.00 (  0.00%)      171.00 (  0.59%)
Min      Rsec-389      134.00 (  0.00%)      139.00 (  3.73%)
Min      Rsec-420      153.00 (  0.00%)      159.00 (  3.92%)
Min      Rsec-451      133.00 (  0.00%)      135.00 (  1.50%)
Min      Rsec-482      127.00 (  0.00%)      127.00 (  0.00%)
Min      Rsec-513      120.00 (  0.00%)      130.00 (  8.33%)
Min      Rsec-544      107.00 (  0.00%)      101.00 ( -5.61%)
Min      Rsec-575       94.00 (  0.00%)      114.00 ( 21.28%)
Min      Rsec-606       94.00 (  0.00%)      127.00 ( 35.11%)
Min      Rsec-637      101.00 (  0.00%)      101.00 (  0.00%)
Min      Rsec-640       81.00 (  0.00%)       90.00 ( 11.11%)
Hmean    Rsec-1      30824.32 (  0.00%)    28676.70 ( -6.97%)
Hmean    Rsec-4      15947.39 (  0.00%)    15456.86 ( -3.08%)
Hmean    Rsec-7       9303.67 (  0.00%)     9820.37 (  5.55%)
Hmean    Rsec-12      6388.57 (  0.00%)     7416.20 ( 16.09%)
Hmean    Rsec-21      3321.63 (  0.00%)     3634.83 (  9.43%)
Hmean    Rsec-30      2815.97 (  0.00%)     3019.42 (  7.22%)
Hmean    Rsec-48      1981.55 (  0.00%)     1982.90 (  0.07%)
Hmean    Rsec-79      1276.93 (  0.00%)     1287.34 (  0.82%)
Hmean    Rsec-110      956.47 (  0.00%)      985.88 (  3.08%)
Hmean    Rsec-141      783.13 (  0.00%)      783.22 (  0.01%)
Hmean    Rsec-172      689.92 (  0.00%)      667.13 ( -3.30%)
Hmean    Rsec-203      587.77 (  0.00%)      556.88 ( -5.26%)
Hmean    Rsec-234      506.71 (  0.00%)      504.36 ( -0.46%)
Hmean    Rsec-265      446.66 (  0.00%)      432.97 ( -3.06%)
Hmean    Rsec-296      412.77 (  0.00%)      378.81 ( -8.23%)
Hmean    Rsec-327      359.13 (  0.00%)      315.30 (-12.20%)
Hmean    Rsec-358      335.46 (  0.00%)      312.77 ( -6.76%)
Hmean    Rsec-389      291.33 (  0.00%)      281.59 ( -3.34%)
Hmean    Rsec-420      289.74 (  0.00%)      278.40 ( -3.91%)
Hmean    Rsec-451      255.18 (  0.00%)      263.41 (  3.22%)
Hmean    Rsec-482      241.82 (  0.00%)      253.38 (  4.78%)
Hmean    Rsec-513      237.84 (  0.00%)      233.55 ( -1.81%)
Hmean    Rsec-544      219.99 (  0.00%)      216.96 ( -1.38%)
Hmean    Rsec-575      205.77 (  0.00%)      216.15 (  5.04%)
Hmean    Rsec-606      199.08 (  0.00%)      215.75 (  8.37%)
Hmean    Rsec-637      183.93 (  0.00%)      190.02 (  3.31%)
Hmean    Rsec-640      183.38 (  0.00%)      184.17 (  0.43%)
Stddev   Rsec-1        144.49 (  0.00%)     1292.15 (794.30%)
Stddev   Rsec-4       1525.43 (  0.00%)     2515.03 ( 64.87%)
Stddev   Rsec-7        853.17 (  0.00%)     1373.82 ( 61.02%)
Stddev   Rsec-12      1178.82 (  0.00%)     1543.19 ( 30.91%)
Stddev   Rsec-21      2459.94 (  0.00%)     2892.79 ( 17.60%)
Stddev   Rsec-30      1585.28 (  0.00%)     1903.96 ( 20.10%)
Stddev   Rsec-48       972.90 (  0.00%)     1219.25 ( 25.32%)
Stddev   Rsec-79       629.60 (  0.00%)      637.97 (  1.33%)
Stddev   Rsec-110      529.71 (  0.00%)      417.64 (-21.16%)
Stddev   Rsec-141      421.55 (  0.00%)      452.80 (  7.41%)
Stddev   Rsec-172      341.05 (  0.00%)      375.21 ( 10.02%)
Stddev   Rsec-203      249.78 (  0.00%)      281.78 ( 12.81%)
Stddev   Rsec-234      244.43 (  0.00%)      193.14 (-20.98%)
Stddev   Rsec-265      186.43 (  0.00%)      196.87 (  5.60%)
Stddev   Rsec-296      192.08 (  0.00%)      184.98 ( -3.70%)
Stddev   Rsec-327      186.84 (  0.00%)      161.37 (-13.63%)
Stddev   Rsec-358      150.51 (  0.00%)      147.22 ( -2.19%)
Stddev   Rsec-389      163.74 (  0.00%)      139.43 (-14.85%)
Stddev   Rsec-420      123.57 (  0.00%)      112.75 ( -8.76%)
Stddev   Rsec-451      130.29 (  0.00%)      127.71 ( -1.98%)
Stddev   Rsec-482      130.08 (  0.00%)      109.39 (-15.90%)
Stddev   Rsec-513      109.04 (  0.00%)      105.78 ( -2.99%)
Stddev   Rsec-544      100.31 (  0.00%)      126.31 ( 25.92%)
Stddev   Rsec-575      102.79 (  0.00%)       98.62 ( -4.06%)
Stddev   Rsec-606       93.57 (  0.00%)       82.75 (-11.57%)
Stddev   Rsec-637      102.32 (  0.00%)       67.40 (-34.13%)
Stddev   Rsec-640       78.48 (  0.00%)       89.02 ( 13.43%)
CoeffVar Rsec-1          0.47 (  0.00%)        4.50 (-859.37%)
CoeffVar Rsec-4          9.47 (  0.00%)       15.82 (-67.06%)
CoeffVar Rsec-7          9.10 (  0.00%)       13.71 (-50.68%)
CoeffVar Rsec-12        17.91 (  0.00%)       20.02 (-11.77%)
CoeffVar Rsec-21        59.52 (  0.00%)       62.44 ( -4.91%)
CoeffVar Rsec-30        49.75 (  0.00%)       54.80 (-10.15%)
CoeffVar Rsec-48        45.09 (  0.00%)       54.08 (-19.96%)
CoeffVar Rsec-79        45.03 (  0.00%)       45.13 ( -0.22%)
CoeffVar Rsec-110       49.78 (  0.00%)       39.18 ( 21.28%)
CoeffVar Rsec-141       48.61 (  0.00%)       51.62 ( -6.20%)
CoeffVar Rsec-172       45.18 (  0.00%)       50.65 (-12.12%)
CoeffVar Rsec-203       39.08 (  0.00%)       45.13 (-15.48%)
CoeffVar Rsec-234       43.61 (  0.00%)       35.62 ( 18.32%)
CoeffVar Rsec-265       37.81 (  0.00%)       41.38 ( -9.44%)
CoeffVar Rsec-296       41.62 (  0.00%)       43.67 ( -4.92%)
CoeffVar Rsec-327       44.65 (  0.00%)       44.15 (  1.13%)
CoeffVar Rsec-358       40.24 (  0.00%)       41.68 ( -3.59%)
CoeffVar Rsec-389       47.42 (  0.00%)       42.81 (  9.73%)
CoeffVar Rsec-420       38.79 (  0.00%)       37.15 (  4.23%)
CoeffVar Rsec-451       43.99 (  0.00%)       43.13 (  1.96%)
CoeffVar Rsec-482       46.33 (  0.00%)       38.94 ( 15.96%)
CoeffVar Rsec-513       40.81 (  0.00%)       40.19 (  1.52%)
CoeffVar Rsec-544       40.41 (  0.00%)       48.71 (-20.54%)
CoeffVar Rsec-575       43.07 (  0.00%)       40.34 (  6.33%)
CoeffVar Rsec-606       41.34 (  0.00%)       35.10 ( 15.08%)
CoeffVar Rsec-637       47.63 (  0.00%)       32.53 ( 31.70%)
CoeffVar Rsec-640       37.58 (  0.00%)       43.34 (-15.33%)
Max      Rsec-1      31000.00 (  0.00%)    30276.00 ( -2.34%)
Max      Rsec-4      18406.00 (  0.00%)    19844.00 (  7.81%)
Max      Rsec-7      11200.00 (  0.00%)    12913.00 ( 15.29%)
Max      Rsec-12     10612.00 (  0.00%)    11465.00 (  8.04%)
Max      Rsec-21     15254.00 (  0.00%)    15490.00 (  1.55%)
Max      Rsec-30     10529.00 (  0.00%)    11822.00 ( 12.28%)
Max      Rsec-48      8134.00 (  0.00%)     8236.00 (  1.25%)
Max      Rsec-79      5105.00 (  0.00%)     5945.00 ( 16.45%)
Max      Rsec-110     4728.00 (  0.00%)     4371.00 ( -7.55%)
Max      Rsec-141     3628.00 (  0.00%)     3997.00 ( 10.17%)
Max      Rsec-172     3261.00 (  0.00%)     3138.00 ( -3.77%)
Max      Rsec-203     2453.00 (  0.00%)     2995.00 ( 22.10%)
Max      Rsec-234     2363.00 (  0.00%)     2194.00 ( -7.15%)
Max      Rsec-265     2038.00 (  0.00%)     2235.00 (  9.67%)
Max      Rsec-296     2174.00 (  0.00%)     1942.00 (-10.67%)
Max      Rsec-327     1791.00 (  0.00%)     1826.00 (  1.95%)
Max      Rsec-358     1389.00 (  0.00%)     1538.00 ( 10.73%)
Max      Rsec-389     1630.00 (  0.00%)     1273.00 (-21.90%)
Max      Rsec-420     1249.00 (  0.00%)     1047.00 (-16.17%)
Max      Rsec-451     1179.00 (  0.00%)     1316.00 ( 11.62%)
Max      Rsec-482     1187.00 (  0.00%)     1211.00 (  2.02%)
Max      Rsec-513     1257.00 (  0.00%)     1018.00 (-19.01%)
Max      Rsec-544     1139.00 (  0.00%)     1216.00 (  6.76%)
Max      Rsec-575     1089.00 (  0.00%)      912.00 (-16.25%)
Max      Rsec-606      903.00 (  0.00%)     1014.00 ( 12.29%)
Max      Rsec-637     1053.00 (  0.00%)      660.00 (-37.32%)
Max      Rsec-640      749.00 (  0.00%)     1081.00 ( 44.33%)

ebizzy Thread spread
                                          4.3.0                       4.3.0
                                 13672-gc669d35              13708-g8e488c2
Min      spread-1          0.00 (  0.00%)        0.00 (  0.00%)
Min      spread-4       1122.00 (  0.00%)     1464.00 (-30.48%)
Min      spread-7       1537.00 (  0.00%)     1949.00 (-26.81%)
Min      spread-12      3466.00 (  0.00%)     3667.00 ( -5.80%)
Min      spread-21      6507.00 (  0.00%)     6406.00 (  1.55%)
Min      spread-30      5648.00 (  0.00%)     7543.00 (-33.55%)
Min      spread-48      3531.00 (  0.00%)     4244.00 (-20.19%)
Min      spread-79      2933.00 (  0.00%)     3184.00 ( -8.56%)
Min      spread-110     2341.00 (  0.00%)     1892.00 ( 19.18%)
Min      spread-141     2084.00 (  0.00%)     2641.00 (-26.73%)
Min      spread-172     1447.00 (  0.00%)     2001.00 (-38.29%)
Min      spread-203     1268.00 (  0.00%)     1686.00 (-32.97%)
Min      spread-234     1703.00 (  0.00%)     1157.00 ( 32.06%)
Min      spread-265     1385.00 (  0.00%)     1370.00 (  1.08%)
Min      spread-296     1139.00 (  0.00%)     1263.00 (-10.89%)
Min      spread-327     1259.00 (  0.00%)      328.00 ( 73.95%)
Min      spread-358      781.00 (  0.00%)     1002.00 (-28.30%)
Min      spread-389      746.00 (  0.00%)      767.00 ( -2.82%)
Min      spread-420      703.00 (  0.00%)      673.00 (  4.27%)
Min      spread-451      812.00 (  0.00%)      603.00 ( 25.74%)
Min      spread-482      530.00 (  0.00%)      685.00 (-29.25%)
Min      spread-513      564.00 (  0.00%)      456.00 ( 19.15%)
Min      spread-544      530.00 (  0.00%)      664.00 (-25.28%)
Min      spread-575      497.00 (  0.00%)      443.00 ( 10.87%)
Min      spread-606      372.00 (  0.00%)      460.00 (-23.66%)
Min      spread-637      377.00 (  0.00%)      185.00 ( 50.93%)
Min      spread-640      295.00 (  0.00%)       82.00 ( 72.20%)
Hmean    spread-1          0.00 (  0.00%)        0.00 (  0.00%)
Hmean    spread-4       2198.84 (  0.00%)     2371.33 ( -7.84%)
Hmean    spread-7       2165.67 (  0.00%)     2771.13 (-27.96%)
Hmean    spread-12      4198.82 (  0.00%)     4507.36 ( -7.35%)
Hmean    spread-21      7559.98 (  0.00%)     8509.79 (-12.56%)
Hmean    spread-30      6617.29 (  0.00%)     8461.26 (-27.87%)
Hmean    spread-48      4726.30 (  0.00%)     5794.29 (-22.60%)
Hmean    spread-79      3596.75 (  0.00%)     3913.30 ( -8.80%)
Hmean    spread-110     3210.81 (  0.00%)     2530.22 ( 21.20%)
Hmean    spread-141     2642.11 (  0.00%)     2904.53 ( -9.93%)
Hmean    spread-172     2147.18 (  0.00%)     2374.37 (-10.58%)
Hmean    spread-203     1778.54 (  0.00%)     2008.80 (-12.95%)
Hmean    spread-234     1843.86 (  0.00%)     1385.32 ( 24.87%)
Hmean    spread-265     1516.18 (  0.00%)     1641.22 ( -8.25%)
Hmean    spread-296     1396.98 (  0.00%)     1441.88 ( -3.21%)
Hmean    spread-327     1418.21 (  0.00%)      789.92 ( 44.30%)
Hmean    spread-358      940.59 (  0.00%)     1187.35 (-26.23%)
Hmean    spread-389     1050.33 (  0.00%)      922.54 ( 12.17%)
Hmean    spread-420      837.76 (  0.00%)      772.29 (  7.82%)
Hmean    spread-451      874.68 (  0.00%)      821.89 (  6.04%)
Hmean    spread-482      755.71 (  0.00%)      782.04 ( -3.49%)
Hmean    spread-513      716.35 (  0.00%)      682.52 (  4.72%)
Hmean    spread-544      659.82 (  0.00%)      807.36 (-22.36%)
Hmean    spread-575      667.82 (  0.00%)      584.47 ( 12.48%)
Hmean    spread-606      547.04 (  0.00%)      556.28 ( -1.69%)
Hmean    spread-637      571.10 (  0.00%)      340.03 ( 40.46%)
Hmean    spread-640      413.62 (  0.00%)      247.08 ( 40.26%)
Stddev   spread-1          0.00 (  0.00%)        0.00 (  0.00%)
Stddev   spread-4       1055.03 (  0.00%)     1918.21 (-81.81%)
Stddev   spread-7        675.30 (  0.00%)      998.13 (-47.80%)
Stddev   spread-12       645.46 (  0.00%)      726.78 (-12.60%)
Stddev   spread-21      2351.57 (  0.00%)     2788.71 (-18.59%)
Stddev   spread-30      1044.36 (  0.00%)      717.65 ( 31.28%)
Stddev   spread-48      1259.45 (  0.00%)      912.70 ( 27.53%)
Stddev   spread-79       445.51 (  0.00%)      833.11 (-87.00%)
Stddev   spread-110      595.82 (  0.00%)      624.63 ( -4.84%)
Stddev   spread-141      370.68 (  0.00%)      285.28 ( 23.04%)
Stddev   spread-172      472.11 (  0.00%)      250.80 ( 46.88%)
Stddev   spread-203      288.31 (  0.00%)      393.40 (-36.45%)
Stddev   spread-234      130.86 (  0.00%)      329.63 (-151.90%)
Stddev   spread-265      129.24 (  0.00%)      196.98 (-52.41%)
Stddev   spread-296      292.03 (  0.00%)      157.32 ( 46.13%)
Stddev   spread-327      136.07 (  0.00%)      443.66 (-226.05%)
Stddev   spread-358      168.12 (  0.00%)      116.22 ( 30.87%)
Stddev   spread-389      273.41 (  0.00%)      120.46 ( 55.94%)
Stddev   spread-420      124.12 (  0.00%)       89.51 ( 27.88%)
Stddev   spread-451       80.65 (  0.00%)      220.33 (-173.18%)
Stddev   spread-482      211.68 (  0.00%)      146.76 ( 30.67%)
Stddev   spread-513      202.23 (  0.00%)      156.38 ( 22.67%)
Stddev   spread-544      183.05 (  0.00%)      149.90 ( 18.11%)
Stddev   spread-575      170.16 (  0.00%)      134.70 ( 20.84%)
Stddev   spread-606      145.56 (  0.00%)      161.55 (-10.99%)
Stddev   spread-637      240.03 (  0.00%)      109.43 ( 54.41%)
Stddev   spread-640      119.87 (  0.00%)      295.05 (-146.15%)
CoeffVar spread-1          0.00 (  0.00%)        0.00 (  0.00%)
CoeffVar spread-4         39.42 (  0.00%)       60.93 ( 54.57%)
CoeffVar spread-7         28.47 (  0.00%)       32.47 ( 14.07%)
CoeffVar spread-12        15.04 (  0.00%)       15.75 (  4.74%)
CoeffVar spread-21        29.16 (  0.00%)       29.98 (  2.80%)
CoeffVar spread-30        15.43 (  0.00%)        8.42 (-45.42%)
CoeffVar spread-48        25.02 (  0.00%)       15.30 (-38.85%)
CoeffVar spread-79        12.19 (  0.00%)       20.43 ( 67.55%)
CoeffVar spread-110       17.88 (  0.00%)       23.42 ( 30.99%)
CoeffVar spread-141       13.74 (  0.00%)        9.73 (-29.15%)
CoeffVar spread-172       20.83 (  0.00%)       10.44 (-49.89%)
CoeffVar spread-203       15.70 (  0.00%)       18.94 ( 20.66%)
CoeffVar spread-234        7.06 (  0.00%)       22.68 (221.11%)
CoeffVar spread-265        8.47 (  0.00%)       11.83 ( 39.72%)
CoeffVar spread-296       20.16 (  0.00%)       10.79 (-46.46%)
CoeffVar spread-327        9.51 (  0.00%)       41.00 (331.14%)
CoeffVar spread-358       17.36 (  0.00%)        9.69 (-44.18%)
CoeffVar spread-389       24.42 (  0.00%)       12.84 (-47.41%)
CoeffVar spread-420       14.52 (  0.00%)       11.43 (-21.27%)
CoeffVar spread-451        9.15 (  0.00%)       25.12 (174.49%)
CoeffVar spread-482       26.01 (  0.00%)       18.24 (-29.86%)
CoeffVar spread-513       26.62 (  0.00%)       21.60 (-18.85%)
CoeffVar spread-544       26.14 (  0.00%)       18.03 (-31.02%)
CoeffVar spread-575       24.10 (  0.00%)       21.88 ( -9.21%)
CoeffVar spread-606       24.89 (  0.00%)       27.30 (  9.67%)
CoeffVar spread-637       36.24 (  0.00%)       28.41 (-21.60%)
CoeffVar spread-640       26.97 (  0.00%)       62.12 (130.29%)
Max      spread-1          0.00 (  0.00%)        0.00 (  0.00%)
Max      spread-4       4390.00 (  0.00%)     6802.00 (-54.94%)
Max      spread-7       3165.00 (  0.00%)     4721.00 (-49.16%)
Max      spread-12      5377.00 (  0.00%)     5913.00 ( -9.97%)
Max      spread-21     12629.00 (  0.00%)    12796.00 ( -1.32%)
Max      spread-30      8385.00 (  0.00%)     9572.00 (-14.16%)
Max      spread-48      6557.00 (  0.00%)     6670.00 ( -1.72%)
Max      spread-79      4169.00 (  0.00%)     5230.00 (-25.45%)
Max      spread-110     3997.00 (  0.00%)     3688.00 (  7.73%)
Max      spread-141     3151.00 (  0.00%)     3416.00 ( -8.41%)
Max      spread-172     2798.00 (  0.00%)     2686.00 (  4.00%)
Max      spread-203     2061.00 (  0.00%)     2681.00 (-30.08%)
Max      spread-234     2049.00 (  0.00%)     1904.00 (  7.08%)
Max      spread-265     1762.00 (  0.00%)     1952.00 (-10.78%)
Max      spread-296     1963.00 (  0.00%)     1737.00 ( 11.51%)
Max      spread-327     1592.00 (  0.00%)     1670.00 ( -4.90%)
Max      spread-358     1197.00 (  0.00%)     1366.00 (-14.12%)
Max      spread-389     1486.00 (  0.00%)     1116.00 ( 24.90%)
Max      spread-420     1067.00 (  0.00%)      879.00 ( 17.62%)
Max      spread-451     1033.00 (  0.00%)     1181.00 (-14.33%)
Max      spread-482     1060.00 (  0.00%)     1084.00 ( -2.26%)
Max      spread-513     1137.00 (  0.00%)      885.00 ( 22.16%)
Max      spread-544     1032.00 (  0.00%)     1103.00 ( -6.88%)
Max      spread-575      995.00 (  0.00%)      789.00 ( 20.70%)
Max      spread-606      809.00 (  0.00%)      887.00 ( -9.64%)
Max      spread-637      951.00 (  0.00%)      518.00 ( 45.53%)
Max      spread-640      625.00 (  0.00%)      991.00 (-58.56%)

               4.3.0       4.3.0
        13672-gc669d3513708-g8e488c2
User        69638.44    67856.26
System     403739.55   405630.82
Elapsed      4055.69     4058.90

                                 4.3.0       4.3.0
                          13672-gc669d3513708-g8e488c2
Minor Faults                2846674710  2831764228
Major Faults                         0           2
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                  2846385041  2831501075
DMA32 allocs                         0           0
Normal allocs                        0           0
Movable allocs                       0           0
Direct pages scanned                 0           0
Kswapd pages scanned                 0           0
Kswapd pages reclaimed               0           0
Direct pages reclaimed               0           0
Kswapd efficiency                 100%        100%
Kswapd velocity                  0.000       0.000
Direct efficiency                 100%        100%
Direct velocity                  0.000       0.000
Percentage direct scans             0%          0%
Zone normal velocity             0.000       0.000
Zone dma32 velocity              0.000       0.000
Zone dma velocity                0.000       0.000
Page writes by reclaim           0.000       0.000
Page writes file                     0           0
Page writes anon                     0           0
Page reclaim immediate               0           0
Sector Reads                       444         956
Sector Writes                    14220       14232
Page rescued immediate               0           0
Slabs scanned                        0           0
Direct inode steals                  0           0
Kswapd inode steals                  0           0
Kswapd skipped wait                  0           0
THP fault alloc                     39          70
THP collapse alloc                   3           3
THP splits                          40          69
THP fault fallback                 209         246
THP collapse fail                    0           0
Compaction stalls                    0           0
Compaction success                   0           0
Compaction failures                  0           0
Page migrate success             23141       24465
Page migrate failure                 0           0
Compaction pages isolated            0           0
Compaction migrate scanned           0           0
Compaction free scanned              0           0
Compaction cost                     24          25
NUMA alloc hit              2846238192  2831325148
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local            1507528120  1466361674
NUMA base PTE updates           572055      572474
NUMA huge PMD updates                0           0
NUMA page range updates         572055      572474
NUMA hint faults                459654      460212
NUMA hint local faults          229186      224799
NUMA hint local percent             49          48
NUMA pages migrated              23141       24465
AutoNUMA cost                    2302%       2305%

-------------- 64k hash pte powernv config start--------------------




Aneesh Kumar K.V (35):
  powerpc/mm: move pte headers to book3s directory
  powerpc/mm: move pte headers to book3s directory (part 2)
  powerpc/mm: make a separate copy for book3s
  powerpc/mm: make a separate copy for book3s (part 2)
  powerpc/mm: Move hash specific pte width and other defines to book3s
  powerpc/mm: Delete booke bits from book3s
  powerpc/mm: Don't have generic headers introduce functions touching
    pte bits
  powerpc/mm: Drop pte-common.h from BOOK3S 64
  powerpc/mm: Don't use pte_val as lvalue
  powerpc/mm: Don't use pmd_val,pud_val and pgd_val as lvalue
  powerpc/mm: Move hash64 PTE bits from book3s/64/pgtable.h to hash.h
  powerpc/mm: Move PTE bits from generic functions to hash64 functions.
  powerpc/booke: Move nohash headers (part 1)
  powerpc/booke: Move nohash headers (part 2)
  powerpc/booke: Move nohash headers (part 3)
  powerpc/booke: Move nohash headers (part 4)
  powerpc/booke: Move nohash headers (part 5)
  powerpc/mm: Convert 4k hash insert to C
  powerpc/mm: Remove the dependency on pte bit position in asm code
  powerpc/mm: Don't track subpage valid bit in pte_t
  powerpc/mm: Remove pte_val usage for the second half of pgtable_t
  powerpc/mm: Increase the width of #define
  powerpc/mm: Convert __hash_page_64K to C
  powerpc/mm: Convert 4k insert from asm to C
  powerpc/mm: Add helper for converting pte bit to hpte bits
  powerpc/mm: Move WIMG update to helper.
  powerpc/mm: Move hugetlb related headers
  powerpc/mm: Move THP headers around
  powerpc/mm: Add a _PAGE_PTE bit
  powerpc/mm: Don't hardcode page table size
  powerpc/mm: Don't hardcode the hash pte slot shift
  powerpc/nohash: Update 64K nohash config to have 32 pte fragement
  powerpc/nohash: we don't use real_pte_t for nohash
  powerpc/mm: Use H_READ with H_READ_4
  powerpc/mm: Don't open code pgtable_t size

 .../include/asm/{pte-hash32.h => book3s/32/hash.h} |    6 +-
 .../asm/{pgtable-ppc32.h => book3s/32/pgtable.h}   |  288 ++++--
 .../{pgtable-ppc64-4k.h => book3s/64/hash-4k.h}    |   58 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  312 ++++++
 arch/powerpc/include/asm/book3s/64/hash.h          |  526 ++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  266 ++++++
 arch/powerpc/include/asm/book3s/pgtable.h          |   29 +
 arch/powerpc/include/asm/mmu-hash64.h              |    2 +-
 .../asm/{pgtable-ppc32.h => nohash/32/pgtable.h}   |   25 +-
 arch/powerpc/include/asm/{ => nohash/32}/pte-40x.h |    6 +-
 arch/powerpc/include/asm/{ => nohash/32}/pte-44x.h |    6 +-
 arch/powerpc/include/asm/{ => nohash/32}/pte-8xx.h |    6 +-
 .../include/asm/{ => nohash/32}/pte-fsl-booke.h    |    6 +-
 .../{pgtable-ppc64-4k.h => nohash/64/pgtable-4k.h} |   12 +-
 .../64/pgtable-64k.h}                              |   27 +-
 .../asm/{pgtable-ppc64.h => nohash/64/pgtable.h}   |  336 +------
 arch/powerpc/include/asm/{ => nohash}/pgtable.h    |  175 ++--
 arch/powerpc/include/asm/{ => nohash}/pte-book3e.h |    6 +-
 arch/powerpc/include/asm/page.h                    |   86 +-
 arch/powerpc/include/asm/pgalloc-32.h              |   34 +-
 arch/powerpc/include/asm/pgalloc-64.h              |   27 +-
 arch/powerpc/include/asm/pgtable.h                 |  200 +---
 arch/powerpc/include/asm/plpar_wrappers.h          |   17 +
 arch/powerpc/include/asm/pte-common.h              |    5 +
 arch/powerpc/include/asm/pte-hash64-4k.h           |   17 -
 arch/powerpc/include/asm/pte-hash64-64k.h          |  102 --
 arch/powerpc/include/asm/pte-hash64.h              |   54 --
 arch/powerpc/kernel/exceptions-64s.S               |   18 +-
 arch/powerpc/mm/40x_mmu.c                          |   10 +-
 arch/powerpc/mm/Makefile                           |    9 +-
 arch/powerpc/mm/hash64_4k.c                        |  123 +++
 arch/powerpc/mm/hash64_64k.c                       |  322 +++++++
 arch/powerpc/mm/hash_low_64.S                      | 1003 --------------------
 arch/powerpc/mm/hash_native_64.c                   |   10 +
 arch/powerpc/mm/hash_utils_64.c                    |  105 +-
 arch/powerpc/mm/hugepage-hash64.c                  |   22 +-
 arch/powerpc/mm/hugetlbpage-hash64.c               |   33 +-
 arch/powerpc/mm/hugetlbpage.c                      |   76 +-
 arch/powerpc/mm/init_64.c                          |    4 -
 arch/powerpc/mm/pgtable.c                          |    4 +
 arch/powerpc/mm/pgtable_64.c                       |   28 +-
 arch/powerpc/platforms/pseries/lpar.c              |   64 +-
 42 files changed, 2276 insertions(+), 2189 deletions(-)
 rename arch/powerpc/include/asm/{pte-hash32.h => book3s/32/hash.h} (93%)
 copy arch/powerpc/include/asm/{pgtable-ppc32.h => book3s/32/pgtable.h} (62%)
 copy arch/powerpc/include/asm/{pgtable-ppc64-4k.h => book3s/64/hash-4k.h} (71%)
 create mode 100644 arch/powerpc/include/asm/book3s/64/hash-64k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/hash.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable.h
 create mode 100644 arch/powerpc/include/asm/book3s/pgtable.h
 rename arch/powerpc/include/asm/{pgtable-ppc32.h => nohash/32/pgtable.h} (96%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-40x.h (95%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-44x.h (96%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-8xx.h (95%)
 rename arch/powerpc/include/asm/{ => nohash/32}/pte-fsl-booke.h (88%)
 rename arch/powerpc/include/asm/{pgtable-ppc64-4k.h => nohash/64/pgtable-4k.h} (92%)
 rename arch/powerpc/include/asm/{pgtable-ppc64-64k.h => nohash/64/pgtable-64k.h} (64%)
 rename arch/powerpc/include/asm/{pgtable-ppc64.h => nohash/64/pgtable.h} (51%)
 copy arch/powerpc/include/asm/{ => nohash}/pgtable.h (62%)
 rename arch/powerpc/include/asm/{ => nohash}/pte-book3e.h (95%)
 delete mode 100644 arch/powerpc/include/asm/pte-hash64-4k.h
 delete mode 100644 arch/powerpc/include/asm/pte-hash64-64k.h
 delete mode 100644 arch/powerpc/include/asm/pte-hash64.h
 create mode 100644 arch/powerpc/mm/hash64_4k.c
 create mode 100644 arch/powerpc/mm/hash64_64k.c
 delete mode 100644 arch/powerpc/mm/hash_low_64.S

-- 
2.5.0
