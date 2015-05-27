Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 391B71A0DED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 07:24:06 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 27 May 2015 15:24:04 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CA7B31FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 15:15:11 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4RLO1Do28770374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 14:24:01 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4RLO10J011941
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 15:24:01 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/10] perf: Add support for PMU events in JSON format
Date: Wed, 27 May 2015 14:23:19 -0700
Message-Id: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CPUs support a large number of performance monitoring events (PMU events)
and often these events are very specific to an architecture/model of the
CPU. To use most of these PMU events with perf we currently have to identify
the events by their raw codes:

	perf stat -e r100f2 sleep 1

This patchset allows architectures to specify these PMU events in a JSON
files which are defined in the tools/perf/pmu-events/arch/ directory of
the mainline tree

	Eg: snippet from 004d0100.json (in patch 4)
	[
		
	  {
	    "EventCode": "0x100f2",
	    "EventName": "PM_1PLUS_PPC_CMPL",
	    "BriefDescription": "1 or more ppc insts finished,",
	    "PublicDescription": "1 or more ppc insts finished (completed).,"
	  },
	]

When building the perf tool, this patchset, first builds/uses a 'jevents'
which locates all the JSON files for the architecture (currently Powerpc).
The jevents binary then translates the JSON files into into a C-style
"PMU events table":

	struct pmu_event pme_power8[] = {
		
		...

		{
			.name = "pm_1plus_ppc_cmpl",
			.event = "event=0x100f2",
			.desc = "1 or more ppc insts finished,",
		},

		...
	}

where the "power8" in the table name is derived from the name of the JSON file.

The jevents binary also looks for a "mapfile" to map a processor model/
version to a specific events table:

	$ cat mapfile.csv
	004b0000,1,power8.json,core
	004c0000,1,power8.json,core
	004d0000,1,power8.json,core
	
and uses this to build a mapping table:

	struct pmu_events_map pmu_events_map[] = {
	{
		.cpuid = "004b0000",
		.version = "1",
		.type = "core",
		.table = pme_power8
	},
	
This mapping and events tables for the architecture are then included in
the perf binary during build.

At run time, perf identifies the specific events table, based on the model
of the CPU perf is running on. Perf uses that table to create event aliases
which would allow the user to specify the event as:

	perf stat -e pm_1plus_ppc_cmpl sleep 1

Note:
	- All known events tables for the architecture are included in the
	  perf binary.

	- Inconsistencies between the JSON files and the mapfile can result
	  in build failures in perf (although jevents try to recover from
	  some and continue the build by leaving out event aliases).

	- For architectures that don't have any JSON files, an empty mapping
	  table is created and they should continue to build)

Thanks to input from Andi Kleen, Jiri Olsa, Namhyung Kim and Ingo Molnar.

These patches are available from

	git@github.com:sukadev/linux.git #branch json-v11

Andi Kleen (8):
  perf, tools: Add jsmn `jasmine' JSON parser
  jevents: Program to convert JSON file to C style file
  perf, tools: Handle header line in mapfile
  perf, tools: Allow events with dot
  perf, tools: Support CPU id matching for x86 v2
  perf, tools: Support alias descriptions
  perf, tools: Query terminal width and use in perf list
  perf, tools: Add a --no-desc flag to perf list

Sukadev Bhattiprolu (2):
  Use pmu_events_map table to create event aliases
  perf: Add power8 PMU events in JSON format

 tools/perf/Documentation/perf-list.txt         |    8 +-
 tools/perf/Makefile.perf                       |   25 +-
 tools/perf/arch/powerpc/util/header.c          |   11 +
 tools/perf/arch/x86/util/header.c              |   24 +-
 tools/perf/builtin-list.c                      |   12 +-
 tools/perf/pmu-events/Build                    |   10 +
 tools/perf/pmu-events/README                   |   67 +
 tools/perf/pmu-events/arch/powerpc/mapfile.csv |   17 +
 tools/perf/pmu-events/arch/powerpc/power8.json | 6380 ++++++++++++++++++++++++
 tools/perf/pmu-events/jevents.c                |  686 +++
 tools/perf/pmu-events/jevents.h                |   17 +
 tools/perf/pmu-events/jsmn.c                   |  313 ++
 tools/perf/pmu-events/jsmn.h                   |   67 +
 tools/perf/pmu-events/json.c                   |  162 +
 tools/perf/pmu-events/json.h                   |   36 +
 tools/perf/pmu-events/pmu-events.h             |   35 +
 tools/perf/util/cache.h                        |    1 +
 tools/perf/util/header.h                       |    3 +-
 tools/perf/util/pager.c                        |   15 +
 tools/perf/util/parse-events.c                 |    4 +-
 tools/perf/util/parse-events.h                 |    2 +-
 tools/perf/util/parse-events.l                 |    5 +-
 tools/perf/util/pmu.c                          |  185 +-
 tools/perf/util/pmu.h                          |    3 +-
 24 files changed, 8036 insertions(+), 52 deletions(-)
 create mode 100644 tools/perf/pmu-events/Build
 create mode 100644 tools/perf/pmu-events/README
 create mode 100644 tools/perf/pmu-events/arch/powerpc/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8.json
 create mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100644 tools/perf/pmu-events/jevents.h
 create mode 100644 tools/perf/pmu-events/jsmn.c
 create mode 100644 tools/perf/pmu-events/jsmn.h
 create mode 100644 tools/perf/pmu-events/json.c
 create mode 100644 tools/perf/pmu-events/json.h
 create mode 100644 tools/perf/pmu-events/pmu-events.h

-- 
1.7.9.5
