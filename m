Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17903.35471.818872.293459@cargo.ozlabs.ibm.com>
Date: Thu, 8 Mar 2007 15:01:19 +1100
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

There are 6 commits there.  Three of them fix compile warnings, one is
a bug fix, one works around a problem on rev 1.0 PPC970MP processors,
and one adds a missing newline in some help text.

Thanks,
Paul.

 arch/powerpc/kernel/cputable.c            |   16 ++++++
 arch/powerpc/kernel/prom_parse.c          |    2 -
 arch/powerpc/platforms/celleb/scc_epci.c  |   82 ++++++++++++++++++++++-------
 arch/powerpc/platforms/powermac/feature.c |    5 +-
 arch/powerpc/platforms/powermac/pci.c     |    7 ++
 arch/powerpc/xmon/xmon.c                  |    2 -
 6 files changed, 88 insertions(+), 26 deletions(-)

commit b5d99e64bc6ec1eef03ed5ffe99088b28f5ad4a4
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Mar 7 11:27:55 2007 +0100

    [POWERPC] Fix warning in powermac pci.c
    
    This fixes a warning due to unused result from pci_enable_device() in
    powermac pci.c
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e71c5c38ed578b4fff3139cc5c76fb5d0544f80c
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Mar 7 11:27:45 2007 +0100

    [POWERPC] Fix warning in powermac feature.c
    
    This fixes a warning due to unused return from pci_enable_device() in
    powermac feature.c core99_ata100_enable() function.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 84532c91206bc6748991fb1ae3ba8a1894d339fa
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Mar 7 11:27:37 2007 +0100

    [POWERPC] Fix warning in prom_parse.c of_irq_map_oldworld()
    
    This function spews a warning due to possible use of an uninitialized
    variable. This can happen on broken device-trees or when called with
    a NULL argument. Makes ure we properly fail instead.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 8388374f1cd45ef67039d3ea128d250fac484df3
Author: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Date:   Fri Mar 2 16:59:25 2007 +0900

    [POWERPC] Celleb: bug fix caused by not casting pointer types
    
    This fixes a bug caused by changes of pointer type in
    commit f1fda89522c5aaa1bd4ef69605e85e6ee9c85faf.
    
    hose->cfg_addr type is "volatile unsigned int __iomem *", so
    "hose->cfg_addr + X" will not make an intended address.
    
    This patch also adds comments for usage of cfg_addr and cfg_data in
    pci_controller structure.  We use them in irregular way, and the
    original code is short of explanations about them.
    
    Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
    Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit c99176a230097b076c2f98e4bf963399fe114ffd
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Mon Feb 26 18:14:06 2007 +0900

    [POWERPC] Add missing newline in xmon help output
    
    My patch to add spu disassembly (af89fb8041562508895c8f3ba04790d7c2f4338c)
    removed a newline from the xmon help that it shouldn't have, put it back.
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 3546e811f13673f2364c15d966a178e8b670cbce
Author: Olof Johansson <olof@lixom.net>
Date:   Mon Feb 26 00:35:14 2007 -0600

    [POWERPC] No DEEPNAP on 970MP 1.0
    
    970MP rev 1.0 is reported to have nonworking DEEPNAP support, we've had
    bug reports of lockups on those machines. Appearantly Apple used them
    on some dual-core dual-cpu systems. Rev 1.1 is OK, and that's the one
    that all 4-way systems seem to use.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
