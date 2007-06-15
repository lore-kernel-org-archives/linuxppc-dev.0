Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18034.7377.94678.758291@cargo.ozlabs.ibm.com>
Date: Fri, 15 Jun 2007 15:00:01 +1000
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

to get two more bug-fixes for powerpc.

Thanks,
Paul.

 arch/powerpc/kernel/udbg.c              |    8 +++++++-
 arch/powerpc/platforms/powermac/setup.c |   13 ++++++++++++-
 arch/powerpc/platforms/powermac/smp.c   |    1 -
 3 files changed, 19 insertions(+), 3 deletions(-)

commit 220ddc0847ebd42d18ee78c7e1c2f4c2e3be637d
Author: Milton Miller <miltonm@bga.com>
Date:   Sun Jun 10 14:32:43 2007 +1000

    [POWERPC] Fix console output getting dropped on platforms without udbg_putc
    
    Previously, registering this early console would just result
    in dropping early buffered printk output until a udbg_putc
    was registered.
    
    However, commit 69331af79cf29e26d1231152a172a1a10c2df511
    clears the CON_PRINTBUFFER flag on the main console when a
    CON_BOOT (early) console has been registered, resulting in
    the buffered messages never being displayed to the user.
    
    This fixes the problem by making sure we don't register udbg_console
    on platforms that don't implement udbg_putc.
    
    Signed-off-by: Milton Miller <miltonm@bga.com>
    Acked-by: Mark A. Greer <mgreer@mvista.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit c63c4faa8cf055319c7ed557d2050c1c3776fac5
Author: Paul Mackerras <paulus@samba.org>
Date:   Thu Jun 7 22:42:19 2007 +1000

    [POWERPC] Fix per-cpu allocation on oldworld SMP powermacs
    
    The per-cpu area(a) for the secondary CPU(s) isn't getting allocated
    on old SMP powermacs that don't have the secondary CPU(s) listed in
    the device tree, as per-cpu areas are now only allocated for CPUs in
    the cpu_possible_map, and we aren't setting the bits for the secondary
    CPU(s) until smp_prepare_cpus(), which is after per-cpu allocation.
    Therefore this sets the bits for CPUs 1..3 in cpu_possible_map in
    pmac_setup_arch, so they get per-cpu data allocated.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>
