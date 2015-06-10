Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 623701A0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 17:26:12 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 03:26:09 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5FA3938C8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:26:06 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A7Q6WR53018798
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 07:26:06 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A7Q56U013558
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:26:06 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH V15 00/19] perf,
 tools: Add support for PMU events in JSON format
Date: Wed, 10 Jun 2015 00:25:04 -0700
Message-Id: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

The file, 'tools/perf/pmu-events/README' in [PATCH 19/19] gives more
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
	json-v15		Source Code only 
	json-files-5		x86 and Powerpc datafiles only
	json-v15-with-data	Both code and data (build/test)
	
NOTE: 	Only "source code" patches (i.e those in json-v15) are being emailed.
	Please pull the "data files" from the json-files-5 branch.

Changelog[v15]
	Code changes:
	- Fix 'perf list' usage string and update man page.
	- Remove a redundant __maybe_unused tag.
	- Rebase to recent perf/core branch.

	Data files updates: json-files-5 branch
	- Rebase to perf/intel-json-files-5 from Andi Kleen
	- Add patch from Madhavan Srinivasan for couple more Powerpc models

Changelog[v14]
	Comments from Jiri Olsa:
	- Change parameter name/type for pmu_add_cpu_aliases (from void *data
	  to list_head *head)
	- Use asprintf() in file_name_to_tablename() and simplify/reorg code.
	- Use __weak definition from <linux/compile.h>
	- Use fopen() with mode "w" and eliminate unlink()
	- Remove minor TODO.
	- Add error check for return value from strdup() in print_pmu_events().
	- Move independent changes from patches 3,11,12 .. to separate patches
	  for easier review/backport.
	- Clarify mapfile's "header line support" in patch description.
	- Fix build failure with DEBUG=1

	Comment from Andi Kleen:
	- In tools/perf/pmu-events/Build, check for 'mapfile.csv' rather than
	  'mapfile*'

	Misc:
	- Minor changes/clarifications to tools/perf/pmu-events/README.


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



*** BLURB HERE ***

Andi Kleen (10):
  perf, tools: Add jsmn `jasmine' JSON parser
  perf, tools, jevents: Program to convert JSON file to C style file
  perf, tools: Allow events with dot
  perf, tools: Support CPU id matching for x86 v2
  perf, tools: Support alias descriptions
  perf, tools: Query terminal width and use in perf list
  perf, tools: Add a --no-desc flag to perf list
  perf, tools: Add override support for event list CPUID
  perf, tools: Add support for event list topics
  perf, tools: Handle header line in mapfile

Sukadev Bhattiprolu (9):
  Use __weak definition from <linux/compiler.h>
  perf, tools: Split perf_pmu__new_alias()
  perf, tools: Use pmu_events table to create aliases
  perf, tools: Support CPU ID matching for Powerpc
  perf, tools, jevents: Add support for long descriptions
  perf, tools: Add alias support for long descriptions
  perf, tools: Support long descriptions with perf list
  perf, tools, jevents: Add support for event topics
  perf, tools: Add README for info on parsing JSON/map files

 tools/perf/Documentation/perf-list.txt |  12 +-
 tools/perf/Makefile.perf               |  25 +-
 tools/perf/arch/powerpc/util/header.c  |  11 +
 tools/perf/arch/x86/util/header.c      |  24 +-
 tools/perf/builtin-list.c              |  17 +-
 tools/perf/pmu-events/Build            |  11 +
 tools/perf/pmu-events/README           | 122 ++++++
 tools/perf/pmu-events/jevents.c        | 712 +++++++++++++++++++++++++++++++++
 tools/perf/pmu-events/jevents.h        |  18 +
 tools/perf/pmu-events/jsmn.c           | 313 +++++++++++++++
 tools/perf/pmu-events/jsmn.h           |  67 ++++
 tools/perf/pmu-events/json.c           | 162 ++++++++
 tools/perf/pmu-events/json.h           |  39 ++
 tools/perf/pmu-events/pmu-events.h     |  37 ++
 tools/perf/util/cache.h                |   1 +
 tools/perf/util/header.h               |   1 +
 tools/perf/util/pager.c                |  15 +
 tools/perf/util/parse-events.c         |   5 +-
 tools/perf/util/parse-events.h         |   3 +-
 tools/perf/util/parse-events.l         |   5 +-
 tools/perf/util/pmu.c                  | 217 ++++++++--
 tools/perf/util/pmu.h                  |   6 +-
 22 files changed, 1772 insertions(+), 51 deletions(-)
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
1.8.3.1
