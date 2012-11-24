Return-Path: <acme@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3B7DD2C0081
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2012 11:21:21 +1100 (EST)
From: Arnaldo Carvalho de Melo <acme@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [GIT PULL 0/8] perf/urgent fixes
Date: Fri, 23 Nov 2012 21:20:45 -0300
Message-Id: <1353716453-9693-1-git-send-email-acme@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@infradead.org>,
 Robert Richter <robert.richter@amd.com>, x86@kernel.org,
 Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>, acme@ghostprotocols.net,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, linux-arch@vger.kernel.org,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Namhyung Kim <namhyung@gmail.com>,
 Anton Blanchard <anton@au1.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Dong Hao <haodong@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 David Ahern <dsahern@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ingo,

	Tested using a cross-compiler and directly on a Raspberry pi (ARM) with
raspbian.

	Please consider pulling.

- Arnaldo

The following changes since commit 18423d3562f396206e0928a71177eeb2edfed077:

  Merge tag 'perf-urgent-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2012-11-13 18:51:51 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux tags/perf-urgent-for-mingo

for you to fetch changes up to 7321090f6751c9987c26a8c81c63680d16a614d7:

  perf kvm: Fix building perf kvm on non x86 arches (2012-11-23 20:40:17 -0300)

----------------------------------------------------------------
perf/urgent fixes

. Don't build 'perf kvm stat" on non-x86 arches, fix from Xiao Guangrong.

. UAPI fixes to get perf building again in non-x86 arches, from David Howells.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      Merge tag 'perf-uapi-20121119' of git://git.infradead.org/users/dhowells/linux-headers into perf/urgent

David Howells (6):
      x86: Export asm/{svm.h,vmx.h,perf_regs.h}
      Merge branch 'x86-pre-uapi' into perf-uapi
      tools: Define a Makefile function to do subdir processing
      tools: Honour the O= flag when tool build called from a higher Makefile
      tools: Pass the target in descend
      perf: Make perf build for x86 with UAPI disintegration applied

Sukadev Bhattiprolu (1):
      perf powerpc: Use uapi/unistd.h to fix build error

Xiao Guangrong (2):
      perf kvm: Rename perf_kvm to perf_kvm_stat
      perf kvm: Fix building perf kvm on non x86 arches

 Makefile                                |    6 +-
 arch/x86/include/asm/Kbuild             |    3 +
 include/linux/hw_breakpoint.h           |   31 +-------
 include/uapi/linux/Kbuild               |    1 +
 include/uapi/linux/hw_breakpoint.h      |   30 ++++++++
 tools/Makefile                          |   24 +++---
 tools/perf/Makefile                     |   29 +++++++-
 tools/perf/arch/x86/include/perf_regs.h |    2 +-
 tools/perf/builtin-kvm.c                |  121 +++++++++++++++++--------------
 tools/perf/builtin-test.c               |    2 +-
 tools/perf/perf.h                       |   16 +---
 tools/perf/util/evsel.c                 |    4 +-
 tools/perf/util/evsel.h                 |    3 +-
 tools/perf/util/header.h                |    2 +-
 tools/perf/util/parse-events-test.c     |    2 +-
 tools/perf/util/parse-events.c          |    2 +-
 tools/perf/util/parse-events.h          |    2 +-
 tools/perf/util/pmu.h                   |    2 +-
 tools/perf/util/session.h               |    2 +-
 tools/scripts/Makefile.include          |   23 +++++-
 20 files changed, 181 insertions(+), 126 deletions(-)
 create mode 100644 include/uapi/linux/hw_breakpoint.h
