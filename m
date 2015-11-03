Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 301231A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 16:09:51 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 3 Nov 2015 15:09:49 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 892143578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 16:09:46 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA359WcD31719600
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 16:09:40 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA359DXe011719
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 16:09:14 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/7] Remove 4k subpage tracking with hash 64K config
In-Reply-To: <20151029030029.GA31681@fergus.ozlabs.ibm.com>
References: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20151029030029.GA31681@fergus.ozlabs.ibm.com>
Date: Tue, 03 Nov 2015 10:38:44 +0530
Message-ID: <87r3k7u0tf.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Wed, Oct 21, 2015 at 01:42:26AM +0530, Aneesh Kumar K.V wrote:
>> Hi,
>> 
>> This patch series is on top of the series posted at 
>> 
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135299.html
>> "[PATCH V4 00/31] powerpc/mm: Update page table format for book3s 64". In this
>> series we remove 4k subpage tracking with 64K config. Instead we do a hash
>> table lookup to get the slot information of 4k hash ptes. This also allow us
>> to remove real_pte_t. Side effect of the change is that a specific 4k slot
>> lookup can result in multiple H_READ hcalls. But that should only impact
>> when we are using 4K subpages which should be rare.
>> 
>> NOTE: I only tested this on systemsim. Wanted to get this out to get early
>> feedback.
>
> I tried this on a quad G5 and it seems to work just fine.  On a kernel
> compile test there was very little difference in speed - I measured
> about 0.4% slowdown but that may not be statistically significant.
> This was with 64k pages configured and THP enabled.
>

I also ran mmtest configs/config-global-dhp__pagealloc-performance
config with changes including this series. (ie, the changes tested
include two patch series, one which change the pte format and this
series). I am attaching the results below. I removed the pagealloc
performance numbers from that because it was giving me all 00 which I
assume is due to systemtap script issue.

We don't see any performance impact with the series and some of the
performance change is withing the variance of test run as indicated by
the numbers below. We do find less page fault and in some case better
autonuma numbers 


aim9
                                     ltctulc6a                   ltctulc6a
                      p1-0c526e14410c98f0ebc7a            p1-3754c8187ca17
Min      page_test  2233460.00 (  0.00%)  2231193.33 ( -0.10%)
Min      brk_test   4129380.41 (  0.00%)  4075466.67 ( -1.31%)
Min      exec_test     1703.00 (  0.00%)     1694.87 ( -0.48%)
Min      fork_test     4790.14 (  0.00%)     4723.52 ( -1.39%)
Hmean    page_test  2259304.39 (  0.00%)  2245792.45 ( -0.60%)
Hmean    brk_test   4177072.87 (  0.00%)  4109747.37 ( -1.61%)
Hmean    exec_test     1742.55 (  0.00%)     1734.06 ( -0.49%)
Hmean    fork_test     4827.06 (  0.00%)     4762.24 ( -1.34%)
Stddev   page_test    19396.37 (  0.00%)    10206.24 ( 47.38%)
Stddev   brk_test     62453.11 (  0.00%)    38772.18 ( 37.92%)
Stddev   exec_test       14.49 (  0.00%)       18.28 (-26.14%)
Stddev   fork_test       15.42 (  0.00%)       20.78 (-34.74%)
CoeffVar page_test        0.86 (  0.00%)        0.45 ( 47.06%)
CoeffVar brk_test         1.49 (  0.00%)        0.94 ( 36.89%)
CoeffVar exec_test        0.83 (  0.00%)        1.05 (-26.76%)
CoeffVar fork_test        0.32 (  0.00%)        0.44 (-36.58%)
Max      page_test  2295226.67 (  0.00%)  2270180.00 ( -1.09%)
Max      brk_test   4284000.00 (  0.00%)  4223933.33 ( -1.40%)
Max      exec_test     1766.33 (  0.00%)     1780.00 (  0.77%)
Max      fork_test     4860.19 (  0.00%)     4803.46 ( -1.17%)

           ltctulc6a   ltctulc6a
        p1-0c526e14410c98f0ebc7ap1-3754c8187ca17
User            0.10        0.10
System          0.13        0.13
Elapsed       723.11      722.38

                             ltctulc6a   ltctulc6a
                          p1-0c526e14410c98f0ebc7ap1-3754c8187ca17
Minor Faults                  83717865    82883370
Major Faults                       515          24
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                    38205119    37853837
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
Sector Reads                    202140        5240
Sector Writes                   251812       70376
Page rescued immediate               0           0
Slabs scanned                        0           0
Direct inode steals                  0           0
Kswapd inode steals                  0           0
Kswapd skipped wait                  0           0
THP fault alloc                      2           0
THP collapse alloc                   0           0
THP splits                           0           0
THP fault fallback                   0           0
THP collapse fail                    0           0
Compaction stalls                    0           0
Compaction success                   0           0
Compaction failures                  0           0
Page migrate success                 0           0
Page migrate failure                 0           0
Compaction pages isolated          256           0
Compaction migrate scanned           1           0
Compaction free scanned              1           0
Compaction cost                      0           0
NUMA alloc hit                38196832    37845473
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local              36493228    36049411
NUMA base PTE updates             2145         635
NUMA huge PMD updates                2           0
NUMA page range updates           3169         635
NUMA hint faults               1792212     1741239
NUMA hint local faults         1791770     1741024
NUMA hint local percent             99          99
NUMA pages migrated                  0           0
AutoNUMA cost                    8961%       8706%

vmr-stream

           ltctulc6a   ltctulc6a
        p1-0c526e14410c98f0ebc7ap1-3754c8187ca17
User            0.03        0.03
System          0.04        0.04
Elapsed         1.83        0.99

                             ltctulc6a   ltctulc6a
                          p1-0c526e14410c98f0ebc7ap1-3754c8187ca17
