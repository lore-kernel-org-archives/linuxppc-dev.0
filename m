Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18149.38752.181735.957301@cargo.ozlabs.ibm.com>
Date: Tue, 11 Sep 2007 05:13:36 +1000
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

There are four bug-fixes there.  Three of them are to fix problems on
PS3 and the fourth is to fix a problem on POWER6 machines.

Thanks,
Paul.

 arch/powerpc/kernel/ibmebus.c           |   30 +++++++++---------------------
 arch/powerpc/platforms/cell/spu_base.c  |   24 +++++++++++++++---------
 arch/powerpc/platforms/ps3/platform.h   |    1 +
 arch/powerpc/platforms/ps3/repository.c |   29 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/ps3/spu.c        |    2 ++
 include/asm-powerpc/spu.h               |    2 +-
 6 files changed, 57 insertions(+), 31 deletions(-)

commit d8612417b2f78767b96ca434b50d23e5cdfcde07
Author: Joachim Fenkes <fenkes@de.ibm.com>
Date:   Wed Aug 29 18:15:17 2007 +0200

    [POWERPC] ibmebus: Prevent bus_id collisions
    
    Previously, ibmebus derived a device's bus_id from its location code.
    The location code is not guaranteed to be unique, so we might get bus_id
    collisions if two devices share the same location code.  The OFDT
    full_name, however, is unique, so we use that instead (truncating it
    on the left if it is too long).
    
    Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit d51dd3de87026cb0ea1ea5f873f08e930053bfc5
Author: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date:   Thu Sep 6 18:14:57 2007 +0200

    [POWERPC] cell/PS3: Ignore storage devices that are still being probed
    
    On PS3, A storage device may show up in the repository before the hypervisor
    has finished probing:
      - If its type is not yet known, it shows up as PS3_DEV_TYPE_STOR_DUMMY,
      - If its regions are being probed, it shows up as having zero regions.
    If any of these happen, consider the device not yet present.  The storage
    probe thread will retry later.
    
    This fixes the timing-dependent problem where a kernel booted from FLASH ROM
    sometimes cannot find the hard disk.
    
    Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
    Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ef8034d01a080e81488e9cf74052acf1e2a37bd0
Author: Jeremy Kerr <jk@ozlabs.org>
Date:   Fri Sep 7 18:28:27 2007 +1000

    [POWERPC] cell/PS3: Always set master run control bit in mfc_sr1_set
    
    At present, running any SPE program on the ps3 will trigger a BUG_ON
    when spufs_run_spu tries to clear the master run control bit, as lv1
    does not make the master run control available to Linux.
    
    This change makes SPE apps work again by disabling changes to the
    master run control on PS3.  Although we don't have the facility to
    disable a SPE with supervisor-level privileges, it's better than
    hitting the BUG_ON unconditionally.
    
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Acked-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit b7f90a406ff72d6698b619210c205e3375dd099a
Author: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Date:   Fri Sep 7 18:28:27 2007 +1000

    [POWERPC] cell/PS3: Fix a bug that causes the PS3 to hang on the SPU Class 0 interrupt.
    
    The Cell BE Architecture spec states that the SPU MFC Class 0 interrupt
    is edge-triggered.  The current spu interrupt handler assumes this
    behavior and does not clear the interrupt status.
    
    The PS3 hypervisor visualizes all SPU interrupts as level, and on return
    from the interrupt handler the hypervisor will deliver a new virtual
    interrupt for any unmasked interrupts which for which the status has not
    been cleared.  This fix clears the interrupt status in the interrupt
    handler.
    
    Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
