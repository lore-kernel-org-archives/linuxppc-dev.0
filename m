Return-Path: <jdl@jdl.com>
From: Jon Loeliger <linuxppc@jdl.com>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Sat, 17 Sep 2005 10:31:52 -0500
Message-Id: <E1EGefQ-00072D-34@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH powerpc: 00/04 Remove __pmac, etc, sections, merge sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Here is a new patch that removes all notion of the pmac, prep,
chrp and openfirmware initialization sections, and then unifies
the sections.h files without those __pmac, etc, sections identifiers
cluttering things up.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---

Part 01/04 - Remove sections use from ppc
 arch/ppc/kernel/pci.c               |   10 +-
 arch/ppc/kernel/setup.c             |    2 
 arch/ppc/platforms/chrp_pci.c       |    8 +-
 arch/ppc/platforms/chrp_setup.c     |   16 ++-
 arch/ppc/platforms/chrp_smp.c       |    2 
 arch/ppc/platforms/chrp_time.c      |    8 +-
 arch/ppc/platforms/pmac_backlight.c |   16 ++-
 arch/ppc/platforms/pmac_cpufreq.c   |   36 ++++---
 arch/ppc/platforms/pmac_feature.c   |  176 ++++++++++++++++++-----------------
 arch/ppc/platforms/pmac_nvram.c     |   42 ++++----
 arch/ppc/platforms/pmac_pci.c       |   22 ++--
 arch/ppc/platforms/pmac_pic.c       |   26 +++--
 arch/ppc/platforms/pmac_setup.c     |   12 +-
 arch/ppc/platforms/pmac_smp.c       |   10 +-
 arch/ppc/platforms/pmac_time.c      |    8 +-
 arch/ppc/platforms/prep_pci.c       |   64 ++++++-------
 arch/ppc/platforms/prep_setup.c     |   44 ++++-----
 arch/ppc/platforms/residual.c       |    2 
 arch/ppc/syslib/btext.c             |    6 +
 arch/ppc/syslib/prep_nvram.c        |   13 +--
 arch/ppc/syslib/prom.c              |   18 ++--

Part 02/04 - Remove sections use from ppc64 and drivers
 arch/ppc64/kernel/pmac_feature.c    |   60 ++++++------
 arch/ppc64/kernel/pmac_nvram.c      |   30 +++---
 arch/ppc64/kernel/pmac_pci.c        |   12 +-
 arch/ppc64/kernel/pmac_setup.c      |   10 +-
 arch/ppc64/kernel/pmac_smp.c        |    2 
 arch/ppc64/kernel/pmac_time.c       |    4 -
 drivers/ide/ppc/pmac.c              |   80 ++++++++--------
 drivers/macintosh/ans-lcd.c         |   10 +-
 drivers/macintosh/mediabay.c        |   56 ++++++-----
 drivers/macintosh/via-cuda.c        |    1 
 drivers/macintosh/via-pmu.c         |  129 +++++++++++++-------------
 drivers/macintosh/via-pmu68k.c      |   15 +--

Part 03/04 - Remove section free() and linker script
 arch/ppc/kernel/vmlinux.lds.S       |   26 -----
 arch/ppc/mm/init.c                  |   12 --

Part 04/04 - Merge simplified sections.h into asm-powerpc
 include/asm-powerpc/sections.h      |   20 ++++
 include/asm-ppc/sections.h          |   33 -------
 include/asm-ppc64/sections.h        |   29 ------

 38 files changed, 492 insertions(+), 578 deletions(-)
