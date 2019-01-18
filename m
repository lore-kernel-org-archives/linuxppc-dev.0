Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47965C43444
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:57:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C305F2086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C305F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h6Z75HjLzDqZw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:57:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5mP1HVQzDr2g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:21:24 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MfpGR-1hPtAA1bnl-00gJbe; Fri, 18 Jan 2019 17:19:15 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 00/29] y2038: add time64 syscalls
Date: Fri, 18 Jan 2019 17:18:06 +0100
Message-Id: <20190118161835.2259170-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MlEP5MAfPrwnhPCR1hEDJ6S/94MC4JorrlQ8VrP4ndjWBdkbGLA
 2Nc1/2Zbp0BUeHuj594YAHANFmnsP98d09kLC6kNisGeC2LIKvLzA9I4qAiHe6n0IjfhgER
 F3tYUAoeL7mos8f2fxr/7zcR8P74bFzeGPrsXs+HjVgZWE1s0XpsqrWkx2LjjAPz6HUgYVg
 jwxfgTuVVpgDW3CiQcSNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oz78oVYd8qs=:+Ez1MakXWRihufLiAYneRn
 /+lD0eLuhx0gzC/JYph91y8EB7KaHKYdW5Zt+Ifou3fVw/134msF0HHr1hzee21gxjYTzW+b2
 bRKSTHIrnTtZwR+b/nQhrLJgHI2VcMWp8EoiQI9VT0gwk6wY92MLyK/ZDpEBoGcnTvks1JBdq
 2NlubYkyII2ojRQ9dMLlZHMt7QVxoi28jbPPq2aJhkuO3kwy4GKPBVhqN86sZlF1UxFpPbE8Z
 K4qMnSx488kq8vLpypDVd9/L5C3ann/8XTyB33kuP4/VUNu9KzAXesyjqwZZQ+uc/XPdckf1I
 o2RQyLXXBftyveUVrfzL9e61fdrfYoTc0JlbQ3ERXoIPpmgzZ554Miqa/Z56oL7F3Bcw1Ix6q
 yKbUJSlDd5pa3B/BQLz4hpAEPpbaShX/7tUJfzeSTceuFP6R4dA6nmNjkvK8EoB2oPzESdr6u
 vhEqeRbO32ebuY/qNblRFRD5DNCy2buIFfgOKeC05v7PMg7GMU+qc2KtX/bGf3AuqoGLG4gBb
 f3uab+AFe8VYwi8Xshk7AfXxGo9lfQstn3Xh/+abPHfd5mJWOp1DTyEhDN9yTU8ribMl7xyhF
 OMMlR9R3v5c8pwSpitWQVVpj1oZ0AL+/gO/buSkQicSx/LDCqB27KcdFAH6N9NMlMN5OnSITZ
 ANb+8YLUdKVkuQl0LnO0X9eiTyw2a82lNCsMe0qk51sVPmtqXa9TMj0nIK+JU1BmumAB/ewYS
 Pt/hFH9xCIvf8RmuWGrkrwj10OUyf7q6cT7KTA==
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
 Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a minor update of the patches I posted last week, I
would like to add this into linux-next now, but would still do
changes if there are concerns about the contents. The first
version did not see a lot of replies, which could mean that
either everyone is happy with it, or that it was largely ignored.

See also the article at https://lwn.net/Articles/776435/.

Changes since v1:

- posting as a combined series for simplicity
- dropped one mips patch that was merged as a 5.0 fix
- reworked s390 compat syscall handling (posted separately)
  and rebased on top of that series
- minor fixes for arm64 and powerpc
- added alpha statfs64 interfaces
- added alpha get{eg,eu,g,p,u,pp}id()

     Arnd

----
v1 description for cleanup:
The system call tables have diverged a bit over the years, and a number
of the recent additions never made it into all architectures, for one
reason or another.

This is an attempt to clean it up as far as we can without breaking
compatibility, doing a number of steps:

- Add system calls that have not yet been integrated into all
  architectures but that we definitely want there.

- Add the separate ipc syscalls on all architectures that
  traditionally only had sys_ipc(). This version is done without
  support for IPC_OLD that is we have in sys_ipc. The
  new semtimedop_time64 syscall will only be added here, not
  in sys_ipc

