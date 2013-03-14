Return-Path: <BATV+18920339ee8181c42cca+3490+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EF94A2C00D3
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Mar 2013 23:23:51 +1100 (EST)
From: Arnaldo Carvalho de Melo <acme@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [GIT PULL 0/8] perf/urgent fixes
Date: Thu, 14 Mar 2013 09:23:07 -0300
Message-Id: <1363263795-31485-1-git-send-email-acme@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Feng Tang <feng.tang@intel.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Jack Mitchell <jack.mitchell@dbbroadcast.co.uk>,
 Stephane Eranian <eranian@google.com>, Oleg Nesterov <oleg@redhat.com>,
 linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung.kim@lge.com>,
 Andi Kleen <ak@linux.intel.com>, Irina Tirdea <irina.tirdea@intel.com>,
 Robert Richter <robert.richter@amd.com>, Vinson Lee <vlee@twitter.com>,
 Ingo Molnar <mingo@redhat.com>, Marcin Slusarz <marcin.slusarz@gmail.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Corey Ashford <cjashfor@linux.vnet.ibm.com>,
 Anton Blanchard <anton@au1.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org,
 Pekka Enberg <penberg@kernel.org>, David Ahern <dsahern@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

Hi Ingo,

	Please consider pulling,

- Arnaldo

The following changes since commit cb16b91a449afd01b85ec4e59f30449d11c4acd7:

  s390: Fix a header dependencies related build error (2013-03-11 10:43:35 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux tags/perf-urgent-for-mingo

for you to fetch changes up to d1398ccfec56e54010476efd6a316427d29045a6:

  perf tools: Fix LIBNUMA build with glibc 2.12 and older. (2013-03-14 08:06:21 -0300)

----------------------------------------------------------------
perf/urgent fixes:

. perf probe: Fix segfault due to testing the wrong pointer for NULL,
  from Ananth N Mavinakayanahalli.

. libtraceevent: Remove hard coded include to /usr/local/include in
  Makefile, which causes cross builds to include host header files,
  fix from Jack Mitchell.

. perf record: Use the right target interface for synthesizing
  threads when --cpu/-C option is used, fix from Jiri Olsa.

. Check if -DFORTIFY_SOURCE=2 is allowed, as gcc 4.7.2 defines
  it and then the build is broken when it is redefined in perf,
  fix from Marcin Slusarz.

. Fix build with NO_NEWT=1, that can happen explicitely or when
  the newt-devel package is not installed, from Michael Ellerman.

. perf/POWER7: Create a sysfs format entry for Power7 events, missing
  patch from a patchseries already merged, from Sukadev Bhattiprolu.

. Fix LIBNUMA build with glibc 2.12 and older, from Vinson Lee.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Ananth N Mavinakayanahalli (1):
      perf probe: Fix segfault

Jack Mitchell (1):
      libtraceevent: Remove hard coded include to /usr/local/include in Makefile

Jiri Olsa (1):
      perf record: Fix -C option

Marcin Slusarz (1):
      perf tools: check if -DFORTIFY_SOURCE=2 is allowed

Michael Ellerman (2):
      perf annotate: Fix build with NO_NEWT=1
      perf report: Fix build with NO_NEWT=1

Sukadev Bhattiprolu (1):
      perf/POWER7: Create a sysfs format entry for Power7 events

Vinson Lee (1):
      perf tools: Fix LIBNUMA build with glibc 2.12 and older.

 arch/powerpc/perf/power7-pmu.c | 13 +++++++++++++
 tools/lib/traceevent/Makefile  |  2 +-
 tools/perf/Makefile            |  8 +++++++-
 tools/perf/bench/bench.h       | 24 ++++++++++++++++++++++++
 tools/perf/builtin-record.c    |  6 ++++--
 tools/perf/util/hist.h         |  5 +++--
 tools/perf/util/strlist.c      |  2 +-
 7 files changed, 53 insertions(+), 7 deletions(-)
