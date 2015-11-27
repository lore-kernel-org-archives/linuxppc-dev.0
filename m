Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5D241A03C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 18:28:54 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Nov 2015 17:28:52 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0AFD22CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 18:28:50 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR7SYpb31195226
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 18:28:42 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR7SH6G026014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 18:28:17 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 07/10] powerpc/mm: update PTE frag size
In-Reply-To: <1448274825-30289-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274825-30289-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 27 Nov 2015 12:57:56 +0530
Message-ID: <87egfbgav7.fsf@linux.vnet.ibm.com>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Now that we don't track 4k subpage information we can use 2K PTE
> fragments.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 5062c6d423fd..a28dbfe2baed 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -39,14 +39,14 @@
>   */
>  #define PTE_RPN_SHIFT	(30)
>  /*
> - * we support 8 fragments per PTE page of 64K size.
> + * we support 32 fragments per PTE page of 64K size.
>   */
> -#define PTE_FRAG_NR	8
> +#define PTE_FRAG_NR	32
>  /*
>   * We use a 2K PTE page fragment and another 4K for storing
>   * real_pte_t hash index. Rounding the entire thing to 8K
>   */
> -#define PTE_FRAG_SIZE_SHIFT  13
> +#define PTE_FRAG_SIZE_SHIFT  11
>  #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
>


This break THP with 4k hpte support because we need to track 4096
subpage information,  and we have only 2048 bytes after this change.