Minor Faults                     11412       11418
Major Faults                         7           7
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                        2234        2217
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
Sector Reads                      1252        1252
Sector Writes                        0           0
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
NUMA alloc hit                    2120        2024
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local                  2095        2024
NUMA base PTE updates                0           0
NUMA huge PMD updates                0           0
NUMA page range updates              0           0
NUMA hint faults                     0           0
NUMA hint local faults               0           0
NUMA hint local percent            100         100
NUMA pages migrated                  0           0
AutoNUMA cost                       0%          0%

pagealloc:

Summary only: Actual numbers where zero looks like systemtap issue

           ltctulc6a   ltctulc6a
        p1-0c526e14410c98f0ebc7ap1-3754c8187ca17
User         3677.27      169.81
System      42032.42     4152.07
Elapsed      1467.95     1646.51

                             ltctulc6a   ltctulc6a
                          p1-0c526e14410c98f0ebc7ap1-3754c8187ca17
Minor Faults                 372547509   368074849
Major Faults                        52          37
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                   369188137   367723176
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
Sector Reads                     72628        6404
Sector Writes                  1020234        7752
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
Page migrate success              1662         151
Page migrate failure                 0           0
Compaction pages isolated            0         768
Compaction migrate scanned           0           3
Compaction free scanned              0           3
Compaction cost                      1           0
NUMA alloc hit               369124470   367723093
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local             264649252   301731875
NUMA base PTE updates         25680332    61617492
NUMA huge PMD updates                0           0
NUMA page range updates       25680332    61617492
NUMA hint faults                 48887        6331
NUMA hint local faults           33608        4385
NUMA hint local percent             68          69
NUMA pages migrated               1662         151
AutoNUMA cost                     424%        462%

ebizzy Overall Throughput
                                    ltctulc6a                   ltctulc6a
                     p1-0c526e14410c98f0ebc7a            p1-3754c8187ca17
