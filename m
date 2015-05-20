Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FF111A0076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 10:02:42 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:02:40 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id EAE58C9005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 19:53:44 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4K02b2p56688806
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 00:02:37 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4K02aIF004090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:02:36 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/4] perf: Add support for PMU events in JSON format
Date: Tue, 19 May 2015 17:02:06 -0700
Message-Id: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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

	struct pmu_event pme_004d0100_core[] = {
		
		...

		{
			.name = "pm_1plus_ppc_cmpl",
			.event = "event=0x100f2",
			.desc = "1 or more ppc insts finished,",
		},

		...
	}

The jevents binary also looks for a "mapfile" to map a processor model/
version to a specific events table:

	$ cat mapfile.csv
	IBM-Power8-9188,004d0100,004d0100-core.json,core
	
and uses this to build a mapping table:

	struct pmu_events_map pmu_events_map[] = {
	{
		.vfm = "IBM-Power8-9188",
		.version = "004d0100",
		.type = "core",
		.table = pme_004d0100_core
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

Andi Kleen (2):
  perf, tools: Add jsmn `jasmine' JSON parser
  jevents: Program to convert JSON file to C style file

Sukadev Bhattiprolu (2):
  Use pmu_events_map table to create event aliases
  perf: Add power8 PMU events in json format

 tools/perf/Build                                   |    1 +
 tools/perf/Makefile.perf                           |    4 +-
 tools/perf/arch/powerpc/util/header.c              |   33 +
 tools/perf/pmu-events/Build                        |   38 +
 tools/perf/pmu-events/README                       |   67 +
 .../pmu-events/arch/powerpc/004d0100-core.json     | 5766 ++++++++++++++++++++
 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |    1 +
 tools/perf/pmu-events/arch/powerpc/power8.json     | 5766 ++++++++++++++++++++
 tools/perf/pmu-events/jevents.c                    |  700 +++
 tools/perf/pmu-events/jevents.h                    |   17 +
 tools/perf/pmu-events/jsmn.c                       |  313 ++
 tools/perf/pmu-events/jsmn.h                       |   67 +
 tools/perf/pmu-events/json.c                       |  162 +
 tools/perf/pmu-events/json.h                       |   36 +
 tools/perf/pmu-events/pmu-events.h                 |   39 +
 tools/perf/util/header.h                           |    4 +-
 tools/perf/util/pmu.c                              |  104 +-
 17 files changed, 13103 insertions(+), 15 deletions(-)
 create mode 100644 tools/perf/pmu-events/Build
 create mode 100644 tools/perf/pmu-events/README
 create mode 100644 tools/perf/pmu-events/arch/powerpc/004d0100-core.json
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
