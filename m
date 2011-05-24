Return-Path: <fweisbec@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15392B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 07:52:37 +1000 (EST)
Received: by wyg36 with SMTP id 36so5990428wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 14:52:33 -0700 (PDT)
From: Frederic Weisbecker <fweisbec@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] hw_breakpoint: Let the user choose not to build it (and
	perf too)
Date: Tue, 24 May 2011 23:52:21 +0200
Message-Id: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Will Deacon <will.deacon@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Ingo Molnar <mingo@elte.hu>, Prasad <prasad@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mostly just a rebase against latest upstream
updates and acks from Will Deacon added In this second version.

Please tell me if you are ok with this set.

Thanks.

---

Frederic Weisbecker (6):
      hw_breakpoints: Split hardware breakpoints config
      hw_breakpoints: Migrate breakpoint conditional build under new config
      x86: Allow the user not to build hw_breakpoints
      hw_breakpoints: Breakpoints arch ability don't need perf events
      hw_breakpoints: Only force perf events if breakpoints are selected
      hw_breakpoints: Drop remaining misplaced dependency on perf


 arch/Kconfig                             |    1 -
 arch/arm/Kconfig                         |    2 +-
 arch/arm/include/asm/hw_breakpoint.h     |    4 +-
 arch/arm/include/asm/processor.h         |    2 +-
 arch/arm/kernel/Makefile                 |    2 +-
 arch/arm/kernel/entry-header.S           |    2 +-
 arch/arm/kernel/ptrace.c                 |    4 +-
 arch/powerpc/Kconfig                     |    2 +-
 arch/powerpc/include/asm/cputable.h      |    4 +-
 arch/powerpc/include/asm/hw_breakpoint.h |    6 ++--
 arch/powerpc/include/asm/processor.h     |    4 +-
 arch/powerpc/kernel/Makefile             |    2 +-
 arch/powerpc/kernel/process.c            |   18 ++++++++--------
 arch/powerpc/kernel/ptrace.c             |   13 ++++++-----
 arch/powerpc/lib/Makefile                |    2 +-
 arch/sh/Kconfig                          |    2 +-
 arch/sh/kernel/Makefile                  |    2 +-
 arch/sh/kernel/cpu/sh4a/Makefile         |    2 +-
 arch/x86/Kconfig                         |    3 +-
 arch/x86/include/asm/debugreg.h          |   33 ++++++++++++++++++++++++++++-
 arch/x86/kernel/Makefile                 |    3 +-
 arch/x86/kernel/process.c                |    1 +
 arch/x86/kernel/ptrace.c                 |   17 +++++++++++++++
 include/linux/hw_breakpoint.h            |    6 ++--
 include/linux/perf_event.h               |    4 +-
 include/linux/ptrace.h                   |    6 ++--
 include/linux/sched.h                    |    2 +-
 init/Kconfig                             |   11 ++++++++++
 kernel/events/Makefile                   |    2 +-
 kernel/events/core.c                     |    4 +-
 kernel/ptrace.c                          |    4 +-
 samples/Kconfig                          |    2 +-
 32 files changed, 115 insertions(+), 57 deletions(-)