Min      Rsec-1      59019.00 (  0.00%)    59026.00 (  0.01%)
Min      Rsec-4     235973.00 (  0.00%)   238172.00 (  0.93%)
Min      Rsec-7     413325.00 (  0.00%)   417364.00 (  0.98%)
Min      Rsec-12    694883.00 (  0.00%)   715217.00 (  2.93%)
Min      Rsec-21    989740.00 (  0.00%)  1156059.00 ( 16.80%)
Min      Rsec-30   1086557.00 (  0.00%)  1185236.00 (  9.08%)
Min      Rsec-48   1378069.00 (  0.00%)  1194562.00 (-13.32%)
Min      Rsec-79   1368744.00 (  0.00%)  1192618.00 (-12.87%)
Min      Rsec-110  1378436.00 (  0.00%)  1193344.00 (-13.43%)
Min      Rsec-141  1342970.00 (  0.00%)  1192966.00 (-11.17%)
Min      Rsec-172  1347378.00 (  0.00%)  1189860.00 (-11.69%)
Min      Rsec-203  1335339.00 (  0.00%)  1188446.00 (-11.00%)
Min      Rsec-234  1334070.00 (  0.00%)  1185668.00 (-11.12%)
Min      Rsec-265  1330046.00 (  0.00%)  1179494.00 (-11.32%)
Min      Rsec-296  1308191.00 (  0.00%)  1173641.00 (-10.29%)
Min      Rsec-327  1308551.00 (  0.00%)  1170249.00 (-10.57%)
Min      Rsec-358  1245558.00 (  0.00%)  1164313.00 ( -6.52%)
Min      Rsec-389  1272398.00 (  0.00%)  1160014.00 ( -8.83%)
Min      Rsec-420  1215291.00 (  0.00%)  1158521.00 ( -4.67%)
Min      Rsec-451  1213763.00 (  0.00%)  1155647.00 ( -4.79%)
Min      Rsec-482  1229500.00 (  0.00%)  1150865.00 ( -6.40%)
Min      Rsec-513  1221127.00 (  0.00%)  1147681.00 ( -6.01%)
Min      Rsec-544  1221782.00 (  0.00%)  1149971.00 ( -5.88%)
Min      Rsec-575  1184374.00 (  0.00%)  1153082.00 ( -2.64%)
Min      Rsec-606  1135188.00 (  0.00%)  1152674.00 (  1.54%)
Min      Rsec-637  1185181.00 (  0.00%)  1153444.00 ( -2.68%)
Min      Rsec-640  1183162.00 (  0.00%)  1147895.00 ( -2.98%)
Hmean    Rsec-1      59299.22 (  0.00%)    59220.51 ( -0.13%)
Hmean    Rsec-4     237803.45 (  0.00%)   238861.28 (  0.44%)
Hmean    Rsec-7     415181.57 (  0.00%)   418361.55 (  0.77%)
Hmean    Rsec-12    702605.63 (  0.00%)   715778.79 (  1.87%)
Hmean    Rsec-21   1013323.29 (  0.00%)  1165423.41 ( 15.01%)
Hmean    Rsec-30   1220002.31 (  0.00%)  1191467.30 ( -2.34%)
Hmean    Rsec-48   1409923.63 (  0.00%)  1195532.99 (-15.21%)
Hmean    Rsec-79   1408296.65 (  0.00%)  1194610.06 (-15.17%)
Hmean    Rsec-110  1388818.63 (  0.00%)  1195059.90 (-13.95%)
Hmean    Rsec-141  1354828.14 (  0.00%)  1194087.34 (-11.86%)
Hmean    Rsec-172  1358682.97 (  0.00%)  1192507.85 (-12.23%)
Hmean    Rsec-203  1357334.86 (  0.00%)  1189685.81 (-12.35%)
Hmean    Rsec-234  1359017.91 (  0.00%)  1186369.03 (-12.70%)
Hmean    Rsec-265  1347971.12 (  0.00%)  1181722.72 (-12.33%)
Hmean    Rsec-296  1329838.20 (  0.00%)  1176027.12 (-11.57%)
Hmean    Rsec-327  1328480.53 (  0.00%)  1172182.97 (-11.77%)
Hmean    Rsec-358  1285729.51 (  0.00%)  1166150.72 ( -9.30%)
Hmean    Rsec-389  1291378.08 (  0.00%)  1164117.83 ( -9.85%)
Hmean    Rsec-420  1246949.71 (  0.00%)  1160737.23 ( -6.91%)
Hmean    Rsec-451  1248264.03 (  0.00%)  1158153.34 ( -7.22%)
Hmean    Rsec-482  1249315.65 (  0.00%)  1157326.39 ( -7.36%)
Hmean    Rsec-513  1240804.63 (  0.00%)  1155363.84 ( -6.89%)
Hmean    Rsec-544  1248735.27 (  0.00%)  1153443.82 ( -7.63%)
Hmean    Rsec-575  1220099.81 (  0.00%)  1154863.48 ( -5.35%)
Hmean    Rsec-606  1190318.14 (  0.00%)  1155167.38 ( -2.95%)
Hmean    Rsec-637  1229362.35 (  0.00%)  1154825.20 ( -6.06%)
Hmean    Rsec-640  1219838.36 (  0.00%)  1149766.28 ( -5.74%)
Stddev   Rsec-1        214.65 (  0.00%)      202.13 (  5.83%)
Stddev   Rsec-4       1105.14 (  0.00%)      468.39 ( 57.62%)
Stddev   Rsec-7       1083.26 (  0.00%)      663.11 ( 38.79%)
Stddev   Rsec-12      6049.49 (  0.00%)      391.93 ( 93.52%)
Stddev   Rsec-21     15780.08 (  0.00%)     6197.16 ( 60.73%)
Stddev   Rsec-30     69652.18 (  0.00%)     3395.62 ( 95.12%)
Stddev   Rsec-48     20425.18 (  0.00%)      702.85 ( 96.56%)
Stddev   Rsec-79     21298.32 (  0.00%)     1056.40 ( 95.04%)
Stddev   Rsec-110     7580.56 (  0.00%)     1036.36 ( 86.33%)
Stddev   Rsec-141     7537.24 (  0.00%)      743.20 ( 90.14%)
Stddev   Rsec-172     9407.43 (  0.00%)     1356.65 ( 85.58%)
Stddev   Rsec-203    12249.70 (  0.00%)     1087.02 ( 91.13%)
Stddev   Rsec-234    13864.68 (  0.00%)      451.98 ( 96.74%)
Stddev   Rsec-265     9281.71 (  0.00%)     1323.11 ( 85.74%)
Stddev   Rsec-296    15608.62 (  0.00%)     1405.19 ( 91.00%)
Stddev   Rsec-327    11437.94 (  0.00%)     1381.67 ( 87.92%)
Stddev   Rsec-358    30749.96 (  0.00%)     1399.78 ( 95.45%)
Stddev   Rsec-389    17644.83 (  0.00%)     2636.34 ( 85.06%)
Stddev   Rsec-420    21707.57 (  0.00%)     1856.06 ( 91.45%)
Stddev   Rsec-451    26977.14 (  0.00%)     2002.56 ( 92.58%)
Stddev   Rsec-482    14564.28 (  0.00%)     3327.88 ( 77.15%)
Stddev   Rsec-513    14453.01 (  0.00%)     4177.19 ( 71.10%)
Stddev   Rsec-544    26548.39 (  0.00%)     2491.44 ( 90.62%)
Stddev   Rsec-575    33561.49 (  0.00%)     1488.00 ( 95.57%)
Stddev   Rsec-606    30111.56 (  0.00%)     1528.70 ( 94.92%)
Stddev   Rsec-637    28212.69 (  0.00%)     1076.03 ( 96.19%)
Stddev   Rsec-640    33645.73 (  0.00%)     1485.91 ( 95.58%)
CoeffVar Rsec-1          0.36 (  0.00%)        0.34 (  5.71%)
CoeffVar Rsec-4          0.46 (  0.00%)        0.20 ( 57.80%)
CoeffVar Rsec-7          0.26 (  0.00%)        0.16 ( 39.25%)
CoeffVar Rsec-12         0.86 (  0.00%)        0.05 ( 93.64%)
CoeffVar Rsec-21         1.56 (  0.00%)        0.53 ( 65.85%)
CoeffVar Rsec-30         5.69 (  0.00%)        0.28 ( 94.99%)
CoeffVar Rsec-48         1.45 (  0.00%)        0.06 ( 95.94%)
CoeffVar Rsec-79         1.51 (  0.00%)        0.09 ( 94.15%)
CoeffVar Rsec-110        0.55 (  0.00%)        0.09 ( 84.11%)
CoeffVar Rsec-141        0.56 (  0.00%)        0.06 ( 88.81%)
CoeffVar Rsec-172        0.69 (  0.00%)        0.11 ( 83.57%)
CoeffVar Rsec-203        0.90 (  0.00%)        0.09 ( 89.87%)
CoeffVar Rsec-234        1.02 (  0.00%)        0.04 ( 96.27%)
CoeffVar Rsec-265        0.69 (  0.00%)        0.11 ( 83.74%)
CoeffVar Rsec-296        1.17 (  0.00%)        0.12 ( 89.82%)
CoeffVar Rsec-327        0.86 (  0.00%)        0.12 ( 86.31%)
CoeffVar Rsec-358        2.39 (  0.00%)        0.12 ( 94.98%)
CoeffVar Rsec-389        1.37 (  0.00%)        0.23 ( 83.42%)
CoeffVar Rsec-420        1.74 (  0.00%)        0.16 ( 90.81%)
CoeffVar Rsec-451        2.16 (  0.00%)        0.17 ( 92.00%)
CoeffVar Rsec-482        1.17 (  0.00%)        0.29 ( 75.33%)
CoeffVar Rsec-513        1.16 (  0.00%)        0.36 ( 68.96%)
CoeffVar Rsec-544        2.13 (  0.00%)        0.22 ( 89.84%)
CoeffVar Rsec-575        2.75 (  0.00%)        0.13 ( 95.31%)
CoeffVar Rsec-606        2.53 (  0.00%)        0.13 ( 94.77%)
CoeffVar Rsec-637        2.29 (  0.00%)        0.09 ( 95.94%)
CoeffVar Rsec-640        2.76 (  0.00%)        0.13 ( 95.31%)
Max      Rsec-1      59477.00 (  0.00%)    59547.00 (  0.12%)
Max      Rsec-4     239279.00 (  0.00%)   239413.00 (  0.06%)
Max      Rsec-7     416467.00 (  0.00%)   419267.00 (  0.67%)
Max      Rsec-12    711538.00 (  0.00%)   716354.00 (  0.68%)
Max      Rsec-21   1034993.00 (  0.00%)  1173890.00 ( 13.42%)
Max      Rsec-30   1271755.00 (  0.00%)  1194865.00 ( -6.05%)
Max      Rsec-48   1431735.00 (  0.00%)  1196503.00 (-16.43%)
Max      Rsec-79   1425144.00 (  0.00%)  1195467.00 (-16.12%)
Max      Rsec-110  1398698.00 (  0.00%)  1196259.00 (-14.47%)
Max      Rsec-141  1362060.00 (  0.00%)  1194837.00 (-12.28%)
Max      Rsec-172  1371670.00 (  0.00%)  1193678.00 (-12.98%)
Max      Rsec-203  1372548.00 (  0.00%)  1191462.00 (-13.19%)
Max      Rsec-234  1373918.00 (  0.00%)  1186881.00 (-13.61%)
Max      Rsec-265  1355405.00 (  0.00%)  1183302.00 (-12.70%)
Max      Rsec-296  1350576.00 (  0.00%)  1177724.00 (-12.80%)
Max      Rsec-327  1340526.00 (  0.00%)  1173891.00 (-12.43%)
Max      Rsec-358  1318225.00 (  0.00%)  1168442.00 (-11.36%)
Max      Rsec-389  1313419.00 (  0.00%)  1167070.00 (-11.14%)
Max      Rsec-420  1272361.00 (  0.00%)  1163315.00 ( -8.57%)
Max      Rsec-451  1287748.00 (  0.00%)  1161601.00 ( -9.80%)
Max      Rsec-482  1266893.00 (  0.00%)  1160102.00 ( -8.43%)
Max      Rsec-513  1265236.00 (  0.00%)  1159734.00 ( -8.34%)
Max      Rsec-544  1286777.00 (  0.00%)  1156780.00 (-10.10%)
Max      Rsec-575  1274216.00 (  0.00%)  1156878.00 ( -9.21%)
Max      Rsec-606  1225411.00 (  0.00%)  1156891.00 ( -5.59%)
Max      Rsec-637  1260667.00 (  0.00%)  1156004.00 ( -8.30%)
Max      Rsec-640  1265580.00 (  0.00%)  1151746.00 ( -8.99%)

