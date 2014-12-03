Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B72A1A0568
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 13:04:18 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 19:04:16 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1C4983E4003D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 19:04:13 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB324DjL50724966
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 19:04:13 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB324Ce8029803
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 19:04:12 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Michael Ellerman <michaele@au1.ibm.com>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH v5 0/6]: Make 24x7 and GPCI events available in sysfs
Date: Tue,  2 Dec 2014 18:03:49 -0800
Message-Id: <1417572235-8197-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, dev@codyps.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current support for the 24x7 and GPCI counters in the kernel requires
users to specify the domain and offset of the event numerically, which is
obviously hard to use:

    perf stat -C 0 -e	\
        'hv_24x7/domain=2,offset=0xd58,starting_index=0,lpar=0xffffffff/' \
	sleep 1

This patchset exports the 24x7 and GPCI counters info in sysfs so users can
specify the events by name:

    $ cd /sys/bus/event_source/devices/hv_24x7/events

    $ cat HPM_CS_FROM_L4_LDATA__PHYS_CORE
    domain=0x2,offset=0xd58,starting_index=$core,lpar=0x0

    $ cat HPM_TLBIE__VCPU_HOME_CHIP
    domain=0x4,offset=0x358,starting_index=$vcpu,lpar=$sibling_guest_id

    perf stat -C 0 -e \
        'hv_24x7/HPM_CS_FROM_L4_LDATA__PHYS_CORE,starting_index=0'
        sleep 1

This patchset adds the kernel support to export events in sysfs.  A follow-on
patchset will add support to the perf tool to parse the event parameters like
'lpar=$sibling_guest_id' and display them via 'perf list'.

Changelog[v5]
	- [Jiri Olsa, Peter Zijlstra] Use '$arg' notation rather than ?
	  to indicate event parameters.
	- [Michael Ellerman] Separate the kernel and tool patches in the
	  patchset into different patchsets.

Changelog[v4]
	- [Jiri Olsa Rebase to perf/core tree to fix small merge conflict.

Changelog[v3]
        - [Jiri Olsa] Changed the event parameters are specified. If
          event file specifes 'param=val' make the usage 'param=123'
          rather than 'val=123'. (patch 1,2/10)
        - Shortened event names using "PHYS" and "VCPU" (patch 4/10)
        - Print help message if invalid parameter is specified or required
          parameter is missing.
        - Moved 3 patches that are unrelated to parametrized events into
          a separate patchset.
        - Reordered patches so code changes come first.

Changelog[v2]
        - [Joe Perches, David Laight] Use beNN_to_cpu() instead of guessing
          the size from type.
        - Use kmem_cache_free() to free page allocated with kmem_cache_alloc().
        - Rebase to recent kernel


Cody P Schafer (6):
  perf: provide sysfs_show for struct perf_pmu_events_attr
  perf: add PMU_EVENT_ATTR_STRING() helper
  powerpc/perf/hv-24x7: parse catalog and populate sysfs with events
  powerpc/perf/{hv-gpci, hv-common}: generate requests with counters
    annotated
  powerpc/perf/hv-gpci: add the remaining gpci requests
  powerpc/perf/hv-24x7: Document sysfs event description entries

 .../testing/sysfs-bus-event_source-devices-hv_24x7 |  22 +
 arch/powerpc/perf/hv-24x7-catalog.h                |  25 +
 arch/powerpc/perf/hv-24x7-domains.h                |  28 +
 arch/powerpc/perf/hv-24x7.c                        | 787 ++++++++++++++++++++-
 arch/powerpc/perf/hv-24x7.h                        |  12 +-
 arch/powerpc/perf/hv-common.c                      |  10 +-
 arch/powerpc/perf/hv-gpci-requests.h               | 262 +++++++
 arch/powerpc/perf/hv-gpci.c                        |   8 +
 arch/powerpc/perf/hv-gpci.h                        |  37 +-
 arch/powerpc/perf/req-gen/_begin.h                 |  13 +
 arch/powerpc/perf/req-gen/_clear.h                 |   5 +
 arch/powerpc/perf/req-gen/_end.h                   |   4 +
 arch/powerpc/perf/req-gen/_request-begin.h         |  15 +
 arch/powerpc/perf/req-gen/_request-end.h           |   8 +
 arch/powerpc/perf/req-gen/perf.h                   | 155 ++++
 include/linux/perf_event.h                         |  10 +
 kernel/events/core.c                               |   8 +
 17 files changed, 1365 insertions(+), 44 deletions(-)
 create mode 100644 arch/powerpc/perf/hv-24x7-domains.h
 create mode 100644 arch/powerpc/perf/hv-gpci-requests.h
 create mode 100644 arch/powerpc/perf/req-gen/_begin.h
 create mode 100644 arch/powerpc/perf/req-gen/_clear.h
 create mode 100644 arch/powerpc/perf/req-gen/_end.h
 create mode 100644 arch/powerpc/perf/req-gen/_request-begin.h
 create mode 100644 arch/powerpc/perf/req-gen/_request-end.h
 create mode 100644 arch/powerpc/perf/req-gen/perf.h

-- 
1.8.3.1
