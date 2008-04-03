Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18420.49297.539817.178726@cargo.ozlabs.ibm.com>
Date: Thu, 3 Apr 2008 22:33:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get some more bug fixes for powerpc, mostly for various embedded
platforms.  The bulk of the changes are once again in the defconfigs.

Thanks,
Paul.

 arch/powerpc/boot/dts/cm5200.dts            |   37 +++++++++++++++-
 arch/powerpc/boot/dts/lite5200.dts          |   15 ++++++
 arch/powerpc/boot/dts/motionpro.dts         |   63 +++++++++++++++----=
--------
 arch/powerpc/boot/dts/mpc8377=5Fmds.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8377=5Frdb.dts       |    3 -
 arch/powerpc/boot/dts/mpc8378=5Frdb.dts       |    3 -
 arch/powerpc/boot/dts/mpc8379=5Fmds.dts       |    8 ++-
 arch/powerpc/boot/dts/mpc8379=5Frdb.dts       |    3 -
 arch/powerpc/boot/dts/tqm5200.dts           |   42 ++++++++++++++++++
 arch/powerpc/configs/mpc832x=5Fmds=5Fdefconfig  |   11 +----
 arch/powerpc/configs/mpc834x=5Fmds=5Fdefconfig  |   11 +----
 arch/powerpc/configs/mpc836x=5Fmds=5Fdefconfig  |   11 +----
 arch/powerpc/configs/mpc837x=5Frdb=5Fdefconfig  |   24 ++++++++++
 arch/powerpc/configs/mpc83xx=5Fdefconfig      |   24 ++++++++++
 arch/powerpc/configs/mpc8544=5Fds=5Fdefconfig   |   11 +----
 arch/powerpc/configs/mpc8568mds=5Fdefconfig   |   11 +----
 arch/powerpc/configs/mpc8572=5Fds=5Fdefconfig   |   11 +----
 arch/powerpc/configs/mpc85xx=5Fdefconfig      |   11 +----
 arch/powerpc/configs/mpc8641=5Fhpcn=5Fdefconfig |   11 +----
 arch/powerpc/configs/prpmc2800=5Fdefconfig    |   11 +----
 arch/powerpc/configs/storcenter=5Fdefconfig   |   11 +----
 arch/powerpc/kernel/head=5F64.S               |   13 +++---
 arch/powerpc/kernel/irq.c                   |    1=20
 arch/powerpc/kernel/rtas=5Fflash.c            |    2 -
 arch/powerpc/mm/hash=5Flow=5F32.S               |    8 +++
 arch/powerpc/sysdev/cpm2.c                  |    1=20
 drivers/ata/sata=5Ffsl.c                      |    5 --
 drivers/dma/fsldma.c                        |    8 ++-
 drivers/net/fec=5Fmpc52xx.c                   |    1=20
 drivers/net/fec=5Fmpc52xx=5Fphy.c               |    1=20
 30 files changed, 234 insertions(+), 142 deletions(-)

commit 8d813941b17626a7610342325be63435282bac02
Author: Ren=E9 B=FCrgel <r.buergel@unicontrol.de>
Date:   Thu Apr 3 19:58:37 2008 +1100

    [POWERPC] Fix MPC5200 (not B!) device tree so FEC ethernet works
   =20
    This gets the FEC ethernet driver working again on the lite5200
    platform.
   =20
    The FEC driver is also compatible with the MPC5200, not only with t=
he
    MPC5200B, so this adds a suitable entry to the driver's match list.=

    Furthermore this adds the settings for the PHY in the dts file for =
the
    Lite5200.  Note, that this is not exactly the same as in the
    Lite5200B, because the PHY is located at f0003000:01 for the 5200, =
and
    at :00 for the 5200B.  This was tested on a Lite5200 and a Lite5200=
B,
    both booted a kernel via tftp and mounted the root via nfs
    successfully.
   =20
    Signed-off-by: Ren=E9 B=FCrgel <r.buergel@unicontrol.de>
    Acked-by: Grant Likely <grant.likely@secretlab.ca>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 115e1adca3b75a82f24da8b2cc9386eb5b7e2cff
Author: Bartlomiej Sieka <tur@semihalf.com>
Date:   Thu Apr 3 01:26:02 2008 +1100

    [POWERPC] mpc5200: Amalgamated DTS fixes and updates
   =20
    DTS updates that fix booting problems on mpc5200-based boards:
    - change to ethernet reg property
    - addition of mdio and phy nodes
    - removal of pci node (Motion-Pro board)
   =20
    Other DTS updates:
    - update i2c device tree nodes
    - add lpb bus node and flash device (without partitions defined)
    - add rtc i2c nodes
   =20
    Signed-off-by: Marian Balakowicz <m8@semihalf.com>
    Acked-by: Grant Likely <grant.likely@secretlab.ca>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 7484839850d826e14b8b024bb048dca8489140ae
Author: Maxim Shchetynin <maxim@de.ibm.com>
Date:   Wed Apr 2 00:12:20 2008 +1100

    [POWERPC] Fix rtas=5Fflash procfs interface
   =20
    Handling of the proc=5Fdir=5Fentry->count was changed in 2.6.24-rc5=
=2E
    After this change, the default value for pde->count is 1 and not 0 =
