Return-Path: <yao.jin@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w37VC3MPyzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:42:58 +1000 (AEST)
Subject: Re: [PATCH v4 0/5] perf report: Show branch type
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
References: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
 <20170412105839.GC14409@krava>
 <baf0ed91-e69c-255b-10f0-a4d82efa78eb@linux.intel.com>
 <20170412142647.GA27451@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <9bbb8cc8-30d4-49b4-771b-fb529024aa98@linux.intel.com>
Date: Wed, 12 Apr 2017 23:42:44 +0800
MIME-Version: 1.0
In-Reply-To: <20170412142647.GA27451@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 4/12/2017 10:26 PM, Jiri Olsa wrote:
> On Wed, Apr 12, 2017 at 08:25:34PM +0800, Jin, Yao wrote:
>
> SNIP
>
>>> # Overhead  Command  Source Shared Object  Source Symbol                            Target Symbol                            Basic Block Cycles
>>> # ........  .......  ....................  .......................................  .......................................  ..................
>>> #
>>>        8.30%  perf
>>> Um  [kernel.vmlinux]      [k] __intel_pmu_enable_all.constprop.17  [k] native_write_msr                     -
>>>        7.91%  perf
>>> Um  [kernel.vmlinux]      [k] intel_pmu_lbr_enable_all             [k] __intel_pmu_enable_all.constprop.17  -
>>>        7.91%  perf
>>> Um  [kernel.vmlinux]      [k] native_write_msr                     [k] intel_pmu_lbr_enable_all             -
>>>        6.32%  kill     libc-2.24.so          [.] _dl_addr                             [.] _dl_addr                             -
>>>        5.93%  perf
>>> Um  [kernel.vmlinux]      [k] perf_iterate_ctx                     [k] perf_iterate_ctx                     -
>>>        2.77%  kill     libc-2.24.so          [.] malloc                               [.] malloc                               -
>>>        1.98%  kill     libc-2.24.so          [.] _int_malloc                          [.] _int_malloc                          -
>>>        1.58%  kill     [kernel.vmlinux]      [k] __rb_insert_augmented                [k] __rb_insert_augmented                -
>>>        1.58%  perf
>>> Um  [kernel.vmlinux]      [k] perf_event_exec                      [k] perf_event_exec                      -
>>>        1.19%  kill     [kernel.vmlinux]      [k] anon_vma_interval_tree_insert        [k] anon_vma_interval_tree_insert        -
>>>        1.19%  kill     [kernel.vmlinux]      [k] free_pgd_range                       [k] free_pgd_range                       -
>>>        1.19%  kill     [kernel.vmlinux]      [k] n_tty_write                          [k] n_tty_write                          -
>>>        1.19%  perf
>>> Um  [kernel.vmlinux]      [k] native_sched_clock                   [k] sched_clock                          -
>>> ...
>>> SNIP
>>>
>>>
>>> jirka
>> Hi,
>>
>> Thanks so much for trying this patch.
>>
>> The branch statistics is printed at the end of perf report --stdio.
> yep, but for some reason with your changes the head report
> got changed as well, I haven't checked the details yet..
>
> jirka

The kill returns immediately with no parameter error. Could you try an 
application which can run for a while?

For example:
perf record -j any,save_type top

Thanks
Jin Yao
