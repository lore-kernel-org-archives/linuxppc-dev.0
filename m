Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w31BD0XLyzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 20:58:44 +1000 (AEST)
Date: Wed, 12 Apr 2017 12:58:39 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com,
 kan.liang@intel.com, yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 0/5] perf report: Show branch type
Message-ID: <20170412105839.GC14409@krava>
References: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2017 at 06:21:01AM +0800, Jin Yao wrote:

SNIP

> 
> 3. Use 2 bits in perf_branch_entry for a "cross" metrics checking
>    for branch cross 4K or 2M area. It's an approximate computing
>    for checking if the branch cross 4K page or 2MB page.
> 
> For example:
> 
> perf record -g --branch-filter any,save_type <command>
> 
> perf report --stdio
> 
>      JCC forward:  27.7%
>     JCC backward:   9.8%
>              JMP:   0.0%
>          IND_JMP:   6.5%
>             CALL:  26.6%
>         IND_CALL:   0.0%
>              RET:  29.3%
>             IRET:   0.0%
>         CROSS_4K:   0.0%
>         CROSS_2M:  14.3%

got mangled perf report --stdio output for:


[root@ibm-x3650m4-02 perf]# ./perf record -j any,save_type kill
kill: not enough arguments
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.013 MB perf.data (18 samples) ]

[root@ibm-x3650m4-02 perf]# ./perf report --stdio -f | head -30
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 253  of event 'cycles'
# Event count (approx.): 253
#
# Overhead  Command  Source Shared Object  Source Symbol                            Target Symbol                            Basic Block Cycles
# ........  .......  ....................  .......................................  .......................................  ..................
#
     8.30%  perf
Um  [kernel.vmlinux]      [k] __intel_pmu_enable_all.constprop.17  [k] native_write_msr                     -                 
     7.91%  perf
Um  [kernel.vmlinux]      [k] intel_pmu_lbr_enable_all             [k] __intel_pmu_enable_all.constprop.17  -                 
     7.91%  perf
Um  [kernel.vmlinux]      [k] native_write_msr                     [k] intel_pmu_lbr_enable_all             -                 
     6.32%  kill     libc-2.24.so          [.] _dl_addr                             [.] _dl_addr                             -                 
     5.93%  perf
Um  [kernel.vmlinux]      [k] perf_iterate_ctx                     [k] perf_iterate_ctx                     -                 
     2.77%  kill     libc-2.24.so          [.] malloc                               [.] malloc                               -                 
     1.98%  kill     libc-2.24.so          [.] _int_malloc                          [.] _int_malloc                          -                 
     1.58%  kill     [kernel.vmlinux]      [k] __rb_insert_augmented                [k] __rb_insert_augmented                -                 
     1.58%  perf
Um  [kernel.vmlinux]      [k] perf_event_exec                      [k] perf_event_exec                      -                 
     1.19%  kill     [kernel.vmlinux]      [k] anon_vma_interval_tree_insert        [k] anon_vma_interval_tree_insert        -                 
     1.19%  kill     [kernel.vmlinux]      [k] free_pgd_range                       [k] free_pgd_range                       -                 
     1.19%  kill     [kernel.vmlinux]      [k] n_tty_write                          [k] n_tty_write                          -                 
     1.19%  perf
Um  [kernel.vmlinux]      [k] native_sched_clock                   [k] sched_clock                          -                 
...
SNIP


jirka