as
    before.  Therefore, if we want to check whether our procfs file is
    already opened (already in use), we have to check if pde->count is
    greater than 2 rather than 1.
   =20
    Signed-off-by: Maxim Shchetynin <maxim@de.ibm.com>
    Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit b991f05f1326fd9e6212851d0f2099875906dd16
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Mon Mar 31 07:49:27 2008 +1100

    [POWERPC] Fix deadlock with mmu=5Fhash=5Flock in hash=5Fpage=5Fsync=

   =20
    hash=5Fpage=5Fsync() takes and releases the low level mmu hash
    lock in order to sync with other processors disposing of page
    tables.  Because that lock can be needed to service hash misses
    triggered by interrupt handlers, taking it must be done with
    interrupts off.  However, hash=5Fpage=5Fsync() appears to be called=

    with interrupts enabled, thus causing occasional deadlocks.
   =20
    We fix it by making sure hash=5Fpage=5Fsync() masks interrupts whil=
e
    holding the lock.
   =20
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ff3da2e0938bae36d10d69c22bce0177b067a9e2
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Apr 2 15:58:40 2008 +1100

    [POWERPC] Fix iSeries hard irq enabling regression
   =20
    A subtle bug sneaked into iSeries recently.  On this platform, we m=
ust
    not normally clear MSR:EE (the hardware external interrupt enable)
    except for short periods of time.  Taking an interrupt while
    soft-disabled doesn't cause us to clear it for example.
   =20
    The iSeries kernel expects to mostly run with MSR:EE enabled at all=

    times except in a few exception entry/exit code paths.  Thus
    local=5Firq=5Fenable() doesn't check if it needs to hard-enable as =
it
    expects this to be unnecessary on iSeries.
   =20
    However, hard=5Firq=5Fdisable() =5Fdoes=5F cause MSR:EE to be clear=
ed,
    including on iSeries.  A call to it was recently added to the
    context switch code, thus causing interrupts to become disabled
    for a long periods of time, causing the iSeries watchdog to kick
    in under some circumstances and other nasty things.
   =20
    This patch fixes it by making local=5Firq=5Fenable() properly re-en=
able
    MSR:EE on iSeries.  It basically removes a return statement here
    to make iSeries use the same code path as everybody else.  That doe=
s
    mean that we might occasionally get spurious decrementer interrupts=

    but I don't think that matters.
   =20
    Another option would have been to make hard=5Firq=5Fdisable() a nop=

    on iSeries but I didn't like it much, in case we have good reasons
    to hard-disable.
   =20
    Part of the patch is fixes to make sure the hard=5Fenabled PACA fie=
ld
    is properly set on iSeries as it used not to be before, since it
    was mostly unused.
   =20
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 025306f30948836a743eb68a7cbaf4ab0bfb5f47
Author: Laurent Pinchart <laurentp@cse-semaphore.com>
Date:   Wed Apr 2 16:46:31 2008 +0200

    [POWERPC] Fix CPM2 SCC1 clock initialization.
   =20
    A missing break statement in a switch caused cpm2=5Fclk=5Fsetup() t=
o initialize
    SCC2 instead of SCC1.
   =20
    Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 1e85d89fa3954eff332033c0e75f6e2442be44ed
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Mon Mar 31 11:53:46 2008 -0500

    [POWERPC] Fix defconfigs so we dont set both GENRTC and RTCLIB
   =20
    The new rtc subsystem conflicts with genrtc so don't enable GENRTC
    if RTCLIB is enabled.
   =20
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 049c9d45531d9825bf737891163a794fca1421c5
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Mon Mar 31 11:13:21 2008 -0500

    [POWERPC] fsldma: Use compatiable binding as spec
   =20
    Documentation/powerpc/booting-without-of.txt specifies the
    compatiables we should bind to for this driver (elo, eloplus).
    Use these instead of the extremely specific 'mpc8540' and 'mpc8349'=

    compatiables.
   =20
    Acked-by: Dan Williams <dan.j.williams@intel.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 96ce1b6dc5824cc6027c954b9a2e4717c70e01b5
Author: Kim Phillips <kim.phillips@freescale.com>
Date:   Fri Mar 28 10:51:33 2008 -0500

    [POWERPC] sata=5Ffsl: reduce compatibility to fsl,pq-sata
   =20
    as prescribed in Documentation/powerpc/booting-without-of.txt.
   =20
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Acked-by: Jeff Garzik <jeff@garzik.org>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 58bb7a973b1d3c0a5127477fb049bbfc5ce02fb5
Author: Kim Phillips <kim.phillips@freescale.com>
Date:   Fri Mar 28 10:51:29 2008 -0500

    [POWERPC] 83xx: enable usb in 837x rdb and 83xx defconfigs
   =20
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 8e8ff3a309ebdaad51fd7a64a6fd2a2f88b30d87
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Wed Mar 12 23:02:13 2008 +0300

    [POWERPC] 83xx: Fix wrong USB phy type in mpc837xrdb dts
   =20
    Due to chip constraint MPC837x USB DR module can only use
    ULPI and serial PHY interfaces.  The patch fixes the wrong
    type in dts.
   =20
    This patch fixes USB malfunctioning on the MPC837xE-RDB boards.
   =20
    Similar patch has been already applied for the MDS boards:
   =20
      commit 28b958859206b7010d03129611c2e444898e3ee4
      Author: Li Yang <leoli@freescale.com>
      Date:   Thu Mar 6 18:42:26 2008 +0800
   =20
          [POWERPC] 83xx: Fix wrong USB phy type in mpc837xmds dts
   =20
    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
