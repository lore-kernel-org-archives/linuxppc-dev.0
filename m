Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF8711A0F5A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 12:14:38 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 7 Jan 2015 18:14:36 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 28D773E40030
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 18:14:34 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t081EXmK33620166
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jan 2015 18:14:33 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t081EWVM006347
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jan 2015 18:14:33 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH v7 0/4] Add support for parametrized events
Date: Wed,  7 Jan 2015 17:13:49 -0800
Message-Id: <1420679633-28856-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
	refered to as "event parameterization". All non-numerical values
	indicate an event parameter.

Notes on how perf-list displays parameterized events

	PARAMETERIZED EVENTS
	--------------------

	Some pmu events listed by 'perf list' will be displayed with '$xyz' in
	them. For example:

	  hv_24x7/HPM_THREAD_NAP_CCYC__PHYS_CORE,core=?/

	This means that when provided as an event, a value for ? must also
	be supplied. For example:

	  perf stat  -e \
	  	'hv_24x7/HPM_THREAD_NAP_CCYC__PHYS_CORE,core=2' ...

Changelog[v7]
	[Jiri Olsa] Nit: Add braces for clarity.
	[Jiri Olsa] Add a check to make sure that sysfs entries have with
	parameters exactly match '=?'.

Changelog[v6]

	[Jiri Olsa, Sukadev Bhattiprolu] Rather than display
	'starting_index=$core' in perf.list and sysfs and expect user to
	specify a value for 'starting_index', replace 'starting_index' with
	what it really means for the event. i.e for an event, if starting_index
	refers to 'core' then display 'core=?' in both perf list and sysfs (see
	examples above).

Changelog[v5]
	- [Jiri Olsa, Peter Zijlstra] Use '$arg' notation rather than ?
	  to indicate event parameters.

	- [Michael Ellerman] Separate the kernel and tool patches in the
	  patchset into different patchsets.

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

Cody P Schafer (4):
  tools/perf: support parsing parameterized events
  tools/perf: extend format_alias() to include event parameters
  perf Documentation: add event parameters
  tools/perf: Document parameterized and symbolic events

 .../testing/sysfs-bus-event_source-devices-events  |  6 ++
 tools/perf/Documentation/perf-list.txt             | 13 +++
 tools/perf/Documentation/perf-record.txt           | 12 +++
 tools/perf/Documentation/perf-stat.txt             | 20 ++++-
 tools/perf/util/parse-events.h                     |  1 +
 tools/perf/util/pmu.c                              | 92 +++++++++++++++++++---
 6 files changed, 128 insertions(+), 16 deletions(-)

-- 
1.8.3.1
