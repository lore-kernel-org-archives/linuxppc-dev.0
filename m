Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18642.33679.149733.537374@cargo.ozlabs.ibm.com>
Date: Thu, 18 Sep 2008 09:36:31 -0700
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

The main thing there is a patch from James Bottomley which fixes the
build failure on 64-bit powerpc with CONFIG_MODULES=n.

There are two other small commits that fix boot problems for embedded
boards: one that ensures that we build the right type of image for the
Holly evaluation board, and one that fixes some interrupt numbers on
Freescale MPC8610-based systems.

Thanks,
Paul.

 arch/powerpc/boot/Makefile             |    2 +-
 arch/powerpc/boot/dts/mpc8610_hpcd.dts |    8 ++++----
 arch/powerpc/include/asm/elf.h         |    7 +++++++
 arch/powerpc/include/asm/sections.h    |   12 +++++++++++-
 arch/powerpc/kernel/module_64.c        |   19 -------------------
 5 files changed, 23 insertions(+), 25 deletions(-)

commit 2d291e902791e1c8d72bc223b6f063bbb27a1280
Author: James Bottomley <James.Bottomley@HansenPartnership.com>
Date:   Tue Sep 9 14:04:18 2008 +0000

    Fix compile failure with non modular builds
    
    Commit deac93df26b20cf8438339b5935b5f5643bc30c9 ("lib: Correct printk
    %pF to work on all architectures") broke the non modular builds by
    moving an essential function into modules.c.  Fix this by moving it
    out again and into asm/sections.h as an inline.  To do this, the
    definition of struct ppc64_opd_entry has been lifted out of modules.c
    and put in asm/elf.h where it belongs.
    
    Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 32dde0f975e430f00f03f80f7dbab585d8b45eab
Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date:   Tue Sep 9 04:00:28 2008 +0000

    powerpc: Holly board needs dtbImage target
    
    One of the changes in the bootwrapper makefile introduced the dtbImage
    targets for boards that need a simple zImage with a DTB embedded in
    them (595be948cce574ff2d5dde5d0426a636a4363c70, "[POWERPC]
    bootwrapper: Build multiple cuImages").  When this was done, it broke
    booting on the Holly board as the zImage.holly wrapper did not get the
    DTB embedded properly.
    
    This changes the target for the Holly board to a dtbImage so that the
    wrapper includes the vmlinux, wrapper bits, and DTB.
    
    Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 612f9d338a6060f814ef35b7108b43407a5df423
Author: Timur Tabi <timur@freescale.com>
Date:   Tue Sep 9 14:43:39 2008 -0500

    powerpc: Fix interrupt values for DMA2 in MPC8610 HPCD device tree
    
    For Freescale 8xxx devices that use an MPIC, the interrupt numbers in
    the device tree must be 16 greater than the values documented in the
    reference manual.  In these chips, the MPIC is wired to use the first
    16 numbers for external interrupts, but the documentation numbers
    internal interrupts from 0.
    
    In the MPC8610 HPCD device tree, the interrupt properties for the DMA
    channels for DMA2 were not the adjusted values.  This fixes that.
    
    Signed-off-by: Timur Tabi <timur@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
