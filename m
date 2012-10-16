Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C7352C00A6
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2012 05:33:25 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 16 Oct 2012 12:33:19 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9832B19D8041
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 12:31:52 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9GIVPvE081404
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 12:31:30 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9GIVKlt005902
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 12:31:22 -0600
Date: Tue, 16 Oct 2012 11:31:48 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Robert Richter <robert.richter@amd.com>
Subject: Re: [RFC][PATCH] perf: Add a few generic stalled-cycles events
Message-ID: <20121016183148.GA25482@us.ibm.com>
References: <20121012012839.GA15348@us.ibm.com>
 <20121015155534.GR8285@erda.amd.com>
 <20121016100809.GS8285@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121016100809.GS8285@erda.amd.com>
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

Robert Richter [robert.richter@amd.com] wrote:
| Sukadev,
| 
| On 15.10.12 17:55:34, Robert Richter wrote:
| > On 11.10.12 18:28:39, Sukadev Bhattiprolu wrote:
| > > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_FIXED_POINT },
| > > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_LOAD_STORE },
| > > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_INSTRUCTION_FETCH },
| > > +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_BRANCH },
| > 
| > Instead of adding new hardware event types I would prefer to use raw
| > events in conjunction with sysfs, see e.g. the intel-uncore
| > implementation. Something like:
| > 
| >  $ find /sys/bus/event_source/devices/cpu/events/
| >  ...
| >  /sys/bus/event_source/devices/cpu/events/stalled-cycles-fixed-point
| >  /sys/bus/event_source/devices/cpu/events/stalled-cycles-load-store
| >  /sys/bus/event_source/devices/cpu/events/stalled-cycles-instruction-fetch
| >  /sys/bus/event_source/devices/cpu/events/stalled-cycles-branch
| >  ...
| >  $ cat /sys/bus/event_source/devices/cpu/events/stalled-cycles-fixed-point
| >  event=0xff,umask=0x00
| > 
| > Perf tool works then out-of-the-box with:
| > 
| >  $ perf record -e cpu/stalled-cycles-fixed-point/ ...
| 
| I refer here to arch/x86/kernel/cpu/perf_event_intel_uncore.c (should
| be in v3.7-rc1 or tip:perf/core). See the INTEL_UNCORE_EVENT_DESC()
| macro and 'if (type->event_descs) ...' in uncore_type_init(). The code
| should be reworked to be non-architectural.


Ok. I will look through that code. Does that mean we are trying to avoid
any more new hardware generic events ?

Also a broader question - is the sysfs approach intended for all raw events
or just for the generic events supported in the kernel ?

If it is intended for all events a CPU supports, isn't there a chance of
bloating kernel code ? Power7 has 530 events and Intel Nehalem (in libpfm)
seems to have 370 events. Would that mean we would need to represent all these
events in the kernel so they are available in sysfs ?

On a side note, how does the kernel on x86 use the 'config' information in 
say /sys/bus/event_source/devices/cpu/format/cccr ? On Power7, the raw
code encodes the information such as the PMC to use for the event. Is that
how the 'config' info in Intel is used ?

Does the 'config' info change from system to system or is it static for
a given event on a given CPU ?

I guess I am trying to understand if this mapping between event-name (event
code) and the config info is something the kernel needs/uses or is it something
the kernel simply passes through from userspace to CPU ?

AFAICT, on the Power we use the raw codes to determine which PMC to select
and which bits to set in some registers. That selection is static for a given 
CPU type such as Power7. If it is static, is it worth adding all this static 
mapping (for 530 events) into the kernel ?

If we don't add to the kernel, we don't seem to have a way to specify the 
events symbolically.

Thanks for you detailed comments.
| 
| PMU registration is implemented for a longer time already for all
| architectures and pmu types:
| 
|  /sys/bus/event_source/devices/*

Yes I see this.

| 
| But
| 
|  /sys/bus/event_source/devices/*/events/

Thanks for clarifying. I was looking to see if this was implemented too :-)

Sukadev

| 
| exists only for a small number of pmus. Perf tool support of this was
| implemented with:
| 
|  a6146d5 perf/tool: Add PMU event alias support
| 
| -Robert
| 
| -- 
| Advanced Micro Devices, Inc.
| Operating System Research Center
