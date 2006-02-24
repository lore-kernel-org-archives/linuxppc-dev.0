Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17406.28971.200764.591757@cargo.ozlabs.ibm.com>
Date: Fri, 24 Feb 2006 13:36:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc-merge.git
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

I have pulled out the problematic commit, so please do a pull from

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

There are 14 commits there: fixes for various bugs and a performance
regression, plus a defconfig update.

Thanks,
Paul.

Alan Curry:
      powerpc: fix altivec_unavailable_exception Oopses

Anton Blanchard:
      powerpc: Fix runlatch performance issues
      powerpc64: remove broken/bitrotted HMT support

Haren Myneni:
      powerpc: Trivial fix to set the proper timeout value for kdump

Kelly Daly:
      powerpc: disable OProfile for iSeries

Kumar Gala:
      powerpc: Enable coherency for all pages on 83xx to fix PCI data corruption

Michael Ellerman:
      powerpc: Initialise hvlpevent_queue.lock correctly
      powerpc: Only calculate htab_size in one place for kexec

Michal Ostrowski:
      Fix race condition in hvc console.

Olaf Hering:
      ppc: fix adb breakage in xmon

Olof Johansson:
      powerpc: Update {g5,pseries,ppc64}_defconfig

R Sharada:
      powerpc64: fix spinlock recursion in native_hpte_clear

Segher Boessenkool:
      powerpc: Fix some MPIC + HT APIC buglets
      powerpc: Don't re-assign PCI resources on Maple

 arch/powerpc/configs/g5_defconfig         |  174 ++++++++++--------------
 arch/powerpc/configs/ppc64_defconfig      |  173 ++++++++++--------------
 arch/powerpc/configs/pseries_defconfig    |  127 ++++++-----------
 arch/powerpc/kernel/crash.c               |    4 -
 arch/powerpc/kernel/head_32.S             |    1 
 arch/powerpc/kernel/head_64.S             |  109 +--------------
 arch/powerpc/kernel/machine_kexec_64.c    |   10 -
 arch/powerpc/kernel/process.c             |   32 ++++
 arch/powerpc/kernel/prom_init.c           |   38 -----
 arch/powerpc/mm/hash_native_64.c          |    7 +
 arch/powerpc/mm/hash_utils_64.c           |    3 
 arch/powerpc/oprofile/Kconfig             |    1 
 arch/powerpc/platforms/iseries/lpevents.c |    2 
 arch/powerpc/platforms/iseries/setup.c    |    1 
 arch/powerpc/platforms/maple/pci.c        |    4 -
 arch/powerpc/platforms/pseries/Kconfig    |    7 -
 arch/powerpc/sysdev/mpic.c                |    9 +
 arch/ppc/kernel/head.S                    |    1 
 arch/ppc/xmon/adb.c                       |  212 -----------------------------
 arch/ppc/xmon/start.c                     |  169 -----------------------
 arch/ppc/xmon/xmon.c                      |  108 ---------------
 drivers/char/hvc_console.c                |    8 +
 include/asm-powerpc/cputable.h            |    9 +
 include/asm-powerpc/mmu.h                 |    1 
 include/asm-powerpc/reg.h                 |   33 -----
 include/asm-powerpc/thread_info.h         |    4 -
 26 files changed, 274 insertions(+), 973 deletions(-)
 delete mode 100644 arch/ppc/xmon/adb.c
