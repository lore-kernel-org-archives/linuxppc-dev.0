Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B94FCB7D7F
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 12:38:22 +1000 (EST)
Date: Mon, 24 May 2010 21:38:14 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <Pine.LNX.4.64.1005242136240.18901@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following changes since commit 99ec28f183daa450faa7bdad6f932364ae325648:
  FUJITA Tomonori (1):
        powerpc: Remove unused 'protect4gb' boot parameter

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Andy Fleming (1):
      powerpc/85xx: Enable support for ports 3 and 4 on 8548 CDS

Anton Vorontsov (1):
      powerpc/fsl-booke: Add hibernation support for FSL BookE processors

Haiying Wang (1):
      powerpc/85xx: Add P1021MDS board support

Lan Chunhe-B25806 (1):
      powerpc/fsl_msi: Add multiple MSI bank support

Li Yang (5):
      powerpc/fsl_msi: fix the conflict of virt_msir's chip_data
      powerpc/fsl_msi: enable msi allocation in all banks
      powerpc/fsl_msi: enable msi sharing through AMP OSes
      powerpc/fsl_msi: add removal path and probe failing path
      powerpc/85xx: Change MPC8572DS camp dtses for MSI sharing

Scott Wood (1):
      powerpc/e500mc: Implement machine check handler.

Sebastian Andrzej Siewior (3):
      powerpc/fsl-booke: fix the case where we are not in the first page
      powerpc/fsl-booke: Move the entry setup code into a seperate file
      powerpc/kexec: Add support for FSL-BookE

 arch/powerpc/Kconfig                           |    2 +-
 arch/powerpc/boot/dts/mpc8548cds.dts           |    4 -
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |   15 +-
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    7 +-
 arch/powerpc/boot/dts/p1021mds.dts             |  698 ++++++++++++++++++++++++
 arch/powerpc/include/asm/cputable.h            |    1 +
 arch/powerpc/include/asm/kexec.h               |   13 +
 arch/powerpc/include/asm/reg_booke.h           |   33 +-
 arch/powerpc/kernel/Makefile                   |    8 +-
 arch/powerpc/kernel/cputable.c                 |    2 +-
 arch/powerpc/kernel/crash.c                    |    4 +
 arch/powerpc/kernel/fsl_booke_entry_mapping.S  |  237 ++++++++
 arch/powerpc/kernel/head_fsl_booke.S           |  200 +-------
 arch/powerpc/kernel/misc_32.S                  |   17 +
 arch/powerpc/kernel/swsusp_booke.S             |  193 +++++++
 arch/powerpc/kernel/traps.c                    |   88 +++-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c      |  102 ++++-
 arch/powerpc/sysdev/fsl_msi.c                  |  117 ++++-
 arch/powerpc/sysdev/fsl_msi.h                  |    3 +
 19 files changed, 1494 insertions(+), 250 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1021mds.dts
 create mode 100644 arch/powerpc/kernel/fsl_booke_entry_mapping.S
 create mode 100644 arch/powerpc/kernel/swsusp_booke.S
