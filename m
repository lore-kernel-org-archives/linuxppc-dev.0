Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59797DDF7D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 19:30:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18917.43269.907035.106694@cargo.ozlabs.ibm.com>
Date: Wed, 15 Apr 2009 19:29:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please pull from the 'merge' branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a collection of bug fixes, a documentation update and a
defconfig update for powerpc.

The commit from Hugh Dickins is not strictly a bugfix, but it is
small, obvious, only affects people using a very specialized embedded
setup (those using 256kB pages on PPC44x embedded systems), and I got
prodded by Andrew Morton about it, so I put it in.

Thanks,
Paul.

 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   46 +++++--
 arch/powerpc/Kconfig                           |    2 
 arch/powerpc/boot/dts/tqm8540.dts              |    4 -
 arch/powerpc/boot/dts/tqm8541.dts              |    4 -
 arch/powerpc/boot/dts/tqm8548-bigflash.dts     |    8 +
 arch/powerpc/boot/dts/tqm8548.dts              |    8 +
 arch/powerpc/boot/dts/tqm8555.dts              |    4 -
 arch/powerpc/boot/dts/tqm8560.dts              |    4 -
 arch/powerpc/configs/85xx/tqm8548_defconfig    |  164 +++++++-----------------
 arch/powerpc/include/asm/futex.h               |   12 +-
 arch/powerpc/include/asm/mmu.h                 |    6 +
 arch/powerpc/include/asm/ppc-opcode.h          |   13 ++
 arch/powerpc/kernel/cputable.c                 |    2 
 arch/powerpc/mm/tlb_nohash.c                   |    1 
 arch/powerpc/mm/tlb_nohash_low.S               |   14 ++
 arch/powerpc/platforms/pseries/dtl.c           |    1 
 arch/powerpc/platforms/pseries/eeh_driver.c    |    2 
 include/linux/fsl_devices.h                    |    4 -
 18 files changed, 136 insertions(+), 163 deletions(-)

Hugh Dickins (1):
      powerpc: Allow 256kB pages with SHMEM

Kumar Gala (3):
      powerpc: Fix tlbilx opcode
      powerpc: Add support for early tlbilx opcode
      powerpc/mm: Fix compile warning

Mike Mason (1):
      powerpc/pseries: Set error_state to pci_channel_io_normal in eeh_report_reset()

Paul Mackerras (1):
      powerpc: Fix data-corrupting bug in __futex_atomic_op

Sachin Sant (1):
      powerpc: pseries/dtl.c should include asm/firmware.h

Wolfgang Grandegger (4):
      powerpc/85xx: TQM85xx: correct address of LM75 I2C device nodes
      powerpc/85xx: TQM8548: use proper phy-handles for enet2 and enet3
      powerpc/85xx: TQM8548: update defconfig
      powerpc: Document new FSL I2C bindings and cleanup
