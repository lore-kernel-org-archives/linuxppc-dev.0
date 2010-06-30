Return-Path: <paulus@ozlabs.org>
Date: Wed, 30 Jun 2010 16:37:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull my perf.git tree support
Message-ID: <20100630063745.GA6059@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

When you set up your next branch for commits to go in 2.6.36-rc1,
please do a pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/perf.git master

to get a series of commits that add support for hw_breakpoint events
on 64-bit POWER server processors in the perf_event subsystem.  This
consists of a commit from me that adds support for most integer
instructions to the emulate_step() function, a series from K. Prasad
that add the ppc64-specific hw_breakpoint code, and some small
commits from me that fix a few bugs that I found in testing.

There is one commit in there from K. Prasad that modifies the generic
hw_breakpoint code to add the ability to have an arch-specific
unregister hook for hw_breakpoints.  It has been acked by Frederic
Weisbecker.

Thanks,
Paul.

The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:

  Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/paulus/perf.git master

K.Prasad (5):
      hw_breakpoints: Allow arch-specific cleanup before breakpoint unregistration
      powerpc, hw_breakpoints: Implement hw_breakpoints for 64-bit server processors
      powerpc, hw_breakpoint: Handle concurrent alignment interrupts
      powerpc, hw_breakpoint: Enable hw-breakpoints while handling intervening signals
      powerpc, hw_breakpoint: Discard extraneous interrupt due to accesses outside symbol length

Paul Mackerras (4):
      powerpc: Emulate most Book I instructions in emulate_step()
      powerpc, hw_breakpoint: Fix off-by-one in checking access address
      powerpc, hw_breakpoint: Cooperate better with other single-steppers
      powerpc, hw_breakpoint: Tell generic code we have no instruction breakpoints

 arch/powerpc/Kconfig                     |    1 +
 arch/powerpc/include/asm/asm-compat.h    |    2 +
 arch/powerpc/include/asm/cputable.h      |    4 +
 arch/powerpc/include/asm/hw_breakpoint.h |   74 ++
 arch/powerpc/include/asm/ppc-opcode.h    |    7 +
 arch/powerpc/include/asm/processor.h     |    8 +
 arch/powerpc/kernel/Makefile             |    1 +
 arch/powerpc/kernel/exceptions-64s.S     |    1 +
 arch/powerpc/kernel/hw_breakpoint.c      |  364 +++++++
 arch/powerpc/kernel/machine_kexec_64.c   |    3 +
 arch/powerpc/kernel/process.c            |   14 +
 arch/powerpc/kernel/ptrace.c             |   64 ++
 arch/powerpc/kernel/signal.c             |    3 +
 arch/powerpc/kernel/traps.c              |    8 +-
 arch/powerpc/lib/Makefile                |    5 +-
 arch/powerpc/lib/ldstfp.S                |  375 ++++++++
 arch/powerpc/lib/sstep.c                 | 1514 +++++++++++++++++++++++++++++-
 kernel/hw_breakpoint.c                   |   12 +
 18 files changed, 2408 insertions(+), 52 deletions(-)
 create mode 100644 arch/powerpc/include/asm/hw_breakpoint.h
 create mode 100644 arch/powerpc/kernel/hw_breakpoint.c
 create mode 100644 arch/powerpc/lib/ldstfp.S
