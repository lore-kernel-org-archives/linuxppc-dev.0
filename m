Return-Path: <rgb@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 3770C2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 08:28:39 +1100 (EST)
From: Richard Guy Briggs <rgb@redhat.com>
To: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6][RFC] audit: standardize and simplify syscall_get_arch()
Date: Wed,  5 Mar 2014 16:27:01 -0500
Message-Id: <cover.1393974970.git.rgb@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 Richard Guy Briggs <rgb@redhat.com>, microblaze-uclinux@itee.uq.edu.au,
 linux@openrisc.net, x86@kernel.org, oleg@redhat.com, eparis@redhat.com,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, sgrubb@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Each arch that supports audit requires syscall_get_arch() to able to log
and identify architecture-dependent syscall numbers.  The information is used
in at least two different subsystems, so standardize it in the same call across
all arches.

Use the standardized syscall_get_arch() locally to add the arch to the
AUDIT_SECCOMP record to identify which syscall was issued.

Since all the callers of syscall_get_arch() presently pass "current" and none
of the arch-specific syscall_get_arch() implementations use the regs parameter,
call syscall_get_arch() locally where it is needed and drop passing around
arch, current and regs in __audit_syscall_entry() and audit_syscall_entry().

Compiles and runs on i686, x86_64, ppc, ppc64, s390, s390x, manually tested in
an x86_64 VM.  aarch64 will be added soon.

Richard Guy Briggs (6):
  syscall: define syscall_get_arch() for each audit-supported arch
  audit: add arch field to seccomp event log
  audit: __audit_syscall_entry: ignore arch arg and call
    syscall_get_arch() directly
  audit: drop arch from audit_syscall_entry() interface
  audit: drop args from syscall_get_arch() interface
  audit: drop arch from __audit_syscall_entry() interface

 arch/arm/include/asm/syscall.h        |    5 ++---
 arch/arm/kernel/ptrace.c              |    2 +-
 arch/ia64/include/asm/syscall.h       |    6 ++++++
 arch/ia64/kernel/ptrace.c             |    2 +-
 arch/microblaze/include/asm/syscall.h |    5 +++++
 arch/microblaze/kernel/ptrace.c       |    2 +-
 arch/mips/include/asm/syscall.h       |    6 +++---
 arch/mips/kernel/ptrace.c             |    3 +--
 arch/openrisc/include/asm/syscall.h   |    5 +++++
 arch/openrisc/kernel/ptrace.c         |    2 +-
 arch/parisc/include/asm/syscall.h     |   11 +++++++++++
 arch/parisc/kernel/ptrace.c           |    5 ++---
 arch/powerpc/include/asm/syscall.h    |   12 ++++++++++++
 arch/powerpc/kernel/ptrace.c          |    6 ++----
 arch/s390/include/asm/syscall.h       |    7 +++----
 arch/s390/kernel/ptrace.c             |    4 +---
 arch/sh/include/asm/syscall.h         |   16 ++++++++++++++++
 arch/sh/kernel/ptrace_32.c            |   13 +------------
 arch/sh/kernel/ptrace_64.c            |   16 +---------------
 arch/sparc/include/asm/syscall.h      |    7 +++++++
 arch/sparc/kernel/ptrace_64.c         |    5 +----
 arch/um/kernel/ptrace.c               |    3 +--
 arch/x86/ia32/ia32entry.S             |   12 ++++++------
 arch/x86/include/asm/syscall.h        |   10 ++++------
 arch/x86/kernel/entry_32.S            |   11 +++++------
 arch/x86/kernel/entry_64.S            |   11 +++++------
 arch/x86/kernel/ptrace.c              |    6 ++----
 arch/xtensa/kernel/ptrace.c           |    2 +-
 include/asm-generic/syscall.h         |    6 ++----
 include/linux/audit.h                 |    9 ++++-----
 include/uapi/linux/audit.h            |    1 +
 kernel/auditsc.c                      |    6 ++++--
 kernel/seccomp.c                      |    4 ++--
 33 files changed, 120 insertions(+), 101 deletions(-)
