Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41h2jZ5ylhzF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 18:03:14 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id c14-v6so1395845wmb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 01:03:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 2 Aug 2018 10:03:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexey Budankov <alexey.budankov@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 David Ahern <dsahern@gmail.com>, Don Zickus <dzickus@redhat.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Jan Glauber <jan.glauber@cavium.com>,
 Jayachandran C <jnair@caviumnetworks.com>,
 Jiri Olsa <jolsa@redhat.com>, Joe Mario <jmario@redhat.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Kim Phillips <kim.phillips@arm.com>, Leo Yan <leo.yan@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Mark Rutland <mark.rutland@arm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Michael Petlan <mpetlan@redhat.com>, Mike Leach <mike.leach@linaro.org>,
 Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 Robert Richter <robert.richter@cavium.com>,
 Robert Walker <robert.walker@arm.com>, rodia@autistici.org,
 Sandipan Das <sandipan@linux.ibm.com>, Stefan Liebler <stli@linux.ibm.com>,
 Sunil K Pandey <sunil.k.pandey@intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Vadim Lomovtsev <vadim.lomovtsev@cavium.com>,
 Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/21] perf/core improvements and fixes
Message-ID: <20180802080306.GA30142@gmail.com>
References: <20180801213648.4814-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, contains a recently merged
> tip/perf/urgent,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit c2586cfbb905939b79b49a9121fb0a59a5668fd6:
> 
>   Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2018-07-31 09:55:45 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.19-20180801
> 
> for you to fetch changes up to b912885ab75c7c8aa841c615108afd755d0b97f8:
> 
>   perf trace: Do not require --no-syscalls to suppress strace like output (2018-08-01 16:20:28 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf trace: (Arnaldo Carvalho de Melo)
> 
> - Do not require --no-syscalls to suppress strace like output, i.e.
> 
>      # perf trace -e sched:*switch
> 
>   will show just sched:sched_switch events, not strace-like formatted
>   syscall events, use --syscalls to get the previous behaviour.
> 
>   If instead:
> 
>      # perf trace
> 
>   is used, i.e. no events specified, then --syscalls is implied and
>   system wide strace like formatting will be applied to all syscalls.
> 
>   The behaviour when just a syscall subset is used with '-e' is unchanged:
> 
>      # perf trace -e *sleep,sched:*switch
> 
>   will work as before: just the 'nanosleep' syscall will be strace-like
>   formatted plus the sched:sched_switch tracepoint event, system wide.
> 
> - Allow string table generators to use a default header dir, allowing
>   use of them without parameters to see the table it generates on
>   stdout, e.g.:
> 
>     $ tools/perf/trace/beauty/kvm_ioctl.sh
>     static const char *kvm_ioctl_cmds[] = {
>         [0x00] = "GET_API_VERSION",
>         [0x01] = "CREATE_VM",
>         [0x02] = "GET_MSR_INDEX_LIST",
>         [0x03] = "CHECK_EXTENSION",
> <BIG SNIP>
>         [0xe0] = "CREATE_DEVICE",
>         [0xe1] = "SET_DEVICE_ATTR",
>         [0xe2] = "GET_DEVICE_ATTR",
>         [0xe3] = "HAS_DEVICE_ATTR",
>     };
>     $
> 
>   See 'ls tools/perf/trace/beauty/*.sh' to see the available string
>   table generators.
> 
> - Add a generator for IPPROTO_ socket's protocol constants.
> 
> perf record: (Kan Liang)
> 
> - Fix error out while applying initial delay and using LBR, due to
>   the use of a PERF_TYPE_SOFTWARE/PERF_COUNT_SW_DUMMY event to track
>   PERF_RECORD_MMAP events while waiting for the initial delay. Such
>   events fail when configured asking PERF_SAMPLE_BRANCH_STACK in
>   perf_event_attr.sample_type.
> 
> perf c2c: (Jiri Olsa)
> 
> - Fix report crash for empty browser, when processing a perf.data file
>   without events of interest, either because not asked for in
>   'perf record' or because the workload didn't triggered such events.
> 
> perf list: (Michael Petlan)
> 
> - Align metric group description format with PMU event description.
> 
> perf tests: (Sandipan Das)
> 
> - Fix indexing when invoking subtests, which caused BPF tests to
>   get results for the next test in the list, with the last one
>   reporting a failure.
> 
> eBPF:
> 
> - Fix installation directory for header files included from eBPF proggies,
>   avoiding clashing with relative paths used to build other software projects
>   such as glibc. (Thomas Richter)
> 
> - Show better message when failing to load an object. (Arnaldo Carvalho de Melo)
> 
> General: (Christophe Leroy)
> 
> - Allow overriding MAX_NR_CPUS at compile time, to make the tooling
>   usable in systems with less memory, in time this has to be changed
>   to properly allocate based on _NPROCESSORS_ONLN.
> 
> Architecture specific:
> 
> - Update arm64's ThunderX2 implementation defined pmu core events (Ganapatrao Kulkarni)
> 
> - Fix complex event name parsing in 'perf test' for PowerPC, where the 'umask' event
>   modifier isn't present. (Sandipan Das)
> 
> CoreSight ARM hardware tracing: (Leo Yan)
> 
> - Fix start tracing packet handling.
> 
> - Support dummy address value for CS_ETM_TRACE_ON packet.
> 
> - Generate branch sample when receiving a CS_ETM_TRACE_ON packet.
> 
> - Generate branch sample for CS_ETM_TRACE_ON packet.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (9):
>       perf trace beauty: Default header_dir to cwd to work without parms
>       tools include uapi: Grab a copy of linux/in.h
>       perf beauty: Add a generator for IPPROTO_ socket's protocol constants
>       perf trace beauty: Do not print NULL strarray entries
>       perf trace beauty: Add beautifiers for 'socket''s 'protocol' arg
>       perf trace: Beautify the AF_INET & AF_INET6 'socket' syscall 'protocol' args
>       perf bpf: Show better message when failing to load an object
>       perf bpf: Include uapi/linux/bpf.h from the 'perf trace' script's bpf.h
>       perf trace: Do not require --no-syscalls to suppress strace like output
> 
> Christophe Leroy (1):
>       perf tools: Allow overriding MAX_NR_CPUS at compile time
> 
> Ganapatrao Kulkarni (1):
>       perf vendor events arm64: Update ThunderX2 implementation defined pmu core events
> 
> Jiri Olsa (1):
>       perf c2c report: Fix crash for empty browser
> 
> Kan Liang (1):
>       perf evlist: Fix error out while applying initial delay and LBR
> 
> Leo Yan (4):
>       perf cs-etm: Fix start tracing packet handling
>       perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
>       perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON packet
>       perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet
> 
> Michael Petlan (1):
>       perf list: Unify metric group description format with PMU event description
> 
> Sandipan Das (2):
>       perf tests: Fix complex event name parsing
>       perf tests: Fix indexing when invoking subtests
> 
> Thomas Richter (1):
>       perf build: Fix installation directory for eBPF
> 
>  tools/include/uapi/linux/in.h                      | 301 +++++++++++++++++++++
>  tools/perf/Makefile.config                         |   4 +-
>  tools/perf/Makefile.perf                           |  10 +
>  tools/perf/builtin-c2c.c                           |   3 +
>  tools/perf/builtin-trace.c                         |  19 +-
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/include/bpf/bpf.h                       |   3 +
>  tools/perf/perf.h                                  |   2 +
>  .../arch/arm64/cavium/thunderx2/core-imp-def.json  |  87 +++++-
>  tools/perf/tests/builtin-test.c                    |   4 +-
>  tools/perf/tests/parse-events.c                    |   2 +-
>  tools/perf/trace/beauty/Build                      |   1 +
>  tools/perf/trace/beauty/beauty.h                   |   3 +
>  tools/perf/trace/beauty/drm_ioctl.sh               |   9 +-
>  tools/perf/trace/beauty/kcmp_type.sh               |   2 +-
>  tools/perf/trace/beauty/kvm_ioctl.sh               |   4 +-
>  tools/perf/trace/beauty/madvise_behavior.sh        |   2 +-
>  tools/perf/trace/beauty/perf_ioctl.sh              |   2 +-
>  .../perf/trace/beauty/pkey_alloc_access_rights.sh  |   2 +-
>  tools/perf/trace/beauty/sndrv_ctl_ioctl.sh         |   4 +-
>  tools/perf/trace/beauty/sndrv_pcm_ioctl.sh         |   4 +-
>  tools/perf/trace/beauty/socket.c                   |  28 ++
>  tools/perf/trace/beauty/socket_ipproto.sh          |  11 +
>  tools/perf/trace/beauty/vhost_virtio_ioctl.sh      |   6 +-
>  tools/perf/util/bpf-loader.c                       |   4 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   1 +
>  tools/perf/util/cs-etm.c                           |  68 ++++-
>  tools/perf/util/evsel.c                            |  14 +
>  tools/perf/util/metricgroup.c                      |   4 +-
>  29 files changed, 556 insertions(+), 49 deletions(-)
>  create mode 100644 tools/include/uapi/linux/in.h
>  create mode 100644 tools/perf/trace/beauty/socket.c
>  create mode 100755 tools/perf/trace/beauty/socket_ipproto.sh

Pulled, thanks a lot Arnaldo!

	Ingo