ebizzy Per-thread
                                    ltctulc6a                   ltctulc6a
                     p1-0c526e14410c98f0ebc7a            p1-3754c8187ca17
Min      Rsec-1      59019.00 (  0.00%)    59026.00 (  0.01%)
Min      Rsec-4      58043.00 (  0.00%)    59093.00 (  1.81%)
Min      Rsec-7      58235.00 (  0.00%)    59056.00 (  1.41%)
Min      Rsec-12     56196.00 (  0.00%)    58710.00 (  4.47%)
Min      Rsec-21     27616.00 (  0.00%)    43185.00 ( 56.38%)
Min      Rsec-30     18107.00 (  0.00%)    35089.00 ( 93.79%)
Min      Rsec-48     13880.00 (  0.00%)    20565.00 ( 48.16%)
Min      Rsec-79     10748.00 (  0.00%)    12743.00 ( 18.56%)
Min      Rsec-110     8584.00 (  0.00%)     8354.00 ( -2.68%)
Min      Rsec-141     8383.00 (  0.00%)     6601.00 (-21.26%)
Min      Rsec-172     6591.00 (  0.00%)     5455.00 (-17.24%)
Min      Rsec-203     5218.00 (  0.00%)     4542.00 (-12.96%)
Min      Rsec-234     4297.00 (  0.00%)     3878.00 ( -9.75%)
Min      Rsec-265     3564.00 (  0.00%)     3601.00 (  1.04%)
Min      Rsec-296     3006.00 (  0.00%)     3207.00 (  6.69%)
Min      Rsec-327     2566.00 (  0.00%)     2986.00 ( 16.37%)
Min      Rsec-358     1957.00 (  0.00%)     2633.00 ( 34.54%)
Min      Rsec-389     1934.00 (  0.00%)     2469.00 ( 27.66%)
Min      Rsec-420     1621.00 (  0.00%)     2113.00 ( 30.35%)
Min      Rsec-451     1332.00 (  0.00%)     1940.00 ( 45.65%)
Min      Rsec-482     1216.00 (  0.00%)     1967.00 ( 61.76%)
Min      Rsec-513     1086.00 (  0.00%)     1775.00 ( 63.44%)
Min      Rsec-544     1059.00 (  0.00%)     1625.00 ( 53.45%)
Min      Rsec-575      931.00 (  0.00%)     1608.00 ( 72.72%)
Min      Rsec-606      854.00 (  0.00%)     1514.00 ( 77.28%)
Min      Rsec-637      785.00 (  0.00%)     1461.00 ( 86.11%)
Min      Rsec-640      769.00 (  0.00%)     1457.00 ( 89.47%)
Hmean    Rsec-1      59299.22 (  0.00%)    59220.51 ( -0.13%)
Hmean    Rsec-4      59448.27 (  0.00%)    59713.55 (  0.45%)
Hmean    Rsec-7      59308.87 (  0.00%)    59764.26 (  0.77%)
Hmean    Rsec-12     58544.65 (  0.00%)    59646.29 (  1.88%)
Hmean    Rsec-21     46566.67 (  0.00%)    55040.62 ( 18.20%)
Hmean    Rsec-30     38129.87 (  0.00%)    39635.40 (  3.95%)
Hmean    Rsec-48     26068.69 (  0.00%)    24727.22 ( -5.15%)
Hmean    Rsec-79     16414.30 (  0.00%)    15054.40 ( -8.28%)
Hmean    Rsec-110    12194.60 (  0.00%)    10748.15 (-11.86%)
Hmean    Rsec-141     9554.89 (  0.00%)     8382.53 (-12.27%)
Hmean    Rsec-172     7874.33 (  0.00%)     6864.12 (-12.83%)
Hmean    Rsec-203     6642.05 (  0.00%)     5805.13 (-12.60%)
Hmean    Rsec-234     5754.57 (  0.00%)     5016.33 (-12.83%)
Hmean    Rsec-265     5033.39 (  0.00%)     4425.33 (-12.08%)
Hmean    Rsec-296     4430.79 (  0.00%)     3930.34 (-11.29%)
Hmean    Rsec-327     3987.30 (  0.00%)     3551.38 (-10.93%)
Hmean    Rsec-358     3497.80 (  0.00%)     3231.49 ( -7.61%)
Hmean    Rsec-389     3224.77 (  0.00%)     2967.51 ( -7.98%)
Hmean    Rsec-420     2864.26 (  0.00%)     2724.67 ( -4.87%)
Hmean    Rsec-451     2654.30 (  0.00%)     2539.20 ( -4.34%)
Hmean    Rsec-482     2474.43 (  0.00%)     2372.93 ( -4.10%)
Hmean    Rsec-513     2303.30 (  0.00%)     2228.18 ( -3.26%)
Hmean    Rsec-544     2179.61 (  0.00%)     2089.91 ( -4.12%)
Hmean    Rsec-575     2004.37 (  0.00%)     1990.74 ( -0.68%)
Hmean    Rsec-606     1835.71 (  0.00%)     1886.48 (  2.77%)
Hmean    Rsec-637     1799.26 (  0.00%)     1791.23 ( -0.45%)
Hmean    Rsec-640     1769.47 (  0.00%)     1776.84 (  0.42%)
Stddev   Rsec-1        214.65 (  0.00%)      202.13 ( -5.83%)
Stddev   Rsec-4        452.36 (  0.00%)      303.68 (-32.87%)
Stddev   Rsec-7        407.54 (  0.00%)      279.43 (-31.44%)
Stddev   Rsec-12       749.25 (  0.00%)      298.44 (-60.17%)
Stddev   Rsec-21      8269.02 (  0.00%)     4821.85 (-41.69%)
Stddev   Rsec-30      9740.83 (  0.00%)     1781.85 (-81.71%)
Stddev   Rsec-48      8940.54 (  0.00%)     2140.32 (-76.06%)
Stddev   Rsec-79      4763.58 (  0.00%)     1019.77 (-78.59%)
Stddev   Rsec-110     2404.10 (  0.00%)     1106.16 (-53.99%)
Stddev   Rsec-141      748.05 (  0.00%)      861.90 ( 15.22%)
Stddev   Rsec-172      443.52 (  0.00%)      706.09 ( 59.20%)
Stddev   Rsec-203      545.22 (  0.00%)      596.05 (  9.32%)
Stddev   Rsec-234      560.10 (  0.00%)      520.38 ( -7.09%)
Stddev   Rsec-265      523.60 (  0.00%)      398.13 (-23.96%)
Stddev   Rsec-296      529.15 (  0.00%)      422.22 (-20.21%)
Stddev   Rsec-327      555.34 (  0.00%)      357.59 (-35.61%)
Stddev   Rsec-358      587.05 (  0.00%)      297.70 (-49.29%)
Stddev   Rsec-389      567.67 (  0.00%)      283.17 (-50.12%)
Stddev   Rsec-420      561.80 (  0.00%)      334.94 (-40.38%)
Stddev   Rsec-451      568.80 (  0.00%)      283.43 (-50.17%)
Stddev   Rsec-482      561.95 (  0.00%)      280.07 (-50.16%)
Stddev   Rsec-513      536.11 (  0.00%)      237.82 (-55.64%)
Stddev   Rsec-544      530.79 (  0.00%)      265.20 (-50.04%)
Stddev   Rsec-575      511.25 (  0.00%)      194.66 (-61.92%)
Stddev   Rsec-606      513.16 (  0.00%)      208.21 (-59.43%)
Stddev   Rsec-637      523.96 (  0.00%)      214.40 (-59.08%)
Stddev   Rsec-640      524.37 (  0.00%)      198.46 (-62.15%)
CoeffVar Rsec-1          0.36 (  0.00%)        0.34 (  5.71%)
CoeffVar Rsec-4          0.76 (  0.00%)        0.51 ( 33.16%)
CoeffVar Rsec-7          0.69 (  0.00%)        0.47 ( 31.96%)
CoeffVar Rsec-12         1.28 (  0.00%)        0.50 ( 60.90%)
CoeffVar Rsec-21        17.13 (  0.00%)        8.69 ( 49.29%)
CoeffVar Rsec-30        23.87 (  0.00%)        4.49 ( 81.20%)
CoeffVar Rsec-48        30.43 (  0.00%)        8.59 ( 71.76%)
CoeffVar Rsec-79        26.72 (  0.00%)        6.74 ( 74.76%)
CoeffVar Rsec-110       19.04 (  0.00%)       10.18 ( 46.53%)
CoeffVar Rsec-141        7.79 (  0.00%)       10.18 (-30.74%)
CoeffVar Rsec-172        5.61 (  0.00%)       10.18 (-81.39%)
CoeffVar Rsec-203        8.15 (  0.00%)       10.17 (-24.74%)
CoeffVar Rsec-234        9.64 (  0.00%)       10.27 ( -6.44%)
CoeffVar Rsec-265       10.29 (  0.00%)        8.93 ( 13.26%)
CoeffVar Rsec-296       11.78 (  0.00%)       10.63 (  9.76%)
CoeffVar Rsec-327       13.67 (  0.00%)        9.98 ( 27.02%)
CoeffVar Rsec-358       16.34 (  0.00%)        9.14 ( 44.06%)
CoeffVar Rsec-389       17.10 (  0.00%)        9.46 ( 44.65%)
CoeffVar Rsec-420       18.92 (  0.00%)       12.12 ( 35.93%)
CoeffVar Rsec-451       20.54 (  0.00%)       11.04 ( 46.27%)
CoeffVar Rsec-482       21.68 (  0.00%)       11.67 ( 46.19%)
CoeffVar Rsec-513       22.17 (  0.00%)       10.56 ( 52.35%)
CoeffVar Rsec-544       23.12 (  0.00%)       12.51 ( 45.88%)
CoeffVar Rsec-575       24.08 (  0.00%)        9.69 ( 59.74%)
CoeffVar Rsec-606       26.11 (  0.00%)       10.93 ( 58.16%)
CoeffVar Rsec-637       27.14 (  0.00%)       11.83 ( 56.42%)
CoeffVar Rsec-640       27.50 (  0.00%)       11.05 ( 59.81%)
Max      Rsec-1      59477.00 (  0.00%)    59547.00 (  0.12%)
Max      Rsec-4      60099.00 (  0.00%)    60109.00 (  0.02%)
Max      Rsec-7      59947.00 (  0.00%)    60146.00 (  0.33%)
Max      Rsec-12     59660.00 (  0.00%)    60095.00 (  0.73%)
Max      Rsec-21     59737.00 (  0.00%)    60052.00 (  0.53%)
Max      Rsec-30     59385.00 (  0.00%)    44024.00 (-25.87%)
Max      Rsec-48     43898.00 (  0.00%)    30457.00 (-30.62%)
Max      Rsec-79     27525.00 (  0.00%)    18652.00 (-32.24%)
Max      Rsec-110    26278.00 (  0.00%)    13760.00 (-47.64%)
Max      Rsec-141    13849.00 (  0.00%)    11322.00 (-18.25%)
Max      Rsec-172    10026.00 (  0.00%)     9901.00 ( -1.25%)
Max      Rsec-203     8790.00 (  0.00%)    10312.00 ( 17.32%)
Max      Rsec-234     8078.00 (  0.00%)     6947.00 (-14.00%)
Max      Rsec-265     7296.00 (  0.00%)     6885.00 ( -5.63%)
Max      Rsec-296     6743.00 (  0.00%)     6186.00 ( -8.26%)
Max      Rsec-327     6036.00 (  0.00%)     5037.00 (-16.55%)
Max      Rsec-358     5615.00 (  0.00%)     4615.00 (-17.81%)
Max      Rsec-389     5728.00 (  0.00%)     4797.00 (-16.25%)
Max      Rsec-420     5548.00 (  0.00%)     4311.00 (-22.30%)
Max      Rsec-451     4887.00 (  0.00%)     4188.00 (-14.30%)
Max      Rsec-482     5382.00 (  0.00%)     4152.00 (-22.85%)
Max      Rsec-513     4493.00 (  0.00%)     3543.00 (-21.14%)
Max      Rsec-544     8204.00 (  0.00%)     3878.00 (-52.73%)
Max      Rsec-575     4884.00 (  0.00%)     3410.00 (-30.18%)
Max      Rsec-606     4399.00 (  0.00%)     3441.00 (-21.78%)
Max      Rsec-637     4630.00 (  0.00%)     3772.00 (-18.53%)
Max      Rsec-640     4303.00 (  0.00%)     3449.00 (-19.85%)

