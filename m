Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9020E1A0597
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 12:43:30 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 26 Jan 2015 18:43:28 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1AACC38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2015 20:43:25 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0R1hP3q28114970
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 01:43:25 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0R1hOis011492
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2015 20:43:24 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v7 0/4] Add support for parametrized events
Date: Mon, 26 Jan 2015 17:43:03 -0800
Message-Id: <1422322990-9030-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

Description of "event parameters" from the documentation patch:

    Event parameters are a basic way for partial events to be specified in
    sysfs with per-event names given to the fields that need to be filled in
    when using a particular event.

    It is intended for supporting cases where the single 'cpu' parameter is
    insufficient. For example, POWER 8 has events for physical
    sockets/cores/cpus that are accessible from with virtual machines. To
    keep using the single 'cpu' parameter we'd need to perform a mapping
    between Linux's cpus and the physical machine's cpus (in this case
    Linux is running under a hypervisor). This isn't possible because
    bindings between our cpus and physical cpus may not be fixed, and we
    probably won't have a "cpu" on each physical cpu.

Description of the sysfs contents when events are parameterized (copied from an
included patch):

	Examples:

		domain=0x1,offset=0x8,core=?

	In the case of the last example, a value replacing "?" would need
	to be provided by the user selecting the particular event. This is
	referred to as "event parameterization".

Notes on how perf-list displays parameterized events

	PARAMETERIZED EVENTS
	--------------------

	Some pmu events listed by 'perf list' will be displayed with '=?' in
	them. For example:

	  hv_24x7/HPM_THREAD_NAP_CCYC__PHYS_CORE,core=?/

	This means that when provided as an event, a value for ? must also
	be supplied. For example:

	  perf stat  -e \
	  	'hv_24x7/HPM_THREAD_NAP_CCYC__PHYS_CORE,core=2' ...


Cody P Schafer (6):
  perf: provide sysfs_show for struct perf_pmu_events_attr
  perf: add PMU_EVENT_ATTR_STRING() helper
  powerpc/perf/hv-24x7: parse catalog and populate sysfs with events
  powerpc/perf/{hv-gpci, hv-common}: generate requests with counters
    annotated
  powerpc/perf/hv-gpci: add the remaining gpci requests
  powerpc/perf/hv-24x7: Document sysfs event description entries

Sukadev Bhattiprolu (1):
  perf: define EVENT_DEFINE_RANGE_FORMAT_LITE helper

 .../testing/sysfs-bus-event_source-devices-hv_24x7 |  22 +
 arch/powerpc/perf/hv-24x7-catalog.h                |  25 +
 arch/powerpc/perf/hv-24x7-domains.h                |  28 +
 arch/powerpc/perf/hv-24x7.c                        | 793 ++++++++++++++++++++-
 arch/powerpc/perf/hv-24x7.h                        |  12 +-
 arch/powerpc/perf/hv-common.c                      |  10 +-
 arch/powerpc/perf/hv-common.h                      |  10 +
 arch/powerpc/perf/hv-gpci-requests.h               | 261 +++++++
 arch/powerpc/perf/hv-gpci.c                        |  23 +
 arch/powerpc/perf/hv-gpci.h                        |  37 +-
 arch/powerpc/perf/req-gen/_begin.h                 |  13 +
 arch/powerpc/perf/req-gen/_clear.h                 |   5 +
 arch/powerpc/perf/req-gen/_end.h                   |   4 +
 arch/powerpc/perf/req-gen/_request-begin.h         |  15 +
 arch/powerpc/perf/req-gen/_request-end.h           |   8 +
 arch/powerpc/perf/req-gen/perf.h                   | 155 ++++
 include/linux/perf_event.h                         |  10 +
 kernel/events/core.c                               |  12 +
 18 files changed, 1396 insertions(+), 47 deletions(-)
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
