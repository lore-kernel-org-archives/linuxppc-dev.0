Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B87051A009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 01:46:03 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id hj7so1299614pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Mar 2016 06:46:03 -0800 (PST)
Subject: Re: [PATCH 0/2] mm: Enable page parallel initialisation for Power
To: Li Zhang <zhlcindy@gmail.com>, akpm@linux-foundation.org, vbabka@suse.cz,
 mgorman@techsingularity.net, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com
References: <1457409354-10867-1-git-send-email-zhlcindy@gmail.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Li Zhang <zhlcindy@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56DEE59F.7020602@gmail.com>
Date: Wed, 9 Mar 2016 01:45:51 +1100
MIME-Version: 1.0
In-Reply-To: <1457409354-10867-1-git-send-email-zhlcindy@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/03/16 14:55, Li Zhang wrote:
> From: Li Zhang <zhlcindy@linux.vnet.ibm.com>
>
> Uptream has supported page parallel initialisation for X86 and the
> boot time is improved greately. Some tests have been done for Power.
>
> Here is the result I have done with different memory size.
>
> * 4GB memory:
>     boot time is as the following: 
>     with patch vs without patch: 10.4s vs 24.5s
>     boot time is improved 57%
> * 200GB memory: 
>     boot time looks the same with and without patches.
>     boot time is about 38s
> * 32TB memory: 
>     boot time looks the same with and without patches 
>     boot time is about 160s.
>     The boot time is much shorter than X86 with 24TB memory.
>     From community discussion, it costs about 694s for X86 24T system.
>
> From code view, parallel initialisation improve the performance by
> deferring memory initilisation to kswap with N kthreads, it should
> improve the performance therotically. 
>
> From the test result, On X86, performance is improved greatly with huge
> memory. But on Power platform, it is improved greatly with less than 
> 100GB memory. For huge memory, it is not improved greatly. But it saves 
> the time with several threads at least, as the following information 
> shows(32TB system log):
>
> [   22.648169] node 9 initialised, 16607461 pages in 280ms
> [   22.783772] node 3 initialised, 23937243 pages in 410ms
> [   22.858877] node 6 initialised, 29179347 pages in 490ms
> [   22.863252] node 2 initialised, 29179347 pages in 490ms
> [   22.907545] node 0 initialised, 32049614 pages in 540ms
> [   22.920891] node 15 initialised, 32212280 pages in 550ms
> [   22.923236] node 4 initialised, 32306127 pages in 550ms
> [   22.923384] node 12 initialised, 32314319 pages in 550ms
> [   22.924754] node 8 initialised, 32314319 pages in 550ms
> [   22.940780] node 13 initialised, 33353677 pages in 570ms
> [   22.940796] node 11 initialised, 33353677 pages in 570ms
> [   22.941700] node 5 initialised, 33353677 pages in 570ms
> [   22.941721] node 10 initialised, 33353677 pages in 570ms
> [   22.941876] node 7 initialised, 33353677 pages in 570ms
> [   22.944946] node 14 initialised, 33353677 pages in 570ms
> [   22.946063] node 1 initialised, 33345485 pages in 580ms
>
> It saves the time about 550*16 ms at least, although it can be ignore to compare 
> the boot time about 160 seconds. What's more, the boot time is much shorter 
> on Power even without patches than x86 for huge memory machine. 
>
> So this patchset is still necessary to be enabled for Power. 
>
>

The patchset looks good, two questions

1. The patchset is still necessary for
    a. systems with smaller amount of RAM?
    b. Theoretically it improves boot time?
2. the pgdat->node_spanned_pages >> 8 sounds arbitrary
    On a system with 2TB*16 nodes, it would initialize about 8GB before calling deferred init?
    Don't we need at-least 32GB + space for other early hash allocations
    BTW, My expectation was that 32TB would imply 32GB+32GB of large hash allocations early on

Balbir Singh.
