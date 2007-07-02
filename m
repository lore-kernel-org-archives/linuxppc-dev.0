Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18056.32340.502484.171937@cargo.ozlabs.ibm.com>
Date: Mon, 2 Jul 2007 14:25:56 +1000
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

My defconfig updates exposed some compile failures on powerpc, which
these three commits fix.

Thanks,
Paul.

 arch/powerpc/kernel/irq.c                 |    6 ++++++
 arch/powerpc/platforms/cell/cbe_cpufreq.c |   15 ++++++++++-----
 drivers/net/Kconfig                       |    2 +-
 include/asm-powerpc/irq.h                 |    5 +----
 4 files changed, 18 insertions(+), 10 deletions(-)

commit 9f7905812e5919862acb6ede63e10d3d1bb4958e
Author: Olof Johansson <olof@lixom.net>
Date:   Mon Jun 4 14:47:04 2007 +1000

    [POWERPC] Uninline and export virq_to_hw() for the pasemi_mac driver
    
    Uninline virq_to_hw and export it so modules can use it. The alternative
    would be to export the irq_map array instead, but it's an infrequently
    called function, and keeping the array unexported seems considerably
    cleaner.
    
    This is needed so that the pasemi_mac driver can be compiled as a module.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ee5d1b7f2a01ce4d95ca247b5a499b72f31cdbe8
Author: Christian Krafft <krafft@de.ibm.com>
Date:   Thu Jun 28 21:14:38 2007 +1000

    [POWERPC] Fix PMI breakage in cbe_cbufreq driver
    
    The recent change to cell_defconfig to enable cpufreq on Cell exposed
    the fact that the cbe_cpufreq driver currently needs the PMI interface
    code to compile, but Kconfig doesn't make sure that the PMI interface
    code gets built if cbe_cpufreq is enabled.
    
    In fact cbe_cpufreq can work without PMI, so this ifdefs out the code
    that deals with PMI.  This is a minimal solution for 2.6.22; a more
    comprehensive solution will be merged for 2.6.23.
    
    Signed-off-by: Christian Krafft <krafft@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 86affd5a00a92e491e5f00ed659492767519fdf7
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Thu Jun 28 11:27:57 2007 +1000

    [POWERPC] Disable old EMAC driver in arch/powerpc
    
    The EMAC driver, in drivers/net/ibm_emac, for the embedded Ethernet
    MAC found in PowerPC 4xx embedded chips is not suitable for
    arch/powerpc.  It will not build because it relies on the old arch/ppc
    OCP mechanism.  BenH has a new, device-tree aware version of the
    driver which will work in arch/powerpc, but until it's merged, this
    patch will disable the old, non-building version.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
