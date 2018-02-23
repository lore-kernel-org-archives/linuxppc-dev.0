Return-Path: <alexander.sverdlin@nokia.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00128.outbound.protection.outlook.com [40.107.0.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znyC20xLdzF1lF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 04:00:07 +1100 (AEDT)
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 James Hogan <jhogan@kernel.org>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: [PATCH 0/3] ARM: Implement MODULE_PLT support in FTRACE
Date: Fri, 23 Feb 2018 17:58:46 +0100
Message-Id: <20180223165849.16388-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FTRACE's function tracer currently doesn't always work on ARM with
MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
code modifier cannot cope with introduced veneers and turns the
function tracer off globally.

ARM64 already has a solution for the problem, refer to the following
patches:

arm64: ftrace: emit ftrace-mod.o contents through code
arm64: module-plts: factor out PLT generation code for ftrace
arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
arm64: ftrace: fix building without CONFIG_MODULES
arm64: ftrace: add support for far branches to dynamic ftrace
arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()

But the presented ARM variant has just a half of the footprint in terms of
the changed LoCs. It also retains the code validation-before-modification
instead of switching it off.

Alexander Sverdlin (3):
  ftrace: Add module to ftrace_make_call() parameters
  ARM: PLT: Move struct plt_entries definition to header
  ftrace: Add MODULE_PLTS support

 arch/arm/include/asm/module.h      | 10 ++++++
 arch/arm/kernel/ftrace.c           | 73 ++++++++++++++++++++++++++++++++------
 arch/arm/kernel/module-plts.c      | 58 +++++++++++++++++++-----------
 arch/arm64/kernel/ftrace.c         |  3 +-
 arch/blackfin/kernel/ftrace.c      |  3 +-
 arch/ia64/kernel/ftrace.c          |  3 +-
 arch/metag/kernel/ftrace.c         |  3 +-
 arch/microblaze/kernel/ftrace.c    |  3 +-
 arch/mips/kernel/ftrace.c          |  3 +-
 arch/powerpc/kernel/trace/ftrace.c |  3 +-
 arch/s390/kernel/ftrace.c          |  3 +-
 arch/sh/kernel/ftrace.c            |  3 +-
 arch/sparc/kernel/ftrace.c         |  3 +-
 arch/tile/kernel/ftrace.c          |  3 +-
 arch/x86/kernel/ftrace.c           |  3 +-
 include/linux/ftrace.h             |  4 ++-
 kernel/trace/ftrace.c              |  6 ++--
 17 files changed, 140 insertions(+), 47 deletions(-)

-- 
2.4.6