- Add syscall numbers for a couple of syscalls that we probably
  don't need everywhere, in particular pkey_* and rseq,
  for the purpose of symmetry: if it's in asm-generic/unistd.h,
  it makes sense to have it everywhere.

- Prepare for having the same system call numbers for any future
  calls. In combination with the generated tables, this hopefully
  makes it easier to add new calls across all architectures
  together.

Most of the contents of this series are unrelated to the actual
y2038 work, but for the moment, that second series is based on
this one. If there are any concerns about changes here, I
can drop or rewrite any individual patch in this series.

My plan is to merge any patches in this series that are found
to be good together with the y2038 patches for linux-5.1, so
please review and provide Acks for merging through my tree,
or pick them up for 5.0 if they seem urgent enough.

v1 description for y2038 patches:

This series finally gets us to the point of having system calls with
64-bit time_t on all architectures, after a long time of incremental
preparation patches.

There was actually one conversion that I missed during the summer,
i.e. Deepa's timex series, which I now updated based the 5.0-rc1 changes
and review comments.

I hope that the actual conversion should be uncontroversial by now,
even if some of the patches are rather large.

The one area that may need a little discussion is for the system call
numbers assigned in the final patch: Can we get consensus on whether
the idea of using the same numbers on all architectures, as well as my
choice of numbers makes sense here?

So far, I have done a lot of build testing across most architectures,
which has found a number of bugs. I have also done an LTP run on arm32
with existing user space, but not on the other architectures. I did LTP
tests with a modified musl libc[2] last summer on an older version of
this series to make sure that the new 64-bit time_t interfaces work.
The version there will need updates for testing with this new kernel
patch series; I plan to do that next.

For testing, the series plus the preparatory patches is available at
[3].  Once there is a general agreement on this series and I have done
more tests for the new system calls, I plan to add this to linux-next
through my asm-generic tree or Thomas' timers tree.

Please review and test!

      Arnd

[1] https://lore.kernel.org/lkml/20190110162435.309262-1-arnd@arndb.de/T/
[2] https://git.linaro.org/people/arnd/musl-y2038.git/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-5.0-rc1

Arnd Bergmann (26):
  ia64: add __NR_umount2 definition
  ia64: add statx and io_pgetevents syscalls
  ia64: assign syscall numbers for perf and seccomp
  alpha: wire up io_pgetevents system call
  alpha: update syscall macro definitions
  ARM: add migrate_pages() system call
  ARM: add kexec_file_load system call number
  m68k: assign syscall number for seccomp
  sh: remove duplicate unistd_32.h file
  sh: add statx system call
  sparc64: fix sparc_ipc type conversion
  ipc: rename old-style shmctl/semctl/msgctl syscalls
  arch: add split IPC system calls where needed
  arch: add pkey and rseq syscall numbers everywhere
  alpha: add standard statfs64/fstatfs64 syscalls
  alpha: add generic get{eg,eu,g,p,u,pp}id() syscalls
  syscalls: remove obsolete __IGNORE_ macros
  time: make adjtime compat handling available for 32 bit
  time: fix sys_timer_settime prototype
  sparc64: add custom adjtimex/clock_adjtime functions
  x86/x32: use time64 versions of sigtimedwait and recvmmsg
  y2038: syscalls: rename y2038 compat syscalls
  y2038: use time32 syscall names on 32-bit
  y2038: remove struct definition redirects
  y2038: rename old time and utime syscalls
  y2038: add 64-bit time_t syscalls to all 32-bit architectures

