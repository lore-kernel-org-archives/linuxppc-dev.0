Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZtKG6XXrzDsYV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 08:25:38 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FMN3TD120791
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:25:36 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fk2xacqh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:25:36 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 18:25:35 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v21 00/20] perf,
 tools: Add support for PMU events in JSON format
Date: Thu, 15 Sep 2016 15:24:37 -0700
Message-Id: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

The file, 'tools/perf/pmu-events/README' in [PATCH 15/19] gives more
details.

Note:
	- All known events tables for the architecture are included in the
	  perf binary.

	- For architectures that don't have any JSON files, an empty mapping
	  table is created and they should continue to build.

Thanks to input from Andi Kleen, Jiri Olsa, Namhyung Kim and Ingo Molnar.

These patches are available from:

	https://github.com/sukadev/linux.git 
	
	Branch			Description
	------------------------------------------------------
	json-code-v21		Source Code only 
	json-code+data-v21	Both code and data (for build/test/pull)
	
NOTE: 	Only "source code" patches (i.e those in json-code-v21) are being
	emailed. Please pull the json-code+data-v21 branch for build/test.

Changelog[v21]
	- Rebase to recent perf/core
	- Group the PMU events supported by a CPU model into topics and
	  create a separate JSON file for each topic for each CPU (code
	  and input from Jiri Olsa).

Changelog[v20]
	- Rebase to recent perf/core
	- Add Patch 20/20 to allow perf-stat to work with the period= field

Changelog[v19]
	Rebase to recent perf/core; fix couple lines >80 chars.

Changelog[v18]
	Rebase to recent perf/core; fix minor merge conflicts.

Changelog[v17]
	Rebase to recent perf/core; couple of small fixes to processing Intel
	JSON files; allow case-insensitive PMU event names.

Changelog[v16]
	Rebase to recent perf/core; fix minor merge conflicts; drop 3 patches
	that were merged into perf/core.

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


Andi Kleen (12):
  perf, tools: Add jsmn `jasmine' JSON parser
  perf, tools, jevents: Program to convert JSON file to C style file
  perf, tools: Support CPU id matching for x86 v2
  perf, tools: Support alias descriptions
  perf, tools: Query terminal width and use in perf list
  perf, tools: Add a --no-desc flag to perf list
  perf, tools: Add override support for event list CPUID
  perf, tools: Add support for event list topics
  perf, tools, jevents: Handle header line in mapfile
  perf, tools: Make alias matching case-insensitive
  perf, tools, pmu-events: Fix fixed counters on Intel
  perf, tools, pmu-events: Add Skylake frontend MSR support

Sukadev Bhattiprolu (7):
  perf, tools: Use pmu_events table to create aliases
  perf, tools: Support CPU ID matching for Powerpc
  perf, tools, jevents: Add support for long descriptions
  perf, tools: Add alias support for long descriptions
  perf, tools: Support long descriptions with perf list
  perf, tools: Add README for info on parsing JSON/map files
  Allow period= in perf stat CPU event descriptions.

 tools/lib/subcmd/pager.c               |  16 +
 tools/lib/subcmd/pager.h               |   1 +
 tools/perf/Documentation/perf-list.txt |  12 +-
 tools/perf/Makefile.perf               |  28 +-
 tools/perf/arch/powerpc/util/header.c  |  11 +
 tools/perf/arch/x86/util/header.c      |  24 +-
 tools/perf/builtin-list.c              |  20 +-
 tools/perf/pmu-events/Build            |  11 +
 tools/perf/pmu-events/README           | 148 ++++++
 tools/perf/pmu-events/jevents.c        | 811 +++++++++++++++++++++++++++++++++
 tools/perf/pmu-events/jevents.h        |  18 +
 tools/perf/pmu-events/jsmn.c           | 313 +++++++++++++
 tools/perf/pmu-events/jsmn.h           |  67 +++
 tools/perf/pmu-events/json.c           | 162 +++++++
 tools/perf/pmu-events/json.h           |  42 ++
 tools/perf/pmu-events/pmu-events.h     |  37 ++
 tools/perf/util/header.h               |   1 +
 tools/perf/util/parse-events.c         |   8 +-
 tools/perf/util/parse-events.h         |   3 +-
 tools/perf/util/pmu.c                  | 177 ++++++-
 tools/perf/util/pmu.h                  |   6 +-
 21 files changed, 1880 insertions(+), 36 deletions(-)
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
