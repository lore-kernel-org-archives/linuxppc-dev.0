Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17851.56154.749593.70103@cargo.ozlabs.ibm.com>
Date: Sun, 28 Jan 2007 10:08:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'merge' branch
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

or, if the mirroring hasn't caught up:

git pull \
master.kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git merge

There are 3 small bugfixes (one- or two-liners, including Ben's fix
for sys_pciconfig_iobase in case you didn't pick it up directly), plus
a change to arch/powerpc/Kconfig to make it clear that the PS3 support
is still incomplete.

Thanks,
Paul.

 arch/powerpc/Kconfig                   |    5 ++++-
 arch/powerpc/kernel/pci_64.c           |    2 +-
 arch/powerpc/platforms/ps3/Makefile    |    3 ++-
 arch/powerpc/platforms/ps3/interrupt.c |    2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

commit 545da94f924d52f80e2bbea99a8652f454889a2b
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sun Jan 28 07:45:53 2007 +1100

    [POWERPC] Fix sys_pciconfig_iobase bus matching
    
    A stupid bug has been plaguing the sys_pciconfig_iobase on ppc64. It wasn't
    noticed until recently as it seems to not affect G5s but it's been causing
    problems running X servers on some other machines recently. The bus number
    matching was bogus.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 05916eec9f4d4370ef9a6cbb699f637302f6e157
Author: Geoff Levand <geoffrey.levand@am.sony.com>
Date:   Thu Jan 25 18:07:14 2007 -0800

    [POWERPC] PS3: add not complete comment to kconfig
    
    Add a comment to the PS3 config option to inform users that the current
    implementation is not yet complete.
    
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ded84bcb246780137ecaa3f6d137ac1b0f06fd08
Author: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date:   Thu Dec 21 13:57:16 2006 +0100

    [POWERPC] ps3_free_io_irq: Fix inverted error check
    
    ps3_free_io_irq: Fix inverted error check after calling
    lv1_destruct_io_irq_outlet().
    
    Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 63ea9c1710f05a7309c272750bbf40134c628f36
Author: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date:   Wed Dec 20 16:11:57 2006 +0100

    [POWERPC] PS3: Fix uniprocessor kernel build
    
    Allow to build a uniprocessor kernel for PS3.
    
    Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