Deepa Dinamani (3):
  time: Add struct __kernel_timex
  timex: use __kernel_timex internally
  timex: change syscalls to use struct __kernel_timex

 arch/Kconfig                                |   2 +-
 arch/alpha/include/asm/unistd.h             |  21 -
 arch/alpha/include/uapi/asm/unistd.h        |  10 +
 arch/alpha/kernel/osf_sys.c                 |   5 +-
 arch/alpha/kernel/syscalls/syscall.tbl      |  22 +-
 arch/arm/include/asm/unistd.h               |   5 +-
 arch/arm/kernel/sys_oabi-compat.c           |   8 +-
 arch/arm/tools/syscall.tbl                  |  85 +++--
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |  99 +++--
 arch/ia64/include/asm/unistd.h              |  14 -
 arch/ia64/include/uapi/asm/unistd.h         |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  11 +-
 arch/m68k/include/asm/unistd.h              |   4 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  88 +++--
 arch/microblaze/include/asm/unistd.h        |   4 +-
 arch/microblaze/kernel/syscalls/syscall.tbl |  83 ++--
 arch/mips/include/asm/unistd.h              |  20 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  77 ++--
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   7 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  85 +++--
 arch/parisc/include/asm/unistd.h            |  15 +-
 arch/parisc/kernel/syscalls/syscall.tbl     | 109 ++++--
 arch/powerpc/include/asm/unistd.h           |   8 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    | 134 +++++--
 arch/s390/include/asm/unistd.h              |   7 +-
 arch/s390/kernel/syscalls/syscall.tbl       |  87 +++--
 arch/sh/include/asm/unistd.h                |   4 +-
 arch/sh/include/uapi/asm/unistd_32.h        | 403 --------------------
 arch/sh/kernel/syscalls/syscall.tbl         |  88 +++--
 arch/sparc/include/asm/unistd.h             |  13 +-
 arch/sparc/kernel/sys_sparc_64.c            |  61 ++-
 arch/sparc/kernel/syscalls/syscall.tbl      | 116 ++++--
 arch/x86/entry/syscalls/syscall_32.tbl      |  85 +++--
 arch/x86/entry/syscalls/syscall_64.tbl      |   4 +-
 arch/x86/include/asm/unistd.h               |   8 +-
 arch/xtensa/include/asm/unistd.h            |  14 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     |  78 ++--
 drivers/ptp/ptp_clock.c                     |   2 +-
 fs/aio.c                                    |  10 +-
 fs/select.c                                 |   4 +-
 fs/timerfd.c                                |   4 +-
 fs/utimes.c                                 |  10 +-
 include/linux/compat.h                      | 104 +----
 include/linux/posix-clock.h                 |   2 +-
 include/linux/syscalls.h                    |  68 +++-
 include/linux/time32.h                      |  32 +-
 include/linux/time64.h                      |   8 -
 include/linux/timex.h                       |   4 +-
 include/uapi/asm-generic/unistd.h           | 103 +++--
 include/uapi/linux/time.h                   |   4 -
 include/uapi/linux/timex.h                  |  39 ++
 ipc/mqueue.c                                |  16 +-
 ipc/msg.c                                   |  39 +-
 ipc/sem.c                                   |  41 +-
 ipc/shm.c                                   |  40 +-
 ipc/syscall.c                               |  12 +-
 ipc/util.h                                  |  21 +-
 kernel/compat.c                             |  64 ----
 kernel/futex.c                              |   2 +-
 kernel/sched/core.c                         |   5 +-
 kernel/signal.c                             |   2 +-
 kernel/sys_ni.c                             |  21 +-
 kernel/time/hrtimer.c                       |   2 +-
 kernel/time/ntp.c                           |  18 +-
 kernel/time/ntp_internal.h                  |   2 +-
 kernel/time/posix-clock.c                   |   2 +-
 kernel/time/posix-stubs.c                   |  25 +-
 kernel/time/posix-timers.c                  |  72 ++--
 kernel/time/posix-timers.h                  |   2 +-
 kernel/time/time.c                          |  92 ++++-
 kernel/time/timekeeping.c                   |   4 +-
 net/compat.c                                |   2 +-
 scripts/checksyscalls.sh                    |  40 ++
 74 files changed, 1544 insertions(+), 1262 deletions(-)
 delete mode 100644 arch/sh/include/uapi/asm/unistd_32.h

-- 
2.20.0
Cc: mattst88@gmail.com
Cc: linux@armlinux.org.uk
Cc: catalin.marinas@arm.com
Cc: will.deacon@arm.com
Cc: tony.luck@intel.com
Cc: fenghua.yu@intel.com
Cc: geert@linux-m68k.org
Cc: monstr@monstr.eu
Cc: paul.burton@mips.com
Cc: deller@gmx.de
Cc: benh@kernel.crashing.org
Cc: mpe@ellerman.id.au
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: dalias@libc.org
Cc: davem@davemloft.net
Cc: luto@kernel.org
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: jcmvbkbc@gmail.com
Cc: arnd@arndb.de
Cc: akpm@linux-foundation.org
Cc: deepa.kernel@gmail.com
Cc: ebiederm@xmission.com
Cc: firoz.khan@linaro.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org

