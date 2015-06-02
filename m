Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17C061A0CEF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 03:12:56 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 11:12:54 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9DEA81FF004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:04:01 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52HCIEK30212338
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 10:12:18 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52HCoGZ025306
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 11:12:51 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH V13 00/14] perf,
 tools: Add support for PMU events in JSON format
Date: Tue,  2 Jun 2015 10:12:00 -0700
Message-Id: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
CPU. To use most of these PMU events with perf, we currently have to identify
them by their raw codes:

	perf stat -e r100f2 sleep 1

This patchset allows architectures to specify these PMU events in JSON
files located in 'tools/perf/pmu-events/arch/' of the mainline tree.
The events from the JSON files for the architecture are then built into
the perf binary.

At run time, perf identifies the specific set of events for the CPU and
creates "event aliases". These aliases allow users to specify events by
"name" as:

	perf stat -e pm_1plus_ppc_cmpl sleep 1

The file, 'tools/perf/pmu-events/README' in [PATCH 14/14] gives more
details.

Note:
	- All known events tables for the architecture are included in the
	  perf binary.

	- For architectures that don't have any JSON files, an empty mapping
	  table is created and they should continue to build)

Thanks to input from Andi Kleen, Jiri Olsa, Namhyung Kim and Ingo Molnar.

These patches are available from:

	https://github.com:sukadev/linux.git 
	
		Branch			Description
		------------------------------------------------------
		json-v13		Source Code only 
		json-files-3		x86 and Powerpc datafiles only
		json-v13-with-data	Both code and data (build/test)
	
NOTE: 	Only "source code" patches (i.e those in json-v13) are being emailed.
	Please pull the "data files" from the json-files-3 branch.

Changelog[v13]

	Version: Individual patches have their own history :-) that I am
	preserving. Patchset version (v13) is for overall patchset and is
	somewhat arbitrary.

	- Added support for "categories" of events to perf
	- Add mapfile, jevents build dependency on pmu-events.c
	- Silence jevents when parsing JSON files unless V=1 is specified
	- Cleanup error messages
	- Fix memory leak with ->cpuid
	- Rebase to Arnaldo's tree
	- Allow overriding CPUID via environment variable
	- Support long descriptions for events
	- Handle header line in mapfile.csv
	- Cleanup JSON files (trim PublicDescription if identical to/prefix of
	  BriefDescription field)


Andi Kleen (12):
  perf, tools: Add jsmn `jasmine' JSON parser
  perf, tools, jevents: Program to convert JSON file to C style file
  perf, tools: Allow events with dot
  perf, tools: Support CPU id matching for x86 v2
  perf, tools: Support alias descriptions
  perf, tools: Query terminal width and use in perf list
  perf, tools: Add a --no-desc flag to perf list
  perf, tools: Group alias perf list by section
  perf, tools: Add override support for event list CPUID
  perf, tools: Support long descriptions with perf list -v
  perf, tools: Add support for event list topics
  perf, tools: Handle header line in mapfile

Sukadev Bhattiprolu (1):
  perf, tools: Use pmu_events_map table to create event aliases

 tools/perf/Documentation/perf-list.txt |    8 +-
 tools/perf/Makefile.perf               |   25 +-
 tools/perf/arch/powerpc/util/header.c  |   11 +
 tools/perf/arch/x86/util/header.c      |   24 +-
 tools/perf/builtin-list.c              |   15 +-
 tools/perf/pmu-events/Build            |   11 +
 tools/perf/pmu-events/README           |   67 +++
 tools/perf/pmu-events/jevents.c        |  714 ++++++++++++++++++++++++++++++++
 tools/perf/pmu-events/jevents.h        |   18 +
 tools/perf/pmu-events/jsmn.c           |  313 ++++++++++++++
 tools/perf/pmu-events/jsmn.h           |   67 +++
 tools/perf/pmu-events/json.c           |  162 ++++++++
 tools/perf/pmu-events/json.h           |   39 ++
 tools/perf/pmu-events/pmu-events.h     |   37 ++
 tools/perf/util/cache.h                |    1 +
 tools/perf/util/header.h               |    3 +-
 tools/perf/util/pager.c                |   15 +
 tools/perf/util/parse-events.c         |    4 +-
 tools/perf/util/parse-events.h         |    2 +-
 tools/perf/util/parse-events.l         |    5 +-
 tools/perf/util/pmu.c                  |  230 ++++++++--
 tools/perf/util/pmu.h                  |    6 +-
 22 files changed, 1725 insertions(+), 52 deletions(-)
 create mode 100644 tools/perf/pmu-events/Build
 create mode 100644 tools/perf/pmu-events/README
 create mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100644 tools/perf/pmu-events/jevents.h
 create mode 100644 tools/perf/pmu-events/jsmn.c
 create mode 100644 tools/perf/pmu-events/jsmn.h
 create mode 100644 tools/perf/pmu-events/json.c
 create mode 100644 tools/perf/pmu-events/json.h
 create mode 100644 tools/perf/pmu-events/pmu-events.h

-- 
1.7.9.5
