Return-Path: <robert.richter@amd.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D75652C0097
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 21:08:23 +1100 (EST)
Date: Tue, 16 Oct 2012 12:08:09 +0200
From: Robert Richter <robert.richter@amd.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] perf: Add a few generic stalled-cycles events
Message-ID: <20121016100809.GS8285@erda.amd.com>
References: <20121012012839.GA15348@us.ibm.com>
 <20121015155534.GR8285@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20121015155534.GR8285@erda.amd.com>
Cc: peterz@infradead.org, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, eranian@google.com, acme@redhat.com,
 linuxppc-dev@ozlabs.org, paulus@samba.org, mpjohn@us.ibm.com, mingo@kernel.org,
 asharma@fb.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev,

On 15.10.12 17:55:34, Robert Richter wrote:
> On 11.10.12 18:28:39, Sukadev Bhattiprolu wrote:
> > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_FIXED_POINT },
> > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_LOAD_STORE },
> > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_INSTRUCTION_FETCH },
> > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_BRANCH },
> 
> Instead of adding new hardware event types I would prefer to use raw
> events in conjunction with sysfs, see e.g. the intel-uncore
> implementation. Something like:
> 
>  $ find /sys/bus/event_source/devices/cpu/events/
>  ...
>  /sys/bus/event_source/devices/cpu/events/stalled-cycles-fixed-point
>  /sys/bus/event_source/devices/cpu/events/stalled-cycles-load-store
>  /sys/bus/event_source/devices/cpu/events/stalled-cycles-instruction-fetch
>  /sys/bus/event_source/devices/cpu/events/stalled-cycles-branch
>  ...
>  $ cat /sys/bus/event_source/devices/cpu/events/stalled-cycles-fixed-point
>  event=0xff,umask=0x00
> 
> Perf tool works then out-of-the-box with:
> 
>  $ perf record -e cpu/stalled-cycles-fixed-point/ ...

I refer here to arch/x86/kernel/cpu/perf_event_intel_uncore.c (should
be in v3.7-rc1 or tip:perf/core). See the INTEL_UNCORE_EVENT_DESC()
macro and 'if (type->event_descs) ...' in uncore_type_init(). The code
should be reworked to be non-architectural.

PMU registration is implemented for a longer time already for all
architectures and pmu types:

 /sys/bus/event_source/devices/*

But

 /sys/bus/event_source/devices/*/events/

exists only for a small number of pmus. Perf tool support of this was
implemented with:

 a6146d5 perf/tool: Add PMU event alias support

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
