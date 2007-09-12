Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18152.12123.495587.248673@cargo.ozlabs.ibm.com>
Date: Thu, 13 Sep 2007 04:26:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch again
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

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get four small bug-fixes for embedded powerpc from Kumar, plus a
one-liner from Olof that I missed putting in the previous batch.

Thanks,
Paul.

 arch/powerpc/kernel/legacy_serial.c        |    2 +-
 arch/powerpc/platforms/85xx/mpc8544_ds.c   |    2 ++
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 ++
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 ++
 arch/powerpc/platforms/Kconfig             |    1 +
 arch/powerpc/sysdev/cpm2_common.c          |    2 +-
 arch/ppc/kernel/head_8xx.S                 |    2 --
 8 files changed, 10 insertions(+), 5 deletions(-)

commit ee56c47440ab04c6a35c835a9bcc4193304adf93
Author: Olof Johansson <olof@lixom.net>
Date:   Wed Aug 22 19:26:37 2007 -0500

    [POWERPC] Move serial_dev_init to device_initcall()
    
    With the I/O space rewrite by BenH, the legacy_serial serial_dev_init()
    initcall is now called before I/O space is setup, but it's dependent on
    it being available.
    
    Since there's no way to make dependencies between initcalls, we'll just
    have to move it to device_initcall(). Yes, it's suboptimal but I'm not
    aware of any better solution at this time, and it fixes a regression
    from 2.6.22.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit fb4f0e8832e0075849b41b65f6bb9fdfa7593b99
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Mon Sep 10 14:57:34 2007 -0500

    [POWERPC] Enable GENERIC_ISA_DMA if FSL_ULI1575 to fix compile issue
    
    Since the ULI1575 has a ISA bus we need to enable the generic ISA dma
    support for drivers that might expect it.  Without this we get compile
    errors like the following:
    
    ound/built-in.o: In function `claim_dma_lock':
    /home/galak/git/linux-8572/include/asm/dma.h:189: undefined reference to `dma_spin_lock'
    /home/galak/git/linux-8572/include/asm/dma.h:189: undefined reference to `dma_spin_lock'
    sound/built-in.o: In function `release_dma_lock':
    /home/galak/git/linux-8572/include/asm/dma.h:195: undefined reference to `dma_spin_lock'
    sound/built-in.o: In function `claim_dma_lock':
    /home/galak/git/linux-8572/include/asm/dma.h:189: undefined reference to `dma_spin_lock'
    /home/galak/git/linux-8572/include/asm/dma.h:189: undefined reference to `dma_spin_lock'
    sound/built-in.o:/home/galak/git/linux-8572/include/asm/dma.h:195: more undefined references to `dma_spin_lock' follow
    make: *** [.tmp_vmlinux1] Error 1
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 83fcdb4b352f74a8a74737aedeaf622c37140c73
Author: Scott Wood <scottwood@freescale.com>
Date:   Wed Sep 5 14:29:10 2007 -0500

    [POWERPC] cpm2: Fix off-by-one error in setbrg().
    
    The hardware adds one to the BRG value to get the divider, so it must
    be subtracted by software.  Without this patch, characters will occasionally
    be corrupted.
    
    Signed-off-by: Scott Wood <scottwood@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 36c50f729b77144cae8d43457fefca66a4eeff6a
Author: Jochen Friedrich <jochen@scram.de>
Date:   Tue Aug 28 13:20:48 2007 +0200

    [PPC] 8xx: Fix r3 trashing due to 8MB TLB page instantiation
    
    Instantiation of 8MB pages on the TLB cache for the kernel static
    mapping trashes r3 register on !CONFIG_8xx_CPU6 configurations.
    This ensures r3 gets saved and restored.
    
    This has been posted to linuxppc-embedded by Marcelo Tosatti
    <marcelo@kvack.org>, but only an incomplete version of the patch
    has been applied in c51e078f82096a7d35ac8ec2416272e843a0e1c4.
    This patch adds the rest of the fix.
    
    Signed-off-by: Jochen Friedrich <jochen@scram.de>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 2af8569dc9f29c303bf4aa012d991afcfaeed0c3
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Mon Sep 10 14:30:33 2007 -0500

    [POWERPC] 8{5,6}xx: Fix build issue with !CONFIG_PCI
    
    We needed some ifdef CONFIG_PCI protection for pcibios_fixup so we
    can build !CONFIG_PCI.
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
