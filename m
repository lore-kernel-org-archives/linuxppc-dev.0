Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 151DF1A0938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 05:27:48 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 24 Sep 2014 15:27:46 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D73896E803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 15:16:29 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8OJRiAj9699732
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 19:27:44 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8OJRhnn032482
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 15:27:44 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org, eranian@google.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v4 00/10] Add support for parameterized events from sysfs
Date: Wed, 24 Sep 2014 12:27:14 -0700
Message-Id: <1411586844-21381-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 dev@codyps.com, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

What this patchset does:

 - the first patch (override sysfs in tools/perf via SYSFS_PATH) was sent out
   previously, but needed a resend anyhow. Having it is useful for testing the
   later changes to tools/perf.
 - the second patch is a bugfix to the powerpc hv-24x7 code which was
   previously sent out, which is a good idea to have when testing these patches
   on POWER8 hardware.

 - document perf sysfs and the changes to add parameterized events
   - semi-notably: removes the growing list of specific POWER cpu events and
     begins documenting them generically, much like the docs for
     /sys/modules/MODULENAME do for modules.
 - tools/perf changes to support parameterized events
 - export some parameterized events from the powerpc pmus hv_24x7 and hv_gpci

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

		domain=0x1,offset=0x8,starting_index=phys_cpu

	In the case of the last example, a value replacing "phys_cpu"
	would need to be provided by the user selecting the particular
	event. This is refered to as "event parameterization". All
	non-numerical values indicate an event parameter.

Notes on how perf-list displays parameterized events (and how to use them,
again culled from an included patch):

	PARAMETERIZED EVENTS
	--------------------

	Some pmu events listed by 'perf-list' will be displayed with '?' in
	them. For example:

	  hv_gpci/dtbp_ptitc,phys_processor_idx=?/

	This means that when provided as an event, a value for
	phys_processor_idx must also be supplied. For example:

	  perf stat -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...

Changelog[v4]
	- [Jiri Olsa] Rebase to perf/core tree (fix small merge conflict)

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

Cody P Schafer (10):
  tools/perf: support parsing parameterized events
  tools/perf: extend format_alias() to include event parameters
  perf: provide sysfs_show for struct perf_pmu_events_attr
  powerpc/perf/hv-24x7: parse catalog and populate sysfs with events
  perf: add PMU_EVENT_ATTR_STRING() helper
  powerpc/perf/{hv-gpci,hv-common}: generate requests with counters
    annotated
  powerpc/perf/hv-gpci: add the remaining gpci requests
  perf Documentation: add event parameters
  tools/perf: Document parameterized and symbolic events
  powerpc/perf/hv-24x7: Document sysfs event description entries

 .../testing/sysfs-bus-event_source-devices-events  |   6 +
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
 tools/perf/Documentation/perf-list.txt             |  13 +
 tools/perf/Documentation/perf-record.txt           |  12 +
 tools/perf/Documentation/perf-stat.txt             |  20 +-
 tools/perf/util/parse-events.h                     |   1 +
 tools/perf/util/pmu.c                              |  91 ++-
 23 files changed, 1492 insertions(+), 60 deletions(-)
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
