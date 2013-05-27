Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/5] powerpc/tm: Various transactional memory fixes
Date: Mon, 27 May 2013 14:09:36 +1000
Message-Id: <1369627781-31088-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bunch of fixes for transactional memory.

Michael Neuling (5):
  powerpc/tm: Make room for hypervisor in abort cause codes
  powerpc/tm: Update cause codes documentation
  powerpc/tm: Abort on emulation and alignment faults
  powerpc/tm: Move TM abort cause codes to uapi
  powerpc/tm: Fix userspace stack corruption on signal delivery for
    active transactions

 Documentation/powerpc/transactional_memory.txt |   27 ++++++++++++++--
 arch/powerpc/include/asm/processor.h           |   13 +++-----
 arch/powerpc/include/asm/reg.h                 |   11 -------
 arch/powerpc/include/asm/signal.h              |    3 ++
 arch/powerpc/include/asm/tm.h                  |    2 ++
 arch/powerpc/include/uapi/asm/tm.h             |   18 +++++++++++
 arch/powerpc/kernel/signal.c                   |   40 ++++++++++++++++++++++--
 arch/powerpc/kernel/signal.h                   |    2 +-
 arch/powerpc/kernel/signal_32.c                |   10 ++----
 arch/powerpc/kernel/signal_64.c                |   23 +++++---------
 arch/powerpc/kernel/traps.c                    |   29 +++++++++++++++++
 11 files changed, 129 insertions(+), 49 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/tm.h

-- 
1.7.10.4
