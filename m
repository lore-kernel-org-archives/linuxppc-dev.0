Return-Path: <roland@redhat.com>
Received: from QMTA10.emeryville.ca.mail.comcast.net
	(qmta10.emeryville.ca.mail.comcast.net [76.96.30.17])
	by ozlabs.org (Postfix) with ESMTP id 9165BDDF4B
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 16:49:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/5] powerpc tracehook
Message-Id: <20080727064859.69692154280@magilla.localdomain>
Date: Sat, 26 Jul 2008 23:48:59 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These patches are posted for review, but you can just pull the GIT branch
if you prefer.  Patch 1/5 corrects a long-standing (minor) error in ptrace
behavior.  The others change no existing behavior, just enable new and
future features to work on the arch.

The following changes since commit 8be1a6d6c77ab4532e4476fdb8177030ef48b52c:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../roland/infiniband

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/frob/linux-2.6-utrace.git powerpc-tracehook

Roland McGrath (5):
      powerpc: tracehook_signal_handler
      powerpc: tracehook syscall
      powerpc: tracehook: asm/syscall.h
      powerpc: tracehook: TIF_NOTIFY_RESUME
      powerpc: tracehook: CONFIG_HAVE_ARCH_TRACEHOOK

 arch/powerpc/Kconfig              |    1 +
 arch/powerpc/kernel/entry_32.S    |   11 ++++-
 arch/powerpc/kernel/entry_64.S    |   10 +++-
 arch/powerpc/kernel/ptrace.c      |   47 ++++++++++-----------
 arch/powerpc/kernel/signal.c      |   21 ++++++++-
 include/asm-powerpc/ptrace.h      |    1 +
 include/asm-powerpc/signal.h      |    3 +-
 include/asm-powerpc/syscall.h     |   84 +++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/thread_info.h |    5 ++-
 9 files changed, 147 insertions(+), 36 deletions(-)
 create mode 100644 include/asm-powerpc/syscall.h


Thanks,
Roland