ebizzy Thread spread
                                      ltctulc6a                   ltctulc6a
                       p1-0c526e14410c98f0ebc7a            p1-3754c8187ca17
Min      spread-1          0.00 (  0.00%)        0.00 (  0.00%)
Min      spread-4        642.00 (  0.00%)      184.00 ( 71.34%)
Min      spread-7        520.00 (  0.00%)      516.00 (  0.77%)
Min      spread-12       854.00 (  0.00%)      662.00 ( 22.48%)
Min      spread-21     17941.00 (  0.00%)     9358.00 ( 47.84%)
Min      spread-30     29196.00 (  0.00%)     6511.00 ( 77.70%)
Min      spread-48     25290.00 (  0.00%)     6198.00 ( 75.49%)
Min      spread-79     14675.00 (  0.00%)     3515.00 ( 76.05%)
Min      spread-110     8494.00 (  0.00%)     2761.00 ( 67.49%)
Min      spread-141     2849.00 (  0.00%)     2543.00 ( 10.74%)
Min      spread-172     1663.00 (  0.00%)     2473.00 (-48.71%)
Min      spread-203     2675.00 (  0.00%)     1788.00 ( 33.16%)
Min      spread-234     2564.00 (  0.00%)     1730.00 ( 32.53%)
Min      spread-265     2787.00 (  0.00%)     1452.00 ( 47.90%)
Min      spread-296     2661.00 (  0.00%)     1780.00 ( 33.11%)
Min      spread-327     2818.00 (  0.00%)     1697.00 ( 39.78%)
Min      spread-358     2762.00 (  0.00%)     1389.00 ( 49.71%)
Min      spread-389     2965.00 (  0.00%)     1535.00 ( 48.23%)
Min      spread-420     2975.00 (  0.00%)     1446.00 ( 51.39%)
Min      spread-451     2688.00 (  0.00%)     1384.00 ( 48.51%)
Min      spread-482     2951.00 (  0.00%)     1557.00 ( 47.24%)
Min      spread-513     2720.00 (  0.00%)      772.00 ( 71.62%)
Min      spread-544     2802.00 (  0.00%)     1458.00 ( 47.97%)
Min      spread-575     2913.00 (  0.00%)      948.00 ( 67.46%)
Min      spread-606     2668.00 (  0.00%)      978.00 ( 63.34%)
Min      spread-637     2772.00 (  0.00%)      870.00 ( 68.61%)
Min      spread-640     2673.00 (  0.00%)     1279.00 ( 52.15%)
Hmean    spread-1          0.00 (  0.00%)        0.00 (  0.00%)
Hmean    spread-4        801.43 (  0.00%)      470.50 ( 41.29%)
Hmean    spread-7        965.88 (  0.00%)      725.33 ( 24.90%)
Hmean    spread-12      1474.71 (  0.00%)      911.49 ( 38.19%)
Hmean    spread-21     25214.17 (  0.00%)    13345.33 ( 47.07%)
Hmean    spread-30     33264.37 (  0.00%)     7229.77 ( 78.27%)
Hmean    spread-48     27289.38 (  0.00%)     7524.92 ( 72.43%)
Hmean    spread-79     15540.65 (  0.00%)     4016.42 ( 74.16%)
Hmean    spread-110    10173.90 (  0.00%)     3569.92 ( 64.91%)
Hmean    spread-141     3739.06 (  0.00%)     3327.24 ( 11.01%)
Hmean    spread-172     2131.19 (  0.00%)     2925.95 (-37.29%)
Hmean    spread-203     2997.71 (  0.00%)     2828.64 (  5.64%)
Hmean    spread-234     2956.73 (  0.00%)     2256.26 ( 23.69%)
Hmean    spread-265     3055.75 (  0.00%)     2130.75 ( 30.27%)
Hmean    spread-296     3072.62 (  0.00%)     2311.81 ( 24.76%)
Hmean    spread-327     2966.20 (  0.00%)     1870.37 ( 36.94%)
Hmean    spread-358     3126.03 (  0.00%)     1648.81 ( 47.26%)
Hmean    spread-389     3180.41 (  0.00%)     1772.25 ( 44.28%)
Hmean    spread-420     3314.92 (  0.00%)     1732.26 ( 47.74%)
Hmean    spread-451     3192.62 (  0.00%)     1769.23 ( 44.58%)
Hmean    spread-482     3319.77 (  0.00%)     1817.95 ( 45.24%)
Hmean    spread-513     3056.14 (  0.00%)     1231.55 ( 59.70%)
Hmean    spread-544     3450.15 (  0.00%)     1732.02 ( 49.80%)
Hmean    spread-575     3223.94 (  0.00%)     1366.10 ( 57.63%)
Hmean    spread-606     3016.24 (  0.00%)     1410.86 ( 53.22%)
Hmean    spread-637     3369.59 (  0.00%)     1267.08 ( 62.40%)
Hmean    spread-640     3108.32 (  0.00%)     1501.63 ( 51.69%)
Stddev   spread-1          0.00 (  0.00%)        0.00 (  0.00%)
Stddev   spread-4        284.37 (  0.00%)      271.81 (  4.42%)
Stddev   spread-7        383.83 (  0.00%)      195.72 ( 49.01%)
Stddev   spread-12       685.16 (  0.00%)      247.70 ( 63.85%)
Stddev   spread-21      4571.79 (  0.00%)     2516.53 ( 44.96%)
Stddev   spread-30      2741.29 (  0.00%)      539.47 ( 80.32%)
Stddev   spread-48      1571.52 (  0.00%)     1212.36 ( 22.85%)
Stddev   spread-79       572.87 (  0.00%)      885.42 (-54.56%)
Stddev   spread-110     3348.16 (  0.00%)      942.23 ( 71.86%)
Stddev   spread-141      827.46 (  0.00%)      574.75 ( 30.54%)
Stddev   spread-172      570.10 (  0.00%)      709.11 (-24.38%)
Stddev   spread-203      292.68 (  0.00%)     1223.27 (-317.96%)
Stddev   spread-234      379.33 (  0.00%)      398.56 ( -5.07%)
Stddev   spread-265      274.53 (  0.00%)      650.83 (-137.07%)
Stddev   spread-296      240.56 (  0.00%)      502.41 (-108.85%)
Stddev   spread-327      108.69 (  0.00%)       98.61 (  9.28%)
Stddev   spread-358      252.78 (  0.00%)      195.68 ( 22.59%)
Stddev   spread-389      293.21 (  0.00%)      244.61 ( 16.57%)
Stddev   spread-420      303.05 (  0.00%)      297.58 (  1.81%)
Stddev   spread-451      276.28 (  0.00%)      237.67 ( 13.97%)
Stddev   spread-482      352.94 (  0.00%)      228.32 ( 35.31%)
Stddev   spread-513      212.64 (  0.00%)      322.39 (-51.61%)
Stddev   spread-544     1571.63 (  0.00%)      213.04 ( 86.44%)
Stddev   spread-575      352.77 (  0.00%)      277.26 ( 21.40%)
Stddev   spread-606      322.88 (  0.00%)      350.63 ( -8.59%)
Stddev   spread-637      332.26 (  0.00%)      485.17 (-46.02%)
Stddev   spread-640      311.30 (  0.00%)      249.49 ( 19.86%)
CoeffVar spread-1          0.00 (  0.00%)        0.00 (  0.00%)
CoeffVar spread-4         32.65 (  0.00%)       40.50 ( 24.04%)
CoeffVar spread-7         34.11 (  0.00%)       25.27 (-25.90%)
CoeffVar spread-12        39.21 (  0.00%)       25.44 (-35.12%)
CoeffVar spread-21        17.47 (  0.00%)       18.11 (  3.67%)
CoeffVar spread-30         8.18 (  0.00%)        7.42 ( -9.34%)
CoeffVar spread-48         5.74 (  0.00%)       15.75 (174.34%)
CoeffVar spread-79         3.68 (  0.00%)       21.27 (477.84%)
CoeffVar spread-110       30.70 (  0.00%)       24.92 (-18.82%)
CoeffVar spread-141       21.18 (  0.00%)       16.76 (-20.89%)
CoeffVar spread-172       25.34 (  0.00%)       23.23 ( -8.32%)
CoeffVar spread-203        9.67 (  0.00%)       37.85 (291.37%)
CoeffVar spread-234       12.63 (  0.00%)       17.10 ( 35.38%)
CoeffVar spread-265        8.92 (  0.00%)       28.09 (215.03%)
CoeffVar spread-296        7.78 (  0.00%)       20.74 (166.59%)
CoeffVar spread-327        3.66 (  0.00%)        5.26 ( 43.65%)
CoeffVar spread-358        8.03 (  0.00%)       11.71 ( 45.74%)
CoeffVar spread-389        9.15 (  0.00%)       13.57 ( 48.33%)
CoeffVar spread-420        9.07 (  0.00%)       16.71 ( 84.25%)
CoeffVar spread-451        8.58 (  0.00%)       13.17 ( 53.46%)
CoeffVar spread-482       10.52 (  0.00%)       12.37 ( 17.55%)
CoeffVar spread-513        6.92 (  0.00%)       24.25 (250.23%)
CoeffVar spread-544       40.77 (  0.00%)       12.12 (-70.28%)
CoeffVar spread-575       10.83 (  0.00%)       19.38 ( 79.06%)
CoeffVar spread-606       10.58 (  0.00%)       23.34 (120.53%)
CoeffVar spread-637        9.75 (  0.00%)       34.41 (252.77%)
CoeffVar spread-640        9.91 (  0.00%)       16.23 ( 63.65%)
Max      spread-1          0.00 (  0.00%)        0.00 (  0.00%)
Max      spread-4       1410.00 (  0.00%)      983.00 ( 30.28%)
Max      spread-7       1707.00 (  0.00%)     1040.00 ( 39.07%)
Max      spread-12      2849.00 (  0.00%)     1353.00 ( 52.51%)
Max      spread-21     30767.00 (  0.00%)    16839.00 ( 45.27%)
Max      spread-30     36695.00 (  0.00%)     7837.00 ( 78.64%)
Max      spread-48     30018.00 (  0.00%)     9892.00 ( 67.05%)
Max      spread-79     16436.00 (  0.00%)     5909.00 ( 64.05%)
Max      spread-110    17489.00 (  0.00%)     5324.00 ( 69.56%)
Max      spread-141     5237.00 (  0.00%)     4102.00 ( 21.67%)
Max      spread-172     3312.00 (  0.00%)     4446.00 (-34.24%)
Max      spread-203     3371.00 (  0.00%)     5389.00 (-59.86%)
Max      spread-234     3586.00 (  0.00%)     2732.00 ( 23.81%)
Max      spread-265     3511.00 (  0.00%)     3106.00 ( 11.54%)
Max      spread-296     3397.00 (  0.00%)     2979.00 ( 12.30%)
Max      spread-327     3115.00 (  0.00%)     1993.00 ( 36.02%)
Max      spread-358     3458.00 (  0.00%)     1982.00 ( 42.68%)
Max      spread-389     3768.00 (  0.00%)     2244.00 ( 40.45%)
Max      spread-420     3829.00 (  0.00%)     2177.00 ( 43.14%)
Max      spread-451     3441.00 (  0.00%)     2052.00 ( 40.37%)
Max      spread-482     3966.00 (  0.00%)     2166.00 ( 45.39%)
Max      spread-513     3347.00 (  0.00%)     1689.00 ( 49.54%)
Max      spread-544     6983.00 (  0.00%)     2064.00 ( 70.44%)
Max      spread-575     3899.00 (  0.00%)     1707.00 ( 56.22%)
Max      spread-606     3420.00 (  0.00%)     1871.00 ( 45.29%)
Max      spread-637     3687.00 (  0.00%)     2275.00 ( 38.30%)
Max      spread-640     3520.00 (  0.00%)     1992.00 ( 43.41%)

           ltctulc6a   ltctulc6a
        p1-0c526e14410c98f0ebc7ap1-3754c8187ca17
