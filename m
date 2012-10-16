Return-Path: <eranian@google.com>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C5792C009F
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 23:21:42 +1100 (EST)
Received: by mail-la0-f42.google.com with SMTP id e6so3746430lah.15
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 05:21:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121016100809.GS8285@erda.amd.com>
References: <20121012012839.GA15348@us.ibm.com>
 <20121015155534.GR8285@erda.amd.com>
 <20121016100809.GS8285@erda.amd.com>
Date: Tue, 16 Oct 2012 14:21:38 +0200
Message-ID: <CABPqkBRd2wfjd1ObCkM+TSSwt7C9WP65dEE9POSyDK1ccvNL8A@mail.gmail.com>
Subject: Re: [RFC][PATCH] perf: Add a few generic stalled-cycles events
From: Stephane Eranian <eranian@google.com>
To: Robert Richter <robert.richter@amd.com>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>, Anton Blanchard <anton@au1.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, mpjohn@us.ibm.com,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Arun Sharma <asharma@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 16, 2012 at 12:08 PM, Robert Richter <robert.richter@amd.com> wrote:
> Sukadev,
>
> On 15.10.12 17:55:34, Robert Richter wrote:
>> On 11.10.12 18:28:39, Sukadev Bhattiprolu wrote:
>> > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_FIXED_POINT },
>> > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_LOAD_STORE },
>> > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_INSTRUCTION_FETCH },
>> > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_BRANCH },
>>
>> Instead of adding new hardware event types I would prefer to use raw
>> events in conjunction with sysfs, see e.g. the intel-uncore
>> implementation. Something like:
>>
In general, I don't like generic events and especially stall events. I
have not seen a clear definition of
what they mean. Without it, there is no way to understand how to map
them across architecture. If
the definition is too precise, you may not be able to find an exact
mapping. If the definition is to loose
then it is unclear what you are measuring.

Also this opens another can of worms which is that on some processors,
you may need more than
one event to encapsulate what the generic event is supposed to
measure. That means developing
a lot of code in the kernel to express and manage that. And of course,
you would not be able
to sample on those events (you cannot sample on a difference, for
instance). So all in all, I think
this is not a very good idea. You have to put this into the tool or a
library that auto-detects the
host CPU and programs the right set of events.

We've had that discussion many times. Just reiterating my personal
opinion on this.

>>  $ find /sys/bus/event_source/devices/cpu/events/
>>  ...
>>  /sys/bus/event_source/devices/cpu/events/stalled-cycles-fixed-point
>>  /sys/bus/event_source/devices/cpu/events/stalled-cycles-load-store
>>  /sys/bus/event_source/devices/cpu/events/stalled-cycles-instruction-fetch
>>  /sys/bus/event_source/devices/cpu/events/stalled-cycles-branch
>>  ...
>>  $ cat /sys/bus/event_source/devices/cpu/events/stalled-cycles-fixed-point
>>  event=0xff,umask=0x00
>>
>> Perf tool works then out-of-the-box with:
>>
>>  $ perf record -e cpu/stalled-cycles-fixed-point/ ...
>
> I refer here to arch/x86/kernel/cpu/perf_event_intel_uncore.c (should
> be in v3.7-rc1 or tip:perf/core). See the INTEL_UNCORE_EVENT_DESC()
> macro and 'if (type->event_descs) ...' in uncore_type_init(). The code
> should be reworked to be non-architectural.
>
> PMU registration is implemented for a longer time already for all
> architectures and pmu types:
>
>  /sys/bus/event_source/devices/*
>
> But
>
>  /sys/bus/event_source/devices/*/events/
>
> exists only for a small number of pmus. Perf tool support of this was
> implemented with:
>
>  a6146d5 perf/tool: Add PMU event alias support
>
> -Robert
>
> --
> Advanced Micro Devices, Inc.
> Operating System Research Center
>
