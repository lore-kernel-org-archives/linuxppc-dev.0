Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysJcJ5YqQzDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 00:00:00 +1100 (AEDT)
In-Reply-To: <20171130083322.31206-1-ravi.bangoria@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, paulus@samba.org,
 kan.liang@intel.com, tglx@linutronix.de, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/perf: Fix oops when grouping different pmu events
Message-Id: <3ysJcJ3ygHz9sRV@ozlabs.org>
Date: Wed,  6 Dec 2017 23:59:59 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-30 at 08:33:22 UTC, Ravi Bangoria wrote:
> When user tries to group imc (In-Memory Collections) event with
> normal event, (sometime) kernel crashes with following log:
> 
>     Faulting instruction address: 0x00000000
>     [link register   ] c00000000010ce88 power_check_constraints+0x128/0x980
>     ...
>     c00000000010e238 power_pmu_event_init+0x268/0x6f0
>     c0000000002dc60c perf_try_init_event+0xdc/0x1a0
>     c0000000002dce88 perf_event_alloc+0x7b8/0xac0
>     c0000000002e92e0 SyS_perf_event_open+0x530/0xda0
>     c00000000000b004 system_call+0x38/0xe0
> 
> 'event_base' field of 'struct hw_perf_event' is used as flags for
> normal hw events and used as memory address for imc events. While
> grouping these two types of events, collect_events() tries to
> interpret imc 'event_base' as a flag, which causes a corruption
> resulting in a crash.
> 
> Consider only those events which belongs to 'perf_hw_context' in
> collect_events().
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Reviewed-By: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/5aa04b3eb6fca63d2e9827be656dca

cheers
