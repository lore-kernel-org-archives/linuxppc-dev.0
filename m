Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18312.1349.656827.252548@cargo.ozlabs.ibm.com>
Date: Sat, 12 Jan 2008 11:09:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
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

to get two more bug fixes for powerpc, as listed below.

Thanks,
Paul.

 arch/powerpc/kernel/prom_init.c              |   39 ++++++++++++++++++++++++++
 arch/powerpc/mm/slb.c                        |    8 +++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 +
 arch/powerpc/platforms/pseries/lpar.c        |    1 +
 include/asm-powerpc/mmu-hash64.h             |    1 +
 5 files changed, 51 insertions(+), 0 deletions(-)

commit 473980a99316c0e788bca50996375a2815124ce1
Author: Michael Neuling <mikey@neuling.org>
Date:   Fri Jan 11 14:02:47 2008 +1100

    [POWERPC] Fix CPU hotplug when using the SLB shadow buffer
    
    Before we register the SLB shadow buffer, we need to invalidate the
    entries in the buffer, otherwise we can end up stale entries from when
    we previously offlined the CPU.
    
    This does this invalidate as well as unregistering the buffer with
    PHYP before we offline the cpu.  Tested and fixes crashes seen on
    970MP (thanks to tonyb) and POWER5.
    
    Signed-off-by: Michael Neuling <mikey@neuling.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 6f4347c969674ed45de7d08d4b26d6326a95b959
Author: Olaf Hering <olaf@aepfle.de>
Date:   Thu Jan 10 01:06:08 2008 +1100

    [POWERPC] efika: add phy-handle property for fec_mpc52xx
    
    The new network driver fec_mpc52xx will not work on efika because the
    firmware does not provide all required properties.
    http://www.powerdeveloper.org/asset/by-id/46 has a Forth script to
    create more properties. But only the phy stuff is required to get a
    working network.
    
    This should go into the kernel because its appearently
    impossible to boot the script via tftp and then load the real boot
    binary (yaboot or zimage).
    
    Signed-off-by: Olaf Hering <olaf@aepfle.de>
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