Another thing I noticed is the impact of not tracking subpage
information. We do see some significant impact as shown by the mmtest
results below. The plan now is to go back to 4K pte framgments but
instead of using 16 bits to track 4k subpage valid bit in pte, we use only 4
bits as the last patch in this series does ("[PATCH V2 10/10]
powerpc/mm: Optmize the hashed subpage iteration"). We will track the
secondary and slot information on the second half. This will result in us using
hidx value 0x0, wrongly. This actually indicate primary hash with slot
number zero. But since we are not going to track individual 4k
subpage information we may using slot 0 wrongly. I checked the existing
code and we should be able to handle that case gracefuly.

aim9
                                         guest                       guest
                                 without-patch                  with-patch
Min      page_test   467386.67 (  0.00%)   330480.00 (-29.29%)
Min      brk_test   4231312.46 (  0.00%)  4217133.33 ( -0.34%)
Min      exec_test     1015.66 (  0.00%)      610.33 (-39.91%)
Min      fork_test     2208.92 (  0.00%)     1556.89 (-29.52%)
Hmean    page_test   475149.52 (  0.00%)   334539.38 (-29.59%)
Hmean    brk_test   4277644.85 (  0.00%)  4294441.01 (  0.39%)
Hmean    exec_test     1042.32 (  0.00%)      625.09 (-40.03%)
Hmean    fork_test     2391.28 (  0.00%)     1663.53 (-30.43%)
Stddev   page_test     3315.58 (  0.00%)     1978.01 ( 40.34%)
Stddev   brk_test     42167.57 (  0.00%)    76647.45 (-81.77%)
Stddev   exec_test       18.02 (  0.00%)        8.16 ( 54.73%)
Stddev   fork_test       77.69 (  0.00%)       49.06 ( 36.84%)
CoeffVar page_test        0.70 (  0.00%)        0.59 ( 15.27%)
CoeffVar brk_test         0.99 (  0.00%)        1.78 (-81.02%)
CoeffVar exec_test        1.73 (  0.00%)        1.30 ( 24.50%)
CoeffVar fork_test        3.25 (  0.00%)        2.95 (  9.20%)
Max      page_test   479513.33 (  0.00%)   338526.67 (-29.40%)
Max      brk_test   4412066.67 (  0.00%)  4454430.38 (  0.96%)
Max      exec_test     1071.62 (  0.00%)      637.00 (-40.56%)
Max      fork_test     2500.00 (  0.00%)     1732.18 (-30.71%)

               guest       guest
        without-patch  with-patch
User            0.23        4.49
System          0.44        2.43
Elapsed       723.30      726.21

                                 guest       guest
                          without-patch  with-patch
Minor Faults                  38893956    25714580
Major Faults                        25         228
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                    12760829     8717992
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
Sector Reads                      4252       27096
Sector Writes                    69488       69948
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
NUMA alloc hit                12757558     8716737
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local              12757558     8716737
NUMA base PTE updates              646         648
NUMA huge PMD updates                0           0
NUMA page range updates            646         648
NUMA hint faults                878759      610567
NUMA hint local faults          878759      610567
NUMA hint local percent            100         100
NUMA pages migrated                  0           0
AutoNUMA cost                    4393%       3052%

pft timings
                                         guest                       guest
                                 without-patch                  with-patch
Min      system-1        0.0900 (  0.00%)       0.0600 ( 33.33%)
Min      system-3        0.1500 (  0.00%)       0.1300 ( 13.33%)
Min      system-5        0.2400 (  0.00%)       0.2000 ( 16.67%)
Min      system-7        0.2700 (  0.00%)       0.2600 (  3.70%)
Min      system-8        0.2400 (  0.00%)       0.2400 (  0.00%)
Min      elapsed-1       0.1000 (  0.00%)       0.0800 ( 20.00%)
Min      elapsed-3       0.0700 (  0.00%)       0.0600 ( 14.29%)
Min      elapsed-5       0.0600 (  0.00%)       0.0600 (  0.00%)
Min      elapsed-7       0.0600 (  0.00%)       0.0600 (  0.00%)
Min      elapsed-8       0.0600 (  0.00%)       0.0600 (  0.00%)
Amean    system-1        0.1896 (  0.00%)       0.1071 ( 43.51%)
Amean    system-3        0.1805 (  0.00%)       0.1640 (  9.14%)
Amean    system-5        0.3372 (  0.00%)       0.3261 (  3.30%)
Amean    system-7        0.3609 (  0.00%)       0.4526 (-25.42%)
Amean    system-8        0.4686 (  0.00%)       0.4309 (  8.06%)
Amean    elapsed-1       0.2313 (  0.00%)       0.1281 ( 44.59%)
Amean    elapsed-3       0.0779 (  0.00%)       0.0714 (  8.35%)
Amean    elapsed-5       0.0916 (  0.00%)       0.0898 (  2.05%)
Amean    elapsed-7       0.0711 (  0.00%)       0.0877 (-23.37%)
Amean    elapsed-8       0.0786 (  0.00%)       0.0749 (  4.77%)
Stddev   system-1        0.3466 (  0.00%)       0.2874 ( 17.07%)
Stddev   system-3        0.0228 (  0.00%)       0.0278 (-21.83%)
Stddev   system-5        0.1883 (  0.00%)       0.1865 (  1.01%)
Stddev   system-7        0.0437 (  0.00%)       0.3484 (-696.61%)
Stddev   system-8        0.2732 (  0.00%)       0.2877 ( -5.33%)
Stddev   elapsed-1       0.4832 (  0.00%)       0.3672 ( 24.01%)
Stddev   elapsed-3       0.0085 (  0.00%)       0.0095 (-11.61%)
Stddev   elapsed-5       0.0464 (  0.00%)       0.0515 (-11.10%)
Stddev   elapsed-7       0.0063 (  0.00%)       0.0645 (-920.30%)
Stddev   elapsed-8       0.0379 (  0.00%)       0.0430 (-13.49%)
CoeffVar system-1      182.7586 (  0.00%)     268.2875 (-46.80%)
CoeffVar system-3       12.6305 (  0.00%)      16.9365 (-34.09%)
CoeffVar system-5       55.8482 (  0.00%)      57.1714 ( -2.37%)
CoeffVar system-7       12.1199 (  0.00%)      76.9777 (-535.14%)
CoeffVar system-8       58.2889 (  0.00%)      66.7748 (-14.56%)
CoeffVar elapsed-1     208.9340 (  0.00%)     286.5759 (-37.16%)
CoeffVar elapsed-3      10.8759 (  0.00%)      13.2441 (-21.78%)
CoeffVar elapsed-5      50.6194 (  0.00%)      57.4107 (-13.42%)
CoeffVar elapsed-7       8.8904 (  0.00%)      73.5236 (-727.00%)
CoeffVar elapsed-8      48.1691 (  0.00%)      57.4055 (-19.18%)
Max      system-1        2.9900 (  0.00%)       2.6600 ( 11.04%)
Max      system-3        0.2900 (  0.00%)       0.2700 (  6.90%)
Max      system-5        1.5200 (  0.00%)       1.4000 (  7.89%)
Max      system-7        0.5700 (  0.00%)       2.6200 (-359.65%)
Max      system-8        1.8700 (  0.00%)       1.9300 ( -3.21%)
Max      elapsed-1       4.1200 (  0.00%)       3.3900 ( 17.72%)
Max      elapsed-3       0.1100 (  0.00%)       0.1000 (  9.09%)
Max      elapsed-5       0.3800 (  0.00%)       0.3700 (  2.63%)
Max      elapsed-7       0.1000 (  0.00%)       0.4900 (-390.00%)
Max      elapsed-8       0.2700 (  0.00%)       0.2900 ( -7.41%)

pft faults
                                            guest                       guest
                                    without-patch                  with-patch
Min      faults/cpu-1    4339.4990 (  0.00%)    4883.1470 ( 12.53%)
Min      faults/cpu-3   42093.3690 (  0.00%)   45489.7530 (  8.07%)
Min      faults/cpu-5    8458.7940 (  0.00%)    9107.9580 (  7.67%)
Min      faults/cpu-7   21747.4000 (  0.00%)    4824.7950 (-77.81%)
Min      faults/cpu-8    6778.2410 (  0.00%)    6542.3320 ( -3.48%)
Min      faults/sec-1    3168.3390 (  0.00%)    3844.8860 ( 21.35%)
Min      faults/sec-3  122912.2040 (  0.00%)  124417.2460 (  1.22%)
Min      faults/sec-5   33891.4780 (  0.00%)   35242.9170 (  3.99%)
Min      faults/sec-7  126138.4850 (  0.00%)   26380.8510 (-79.09%)
Min      faults/sec-8   47493.9370 (  0.00%)   44882.3140 ( -5.50%)
Hmean    faults/cpu-1   65728.7295 (  0.00%)  112975.9206 ( 71.88%)
Hmean    faults/cpu-3   67715.8785 (  0.00%)   74340.0153 (  9.78%)
Hmean    faults/cpu-5   36339.2283 (  0.00%)   37396.4486 (  2.91%)
Hmean    faults/cpu-7   33959.8828 (  0.00%)   27199.2785 (-19.91%)
Hmean    faults/cpu-8   26145.9644 (  0.00%)   28495.1995 (  8.99%)
Hmean    faults/sec-1   56465.3726 (  0.00%)  100362.9738 ( 77.74%)
Hmean    faults/sec-3  166282.3786 (  0.00%)  183015.5259 ( 10.06%)
Hmean    faults/sec-5  142135.4993 (  0.00%)  144915.9134 (  1.96%)
Hmean    faults/sec-7  182191.8573 (  0.00%)  147016.2008 (-19.31%)
Hmean    faults/sec-8  166712.4745 (  0.00%)  175603.5422 (  5.33%)
Stddev   faults/cpu-1   21957.2462 (  0.00%)   23554.5092 ( -7.27%)
Stddev   faults/cpu-3    7091.4813 (  0.00%)    9985.8867 (-40.82%)
Stddev   faults/cpu-5    7541.9566 (  0.00%)    8947.1204 (-18.63%)
Stddev   faults/cpu-7    3980.6287 (  0.00%)    8638.2507 (-117.01%)
Stddev   faults/cpu-8    6429.2045 (  0.00%)    7858.0479 (-22.22%)
Stddev   faults/sec-1   21569.0114 (  0.00%)   21640.5914 ( -0.33%)
Stddev   faults/sec-3   14715.2173 (  0.00%)   21064.4060 (-43.15%)
Stddev   faults/sec-5   30084.3765 (  0.00%)   34040.2952 (-13.15%)
Stddev   faults/sec-7   13592.3120 (  0.00%)   45590.2568 (-235.41%)
Stddev   faults/sec-8   31470.9091 (  0.00%)   40231.8893 (-27.84%)
CoeffVar faults/cpu-1      23.2163 (  0.00%)      14.9965 ( 35.41%)
CoeffVar faults/cpu-3      10.3387 (  0.00%)      13.1506 (-27.20%)
CoeffVar faults/cpu-5      18.9342 (  0.00%)      21.4360 (-13.21%)
CoeffVar faults/cpu-7      11.5648 (  0.00%)      26.3385 (-127.75%)
CoeffVar faults/cpu-8      22.0578 (  0.00%)      23.8259 ( -8.02%)
CoeffVar faults/sec-1      23.8979 (  0.00%)      14.7121 ( 38.44%)
CoeffVar faults/sec-3       8.7752 (  0.00%)      11.3428 (-29.26%)
CoeffVar faults/sec-5      19.3505 (  0.00%)      21.0165 ( -8.61%)
CoeffVar faults/sec-7       7.4160 (  0.00%)      25.8994 (-249.24%)
CoeffVar faults/sec-8      17.3858 (  0.00%)      20.3632 (-17.13%)
Max      faults/cpu-1  135058.1560 (  0.00%)  179611.8510 ( 32.99%)
Max      faults/cpu-3   81575.7040 (  0.00%)   91510.1490 ( 12.18%)
Max      faults/cpu-5   50969.3560 (  0.00%)   62628.1740 ( 22.87%)
Max      faults/cpu-7   45106.2770 (  0.00%)   47090.8720 (  4.40%)
Max      faults/cpu-8   50540.8730 (  0.00%)   51169.9640 (  1.24%)
Max      faults/sec-1  130267.4950 (  0.00%)  159347.5220 ( 22.32%)
Max      faults/sec-3  193635.1080 (  0.00%)  223454.3190 ( 15.40%)
Max      faults/sec-5  204045.3880 (  0.00%)  219350.7390 (  7.50%)
Max      faults/sec-7  217209.2480 (  0.00%)  225028.8150 (  3.60%)
Max      faults/sec-8  215116.6780 (  0.00%)  231008.5060 (  7.39%)

               guest       guest
        without-patch  with-patch
User           15.01       16.37
System        146.03      164.43
Elapsed        52.21       57.82

                                 guest       guest
                          without-patch  with-patch
Minor Faults                   5481327     5493919
Major Faults                         0          90
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                     5271143     5277377
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
Sector Reads                        72       14632
Sector Writes                      508        3760
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
NUMA alloc hit                 5271051     5277260
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local               5271051     5277260
NUMA base PTE updates            19661       11194
NUMA huge PMD updates                0           0
NUMA page range updates          19661       11194
NUMA hint faults                    19          14
NUMA hint local faults              19          14
NUMA hint local percent            100         100
NUMA pages migrated                  0           0
AutoNUMA cost                       0%          0%

ebizzy Overall Throughput
                                       guest                       guest
                               without-patch                  with-patch
Min      Rsec-1      6614.00 (  0.00%)     4366.00 (-33.99%)
Min      Rsec-3     10621.00 (  0.00%)     7221.00 (-32.01%)
Min      Rsec-5     10792.00 (  0.00%)     7634.00 (-29.26%)
Min      Rsec-7     10994.00 (  0.00%)     7649.00 (-30.43%)
Min      Rsec-12    13824.00 (  0.00%)     7520.00 (-45.60%)
Min      Rsec-18    12508.00 (  0.00%)     7465.00 (-40.32%)
Min      Rsec-24    14684.00 (  0.00%)     9897.00 (-32.60%)
Min      Rsec-30    14917.00 (  0.00%)    10430.00 (-30.08%)
Min      Rsec-32    14566.00 (  0.00%)    10135.00 (-30.42%)
Hmean    Rsec-1      6693.18 (  0.00%)     4393.27 (-34.36%)
Hmean    Rsec-3     10900.07 (  0.00%)     7536.06 (-30.86%)
Hmean    Rsec-5     11428.67 (  0.00%)     7776.80 (-31.95%)
Hmean    Rsec-7     11632.77 (  0.00%)     7862.60 (-32.41%)
Hmean    Rsec-12    14513.82 (  0.00%)     7719.10 (-46.82%)
Hmean    Rsec-18    13291.53 (  0.00%)     7785.99 (-41.42%)
Hmean    Rsec-24    14897.25 (  0.00%)    10232.64 (-31.31%)
Hmean    Rsec-30    15259.81 (  0.00%)    10658.01 (-30.16%)
Hmean    Rsec-32    14884.59 (  0.00%)    10651.59 (-28.44%)
Stddev   Rsec-1        64.40 (  0.00%)       24.20 ( 62.41%)
Stddev   Rsec-3       178.18 (  0.00%)      170.17 (  4.49%)
Stddev   Rsec-5       374.77 (  0.00%)       78.30 ( 79.11%)
Stddev   Rsec-7       495.33 (  0.00%)      124.71 ( 74.82%)
Stddev   Rsec-12      825.33 (  0.00%)      113.93 ( 86.20%)
Stddev   Rsec-18      733.83 (  0.00%)      393.07 ( 46.44%)
Stddev   Rsec-24      118.49 (  0.00%)      279.08 (-135.54%)
Stddev   Rsec-30      270.38 (  0.00%)      145.14 ( 46.32%)
Stddev   Rsec-32      342.51 (  0.00%)      441.92 (-29.03%)
CoeffVar Rsec-1         0.96 (  0.00%)        0.55 ( 42.73%)
CoeffVar Rsec-3         1.63 (  0.00%)        2.26 (-38.10%)
CoeffVar Rsec-5         3.28 (  0.00%)        1.01 ( 69.27%)
CoeffVar Rsec-7         4.25 (  0.00%)        1.59 ( 62.69%)
CoeffVar Rsec-12        5.67 (  0.00%)        1.48 ( 73.97%)
CoeffVar Rsec-18        5.50 (  0.00%)        5.04 (  8.51%)
CoeffVar Rsec-24        0.80 (  0.00%)        2.73 (-242.68%)
CoeffVar Rsec-30        1.77 (  0.00%)        1.36 ( 23.13%)
CoeffVar Rsec-32        2.30 (  0.00%)        4.14 (-80.09%)
Max      Rsec-1      6792.00 (  0.00%)     4429.00 (-34.79%)
Max      Rsec-3     11131.00 (  0.00%)     7700.00 (-30.82%)
Max      Rsec-5     11933.00 (  0.00%)     7842.00 (-34.28%)
Max      Rsec-7     12508.00 (  0.00%)     8027.00 (-35.83%)
Max      Rsec-12    16002.00 (  0.00%)     7847.00 (-50.96%)
Max      Rsec-18    14516.00 (  0.00%)     8567.00 (-40.98%)
Max      Rsec-24    15013.00 (  0.00%)    10599.00 (-29.40%)
Max      Rsec-30    15656.00 (  0.00%)    10853.00 (-30.68%)
Max      Rsec-32    15385.00 (  0.00%)    11381.00 (-26.03%)

ebizzy Per-thread
                                       guest                       guest
                               without-patch                  with-patch
Min      Rsec-1      6614.00 (  0.00%)     4366.00 (-33.99%)
Min      Rsec-3      3464.00 (  0.00%)     2387.00 (-31.09%)
Min      Rsec-5      2100.00 (  0.00%)     1486.00 (-29.24%)
Min      Rsec-7      1494.00 (  0.00%)     1016.00 (-31.99%)
Min      Rsec-12     1010.00 (  0.00%)      586.00 (-41.98%)
Min      Rsec-18      571.00 (  0.00%)      373.00 (-34.68%)
Min      Rsec-24      473.00 (  0.00%)      330.00 (-30.23%)
Min      Rsec-30      398.00 (  0.00%)      283.00 (-28.89%)
Min      Rsec-32      364.00 (  0.00%)      250.00 (-31.32%)
Hmean    Rsec-1      6693.18 (  0.00%)     4393.27 (-34.36%)
Hmean    Rsec-3      3627.65 (  0.00%)     2504.84 (-30.95%)
Hmean    Rsec-5      2283.84 (  0.00%)     1554.53 (-31.93%)
Hmean    Rsec-7      1637.70 (  0.00%)     1121.58 (-31.51%)
Hmean    Rsec-12     1192.25 (  0.00%)      642.41 (-46.12%)
Hmean    Rsec-18      687.06 (  0.00%)      428.11 (-37.69%)
Hmean    Rsec-24      606.35 (  0.00%)      415.99 (-31.39%)
Hmean    Rsec-30      497.96 (  0.00%)      349.99 (-29.72%)
Hmean    Rsec-32      455.21 (  0.00%)      323.05 (-29.03%)
Stddev   Rsec-1        64.40 (  0.00%)       24.20 (-62.41%)
Stddev   Rsec-3       156.31 (  0.00%)      147.43 ( -5.68%)
Stddev   Rsec-5        95.61 (  0.00%)       30.04 (-68.58%)
Stddev   Rsec-7       286.41 (  0.00%)       40.64 (-85.81%)
Stddev   Rsec-12      178.07 (  0.00%)       19.11 (-89.27%)
Stddev   Rsec-18      250.94 (  0.00%)       69.96 (-72.12%)
Stddev   Rsec-24       97.93 (  0.00%)       69.89 (-28.63%)
Stddev   Rsec-30       81.68 (  0.00%)       42.31 (-48.20%)
Stddev   Rsec-32       70.76 (  0.00%)       62.86 (-11.16%)
CoeffVar Rsec-1         0.96 (  0.00%)        0.55 ( 42.73%)
CoeffVar Rsec-3         4.30 (  0.00%)        5.87 (-36.40%)
CoeffVar Rsec-5         4.18 (  0.00%)        1.93 ( 53.78%)
CoeffVar Rsec-7        17.21 (  0.00%)        3.62 ( 78.97%)
CoeffVar Rsec-12       14.68 (  0.00%)        2.97 ( 79.76%)
CoeffVar Rsec-18       33.90 (  0.00%)       16.15 ( 52.35%)
CoeffVar Rsec-24       15.79 (  0.00%)       16.40 ( -3.86%)
CoeffVar Rsec-30       16.07 (  0.00%)       11.92 ( 25.79%)
CoeffVar Rsec-32       15.22 (  0.00%)       18.88 (-24.05%)
Max      Rsec-1      6792.00 (  0.00%)     4429.00 (-34.79%)
Max      Rsec-3      3968.00 (  0.00%)     2818.00 (-28.98%)
Max      Rsec-5      2480.00 (  0.00%)     1607.00 (-35.20%)
Max      Rsec-7      3290.00 (  0.00%)     1193.00 (-63.74%)
Max      Rsec-12     1842.00 (  0.00%)      678.00 (-63.19%)
Max      Rsec-18     1495.00 (  0.00%)     1074.00 (-28.16%)
Max      Rsec-24      987.00 (  0.00%)      738.00 (-25.23%)
Max      Rsec-30      824.00 (  0.00%)      456.00 (-44.66%)
Max      Rsec-32      690.00 (  0.00%)      581.00 (-15.80%)

ebizzy Thread spread
                                         guest                       guest
                                 without-patch                  with-patch
Min      spread-1         0.00 (  0.00%)        0.00 (  0.00%)
Min      spread-3        69.00 (  0.00%)       38.00 ( 44.93%)
Min      spread-5       126.00 (  0.00%)       54.00 ( 57.14%)
Min      spread-7        79.00 (  0.00%)       78.00 (  1.27%)
Min      spread-12      262.00 (  0.00%)       36.00 ( 86.26%)
Min      spread-18      667.00 (  0.00%)       39.00 ( 94.15%)
Min      spread-24      300.00 (  0.00%)      156.00 ( 48.00%)
Min      spread-30      330.00 (  0.00%)      100.00 ( 69.70%)
Min      spread-32      220.00 (  0.00%)      158.00 ( 28.18%)
Hmean    spread-1         0.00 (  0.00%)        0.00 (  0.00%)
Hmean    spread-3       162.44 (  0.00%)      125.30 ( 22.86%)
Hmean    spread-5       161.03 (  0.00%)       65.41 ( 59.38%)
Hmean    spread-7       143.51 (  0.00%)      102.37 ( 28.67%)
Hmean    spread-12      376.64 (  0.00%)       53.48 ( 85.80%)
Hmean    spread-18      758.21 (  0.00%)       58.48 ( 92.29%)
Hmean    spread-24      348.60 (  0.00%)      215.23 ( 38.26%)
Hmean    spread-30      358.66 (  0.00%)      126.49 ( 64.73%)
Hmean    spread-32      264.70 (  0.00%)      199.06 ( 24.80%)
Stddev   spread-1         0.00 (  0.00%)        0.00 (  0.00%)
Stddev   spread-3       160.65 (  0.00%)      134.27 ( 16.42%)
Stddev   spread-5        20.56 (  0.00%)       14.92 ( 27.43%)
Stddev   spread-7       667.59 (  0.00%)       23.11 ( 96.54%)
Stddev   spread-12      190.86 (  0.00%)       11.03 ( 94.22%)
Stddev   spread-18       64.39 (  0.00%)      244.20 (-279.25%)
Stddev   spread-24       63.41 (  0.00%)       78.27 (-23.44%)
Stddev   spread-30       34.19 (  0.00%)       25.58 ( 25.20%)
Stddev   spread-32       27.74 (  0.00%)       63.89 (-130.27%)
CoeffVar spread-1         0.00 (  0.00%)        0.00 (  0.00%)
CoeffVar spread-3        58.00 (  0.00%)       50.71 (-12.57%)
CoeffVar spread-5        12.54 (  0.00%)       21.81 ( 73.99%)
CoeffVar spread-7       144.19 (  0.00%)       21.60 (-85.02%)
CoeffVar spread-12       42.68 (  0.00%)       19.63 (-54.00%)
CoeffVar spread-18        8.43 (  0.00%)      139.55 (1554.83%)
CoeffVar spread-24       17.71 (  0.00%)       33.28 ( 87.89%)
CoeffVar spread-30        9.46 (  0.00%)       19.49 (106.17%)
CoeffVar spread-32       10.36 (  0.00%)       29.61 (185.76%)
Max      spread-1         0.00 (  0.00%)        0.00 (  0.00%)
Max      spread-3       492.00 (  0.00%)      386.00 ( 21.54%)
Max      spread-5       185.00 (  0.00%)       89.00 ( 51.89%)
Max      spread-7      1796.00 (  0.00%)      146.00 ( 91.87%)
Max      spread-12      686.00 (  0.00%)       69.00 ( 89.94%)
Max      spread-18      869.00 (  0.00%)      662.00 ( 23.82%)
Max      spread-24      479.00 (  0.00%)      384.00 ( 19.83%)
Max      spread-30      426.00 (  0.00%)      173.00 ( 59.39%)
Max      spread-32      302.00 (  0.00%)      312.00 ( -3.31%)

               guest       guest
        without-patch  with-patch
User         1585.46      996.79
System       6802.57     7388.01
Elapsed      1352.70     1355.62

                                 guest       guest
                          without-patch  with-patch
Minor Faults                 102375790    67314425
Major Faults                         0           1
Swap Ins                             0           0
Swap Outs                            0           0
Allocation stalls                    0           0
DMA allocs                   102297177    67229359
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
Sector Reads                       428         620
Sector Writes                     4164        4620
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
NUMA alloc hit               102297213    67229443
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local             102297213    67229443
NUMA base PTE updates            43814       45596
NUMA huge PMD updates                0           0
NUMA page range updates          43814       45596
NUMA hint faults                 35181       36243
NUMA hint local faults           35181       36243
NUMA hint local percent            100         100
NUMA pages migrated                  0           0
AutoNUMA cost                     176%        181%
