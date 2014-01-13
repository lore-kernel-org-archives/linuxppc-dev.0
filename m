Return-Path: <paulus@samba.org>
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/3] Transactional memory fixes
Date: Mon, 13 Jan 2014 15:56:27 +1100
Message-Id: <1389588990-25953-1-git-send-email-paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches fixes a couple of cases where bugs in the
handling of FP/VMX/VSX state around transactions can lead to
corruption of the FP/VMX/VSX state visible to user processes.  The
bugs were found basically by inspection but then verified by writing
small test programs that provoke the bugs.

Paul.

 arch/powerpc/include/asm/processor.h   |   2 +
 arch/powerpc/include/asm/thread_info.h |   9 +-
 arch/powerpc/include/asm/tm.h          |   1 +
 arch/powerpc/kernel/entry_64.S         |  12 ++-
 arch/powerpc/kernel/fpu.S              |  16 ++++
 arch/powerpc/kernel/process.c          | 146 ++++++++++++++++++++++++++++++---
 arch/powerpc/kernel/signal.c           |   3 +-
 arch/powerpc/kernel/signal_32.c        |  21 ++---
 arch/powerpc/kernel/signal_64.c        |  14 ++--
 arch/powerpc/kernel/traps.c            |  57 +++++++++----
 arch/powerpc/kernel/vector.S           |  10 +++
 11 files changed, 231 insertions(+), 60 deletions(-)
