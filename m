Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 612311A0C73
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:41:22 +1000 (AEST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 02:41:19 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7EC46C9005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:32:26 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E6fHBl16318696
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:41:17 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E6fERR021508
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:16 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v9 00/11] Add support for JSON event files.
Date: Mon, 13 Apr 2015 23:40:53 -0700
Message-Id: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is another attempt to resurrect Andi Kleen's patchset so users
can specify perf events by their event names rather than raw codes.

This is a rebase of Andi Kleen's patchset from Jul 30, 2014[1] to 4.0.
(I fixed minor and not so minor conflicts).

This patchset includes the perf-download tool that was dropped and sets
the default download location to the (tools/perf/pmu-events/arch/...
directory in Linus's tree.

A follow-on patchset will include the actual JSON files for Powerpc, which
are currently available on github[2].

[1] https://lkml.org/lkml/2014/7/30/693
[2] https://github.com/open-power/power-pmu-events

Andi Kleen (9):
  perf, tools: Add jsmn `jasmine' JSON parser
  perf, tools: Add support for text descriptions of events and alias
    add
  perf, tools, list: Update perf list to output descriptions
  perf, tools: Add support for reading JSON event files
  perf, tools: Automatically look for event file name for cpu
  perf, tools: Query terminal width and use in perf list
  perf, tools: Add a new pmu interface to iterate over all events
  perf, tools, test: Add test case for alias and JSON parsing
  perf, tools: Add a --no-desc flag to perf list

Sukadev Bhattiprolu (2):
  powerpc/perf: Implement get_cpu_str()
  perf-download: Download the events json file

 tools/perf/Documentation/perf-download.txt |   31 +++
 tools/perf/Documentation/perf-list.txt     |   29 ++-
 tools/perf/Documentation/perf-record.txt   |    9 +-
 tools/perf/Documentation/perf-stat.txt     |    8 +-
 tools/perf/Makefile.perf                   |   12 +-
 tools/perf/arch/powerpc/util/header.c      |   12 ++
 tools/perf/arch/x86/util/header.c          |   19 +-
 tools/perf/builtin-list.c                  |   18 +-
 tools/perf/builtin-record.c                |    3 +
 tools/perf/builtin-stat.c                  |    2 +
 tools/perf/perf-download.sh                |  171 +++++++++++++++
 tools/perf/tests/aliases.c                 |   59 ++++++
 tools/perf/tests/builtin-test.c            |    4 +
 tools/perf/tests/tests.h                   |    1 +
 tools/perf/util/cache.h                    |    1 +
 tools/perf/util/jevents.c                  |  287 +++++++++++++++++++++++++
 tools/perf/util/jevents.h                  |    9 +
 tools/perf/util/jsmn.c                     |  313 ++++++++++++++++++++++++++++
 tools/perf/util/jsmn.h                     |   67 ++++++
 tools/perf/util/json.c                     |  162 ++++++++++++++
 tools/perf/util/json.h                     |   13 ++
 tools/perf/util/pager.c                    |   15 ++
 tools/perf/util/parse-events.c             |    4 +-
 tools/perf/util/parse-events.h             |    2 +-
 tools/perf/util/pmu.c                      |  160 +++++++++++---
 tools/perf/util/pmu.h                      |    5 +-
 26 files changed, 1365 insertions(+), 51 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-download.txt
 create mode 100755 tools/perf/perf-download.sh
 create mode 100644 tools/perf/tests/aliases.c
 create mode 100644 tools/perf/util/jevents.c
 create mode 100644 tools/perf/util/jevents.h
 create mode 100644 tools/perf/util/jsmn.c
 create mode 100644 tools/perf/util/jsmn.h
 create mode 100644 tools/perf/util/json.c
 create mode 100644 tools/perf/util/json.h

-- 
1.7.9.5