User       449857.75    72187.34
System       2638.18      105.00
Elapsed      4054.44     4053.38

                             ltctulc6a   ltctulc6a
                          p1-0c526e14410c98f0ebc7ap1-3754c8187ca17
Minor Faults                   2765118     1514804
Major Faults                       408           1
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                     1167862     1071627
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
Sector Reads                   1444141         172
Sector Writes                    91684       13168
Page rescued immediate               0           0
Slabs scanned                        0           0
Direct inode steals                  0           0
Kswapd inode steals                  0           0
Kswapd skipped wait                  0           0
THP fault alloc                     51         190
THP collapse alloc                   2           2
THP splits                          51         170
THP fault fallback                 135         380
THP collapse fail                    0           0
Compaction stalls                    0           0
Compaction success                   0           0
Compaction failures                  0           0
Page migrate success             65321       66111
Page migrate failure                 0           0
Compaction pages isolated            0        1024
Compaction migrate scanned           0           4
Compaction free scanned              0           4
Compaction cost                     67          68
NUMA alloc hit                 1090456      890448
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local                945985      514745
NUMA base PTE updates           864898      601053
NUMA huge PMD updates                0           0
NUMA page range updates         864898      601053
NUMA hint faults                851929      593151
NUMA hint local faults          335015      217196
NUMA hint local percent             39          36
NUMA pages migrated              65321       66111
AutoNUMA cost                    4266%       2971%
